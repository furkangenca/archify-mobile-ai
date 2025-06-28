# 🧠 Archify — Mobile AI for Architectural Style Recognition

**Archify** is a mobile deep learning app that classifies architectural styles from building photos.  
Built with **Flutter** and deployed using **TensorFlow Lite**, it performs real-time predictions entirely on-device.

Originally developed as a deep learning graduation project focused on mobile deployment.

> 🏛️ Trained on 10,000+ labeled images across 25 architectural styles  
> 📱 Deployed with TensorFlow Lite using MobileNetV2  

---

## 🧠 Overview

- Recognizes styles like Art Deco, Gothic, Bauhaus, Romanesque  
- Trained using transfer learning (MobileNetV2 base, frozen layers)  
- Optimized for mobile inference using `.tflite`  
- No internet required — works fully offline

---

## 📷 UI Preview

| Uploaded Image | Predicted Style |
|----------------|------------------|
| ![Input](https://github.com/user-attachments/assets/edc05d85-14ab-4d70-a498-02f699af7485) | ![Prediction](https://github.com/user-attachments/assets/45828ee3-7449-493f-b4c9-81e3377fbb34) |

---

## 📂 Dataset

- **Source:** [Architectural Styles Dataset (Kaggle)](https://www.kaggle.com/datasets/dumitrux/architectural-styles-dataset)  
- **Size:** 10,113 images  
- **Classes:** 25 styles (e.g. Byzantine, Gothic, Bauhaus, Baroque, etc.)  
- **Note:** Data gathered from public image search and ECCV 2014 set

---

## 🧪 Model Summary

- Base model: **MobileNetV2** with frozen convolutional layers  
- Optimized using Keras Tuner  
- Final performance (validation set):  
  - Accuracy: **57%**  
  - Macro F1: **0.56**

### Tools Used

- TensorFlow · Keras · Keras Tuner  
- Python · Flutter · TensorFlow Lite

---

## 📱 Mobile Deployment

- Model converted to `.tflite` using TensorFlow Lite  
- Integrated into Flutter application  
- Predictions are made locally on the device  
- Upload or take a photo → receive style prediction in real time

---

## ⚙️ Environment

- **Flutter:** 3.22.x  
- **TensorFlow:** 2.14.x  
- **Android SDK Target:** 33+

---

## ⚙️ Setup & Run

### Prerequisites
- Flutter SDK 3.22+
- Android Studio or VS Code with Flutter extension
- Android emulator or physical device

### Run the App

```bash
git clone https://github.com/furkangenca/archify-mobile-ai.git
cd archify-mobile-ai
flutter pub get
flutter run
```

    📦 Make sure the .tflite model file is located under /assets/model/ and listed in pubspec.yaml.

---

## 📬 Contact

**Furkan Gença**  
*Graduation Project — B.Sc. Software Engineering (2025)*  
[@furkangenca](https://github.com/furkangenca)

---

## ⚠️ License

> This project is **not open source**.  
> Code and model are private. For academic presentation only.
