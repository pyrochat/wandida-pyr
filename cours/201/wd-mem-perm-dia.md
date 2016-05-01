<!-- DIAPORAMA -->

<section class="page_de_garde">
<img src="../../statiques/images/epfl-logo-pp.png" style="top:1.05cm; left:1.95cm; width:5.87cm" />
<img src="../../statiques/images/trait-rouge.png" style="top:5.07cm; left:0cm; width:60.02cm; height:0.23cm" />
<div style="top:11cm; left:4cm; font-size:50pt; font-family: Arial Narrow, sans-serif; color: #e2001a; ">Systèmes embarqués</div>
<div style="top:20cm; left:4cm; font-size:70pt; font-family: Impact, sans-serif;">Mémoires permanentes pour les microcontrôleurs</div>
<div style="top:27.7cm; left:4cm; font-size:47pt; font-family: Arial Narrow, sans-serif;">Pierre-Yves Rochat</div>
<img src="./images/dring-allo.svg" style="top:12cm; left:36cm; width:12cm;" />
<img src="./images/inter-principe.svg" style="top:11.5cm; left:48cm; width:10cm;" />
<img src="./images/decodage-inter.svg" style="top:23cm; left:37cm; width:20cm;" />
</section>


<section>
<h1 class="en_tete">Mémoires permanentes pour les microcontrôleurs</h1>
<!-- def A --><img src="../../statiques/images/epfl-logo-pp.png" style="top:0.8cm; left:54.41cm; width:3.6cm" />
<!-- def A --><img src="../../statiques/images/trait-rouge.png" style="top:5.07cm; left:0cm; width:60.02cm; height:0.23cm" />
<!-- def A --><div style="top:31.26cm; left:35cm; width:23cm; text-align: right;  font-size:21pt; font-family: Arial Narrow, sans-serif; color:#555555;">
<!-- def A -->Systèmes embarqués | **Mémoires permanentes pour les microcontrôleurs**
<!-- def A --></div>
<!-- A -->
<div style="top:6.5cm; left:35cm; width:23cm; text-align: right;  font-size:48pt; font-family: Impact, sans-serif;">
Pierre-Yves Rochat
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Types de mémoires</h1>
<div style="top:9cm; left:2.65cm; line-height:1.2; font-size:50pt;">
* Principalement deux mémoires dans un microcontrôleur :
</div>
<!-- 234 --><div style="top:11cm; left:3.65cm; line-height:1.2; font-size:50pt;">
<!-- 234 -->`1.` Mémoire Flash, pour les programmes<br/>
<!-- 34 -->`2.` Mémoire vive (RAM) pour les données
<!-- 234 --></div>
<!-- 4 --><div style="top:20cm; left:2.65cm; line-height:1.2; font-size:50pt;">
<!-- 4 -->* Comment conserver des données ?<br/> Par exemple des paramètres de fonctionnement du système,<br/> des compteurs d'utilisation, etc.
<!-- 4 --></div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">EEPROM</h1>
<div style="top:9cm; left:2.65cm; line-height:1.2; font-size:50pt;">
* Certains microcontrôleurs disposent d’une mémoire du type EEPROM
<br/>*Electrically-Erasable Programmable Read-Only Memory*
<br/><br/>
<!-- 23 -->* Par exemple, l’ATmega328<br/> dispose de 1 kB d’EEPROM
</div>
<!-- 3 --><img src="./images/eeprom-avr.svg" style="top:15cm; left:30cm; width:15cm;" />
</section>


<section>
<!-- A -->
<h1 class="en_tete">EEPROM : programmation</h1>
<img src="./images/eeprom-avr.svg" style="top:7cm; left:42cm; width:10cm;" />
<div style="top:10cm; left:2cm; font-size:36pt;">
~~~~~~~ { .c .numberLines startFrom="1" }
  // Lecture en EEPROM :
  EEAR = adresse; // l'adresse est donnée
  EECR = (1<<EERE); // le fanion de lecture est activé
  valeur = EEDR; // lecture de la valeur

  // Ecriture en EEPROM :
  while (EECR & (1<<EEPE)) {} // attente de la fin d'une éventuelle écriture précédente
  EEAR = adresse; // l'adresse est donnée
  EEDR = valeur; // la valeur est donnée
  EECR = (1<<EEMPE); // autorise une écriture (Master Write Enable)
  EECR = (1<<EEPE); // lance le cycle d'écriture (Write Enable)
~~~~~~~
<!-- retour au mode normal pour l'éditeur -->
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">FLASH</h1>
<div style="top:9cm; left:2.65cm; line-height:1.2; font-size:50pt; width:53cm">
* Il est généralement possible d’accéder à la mémoire flash d’un microcontrôleur
<!-- 234 --><br/>... en faisant attention à ne pas détruire le programme !
<!-- 34 --><br/><br/>
<!-- 34 -->* C’est un peu plus difficile sur des microcontrôleurs dont l’architecture n’est pas du type Von Neumann
<!-- 4 --><br/><br/>
<!-- 4 -->* Dans tous les cas, l’effacement s’effectue par bloc
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">FLASH : programmation</h1>
<div style="top:7cm; left:2cm; font-size:36pt;">
~~~~~~~ { .c .numberLines startFrom="1" }
  // Lecture en Flash :
  uint8_t *pointeur; // pointeur dans la Flash
  pointeur = (uint8_t *) 0x1040; //place l'adresse dans le pointeur
  uint8_t valeur = *pointeur;

  // Ecriture en Flash :
  FCTL3 = FWKEY; // Clear Lock bit
  *pointeur = valeur; // écrit la valeur dans la Flash
  FCTL3 = FWKEY + LOCK; // Set LOCK bit

  // Effacement d'un bloc de la mémoire Flash
  FCTL1 = FWKEY + ERASE; // Set Erase bit
  FCTL3 = FWKEY; // Clear Lock bit
  *pointeur = 0; // lance un cycle d'effacement du bloc, la valeur donnée n'a pas d'importance
  FCTL3 = FWKEY + LOCK; // Set LOCK bit
  FCTL1 = FWKEY; // Clear WRT bit
~~~~~~~
<!-- retour au mode normal pour l'éditeur -->
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Limite du nombre de cycles d’écriture</h1>
<div style="top:9cm; left:2.65cm; line-height:1.2; font-size:50pt;line-height: 1.5;">
* Pour chaque type de mémoire non-volatile, un nombre de cycles limité
<!-- 23 -->* Typiquement 10’000 pour une FLASH
<!-- 3 -->* 100’000 pour une EEPROM
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Mémoires externes</h1>
<!-- Contenu : -->
<div style="top:9cm; left:2.65cm; line-height:1.2; font-size:50pt;line-height: 1.5;">
* Il est possible d’ajouter des mémoires non-volatiles externes :
<!-- 234 -->* RAM secourues
<!-- 34 -->* EEPROM série (I2C ou SPI)
</div>
<div>
<!-- 4 --><img src="./images/m95256.svg" style="top:13cm; left:26cm; width:28cm;" />
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Mémoires externes</h1>
<!-- Contenu : -->
<div style="top:9cm; left:2.65cm; line-height:1.2; font-size:50pt;line-height: 1.5;">
* Il est possible d’ajouter des mémoires non-volatiles externes :
* RAM secourues
* EEPROM série
* Cartes SD
</div>
<!-- 2 --><img src="./images/sd-microsd.png" style="top:15cm; left:26cm; width:25cm;" />
</section>


<section>
<!-- A -->
<h1 class="en_tete">Système de fichier</h1>
<div style="top:9cm; left:2.65cm; line-height:1.2; font-size:50pt;line-height: 1.5;">
* Compliqué de gérer les données d’une carte SD
<!-- 234 -->* Pratique d’utiliser un système de fichier : par exemple FAT 32
<!-- 34 -->* Des librairies sont disponibles
<!-- 4 --><br/>PetitFat :
<!-- 4 --></div>
<!-- 4 --><div style="top:15cm; left:13cm; line-height:1.2; font-size:40pt;line-height: 1;">
<!-- 4 --><br/><br/>
<!-- 4 -->*Procédure*<br/>
<!-- 4 -->`pf_mount:`<br/>
<!-- 4 -->`pf_open:`<br/>
<!-- 4 -->`pf_read:`<br/>
<!-- 4 -->`pf_write:`<br/>
<!-- 4 -->`pf_lseek:`<br/>
<!-- 4 -->`pf_opendir:`<br/>
<!-- 4 -->`pf_readdir:`
<!-- 4 --></div>
<!-- 4 --><div style="top:15cm; left:23cm; line-height:1.2; font-size:40pt;line-height: 1;">
<!-- 4 --><br/><br/>
<!-- 4 -->*Rôle*<br/>
<!-- 4 -->`Monter un volume`<br/>
<!-- 4 -->`Ouvrir un fichier`<br/>
<!-- 4 -->`Lire des données dans un fichier`<br/>
<!-- 4 -->`Écrire des données dans un fichier`<br/>
<!-- 4 -->`Déplacer le pointeur de lecture ou d’écriture`<br/>
<!-- 4 -->`Ouvrir un dossier`<br/>
<!-- 4 -->`Lire le contenu d’un dossier`
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Mémoires permanentes pour les microcontrôleurs</h1>
<div class="liste_demi">
* RAM : non-volatile
* EEPROM
* Mémoires Flash
* Mémoires externes
</div>
<img src="./images/microsd.png" style="top:2cm; left:26cm;" />
</section>





