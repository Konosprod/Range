Range
=====

Renommez-le "range" et faites un "sudo cp rang /usr/local/bin" afin de l'installer. Vous pouvez maintenant vous en servir dans un terminal normalement.

Utilisation
-----------
range [Dossier à trier]

###Support actuellement

* Documents
  * .pdf
  * .ps
  * .odt
  * .me
  * .txt
* Archives
  * .rar
  * .zip
  * .iso
  * .gz
  * .deb
  * .bz
* Windows
  * .exe
* Audio
  * .mp3
  * .ogg
* Vidéo
  * .mp4
  * .ogv
  * .flv
  * .wmv
* Images
  * .bmp
  * .png
  * .jpg
  * .gif
* Programmation
  * .c
  * .sh
  * .lua

###Comment ajouter mes formats ?

Il faut éditer le fichier range, et connaitre le type mime du format de fichier que vous voulez ajouter. Pour ceci il faut utiliser la commande :

file -bi [FICHIER]


