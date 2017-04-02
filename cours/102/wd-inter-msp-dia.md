<!-- DIAPORAMA -->


<!-- Page de titre -->
<section class="page_de_garde">
<img src="../../statiques/images/epfl-logo-pp.png" style="top:1.05cm; left:1.95cm; width:5.87cm" />
<img src="../../statiques/images/trait-rouge.png" style="top:5.07cm; left:0cm; width:60.02cm; height:0.23cm" />
<div style="top:11cm; left:4cm; font-size:50pt; font-family: Arial Narrow, sans-serif; color: #e2001a; ">Systèmes embarqués</div>
<div style="top:20cm; left:4cm; font-size:70pt; font-family: Impact, sans-serif;">Les interruptions du MSP430</div>
<div style="top:27.7cm; left:4cm; font-size:47pt; font-family: Arial Narrow, sans-serif;">Pierre-Yves Rochat</div>
<img src="./images/x.svg" style="top:11cm; left:36cm; width:12cm;" />
<img src="./images/y.svg" style="top:10.5cm; left:48cm; width:10cm;" />
<img src="./images/z.svg" style="top:24cm; left:37cm; width:21cm;" />
</section>

<!-- Page bienvenue plein écran-->
<section>
<h1 class="en_tete">Les interruptions du MSP430</h1>
<!-- def A --><img src="../../statiques/images/epfl-logo-pp.png" style="top:0.8cm; left:54.41cm; width:3.6cm" />
<!-- def A --><img src="../../statiques/images/trait-rouge.png" style="top:5.07cm; left:0cm; width:60.02cm; height:0.23cm" />
<!-- def A --><div style="top:31.26cm; left:35cm; width:23cm; text-align: right;  font-size:21pt; font-family: Arial Narrow, sans-serif; color:#555555;">
<!-- def A -->Systèmes embarqués | **Les interruptions du MSP430**
<!-- def A --></div>
<!-- A -->
<div style="font-size:50pt; left:32cm; top:5.0cm; width:27cm">
Une interruption, c'est l’arrêt temporaire d’un programme au profit d’un autre, jugé à cet instant plus important.
</div>
<img src="./images/inter-principe.svg" style="top:13.5cm; left:37cm; width:17cm;" />
</section>


<section>
<!-- A -->
<h1 class="en_tete">Evénement et routine</h1>
<div style="font-size:50pt; left:2.65cm; top:6.5cm; width:55cm">
* Une interruption est caractérisée par un événement et une routine.
</div>
<!-- 2 --><div style="font-size:50pt; left:2.65cm; top:9.5cm; width:55cm">
<!-- 2 -->* Le choix de l'événement est piloté par une logique, <br>spécifique à chaque interruption de chaque microcontrôleur.
<!-- 2 --></div>
<!-- 2 --><img src="./images/decodage-inter.svg" style="top:17.5cm; left:4cm; width:48cm;" />
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
<h1 class="en_tete">Interruption sur une entrée</h1>
<div style="font-size:50pt; left:2.65cm; top:6.5cm; width:55cm">
* **`P1DIR`** entrée ou sortie
* **`P1OUT`** valeur de sortie
* **`P1IN`** valeur des entrées *(lecture)*
* **`P1REN`** résistance de tirage *(pull-up ou pull-down)*
</div>
<!-- 2 --><img src="./images/io-registre-table-msp.svg" style="top:17cm; left:4cm; width:35cm;" />
</section>


<section>
<!-- A -->
<h1 class="en_tete">Interruption sur une entrée</h1>
<div style="font-size:50pt; left:2.65cm; top:6.5cm; width:55cm">
* **`P1DIR`** entrée ou sortie
* **`P1OUT`** valeur de sortie
* **`P1IN`** valeur des entrées *(lecture)*
* **`P1REN`** résistance de tirage *(pull-up ou pull-down)*
</div>
<div style="font-size:50pt; left:2.65cm; top:23cm; width:55cm">
* **`P1IE`** *Interrupt Enable* : autorisation de l’interruption
* **`P1IES`** *Interrupt Edge Select* : choix du flanc
* **`P1IFG`** *Interrupt FlaG* : les **fanions d’interruption**
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Interruption sur une entrée</h1>
<img src="./images/decodage-inter.svg" style="top:7.5cm; left:3cm; width:50cm;" />
<div style="font-size:50pt; left:2.65cm; top:23cm; width:55cm">
* **`P1IE`** *Interrupt Enable* : autorisation de l’interruption
* **`P1IES`** *Interrupt Edge Select* : choix du flanc
* **`P1IFG`** *Interrupt FlaG* : les **fanions d’interruption**
</div>>
<!-- 2 --><img src="./images/bits-ies-ie-ifg.svg" style="left:39cm; top:21.5cm; width:18.5cm">
</section>


<section>
<!-- A -->
<h1 class="en_tete">Interruption sur une entrée</h1>
<div style="top:6.5cm; left:2cm; width: 5cm; font-size:45pt;">
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {.C  .numberLines}
 int main() {
   WDTCTL = WDTPW + WDTHOLD; // Stop watchdog timer
   P1DIR |= (1<<6); // Led verte en sortie
   P1OUT |= (1<<3); P1REN |= (1<<3); //pull-up sur l'entrée P1.3

   P1IES |= (1<<3); // Sur le flanc descendant
   P1IE |= (1<<3); // Interruption P1 activée sur le bit 3
   P1IFG &=~(1<<3); // Fanion d'interruption remis à zéro
   __enable_interrupt(); // General Interrupt Enable

   while(1) { // il n'y a rien à faire dans la boucle principale !
   }
 }

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Interruption sur une entrée</h1>
<div style="top:7.5cm; left:2cm; width: 5cm; font-size:45pt;">
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {.C  .numberLines startFrom="14"}
 // Syntaxe spécifique pour les interruptions :

 // Routine d'interruption associée au Port P1
 #pragma vector=PORT1_VECTOR
 __interrupt void Port1_ISR(void) {

   // Fanion d'interruption correspondant au bit 3 remis à 0 :
   P1IFG &= ~(1<<3)

   P1OUT ^= (1<<6); // inverse P1.6 (LED verte)
 }

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Interruption sur deux entrées, avec discrimination</h1>
<div style="top:6.5cm; left:1.5cm; width: 56cm; font-size:45pt;">
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {.C  .numberLines}
 int main() {
   ...
   P1IES &=~((1<<3)|(1<<4)); // Flancs montants
   P1IE |= (1<<3)|(1<<4); // Interruption activée sur 2 entrées
   P1IFG &=~((1<<3)|(1<<4)); // Fanions d'interruption remis à 0
   ...

 #pragma vector=PORT1_VECTOR
 __interrupt void Port1_ISR(void) {
   // discrimination des causes possible de l'interruption :
   if (P1IFG & (1<<3)) { P1IFG &= ~(1<<3); ... ;}
   if (P1IFG & (1<<4)) { P1IFG &= ~(1<<4); ... ;}
 }

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
</div>
</section>


<!-- Page ADC, 2 parties -->
<section>
<!-- A -->
<h1 class="en_tete">Interruption sur une fin de conversion AD</h1>
<div style="top:6.5cm; left:1.5cm; width: 56cm; font-size:45pt;">
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {.C  .numberLines}
 int main() {
   WDTCTL = WDTPW + WDTHOLD; // Stop watchdog timer
   P1DIR |= (1<<6); P1OUT &=~(1<<6); // LED verte en sortie
   // Activation du convertisseur ADC 10 bits (ADC10) :
   ADC10CTL0 = ADC10SHT_2 + ADC10ON + ADC10IE; // Interrupt enable
   ADC10CTL1 = INCH_1; // Canal 1 = entrée A1 = P1.1
   ADC10AE0 |= (1<<1); // Autorisation de l'entrée A1
   __enable_interrupt(); // General Interrupt Enable
   ADC10CTL0 |= ENC + ADC10SC; // lance une première conversion

   while(1) { // il n'y a rien à faire dans la boucle principale !
   }
 }

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Interruption sur une fin de conversion AD</h1>
<div style="top:6.5cm; left:1.5cm; width: 56cm; font-size:45pt;">
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {.C  .numberLines startFrom="14"}
 // Routine d'interruption associée à la fin de conversion ADC
 #pragma vector=ADC10_VECTOR
 __interrupt void ADC10_ISR(void) {

   uint16_t val = ADC10MEM; // lit le résultat de la conversion
   ADC10CTL0 |= ENC + ADC10SC; // lance la conversion suivante

   if (val > 511) { // La LED verte montre si la valeur dépasse Vcc/2
     P1OUT |= (1<<6); // LED verte On
   } else {
     P1OUT &=~(1<<6); // LED verte Off
   }
 }

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Les interruptions du MSP430</h1>
<div style="font-size:48pt; left:33cm; width:26.0cm; top:7cm; line-height:1.2; ">
* Registres pour le choix des événements
* Écriture d'une routine d'interruption
* Interruption sur un entrée
* Interruption de fin de conversion A/D 

*Suite :*

* Les timers
* Les timers du le MSP430
</div>
</section>






