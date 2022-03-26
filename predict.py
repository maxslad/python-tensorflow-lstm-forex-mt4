import numpy as np
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras.layers import LSTM, Dense, SimpleRNN
from sklearn.preprocessing import MinMaxScaler
from imblearn.over_sampling._smote.base import SMOTE

import sys
import os
import time
import random


inp_width = 14
file_path = "./"
file_name = "x_train_for_norm_FST_LIM_DST.txt"
file_full_path = file_path + file_name

model_file_name = "IS_FST_LIM_DST_BEST.hdf5"


f = open(file_full_path, "r")


data = f.readlines()
data_clean = [[float(j) for j in i.replace("\n", "").split(",")] for i in data if i != "\n"]


f.close()

# print(data_clean)


# for i in data_clean:
#     print(i)
#     print()


x_for_norm = np.array(data_clean)
# data_np = np.array(data_clean)
# x = data_np[:, :-1]
# y = data_np[:, -1]

# # resampling
# sm = SMOTE()
# x_sm, y_sm = sm.fit_resample(x, y)

# y_sm = [[i] for i in y_sm]
# y_sm = np.array(y_sm)

# xy_sm = np.append(x_sm, y_sm, axis=1)

# train = []
# val = []
# test = []

# train_1_counter = 0
# train_2_counter = 0
# train_3_counter = 0
# val_1_counter = 0
# val_2_counter = 0
# val_3_counter = 0
# test_1_counter = 0
# test_2_counter = 0
# test_3_counter = 0

# train_1_amount = 2160
# train_2_amount = 2160
# train_3_amount = 2160
# val_1_amount = 270
# val_2_amount = 270
# val_3_amount = 270
# test_1_amount = 270
# test_2_amount = 270
# test_3_amount = 270

# # train_amount = 2700
# # val_amount = 270
# # test_amount = 270


# # rand_list = [i for i in range(data_np.shape[0])]
# rand_list = [i for i in range(xy_sm.shape[0])]
# # print(rand_list)


# # create dataset
# random.seed(1)

# dup_list = []

# # train set
# while True:
#     rand_index = random.randrange(len(rand_list))
#     rand = rand_list[rand_index]
#     if y_sm[rand] == 0 and train_1_counter < train_1_amount:
#         train.append(xy_sm[rand])
#         rand_list.remove(rand)
#         dup_list.append(rand)
#         train_1_counter += 1
#     elif y_sm[rand] == 1 and train_2_counter < train_2_amount:
#         train.append(xy_sm[rand])
#         rand_list.remove(rand)
#         dup_list.append(rand)
#         train_2_counter += 1
#     elif y_sm[rand] == 2 and train_3_counter < train_3_amount:
#         train.append(xy_sm[rand])
#         rand_list.remove(rand)
#         dup_list.append(rand)
#         train_3_counter += 1
#     train_fully = train_1_counter == train_1_amount and train_2_counter == train_2_amount and train_3_counter == train_3_amount
#     if train_fully:
#         break

# # val set
# while True:
#     rand_index = random.randrange(len(rand_list))
#     rand = rand_list[rand_index]
#     if y_sm[rand] == 0 and val_1_counter < val_1_amount:
#         val.append(xy_sm[rand])
#         val_1_counter += 1
#     elif y_sm[rand] == 1 and val_2_counter < val_2_amount:
#         val.append(xy_sm[rand])
#         val_2_counter += 1
#     elif y_sm[rand] == 2 and val_3_counter < val_3_amount:
#         val.append(xy_sm[rand])
#         val_3_counter += 1
#     val_fully = val_1_counter == val_1_amount and val_2_counter == val_2_amount and val_3_counter == val_3_amount
#     if val_fully:
#         break

# # test set
# while True:
#     rand_index = random.randrange(len(rand_list))
#     rand = rand_list[rand_index]
#     if y_sm[rand] == 0 and test_1_counter < test_1_amount:
#         test.append(xy_sm[rand])
#         test_1_counter += 1
#     elif y_sm[rand] == 1 and test_2_counter < test_2_amount:
#         test.append(xy_sm[rand])
#         test_2_counter += 1
#     elif y_sm[rand] == 2 and test_3_counter < test_3_amount:
#         test.append(xy_sm[rand])
#         test_3_counter += 1
#     test_fully = test_1_counter == test_1_amount and test_2_counter == test_2_amount and test_3_counter == test_3_amount
#     if test_fully:
#         break



# train = np.array(train)
# val = np.array(val)
# test = np.array(test)


# x_train = [i[:-1] for i in train]
# # y_train = [i[-1] for i in train]
# y_train = []
# for i in train:
#     if i[-1] == 0:
#         y_train.append([1,0,0])
#     elif i[-1] == 1:
#         y_train.append([0,1,0])
#     elif i[-1] == 2:
#         y_train.append([0,0,1])

# x_val = [i[:-1] for i in val]
# # y_val = [i[-1] for i in val]
# y_val = []
# for i in val:
#     if i[-1] == 0:
#         y_val.append([1,0,0])
#     elif i[-1] == 1:
#         y_val.append([0,1,0])
#     elif i[-1] == 2:
#         y_val.append([0,0,1])

# x_test = [i[:-1] for i in test]
# # y_test = [i[-1] for i in test]
# y_test = []
# for i in test:
#     if i[-1] == 0:
#         y_test.append([1,0,0])
#     elif i[-1] == 1:
#         y_test.append([0,1,0])
#     elif i[-1] == 2:
#         y_test.append([0,0,1])



# x_train = np.array(x_train)
# y_train = np.array(y_train)

# x_val = np.array(x_val)
# y_val = np.array(y_val)

# x_test = np.array(x_test)
# y_test = np.array(y_test)

# print(x_train.shape)
# print(x_val.shape)
# print(x_test.shape)




minmax_norm = MinMaxScaler().fit( x_for_norm )

print( "Dataset min:" , minmax_norm.data_min_ )
print( "Dataset max:" , minmax_norm.data_max_ )


# predict function
def predict_FX(fx_data):


    data_np = np.array(fx_data)
    
    # print(data_np)
    # print(data_np.shape)
    # exit()

    # scale data
    data_scale = None
    # for i in range(data_np.shape[0]):
    #     if data_scale is None:
    #         temp = np.array([minmax_norm.transform( data_np[i].reshape(-1,1) ).reshape(-1)])
    #         data_scale = temp
    #     else:
    #         temp = np.array([minmax_norm.transform( data_np[i].reshape(-1,1) ).reshape(-1)])
    #         data_scale = np.append(data_scale, temp, axis=0)
    # data_scale = data_scale[..., np.newaxis]

    data_scale = minmax_norm.transform(data_np)
    # data_scale = data_scale[..., np.newaxis]
    data_scale = np.array([data_scale])
    # data_scale = data_scale.reshape((1, data_scale.shape[0], data_scale.shape[1]))
    print(data_scale)
    print(data_scale.shape)

    model_best = tf.keras.models.load_model('weight/' + model_file_name, compile=True )

    # print(data_scale)
    res = model_best.predict(data_scale)
    # print(res)
    # print(np.argmax(res[0]))
    # exit()

    res_predict = 0
    if res[0][np.argmax(res[0])] >= 0.95:
        res_predict = np.argmax(res[0])

    # print(f"\t\t RES {res[0][np.argmax(res[0])]}")
    print(f"\t\t RES {res[0][np.argmax(res[0])]}")
    return res_predict
    # return np.argmax(res[0])
    # return 0


status = False
pipe_send = False
pipe_return = False

data_for_predict = []


while True:


    # status file
    while True:
        try:
            f = open("status.txt", "r")
            data = f.read()
            print("status")
            data = data.replace("\n", "")
            data = data.replace(" ", "")
            print(data)
            if data == "1":
                print("next to step 2")
                status = True
            f.close()

            if status:
                break
            time.sleep(1)

        except Exception as ex:
            print(f"status ERROR : {ex}")


    # pipe_send file
    while True:

        try:
            f = open("pipe_send.txt", "r")
            data = f.read()
            print("pipe_send")
            # data = data.replace("\n", "")
            data = data.replace(" ", "")
            print(data)
            data_split = data.split("\n")
            data_split.remove("")
            print()
            print(data_split)
            print(len(data_split))
            # print(data_split[0])
            # exit()
            if len(data_split) == inp_width:
                print("next to step 3")
                data_for_predict = []
                for i in data_split:
                    
                    # print(i)
                    # exit()
                    data_split_arr = i.split(",")
                    print(data_split_arr)
                    temp = [float(j) for j in data_split_arr]
                    print(temp)
                    # exit()
                    data_for_predict.append(temp)

                pipe_send = True
            f.close()

            print()
            print()
            print()
            print()
            # for i in data_for_predict:
            #     print(i)
            # exit()
            if pipe_send:
                break
            time.sleep(1)

        except Exception as ex:
            print(f"pipe_send ERROR : {ex} > Line {sys.exc_info()[-1].tb_lineno}")

    
    # pipe_return file
    while True:
        
        try:

            f = open("pipe_return.txt", "w")
            print("pipe_return")

            # rand = random.randrange(1, 3)
            # print(f"random : {rand}")
            # f.write(str(rand))
            

            # test = np.array(data_for_predict)
            # print(test)
            # print(test.shape)
            # exit()

            pct_res = predict_FX(data_for_predict)
            print("\n\n\n")
            print(f"predict : {pct_res}")
            print("\n\n\n")
            f.write(str(pct_res))

            f.close()


            # restore data in file
            f = open("status.txt", "w")
            f.write("0")
            f.close()

            f = open("pipe_send.txt", "w")
            f.write("")
            f.close()

            status = False
            pipe_send = False

            break



        except Exception as ex:
            print(f"pipe_return ERROR : {ex} > Line {sys.exc_info()[-1].tb_lineno}")
            # print(sys.exc_info()[-1].tb_lineno)