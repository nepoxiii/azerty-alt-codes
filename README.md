# Alt-Codes AZERTY (AutoHotkey v2)

Script d'émulation robuste des **Alt-Codes** pour claviers sans pavé numérique (ordinateurs portables, formats 60%/TKL) avec disposition **AZERTY française**.

Permet notamment de générer facilement une puce avec **`Alt + è = •`**, ainsi que l'ensemble des combinaisons de symboles de **1 à 30** (table OEM / CP437).

---

## 🚀 Fonctionnement rapide

1. **Maintenez la touche `Alt` gauche enfoncée** (vous pouvez la maintenir aussi longtemps que nécessaire).
2. **Tapez le ou les chiffres souhaités** sur la rangée supérieure de votre clavier (**sans appuyer sur Shift**) :
   - `&` = 1
   - `é` = 2
   - `"` = 3
   - `'` = 4
   - `(` = 5
   - `-` = 6
   - `è` = 7  *(ex: Alt + è pour la puce `•`)*
   - `_` = 8
   - `ç` = 9
   - `à` = 0
3. **Relâchez la touche `Alt` gauche** : le symbole s'affiche instantanément.

> **Astuce :** Si vous vous trompez dans la saisie avant d'avoir relâché Alt, appuyez sur la touche **`Échap`** pour annuler.

---

## 📋 Table des combinaisons (1 à 30)

| Code | Touche(s) AZERTY | Symbole | Description |
| :---: | :--- | :---: | :--- |
| **1** | Alt + `&` | **☺** | Visage souriant blanc |
| **2** | Alt + `é` | **☻** | Visage souriant noir |
| **3** | Alt + `"` | **♥** | Cœur |
| **4** | Alt + `'` | **♦** | Carreau |
| **5** | Alt + `(` | **♣** | Trèfle |
| **6** | Alt + `-` | **♠** | Pique |
| **7** | Alt + `è` | **•** | **Puce (bullet point)** |
| **8** | Alt + `_` | **◘** | Puce carrée inversée |
| **9** | Alt + `ç` | **○** | Cercle blanc |
| **10** | Alt + `&` puis `à` | **◙** | Cercle inverse |
| **11** | Alt + `&` puis `&` | **♂** | Symbole masculin (Mars) |
| **12** | Alt + `&` puis `é` | **♀** | Symbole féminin (Vénus) |
| **13** | Alt + `&` puis `"` | **♪** | Note de musique simple |
| **14** | Alt + `&` puis `'` | **♫** | Double note de musique |
| **15** | Alt + `&` puis `(` | **☼** | Soleil rayonnant |
| **16** | Alt + `&` puis `-` | **►** | Flèche droite pleine |
| **17** | Alt + `&` puis `è` | **◄** | Flèche gauche pleine |
| **18** | Alt + `&` puis `_` | **↕** | Double flèche verticale |
| **19** | Alt + `&` puis `ç` | **‼** | Double point d'exclamation |
| **20** | Alt + `é` puis `à` | **¶** | Pied-de-mouche (paragraphe) |
| **21** | Alt + `é` puis `&` | **§** | Symbole section / paragraphe |
| **22** | Alt + `é` puis `é` | **▬** | Rectangle noir horizontal |
| **23** | Alt + `é` puis `"` | **↨** | Flèche verticale avec base |
| **24** | Alt + `é` puis `'` | **↑** | Flèche vers le haut |
| **25** | Alt + `é` puis `(` | **↓** | Flèche vers le bas |
| **26** | Alt + `é` puis `-` | **→** | Flèche vers la droite |
| **27** | Alt + `é` puis `è` | **←** | Flèche vers la gauche |
| **28** | Alt + `é` puis `_` | **∟** | Angle droit |
| **29** | Alt + `é` puis `ç` | **↔** | Double flèche horizontale |
| **30** | Alt + `"` puis `à` | **▲** | Triangle plein vers le haut |
| *(31)* | Alt + `"` puis `&` | **▼** | Triangle plein vers le bas |

*(Le script supporte également tous les autres codes étendus Windows, par exemple Alt + 0169 pour `©` ou Alt + 0128 pour `€`).*

---

## ⚙️ Points forts techniques

- **Indépendance totale** : Le script ne dépend pas du moteur fragile de pavé numérique de Windows. Il gère sa propre mémoire interne et injecte directement les caractères Unicode réels.
- **Maintien d'Alt prolongé sans échec** : Vous pouvez maintenir Alt enfoncé plusieurs secondes sans que Windows n'annule la commande ou ne bascule sur la barre de menus.
- **Anti-répétition matérielle** : Même si vous gardez le doigt appuyé sur un chiffre, celui-ci n'est comptabilisé qu'une seule fois grâce à `KeyWait`.
- **Préservation de `AltGr`** : Seule la touche `Alt` gauche est capturée. Les raccourcis classiques de la touche `AltGr` (`@`, `~`, `#`, `{`, `[`, `|`, `` ` ``, `\`, `^`, `]`, `}`) continuent de fonctionner sans aucune interférence.

---

## 📦 Installation et démarrage

### Prérequis
- [AutoHotkey v2.0+](https://www.autohotkey.com/) installé sur votre machine Windows.

### Lancer le script
- Double-cliquez simplement sur le fichier `alt + è = •.ahk`.
- Une icône verte **H** apparaîtra dans la zone de notification (près de l'horloge).

### Recharger le script
- Si vous apportez une modification, faites un clic droit sur l'icône **H** et cliquez sur **Reload Script**.

### Démarrage automatique avec Windows (optionnel)
1. Appuyez sur `Win + R`.
2. Tapez `shell:startup` et validez par Entrée.
3. Créez et déposez un raccourci vers `alt + è = •.ahk` dans ce dossier.
Le script démarrera automatiquement à chaque ouverture de session.
