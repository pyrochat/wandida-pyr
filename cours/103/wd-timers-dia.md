<!-- DIAPORAMA -->


<!-- Page de titre -->
<section class="page_de_garde">
<img src="../../statiques/images/epfl-logo-pp.png" style="top:1.05cm; left:1.95cm; width:5.87cm" />
<img src="../../statiques/images/trait-rouge.png" style="top:5.07cm; left:0cm; width:60.02cm; height:0.23cm" />
<div style="top:11cm; left:4cm; font-size:50pt; font-family: Arial Narrow, sans-serif; color: #e2001a; ">Systèmes embarqués</div>
<div style="top:20cm; left:4cm; font-size:70pt; font-family: Impact, sans-serif;">Intruduction aux timers</div>
<div style="top:27.7cm; left:4cm; font-size:47pt; font-family: Arial Narrow, sans-serif;">Pierre-Yves Rochat</div>
</section>


<section>
<!-- def A --><img src="../../statiques/images/epfl-logo-pp.png" style="top:0.8cm; left:54.41cm; width:3.6cm" />
<!-- def A --><img src="../../statiques/images/trait-rouge.png" style="top:5.07cm; left:0cm; width:60.02cm; height:0.23cm" />
<!-- def A --><div style="top:31.26cm; left:35cm; width:23cm; text-align: right;  font-size:21pt; font-family: Arial Narrow, sans-serif; color:#555555;">
<!-- def A -->Systèmes embarqués | **Intruduction aux timers**
<!-- def A --></div>
<!-- A -->
<h1 class="en_tete">Les timers</h1>
<div style="font-size:48pt; left:33cm; width:25.0cm; top:7cm;">
* Gérer le temps en jouant avec 
</div>
<div style="font-size:48pt; left:34.5cm; width:25.0cm; top:7.5cm;">
le temps d'exécution des instructions
</div>
<div style="font-size:48pt; left:34.5cm; width:25.0cm; top:9.6cm;">
est compliqué.
</div>
<div style="top:15cm; left:33cm; width: 26cm; font-size:40pt;">
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {.C  .numberLines startFrom="1"}
void AttenteMs (int duree) {
  volatile int j;
  int i;
  for (i=0; i<duree; i++) {
    for (j=0; j<BaseTempsMs; j++){
    }
  }
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Gestion précise du temps</h1>
<div style="font-size:50pt; left:2.65cm; top:6.5cm; width:55cm">
* Des circuits spécialisés vont nous aider.
<!-- 2 -->* Par exemple pour générer un PWM :
</div>
<!-- 2 --><img src="./images/compteur-pwm.svg" style="top:15cm; left:15cm; width:29cm;" />
</section>


<section>
<!-- A -->
<h1 class="en_tete">Compteur binaire</h1>
<div style="font-size:50pt; left:2.65cm; top:6.5cm; width:55cm">
* La base d'un timer est un compteur binaire :
</div>
<img src="./images/div2.svg" style="top:11cm; left:10cm; width:39cm;" />
<!-- 23 --><img src="./images/div2n.svg" style="top:22cm; left:2.65cm; width:25cm;" />
<!-- 3 --><img src="./images/chrono-compteur.svg" style="top:22cm; left:32cm; width:23cm;" />
</section>


<section>
<!-- A -->
<h1 class="en_tete">Les timers</h1>
<img src="./images/timer-base.svg" style="top:10cm; left:10cm; width:42cm;" />
</section>


<section>
<!-- A -->
<h1 class="en_tete">Prédivision</h1>
<img src="./images/timer-base-p.svg" style="top:7cm; left:36cm; width:22cm;" />
<img src="./images/pre-div.svg" style="top:14cm; left:3cm; width:33cm;" />
</section>


<section>
<!-- A -->
<h1 class="en_tete">Logique de gestion</h1>
<img src="./images/timer-base-l.svg" style="top:7cm; left:36cm; width:22cm;" />
<img src="./images/logique-timer.svg" style="top:19cm; left:3cm; width:45cm;" />
</section>


<section>
<!-- A -->
<h1 class="en_tete">Registres de comparaison</h1>
<img src="./images/timer-base-c.svg" style="top:7cm; left:36cm; width:22cm;" />
<img src="./images/registre-comp.svg" style="top:14cm; left:1.5cm; width:35cm;" />
</section>


<section>
<!-- A -->
<h1 class="en_tete">Les timers des microcontrôleurs</h1>
<div style="font-size:46pt; left:31cm; width:27.0cm; top:9cm;">
* Intel 8253 comme complément aux microprocesseurs
</div>
<div style="font-size:46pt; left:31cm; width:28.5cm; top:14cm;">
* Le timer très simple des premiers PIC
* Les AVR et leurs timers 8 et 16 bits
* Les timers 16 bits des MSP430
* Des timers 32 bits complexes sur les ARM
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">Les interruptions associées aux timers</h1>
<div style="font-size:48pt; left:2.65cm; width:57.0cm; top:9cm;">
* Les timers deviennent intéressant lorsqu'ils sont associés à des interruptions
<!-- 234 -->* Une interruption peut être générée au dépassement de capacité du compteur
<!-- 34 -->* Des interruptions peuvent se produire par les registres de comparaison
<!-- 4 -->* Bien d'autres modes sont disponibles
</div>
</section>


<section>
<!-- A -->
<h1 class="en_tete">PWM par interruption</h1>
<div style="top:5.3cm; left:1.5cm; width: 56cm; font-size:31pt;">
</div>
<img src="./images/chrono-timer-pwm.svg" style="top:7cm; left:3cm; width:42cm;" />
</section>


<section>
<!-- A -->
<h1 class="en_tete">Les timers</h1>
<div style="font-size:48pt; left:33cm; width:25.0cm; top:9cm;">
* Les timers aident à gérer le temps
* Prédivision, logique de gestion
* Registres de comparaison
</div>
<div style="font-size:48pt; left:34.5cm; width:25.0cm; top:16.5cm;">
*Suite :*
</div>
<div style="font-size:48pt; left:33cm; width:25.0cm; top:21cm;">
* Mise en œuvre : exemple du MSP430
</div>

</section>

