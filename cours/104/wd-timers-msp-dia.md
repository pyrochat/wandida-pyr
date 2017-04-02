<!-- DIAPORAMA -->


<!-- Page de titre -->
<section class="page_de_garde">
<img src="../../statiques/images/epfl-logo-pp.png" style="top:1.05cm; left:1.95cm; width:5.87cm" />
<img src="../../statiques/images/trait-rouge.png" style="top:5.07cm; left:0cm; width:60.02cm; height:0.23cm" />
<div style="top:11cm; left:4cm; font-size:50pt; font-family: Arial Narrow, sans-serif; color: #e2001a; ">Systèmes embarqués</div>
<div style="top:20cm; left:4cm; font-size:70pt; font-family: Impact, sans-serif;">Les timers du MSP430</div>
<div style="top:27.7cm; left:4cm; font-size:47pt; font-family: Arial Narrow, sans-serif;">Pierre-Yves Rochat</div>
</section>

<!-- Page bienvenue plein écran-->
<section>
<h1 class="en_tete">Introduction aux interruptions</h1>
<!-- def A --><img src="../../statiques/images/epfl-logo-pp.png" style="top:0.8cm; left:54.41cm; width:3.6cm" />
<!-- def A --><img src="../../statiques/images/trait-rouge.png" style="top:5.07cm; left:0cm; width:60.02cm; height:0.23cm" />
<!-- def A --><div style="top:31.26cm; left:35cm; width:23cm; text-align: right;  font-size:21pt; font-family: Arial Narrow, sans-serif; color:#555555;">
<!-- def A -->Systèmes embarqués | **Les timers du MSP430**
<!-- def A --></div>
<!-- A -->
<div style="top:6.5cm; left:35cm; width:23cm; text-align: right;  font-size:48pt; font-family: Impact, sans-serif;">
Pierre-Yves Rochat
</div>
</section>


<!-- Page bienvenue, demi-->
<section>
<!-- A -->
<h1 class="en_tete">Les timers</h1>
<div style="font-size:48pt; left:33cm; width:25.0cm; top:9cm;">
* Gestion du temps
</div>
<div style="font-size:48pt; left:33cm; width:25.0cm; top:12cm;">
* Timers, prédivision, logique de gestion 
</div>
<div style="font-size:48pt; left:34.5cm; width:25.0cm; top:12.5cm;">
et registres de comparaison
</div>
<div style="font-size:48pt; left:33cm; width:25.0cm; top:17cm;">
* Mise en œuvre : exemple du MSP430
</div>
<div style="font-size:48pt; left:33cm; width:25.0cm; top:20cm;">
* Interruptions des timers
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Le timer A du MSP430</h1>
<img src="./images/timer-a1.jpg" style="top:12cm; left:5cm; width:50cm;" />
</section>


<section>
<!-- A -->
<h1 class="en_tete">Le registre de contrôle</h1>
<img src="./images/tactl-1.jpg" style="top:6cm; left:6cm; width:43cm;" />
<img src="./images/tactl-2.jpg" style="top:15.5cm; left:6cm; width:50cm;" />
</section>


<section>
<h1 class="en_tete">Le registre de contrôle</h1>
<img src="./images/tactl-1.jpg" style="top:6cm; left:6cm; width:43cm;" />
<img src="./images/tactl-3.jpg" style="top:15.5cm; left:6cm; width:50cm;" />
<!-- A -->
</section>


<section>
<!-- A -->
<h1 class="en_tete">Programme de mise en oeuvre</h1>
<div style="top:6.5cm; left:1.5cm; width: 56cm; font-size:45pt;">
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {.C  .numberLines startFrom="1"}
int main() {
  WDTCTL = WDTPW + WDTHOLD; // Watchdog hors service
  BCSCTL1 = CALBC1_1MHZ;
  DCOCTL = CALDCO_1MHZ;     // Fréquence CPU
  P1DIR |= (1<<0); // P1.0 en sortie pour la LED
  TACTL0 = TASSEL_2 + ID_3 + MC_2;
  while (1) {               // Boucle infinie
    if (TACTL0 & TAIFG) {
      TACTL0 &= ~TAIFG;
      P1OUT ^= (1<<0);      // Inversion LED
    }
  }
}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Les registres de comparaison</h1>
<img src="./images/timer-a2.jpg" style="top:7cm; left:8cm; width:36cm;" />
</section>


<section>
<!-- A -->
<h1 class="en_tete">Les registres de comparaison</h1>
<img src="./images/tacctl-1.jpg" style="top:6cm; left:10cm; width:30cm;" />
<img src="./images/tacctl-4.jpg" style="top:15.5cm; left:6cm; width:50cm;" />
</section>


<section>
<!-- A -->
<h1 class="en_tete">Les registres de comparaison</h1>
<div style="top:6.5cm; left:1.5cm; width: 56cm; font-size:45pt;">
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {.C  .numberLines startFrom="14"}
int main() {
  ...
  TACCR0 = 62500; // 62500 * 8 us = 500 ms
  while (1) {     // Boucle infinie
    if (TACCTL0 & CCIFG) {
      TACCTL0 &= ~CCIFG;
      TACCR0 += 62500;
      P1OUT ^= (1<<0); // Inversion LED
    }
  }
}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">L'interruptions de dépassement de capacité</h1>
<div style="top:5.3cm; left:1.5cm; width: 56cm; font-size:38pt;">
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {.C  .numberLines startFrom="14"}
int main() {
  ...
  TACTL |= TAIE; // Interruption de l'overflow
  _BIS_SR (GIE); // Autorisation générale des interruptions
  while (1) {    // Boucle infinie vide
  }
}
// Timer_A1 Interrupt Vector (TAIV) handler
#pragma vector=TIMER0_A1_VECTOR
__interrupt void Timer_A1 (void) {
  switch (TAIV) {    // discrimination des sources d'interruption
  case  2:           // CCR1 : not used
    break;
  case  4:           // CCR2 : not used
    break;
  case 10:           // Overflow
    P1OUT ^= (1<<0); // Inversion LED
    break;
  }
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">L'interruption de comparaison</h1>
<div style="top:6.5cm; left:1.5cm; width: 56cm; font-size:45pt;">
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {.C  .numberLines startFrom="14"}
int main() {
  ...
  TACCTL0 |= CCIE; // Interruption de la comparaison
  _BIS_SR (GIE);   // Autorisation générale des interruptions
  while (1) {      // Boucle infinie vide
  }
}
#pragma vector=TIMER0_A0_VECTOR
__interrupt void Timer_A0 (void) {
  CCR0 += 62500;
  P1OUT ^= (1<<0); // Inversion LED
}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">PWM par interruption</h1>
<div style="top:5.3cm; left:1.5cm; width: 56cm; font-size:31pt;">
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {.C  .numberLines startFrom="14"}
int main() {
  ...
  TACTL |= TAIE;   // Interruption de l'overflow
  TACCTL0 |= CCIE; // Interruption de la comparaison
  _BIS_SR (GIE);   // Autorisation générale des interruptions
  while (1) {      // Boucle infinie vide
  }
}
#pragma vector=TIMER0_A1_VECTOR
__interrupt void Timer_A1 (void) {
  switch (TAIV) {    // discrimination des sources d'interruption
  case  2:           // CCR1 : not used
    break;
  case  4:           // CCR2 : not used
    break;
  case 10:           // Overflow
    P1OUT |= (1<<0); // Activer le signal au début du cycle
    break;
  }
}
#pragma vector=TIMER0_A0_VECTOR
__interrupt void Timer_A0 (void) {
  P1OUT &=~(1<<0); // Désactiver le signal au moment donné 
}                  // par le registre de comparaison
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Les timers</h1>
<div style="font-size:48pt; left:33cm; width:25.0cm; top:9cm;">
* Gestion du temps
</div>
<div style="font-size:48pt; left:33cm; width:25.0cm; top:12cm;">
* Timers, prédivision, logique de gestion 
</div>
<div style="font-size:48pt; left:34.5cm; width:25.0cm; top:12.5cm;">
et registres de comparaison
</div>
<div style="font-size:48pt; left:33cm; width:25.0cm; top:17cm;">
* Mise en œuvre : exemple du MSP430
</div>
<div style="font-size:48pt; left:33cm; width:25.0cm; top:20cm;">
* Interruptions des timers
</div>
</section>

