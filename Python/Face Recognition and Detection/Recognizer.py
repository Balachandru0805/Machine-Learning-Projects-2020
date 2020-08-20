import numpy as np
import pickle
import glob, face_recognition, cv2

f = open('name.pkl','rb')
name_dict = pickle.load(f)
f.close()

f = open('embed.pkl','rb')
embed_dict = pickle.load(f)
f.close()

known_face_names = []
known_face_encoding = []

for id,embeds in embed_dict().items():
    for embed in embeds:
        known_face_names += [id]
        known_face_encoding += [embed]

face_locations = []
face_encodings = []
face_names = []
process_this_frame = True

webcam = cv2.VideoCapture(0)

while True:
    check, frame = webcam.read()
    small_frame = cv2.resize(frame, (0, 0), fx=0.25, fy=0.25)
    rgb_small_frame = small_frame[:, :, ::-1]

    if process_this_frame:
        face_locations = face_recognition.face_locations(rgb_small_frame)
        face_encodings = face_recognition.face_encodings(rgb_small_frame, face_locations)
        
        face_names = []
        for face_encoding in face_encodings:
            matches = face_recognition.compare_faces(known_face_encodings, face_encoding)
            name = "Unknown"
            face_distances = face_recognition.face_distance(known_face_encodings, face_encoding)
            best_match_index = np.argmin(face_distances)
            if matches[best_match_index]:
                name = known_face_names[best_match_index]
            face_names.append(name)
            
    process_this_frame = not process_this_frame
    
    for (top_s, right, bottom, left), name in zip(face_locations, face_names):
        top_s *= 4
        right *= 4
        bottom *= 4
        left *= 4

        cv2.rectangle(frame, (left, top_s), (right, bottom), (0, 0, 255), 2)
        cv2.rectangle(frame, (left, bottom - 35), (right, bottom), (0, 0, 255), cv2.FILLED)
        font = cv2.FONT_HERSHEY_DUPLEX
        cv2.putText(frame, ref_dictt[name], (left + 6, bottom - 6), font, 1.0, (255, 255, 255), 1)
    font = cv2.FONT_HERSHEY_DUPLEX
    cv2.imshow('Video', frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
webcam.release()
cv2.destroyAllWindows()
    

























