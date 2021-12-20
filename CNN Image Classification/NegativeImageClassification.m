import torch
import torch.nn as nn
import torch.nn.functional as F
import torchvision as tv
import torchvision.transforms as transforms
import torch.optim as optim
import matplotlib.pyplot as plt
import time
import numpy as np


class Net(nn.Module):

    def __init__(self):
        super(Net, self).__init__()
        # 1 input image channel, 6 output channels, 5x5 square convolution
        # kernel
        self.conv1 = nn.Conv2d(1, 6, 5)  # input 1*28*28, 6 convolution filters
        self.conv2 = nn.Conv2d(6, 16, 5)
        # an affine operation: y = Wx + b
        self.fc1 = nn.Linear(16 * 4 * 4, 120)  # 4*4 from image dimension
        self.fc2 = nn.Linear(120, 84)
        self.fc3 = nn.Linear(84, 10)

    def forward(self, x):
        # Max pooling over a (2, 2) window
        x = F.max_pool2d(F.relu(self.conv1(x)), (2, 2))
        # If the size is a square you can only specify a single number
        x = F.max_pool2d(F.relu(self.conv2(x)), 2)
        x = x.view(-1, self.num_flat_features(x))
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = self.fc3(x)
        return x

    def num_flat_features(self, x):
        size = x.size()[1:]  # all dimensions except the batch dimension
        num_features = 1
        for s in size:
            num_features *= s
        return num_features


# change and test different size to see the performance and speed
train_batch_size = 64
test_batch_size = 1000


# define the function of loading data
def load_data():
    transform = transforms.Compose([
        transforms.ToTensor(),
        transforms.Normalize((0.1307,), (0.3081,))])
    train_set = tv.datasets.MNIST(
        root='./data/',
        train=True,
        download=True,
        transform=transform
        )
    train_loader = torch.utils.data.DataLoader(
        train_set,
        batch_size=train_batch_size,
        shuffle=True,
        num_workers=2)
    test_set = tv.datasets.MNIST(
        root='./data/',
        train=False,
        download=True,
        transform=transform
        )
    test_loader = torch.utils.data.DataLoader(
        test_set,
        batch_size=test_batch_size,
        shuffle=False,
        num_workers=2
        )
    # print("data loaded successfully...")
    return train_loader, test_loader


# timer begin
start_time = time.time()
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

# accuracy_train = []
# accuracy_test = []


def run():
    torch.multiprocessing.freeze_support()
    print('loop')


if __name__ == '__main__':
    run()
    find_best_train = list()
    find_best = list()
    mean_MNIST = 0
    std_MNIST = 0

    # from torchvision import datasets, transforms
    # import numpy as np
    #
    # train_dataset = datasets.MNIST("datasets/", train=True, download=True, transform=transforms.ToTensor())
    # testdataset = datasets.MNIST("datasets/", train=False, download=True, transform=transforms.ToTensor())
    # mnist_data = train_dataset + testdataset
    # _data = [d[0].data.cpu().numpy() for d in mnist_data]
    # _data = 1 - _data
    # print(_data)
    # print(np.mean(_data))
    # print(np.std(_data))

    for r in range(1):
        # check the structure of the net
        net = Net()

        # load training and testing data
        trainloader, testloader = load_data()

        # define the criterion function
        # criterion = nn.MSELoss()
        criterion = nn.CrossEntropyLoss()

        # create your optimizer
        optimizer = optim.SGD(net.parameters(), lr=0.0001, momentum=0.95, weight_decay=0.0001)
        #optimizer = optim.Adam(net.parameters(), lr=0.0005, betas=(0.9, 0.99), eps=1e-06, weight_decay=0.0004)

        accuracy_train = []
        accuracy_test = []
        # training
        # i=0
        inputs_all = []
        labels_all = []
        inputs_all2 = []
        labels_all2 = []
        for epoch in range(20):
            running_loss = 0.0
            train_correct = 0.0
            test_correct = 0.0
            train_total = 0.0
            for i, data in enumerate(trainloader, 0):
                # get the inputs
                inputs1, labels1 = data
                inputs_all.append(inputs1)
                labels_all.append(labels1)

                inputs_all2.append(-inputs1)

            # print('len2:',len(inputs_all2))
            inputs_all_final = inputs_all+inputs_all2
            # print('lenfinal:',len(inputs_all_final))
            labels_all_final = labels_all+labels_all
            # print('inputs:', inputs_all_final)
            # print('labels:', labels_all_final)
                # zero the parameter gradients

            for iall in range(len(labels_all_final)):
                inputs = inputs_all_final[iall]
                labels = labels_all_final[iall]
                # print('chekc inout：', inputs)
                # print('check label:', labels)
                optimizer.zero_grad()

                # forward + backward + optimize
                outputs = net(inputs)
                loss = criterion(outputs, labels)
                loss.backward()
                optimizer.step()

                # training accuracy
                running_loss += loss.item()
                _, predicted = torch.max(outputs, 1)
                train_correct += (predicted == labels).sum().item()
                train_total += labels.size(0)
                if iall % 2000 == 1999:
                    print('[%d, %5d] loss: %.3f' %
                          (epoch + 1, iall + 1, running_loss / 2000))
                    running_loss = 0.0
            train_correct = train_correct / train_total
            accuracy_train.append(100*train_correct)

            # testing
            correct = 0.0
            total = 0.0
            inputs_all3 = []
            inputs_all4 = []
            labels_all3 = []
            labels_all4 = []
            for i3, data3 in enumerate(testloader, 0):
                # get the inputs
                inputs3, labels3 = data3
                inputs_all3.append(inputs3)
                labels_all3.append(labels3)

                inputs_all4.append(-inputs3)

            test_inputs_all_final = inputs_all3 + inputs_all4
            # print('lenfinal_test:', len(test_inputs_all_final))
            test_labels_all_final = labels_all3 + labels_all3
            # print('test inputs:', test_inputs_all_final)
            # print('test labels:', test_labels_all_final)

            with torch.no_grad():
                for itestall in range(len(test_labels_all_final)):
                    x_test = test_inputs_all_final[itestall]
                    y_test = test_labels_all_final[itestall]
                    outputs = net(x_test)
                    _, prediction = torch.max(outputs, 1)
                    correct += (prediction == y_test).sum().item()
                    total += y_test.size(0)

            # testing accuracy
            test_correct = correct / total
            accuracy_test.append(100*test_correct)
            print('training accuracy is: ', 100*train_correct, 'testing accuracy is: ', 100*test_correct)
        print('Finished Training')
        find_best.append(accuracy_test[19])
        find_best_train.append(accuracy_train[19])
    # evaluation of train set
    print('all 5 accuracy of training set of the last epoch: ', np.array(find_best_train))
    mean_MNIST_train = np.mean(np.array(find_best_train))
    print('mean accuracy of training set of the last epoch:', mean_MNIST_train)
    std_MNIST_train = np.std(np.array(find_best_train))
    print('std of accuracy of training set of the last epoch:', std_MNIST_train)

    # evaluation of test set
    print('all 5 accuracy of testing set of the last epoch: ', np.array(find_best))
    mean_MNIST = np.mean(np.array(find_best))
    print('mean accuracy of testing set of the last epoch:', mean_MNIST)
    std_MNIST = np.std(np.array(find_best))
    print('std of accuracy of testing set of the last epoch:', std_MNIST)
    # timer end
    print('total time is: ', (time.time() - start_time)/(60))

    # plt.imshow(inputs3[1].data.squeeze(), cmap='gray')

    epoch = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    epoch1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]#, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50]
    plt.figure()
    plt.title('Performance Curve for inverse MNIST')
    plt.plot(epoch, accuracy_train, label="train accuracy")
    plt.plot(epoch, accuracy_test, label="test accuracy")
    plt.xlabel('Epoch')
    plt.ylabel('Accuracy(%)')
    plt.legend()
    plt.show()

