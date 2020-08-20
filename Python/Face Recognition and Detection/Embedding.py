import sys
import pickle
import cv2
import face_recognition

name = input('Enter Name : ')
id = input('Enter Id : ')

try:
    f = open('name.pkl','rb')
    name_dict = pickle.load(f)
    f.close()
except:
    name_dict = {}
    name_dict[id] = name

f = open('name.pkl','wb')
pickle.dump(name_dict,f)
f.close()

try:
    f = open('embed.pkl','rb')
    embed_dict = pickle.load(f)
    f.close()
except:
    embed_dict = {}


for i in range(5):
    key = cv2.waitKey(1)
    webcam = cv2.VideoCapture()

    while True:
        check, frame = webcam.read()
        cv2.imshow('Capturing', frame)
        small_frame = cv2.resize(frame, (0,0), fx=0.25, fy=0.25)
        rgb_small_frame = small_frame[:, :, ::-1]

        key = cv2.waitKey(1)
        if key==ord('s'):
            face_locations = face_recognition.face_locations(rgb_small_frame)
            if face_locations != []:
                face_encoding = face_recognition.face_encodings(frame)[0]
                if id in embed_dict:
                    embed_dict[id] +=[face_encoding]
                else:
                    embed_dict[id] = [face_encoding]
                webcam.release()
                cv2.waitKey(1)
                cv2.destroyAllWindows()
                break
        elif key==ord('q'):
            print('Turining off Camera')
            webcam.release()
            print('Progrm ended')
            cv2.destroyAllWindows()
            break

        
f=open("embed.pkl","wb")
pickle.dump(embed_dictt,f)
f.close()

























                
    
