#  Archify – Architectural Style Recognition with Deep Learning

Archify is a mobile application that classifies architectural styles from building images using a lightweight deep learning model optimized for on-device inference.

The project focuses on computer vision, transfer learning, and deploying deep learning models on mobile devices using TensorFlow Lite.

---

## Tech Stack
- Mobile: Flutter
- ML: TensorFlow, Keras, TensorFlow Lite
- Model Optimization: Keras Tuner
- Language: Python, Dart

---

## Key Features
- Classification of 25 architectural styles from images
- Transfer learning using MobileNetV2
- Fully offline inference with TensorFlow Lite
- Mobile-optimized model for real-time predictions
- No server or cloud dependency

---

## Architecture & Design

### Model Architecture
- Backbone: **MobileNetV2**
- Transfer learning with frozen convolutional layers
- Custom classification head trained on architectural styles

### Dataset & Training
- Dataset size: 10,113 images
- Number of classes: 25 architectural styles
- Data sourced from public architectural image datasets
- Hyperparameter tuning performed using Keras Tuner

### Evaluation Metrics
| Metric | Value |
|------|-------|
| Validation Accuracy | 57% |
| Macro F1 Score | 0.56 |

The results reflect the inherent difficulty of architectural style classification due to visual similarity between classes.

---

## Mobile Integration
- Trained model converted to `.tflite` format
- Model embedded directly into the Flutter application
- All inference runs locally on the device (Android)
- Real-time predictions from camera or gallery images

---

## Screenshots

| Input Image | Prediction |
|------------|------------|
| ![Input](https://github.com/user-attachments/assets/edc05d85-14ab-4d70-a498-02f699af7485) | ![Prediction](https://github.com/user-attachments/assets/45828ee3-7449-493f-b4c9-81e3377fbb34) |

---

## Setup
1. Clone the repository
2. Install Flutter dependencies
3. Ensure the TensorFlow Lite model is placed under `assets/model/`
4. Run the application on an Android emulator or device

---

## License
This project is licensed under the MIT License.
