# 🏛️ Archify — AI-Powered Mobile App for Architectural Style Recognition

**Archify** is a Flutter-based mobile application that classifies architectural styles from building photos using an on-device deep learning model.

Originally developed as a B.Sc. graduation project, the app leverages **TensorFlow Lite** and **MobileNetV2** to deliver fast, offline predictions.

> 🏛️ Trained on 10K+ images across 25 architectural styles  
> 📱 Real-time inference with TensorFlow Lite, no internet required

---

## 🧠 Key Features

- Classifies styles such as Art Deco, Gothic, Bauhaus, Romanesque, etc.
- Uses transfer learning with frozen **MobileNetV2** base layers
- Model optimized for mobile inference (`.tflite`)
- Fully offline — no server or cloud dependency

---

## 📷 Demo Preview

| Input Image | Prediction |
|------------|------------|
| ![Input](https://github.com/user-attachments/assets/edc05d85-14ab-4d70-a498-02f699af7485) | ![Prediction](https://github.com/user-attachments/assets/45828ee3-7449-493f-b4c9-81e3377fbb34) |

---

## 📊 Dataset

- **Source:** [Architectural Styles Dataset (Kaggle)](https://www.kaggle.com/datasets/dumitrux/architectural-styles-dataset)  
- **Size:** 10,113 images  
- **Classes:** 25 architectural styles  
- **Origin:** Public image search and ECCV 2014 dataset

---

## 🧪 Model Overview

- **Architecture:** MobileNetV2 (transfer learning, frozen conv layers)  
- **Tuning:** Hyperparameters optimized with **Keras Tuner**  
- **Performance:**  
  - Accuracy: **57%** (validation)  
  - Macro F1-score: **0.56**

### Stack

- TensorFlow · Keras · Keras Tuner  
- Python · Flutter · TensorFlow Lite

---

## 📱 Mobile Integration

- `.tflite` model deployed inside Flutter app  
- Inference runs locally on device (Android)  
- Instant predictions from captured or uploaded images

---

## ⚙️ Setup & Run

### Requirements
- Flutter 3.22+  
- TensorFlow 2.14.x  
- Android SDK 33+  
- Android Studio or VS Code (Flutter plugin)  
- Android emulator or physical device

### Run Locally

```bash
git clone https://github.com/furkangenca/archify-mobile-ai.git
cd archify-mobile-ai
flutter pub get
flutter run
```

> ✅ Ensure `model.tflite` is placed under `/assets/model/` and registered in `pubspec.yaml`.

---

## 👤 About

**Furkan Gença**  
Graduation Project — B.Sc. Software Engineering (2025)  
GitHub: [@furkangenca](https://github.com/furkangenca)

---

## 📄 License

Licensed under the [MIT License](./LICENSE).  
You may use, modify, and distribute this project under its terms.
