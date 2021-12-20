import torch
import torch.nn as nn
import torch.nn.functional as F
import torchvision as tv
import torchvision.transforms as transforms
import torch.optim as optim
import matplotlib.pyplot as plt
import time
import numpy as np
import math


class Net(nn.Module):

    def __init__(self):
        super(Net, self).__init__()
        # 1 input image channel, 6 output channels, 5x5 square convolution
        # kernel
        self.conv1 = nn.Conv2d(3, 6, 5)  # input 1*28*28, 6 convolution filters
        torch.nn.init.kaiming_normal_(self.conv1.weight, a=0, mode='fan_in', nonlinearity='leaky_relu')
        self.conv2 = nn.Conv2d(6, 16, 5)
        torch.nn.init.kaiming_normal_(self.conv2.weight, a=0, mode='fan_in', nonlinearity='leaky_relu')
        # an affine operation: y = Wx + b
        self.fc1 = nn.Linear(16 * 5 * 5, 120)  # 4*4 from image dimension
        torch.nn.init.kaiming_normal_(self.fc1.weight, a=0, mode='fan_in', nonlinearity='leaky_relu')
        self.fc2 = nn.Linear(120, 84)
        torch.nn.init.kaiming_normal_(self.fc2.weight, a=0, mode='fan_in', nonlinearity='leaky_relu')
        self.fc3 = nn.Linear(84, 10)
        torch.nn.init.kaiming_normal_(self.fc3.weight, a=0, mode='fan_in', nonlinearity='leaky_relu')

    def forward(self, x):
        # Max pooling over a (2, 2) window
        x = F.max_pool2d(F.relu(self.conv1(x)), (2, 2))
        # If the size is a square you can only specify a single number
        x = F.max_pool2d(F.relu(self.conv2(x)), 2)
        x = x.view(-1, self.num_flat_features(x))
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = self.fc3(x)
        # x = F.softmax(x)
        return x

    def num_flat_features(self, x):
        size = x.size()[1:]  # all dimensions except the batch dimension
        num_features = 1
        for s in size:
            num_features *= s
        return num_features


# change and test different size to see the performance and speed
train_batch_size = 128
test_batch_size = 1000


# def weight_init(m):
#     if isinstance(m, nn.Conv2d):
#         n = m.kernel_size[0] * m.kernel_size[1] * m.out_channels
#         m.weight.data.normal_(0, math.sqrt(2.0 / n))
#         m.bias.data.zero_()
#     elif isinstance(m, nn.BatchNorm3d):
#         m.weight.data.fill_(1)
#         m.bias.data.zero_()
#     elif isinstance(m, nn.Linear):
#         m.weight.data.normal_(0, 0.02)
#         m.bias.data.zero_()


# define the function of loading data
def load_data():
    transform = transforms.Compose([
        transforms.ToTensor(),
        transforms.Normalize((0.1307, 0.1307, 0.1307), (0.3081, 0.3081, 0.3081))])
    train_set = tv.datasets.CIFAR10(
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
    test_set = tv.datasets.CIFAR10(
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
    for r in range(5):
        # check the structure of the net
        net = Net()
        # net.apply(weight_init)

        # load training and testing data
        trainloader, testloader = load_data()

        # define the criterion function
        # criterion = nn.MSELoss()
        criterion = nn.CrossEntropyLoss()

        # create your optimizer
        #optimizer = optim.SGD(net.parameters(), lr=0.001, momentum=0.9   , weight_decay=0.0001)
        optimizer = optim.Adam(net.parameters(), lr=0.005, betas=(0.9, 0.99), eps=1e-06, weight_decay=0.001)
        #optimizer = optim.Adagrad(net.parameters(), lr=0.0003, lr_decay=0, weight_decay=0.0003, initial_accumulator_value=0, eps=1e-10)

        accuracy_train = []
        accuracy_test = []
        # training
        # i=0
        for epoch in range(50):
            running_loss = 0.0
            train_correct = 0.0
            test_correct = 0.0
            train_total = 0.0
            for i, data in enumerate(trainloader, 0):
                # get the inputs
                inputs, labels = data

                # zero the parameter gradients
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
                if i % 2000 == 1999:
                    print('[%d, %5d] loss: %.3f' %
                          (epoch + 1, i + 1, running_loss / 2000))
                    running_loss = 0.0
            train_correct = train_correct / train_total
            accuracy_train.append(100*train_correct)

            # testing
            correct = 0.0
            total = 0.0
            with torch.no_grad():
                for data in testloader:
                    x_test, y_test = data
                    outputs = net(x_test)
                    _, prediction = torch.max(outputs, 1)
                    correct += (prediction == y_test).sum().item()
                    total += y_test.size(0)

            # testing accuracy
            test_correct = correct / total
            accuracy_test.append(100*test_correct)
            print('training accuracy is: ', 100*train_correct, 'testing accuracy is: ', 100*test_correct)
        print('Finished Training')
        find_best.append(accuracy_test[49])
        find_best_train.append(accuracy_train[49])
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
    print('total time is: ', (time.time() - start_time)/(5*60))

    ep = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    #epoch1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
        #, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]
    ep50 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50]
              #51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80]
    plt.figure()
    plt.title('Performance Curve')
    plt.plot(ep50, accuracy_train, label="train accuracy")
    plt.plot(ep50, accuracy_test, label="test accuracy")
    plt.xlabel('Epoch')
    plt.ylabel('Accuracy(%)')
    plt.legend()
    plt.show()

