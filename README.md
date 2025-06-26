# 🧠 Archify – Mobile AI for Architectural Style Recognition

**Archify** is a mobile AI application that classifies architectural styles from building images using deep convolutional neural networks. Built for an academic project in deep learning, it combines custom-trained CNNs and transfer learning with a real-time Flutter interface and TensorFlow Lite deployment.

> 🏛️ Trained on 10,000+ images across 25 architectural styles  
> 📱 Deployed as an on-device model using TensorFlow Lite  
> 🎯 Final accuracy: ~57% (Macro F1: 0.56)

---

## 📂 Dataset

- **Source:** [Architectural Styles Dataset (Kaggle)](https://www.kaggle.com/datasets/dumitrux/architectural-styles-dataset)  
- **Total Images:** 10,113  
- **Classes:** 25 architectural styles  
- **Examples:** Art Deco, Gothic, Bauhaus, Byzantine, Romanesque, etc.  
- **Note:** Dataset includes images from both Google Images and ECCV 2014 research data.

---

## 🧪 Model Development

### Tested Architectures:
- Custom CNN (Conv2D + MaxPooling)
- **MobileNetV2** (best results)
- EfficientNetB0
- ResNet50

### Tools & Libraries:
- TensorFlow & Keras
- Keras Tuner (Hyperparameter optimization)
- Python
- Flutter (UI)
- TensorFlow Lite (deployment)

---

## 🧠 Results (on validation set)

| Model                  | Accuracy | Macro F1 | Precision | Recall |
|------------------------|----------|----------|-----------|--------|
| MobileNetV2 (Frozen)   | 57%      | 0.56     | 0.58      | 0.56   |
| ResNet50               | 18%      | 0.13     | 0.16      | 0.17   |
| EfficientNetB0         | 7%       | 0.01     | 0.00      | 0.04   |

> 📌 **MobileNetV2** with frozen layers yielded the best performance for this dataset.

---

## 📱 Mobile Deployment

- Final model converted to `.tflite` using TensorFlow Lite
- Integrated into a **Flutter mobile app**
- On-device inference: no internet required
- Predicts architectural style from uploaded building images

---

## 🆕 Innovation

- Rare topic: architecture style recognition via DL is not widely explored
- Combines academic rigor (multiple model benchmarking) with real-world deployment
- Mobile AI – no server dependency

---

## 🔜 Future Work

- Improve dataset balance and augment underrepresented classes
- Add GPS and historical info overlay to enhance tourist use case
- Apply model compression for older devices

---

## ⚠️ License

This project is licensed under the MIT License.  
Please refer to the `LICENSE` file for usage permissions.
