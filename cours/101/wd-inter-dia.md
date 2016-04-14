<!-- DIAPORAMA -->


<!-- Page de titre -->
<section class="page_de_garde">
<img src="../../statiques/images/epfl-logo-pp.png" style="top:1.05cm; left:1.95cm; width:5.87cm" />
<img src="../../statiques/images/trait-rouge.png" style="top:5.07cm; left:0cm; width:60.02cm; height:0.23cm" />
<div style="top:11cm; left:4cm; font-size:50pt; font-family: Arial Narrow, sans-serif; color: #e2001a; ">Systèmes embarqués</div>
<div style="top:20cm; left:4cm; font-size:70pt; font-family: Impact, sans-serif;">Introduction aux interruptions</div>
<div style="top:27.7cm; left:4cm; font-size:47pt; font-family: Arial Narrow, sans-serif;">Pierre-Yves Rochat</div>
<img src="./images/dring-allo.svg" style="top:12cm; left:36cm; width:12cm;" />
<img src="./images/inter-principe.svg" style="top:11.5cm; left:48cm; width:10cm;" />
<img src="./images/decodage-inter.svg" style="top:23cm; left:37cm; width:20cm;" />
</section>

<!-- Page bienvenue plein écran-->
<section>
<h1 class="en_tete">Introduction aux interruptions</h1>
<!-- def A --><img src="../../statiques/images/epfl-logo-pp.png" style="top:0.8cm; left:54.41cm; width:3.6cm" />
<!-- def A --><img src="../../statiques/images/trait-rouge.png" style="top:5.07cm; left:0cm; width:60.02cm; height:0.23cm" />
<!-- def A --><div style="top:31.26cm; left:35cm; width:23cm; text-align: right;  font-size:21pt; font-family: Arial Narrow, sans-serif; color:#555555;">
<!-- def A -->Systèmes embarqués | **Introduction aux interruptions**
<!-- def A --></div>
<!-- A -->
<div style="top:6.5cm; left:35cm; width:23cm; text-align: right;  font-size:48pt; font-family: Impact, sans-serif;">
Pierre-Yves Rochat
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Motivation des interruptions</h1>
<div style="font-size:55pt; left:2.65cm; top:5.5cm; width:55cm">
De manière générale un microcontrôleur doit être programmé pour :
</div>
<img src="./images/sys-io.svg" style="top:12cm; left:39cm; width:20cm;" />
<!-- 234567 --><div style="font-size:55pt; left:2.65cm; top:10.5cm; width:55cm">
<!-- 234567 -->* détecter des changements sur ses entrées
<!-- 34567 -->* agir en conséquence sur ses sorties
<!-- 234567 --></div>
<!-- 4567 --><div style="font-size:55pt; left:2.65cm; top:15.5cm;">
<!-- 4567 -->On constate que :
<!-- 4567 --></div>
<!-- 567 --><div style="font-size:55pt; left:2.65cm; top:20.5cm;">
<!-- 567 -->* Les sorties gardent leur état jusqu'au prochain changement
<!-- 67 -->* Mais pour les entrées, on ne sait pas quand elles vont changer
<!-- 7 -->* On utilise la scrutation ( *polling* ), qui prend beaucoup de temps
<!-- 567 --></div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Définition</h1>
<div style="font-size:55pt; left:2.65cm; top:5.5cm; width:55cm">
On appelle interruption l’arrêt temporaire d’un programme au profit d’un autre programme, jugé à cet instant plus important.
</div>
<!-- 23456 --><div style="font-size:55pt; left:2.65cm; top:14.5cm;">
<!-- 23456 -->Dans la vie courante :
<!-- 23456 --></div>
<!-- 3456 --><div style="font-size:55pt; left:2.65cm; top:20.5cm;">
<!-- 3456 -->* Je suis en train de travailler
<!-- 456 -->* Le téléphone sonne
<!-- 56 -->* Je vais répondre au téléphone
<!-- 6 -->* Après la conversation, je reprends mon travail là où je l’avais laissé.
<!-- 3456 --></div>
<!-- 3456 --><img src="./images/dring-allo-g1.png" style="top:11cm; left:30cm; width:27cm;" />
<!-- 456 --><img src="./images/dring-allo-g2.png" style="top:11cm; left:30cm; width:27cm;" />
<!-- 56 --><img src="./images/dring-allo-g3.png" style="top:11cm; left:30cm; width:27cm;" />
<!-- 6 --><img src="./images/dring-allo-g4.png" style="top:11cm; left:30cm; width:27cm;" />
</section>



<section>
<!-- A -->
<h1 class="en_tete">Procédure ou fonction</h1>
<img src="./images/inter-principe1.png" style="top:4.3cm; left:15cm; width:26cm;" />
<!-- 2 --><img src="./images/inter-principe5.png" style="top:4.3cm; left:15cm; width:26cm;" />
<!-- 3 --><img src="./images/inter-principe6.png" style="top:4.3cm; left:15cm; width:26cm;" />
<!-- 4 --><img src="./images/inter-principe7.png" style="top:4.3cm; left:15cm; width:26cm;" />
</section>

<section>
<!-- A -->
<h1 class="en_tete">Routine d’interruption</h1>
<img src="./images/inter-principe8.png" style="top:4.3cm; left:15cm; width:26cm;" />
<!-- 2 --><img src="./images/inter-principe9.png" style="top:4.3cm; left:15cm; width:26cm;" />
<!-- 3 --><img src="./images/inter-principe.png" style="top:4.3cm; left:15cm; width:26cm;" />
</section>


<section>
<!-- A -->
<h1 class="en_tete">Événements produisant des interruption</h1>
<div style="font-size:55pt; left:2.65cm; top:7cm; width:55cm">
Deux sortes d’événements produisant des interruptions :

<!-- 234 -->* Les événements __extérieurs__ au microcontrôleur
<!-- 34 -->* Les événements __intérieurs__ au microcontrôleur
<!-- 4 -->
<!-- 4 -->*...dont les événements liées aux Timers.*
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Discrimination des sources d’interruption</h1>
<div style="font-size:55pt; left:2.65cm; top:7cm; width:55cm">
Il y a plusieurs sources d’interruptions sur un microcontrôleur.

<!-- 234 -->Le système doit être capable d’en connaître la source !
<!-- 234 -->
<!-- 34 -->* En consultant les fanions correspondant à chaque interruption
<!-- 4 -->* Grâce aux __vecteurs d’interruption__ *(interrupt vectors)*
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Vecteurs d’interruption sur un MSP430G</h1>
<div style="font-size:48pt; left:2.65cm; top:8cm; width:55cm">
* 0xFFFE : Reset
* 0xFFFC : NMI
* 0xFFFA : Timer1 CCR0
* 0xFFF8 : Timer1 CCR1, CCR2, TAIFG
* 0xFFF6 : Comparator_A
* 0xFFF4 : Watchdog Timer
* 0xFFF2 : Timer0 CCR0
* 0xFFF0 : Timer0 CCR1, CCR2, TAIFG
</div>
<div style="font-size:48pt; left:32cm; top:8cm; width:55cm">
* 0xFFEE : USCI status
* 0xFFEC : USCI receive/transmit
* 0xFFEA : ADC10
* 0xFFE8 : -
* 0xFFE6 : Port P2
* 0xFFE4 : Port P1
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Étapes pour mettre en œuvre une interruption</h1>
<div style="font-size:54pt; left:2.65cm; top:6.0cm; width:55cm">
<!-- 23456 -->* Autoriser l’interruption qui nous intéresse
<!-- 3456 -->* Préciser comment cette interruption doit fonctionner
<!-- 456 -->* Autoriser globalement les interruptions
<!-- 56 -->* ... et écrire la routine d'interruption !
</div>
<!-- 5 --><img src="./images/decodage-inter.png" style="top:18.2cm; left:3cm; width:50cm;" />
</section>


<section>
<!-- A -->
<h1 class="en_tete">Introduction aux interruptions</h1>
<div class="liste_demi" style="font-size:48pt; left:33cm; width:26.0cm; top:8cm;">
* Evénements, qui provoquent...
* l'exécution d'une routine d'interruption
* Etapes de mise en oeuvre

*Suite :*

* Les interruptions sur le MSP430
* Les timers
</div>
</section>






