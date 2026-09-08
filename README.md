# CAMU - Couverture Maladie Universelle

Application mobile de gestion de couverture santé universelle.

---

## Prérequis

- [Flutter 3.19+](https://flutter.dev)
- Dart 3.3+
- Android Studio / VS Code (recommandé)
- Git

---

## Installation

### 1. Cloner le dépôt

```bash
git clone https://github.com/like2300/apps-project.git
cd apps-project
```

### 2. Installer les dépendances

```bash
flutter pub get
```

### 3. Lancer l'application

```bash
flutter run
```

---

## Installation Par Plateforme

### Linux

#### Installer Flutter

```bash
# Installer les dépendances
sudo apt update
sudo apt install git curl unzip xz-utils libgtk-3-dev -y

# Télécharger Flutter
cd ~
git clone https://github.com/flutter/flutter.git -b stable

# Ajouter Flutter au PATH
echo 'export PATH="$PATH:`pwd`/flutter/bin"' >> ~/.bashrc
source ~/.bashrc

# Vérifier
flutter doctor
```

#### Activer Android (optionnel)

```bash
# Installer Android Studio
sudo snap install android-studio --classic

# Installer les outils Android
sudo apt install android-tools-adb android-tools-fastboot -y

# Configurer les variables d'environnement
echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> ~/.bashrc
echo 'export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"' >> ~/.bashrc
source ~/.bashrc
```

#### Lancer l'application

```bash
cd apps-project
flutter run -d linux
```

---

### macOS

#### Installer Flutter

```bash
# Installer Flutter
cd ~
git clone https://github.com/flutter/flutter.git -b stable

# Ajouter Flutter au PATH
echo 'export PATH="$PATH:`pwd`/flutter/bin"' >> ~/.zshrc
source ~/.zshrc

# Installer Xcode (via App Store)
# Puis installer les outils en ligne de commande
xcode-select --install

# Accepter les licences Xcode
sudo xcodebuild -runFirstLaunch
```

#### Configurer le simulateur iOS

```bash
# Lister les appareils disponibles
flutter devices

# Lancer le simulateur (choisir un appareil)
open -a Simulator
```

#### Lancer l'application

```bash
cd apps-project
flutter run
```

---

### Windows

#### Installer Flutter

```powershell
# Télécharger Flutter dans C:\src\flutter
cd C:\
git clone https://github.com/flutter/flutter.git -b stable --depth 1

# Ajouter Flutter au PATH
[Environment]::SetEnvironmentVariable("Path", "$env:Path;C:\src\flutter\bin", "User")

# Redémarrer le terminal
```

#### Installer Android Studio

1. Télécharger et installer [Android Studio](https://developer.android.com/studio)
2. Pendant l'installation, s'assurer que :
   - Android SDK est installé
   - Android SDK Platform
   - Android Virtual Device (AVD)
   - Performance (Intel HAXM)

#### Configurer les variables d'environnement

```powershell
[Environment]::SetEnvironmentVariable("ANDROID_HOME", "$env:LOCALAPPDATA\Android\Sdk", "User")
[Environment]::SetEnvironmentVariable("Path", "$env:Path;$env:LOCALAPPDATA\Android\Sdk\platform-tools", "User")
```

#### Lancer l'application

```powershell
cd apps-project
flutter run
```

---

## Commandes Utiles

### Générer les icônes d'application

```bash
flutter pub run flutter_launcher_icons:main
```

### Build APK (Android)

```bash
flutter build apk --release
# Le fichier se trouve dans : build/app/outputs/flutter-apk/app-release.apk
```

### Build APP (iOS)

```bash
flutter build ios --release
# Ouvrir le projet dans Xcode pour archiver
cd ios
xcodebuild archive -workspace Runner.xcworkspace -scheme Runner -archivePath build/Runner.xcarchive
```

### Build Linux

```bash
flutter build linux --release
# Le fichier se trouve dans : build/linux/x64/release/bundle/
```

---

## Ressources

- [Flutter Documentation](https://flutter.dev/docs)
- [Flutter GitHub](https://github.com/flutter/flutter)
- [Dart Documentation](https://dart.dev/docs)

---

## Licence

Ce projet est sous licence [MIT](LICENSE).

---

*Projet développé avec Flutter et Dart*
# apps-project
