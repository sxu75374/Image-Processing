import numpy as np
from tensorflow.keras.datasets import fashion_mnist
from skimage.util import view_as_windows
from EE569HW6.pixelhop import Pixelhop
from skimage.measure import block_reduce
import xgboost as xgb
import warnings
from sklearn.metrics import plot_confusion_matrix
import time


np.random.seed(1)

# Preprocess
N_Train_Reduced = 10000  # 10000
N_Train_Full = 60000  # 50000
N_Test = 10000  # 10000

BS = 2000  # batch size


def shuffle_data(X, y):
    shuffle_idx = np.random.permutation(y.size)
    X = X[shuffle_idx]
    y = y[shuffle_idx]
    return X, y


def select_balanced_subset(images, labels, use_num_images):
    '''
    select equal number of images from each classes
    '''
    num_total, H, W, C = images.shape
    num_class = np.unique(labels).size
    num_per_class = int(use_num_images / num_class)

    # Shuffle
    images, labels = shuffle_data(images, labels)

    selected_images = np.zeros((use_num_images, H, W, C))
    selected_labels = np.zeros(use_num_images)

    for i in range(num_class):
        selected_images[i * num_per_class:(i + 1) * num_per_class] = images[labels == i][:num_per_class]
        selected_labels[i * num_per_class:(i + 1) * num_per_class] = np.ones((num_per_class)) * i

    # Shuffle again
    selected_images, selected_labels = shuffle_data(selected_images, selected_labels)

    return selected_images, selected_labels


def Shrink(X, shrinkArg):
    # ---- max pooling----
    pool = shrinkArg['pool']
    # TODO: fill in the rest of max pooling
    if pool > 1:
        X = block_reduce(X.reshape(X.shape[0], X.shape[1], X.shape[2], -1), func=np.max, block_size=(1, pool, pool, 1))
        print('after max pooling:', X.shape)

    # ---- neighborhood construction
    win = shrinkArg['win']
    stride = shrinkArg['stride']
    pad = shrinkArg['pad']
    ch = X.shape[-1]
    # TODO: fill in the rest of neighborhood construction
    if pad > 0:
        X = np.pad(X, ((0, 0), (pad, pad), (pad, pad), (0, 0)), 'reflect')
        # print('X shape after pad', X.shape)
    X = view_as_windows(X, (1, win, win, ch), (1, stride, stride, ch))
    return X.reshape(X.shape[0], X.shape[1], X.shape[2], -1)


# example callback function for how to concate features from different hops
def Concat(X, concatArg):
    return X


def get_feat(X, num_layers=3):
    output = p2.transform_singleHop(X, layer=0)
    if num_layers > 1:
        for i in range(num_layers - 1):
            output = p2.transform_singleHop(output, layer=i + 1)
    return output


if __name__ == "__main__":
    warnings.filterwarnings("ignore")
    # ---------- Load MNIST data and split ----------
    (x_train, y_train), (x_test, y_test) = fashion_mnist.load_data()

    # -----------Data Preprocessing-----------
    x_train = np.asarray(x_train, dtype='float32')[:, :, :, np.newaxis]
    x_test = np.asarray(x_test, dtype='float32')[:, :, :, np.newaxis]
    y_train = np.asarray(y_train, dtype='int')
    y_test = np.asarray(y_test, dtype='int')

    # if use only 10000 images train pixelhop
    x_train_reduced, y_train_reduced = select_balanced_subset(x_train, y_train, use_num_images=N_Train_Reduced)

    x_train /= 255.0
    x_test /= 255.0
    # print('x_train', x_train)

    # -----------Module 1: set PixelHop parameters-----------
    # TODO: fill in this part
    SaabArgs = [{'num_AC_kernels': -1, 'needBias': False, 'cw': False},
                {'num_AC_kernels': -1, 'needBias': True, 'cw': True},
                {'num_AC_kernels': -1, 'needBias': True, 'cw': True}]
    shrinkArgs = [{'func': Shrink, 'win': 5, 'stride': 1, 'pad': 2, 'pool': 1},
                  {'func': Shrink, 'win': 5, 'stride': 1, 'pad': 0, 'pool': 2},
                  {'func': Shrink, 'win': 5, 'stride': 1, 'pad': 0, 'pool': 2}]
    concatArg = {'func': Concat}

    # -----------Module 1: Train PixelHop -----------
    # TODO: fill in this part
    TIMER = []
    TRAIN_ACC = []
    TEST_ACC = []
    TH1_choice = []
    L1 = []
    L2 = []
    L3 = []
    start = time.time()
    p2 = Pixelhop(depth=3, TH1=0.005, TH2=0.001, SaabArgs=SaabArgs, shrinkArgs=shrinkArgs, concatArg=concatArg).fit(
        x_train)
    end = time.time()
    timer = end-start
    # print('Pixelhop++ training time = ', round(timer, 3))
    TIMER.append(timer)
    # --------- Module 2: get only Hop 3 feature for both training set and testing set -----------
    # you can get feature "batch wise" and concatenate them if your memory is restricted
    # TODO: fill in this part
    # get K1, K2, K3
    train_hop3_feats = get_feat(x_train, num_layers=3)
    test_hop3_feats = get_feat(x_test, num_layers=3)
    # print('train_hop3_feats', train_hop3_feats)
    # print('test_hop3_feats', test_hop3_feats)
    # print('size of layer3: ', train_hop3_feats.shape)
    # print('shape of test_hop3_feats', test_hop3_feats.shape)
    # --------- Module 2: standardization
    STD = np.std(train_hop3_feats, axis=0, keepdims=1)
    train_hop3_feats = train_hop3_feats / STD
    test_hop3_feats = test_hop3_feats / STD
    # print('train_hop3_feats std', train_hop3_feats)
    # print('test_hop3_feats std', test_hop3_feats)
    # print('shape of train_hop3_feats std', train_hop3_feats.shape)
    # print('shape of test_hop3_feats std', test_hop3_feats.shape)

    # ---------- Module 3: Train XGBoost classifier on hop3 feature ---------
    clf = xgb.XGBClassifier(n_jobs=-1,
                            objective='multi:softprob',
                            # tree_method='gpu_hist', gpu_id=None,
                            max_depth=6, n_estimators=100,
                            min_child_weight=5, gamma=5,
                            subsample=0.8, learning_rate=0.1,
                            nthread=8, colsample_bytree=1.0)

    # TODO: fill in the rest and report accuracy
    c = 0
    clf.fit(train_hop3_feats.squeeze(), y_train)
    y_hat_train = clf.predict(train_hop3_feats.squeeze())
    y_hat_test = clf.predict(test_hop3_feats.squeeze())
    for i in range(len(y_hat_train)):
        if y_hat_train[i] == y_train[i]:
            c = c + 1
    accuracy_train = c / len(y_hat_train)
    print('train accuracy of Fashion-MNIST is: ', accuracy_train)
    TRAIN_ACC.append(accuracy_train)

    c = 0
    for i in range(len(y_hat_test)):
        if y_hat_test[i] == y_test[i]:
            c = c + 1
    accuracy_test = c / len(y_hat_test)
    TEST_ACC.append(accuracy_test)
    print('test accuracy of Fashion-MNIST is: ', accuracy_test)

    from sklearn.metrics import confusion_matrix

    cfMatrix = confusion_matrix(y_test, y_hat_test)
    print('confusion matrix: \n', cfMatrix)
    import seaborn as sns
    import matplotlib.pyplot as plt

    fig = plt.figure()
    sns_plot = sns.heatmap(cfMatrix)
    plt.title('Heat map for Fashion-MNIST')
    plt.xlabel('predict label')
    plt.ylabel('ground truth')
    plt.show()

    plt.figure()
    plot_confusion_matrix(clf, test_hop3_feats.squeeze(), y_test, cmap=plt.cm.Blues, normalize='true')
    plt.title('confusion matrix for Fashion-MNIST')
    plt.xlabel('predict label')
    plt.ylabel('ground truth')
    plt.show()

