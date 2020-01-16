# Animated scale pumpjack

I had (and still have) no knowledge nor experience in mechanical design but I always wanted to make a completely parametric model in OpenSCAD. For this project, I designed all the parts of a scale model of an oil pumpjack, to be 3D-printed and driven by a 5V stepper motor. Its only purpose is to shake a tea bag and make a desktop gadget.  

[![Demo funcionando](img/final.jpg)](https://youtu.be/eCK8AgMWHLU)

To control the stepper motor position and speed, I designed a four-step sequencer that uses a two-bit counter based on JK master-slave flip-flops (74HC109) and an AND-gate based decoder (74HC08). An ULN2003 based driver (not displayed in the schematics) was used to amplify the output current of the sequencer.  

![Schematics](hardware/Proteus/schematic.bmp)  

This circuit was implemented on a perfboard. I should, and in fact, I started doing the design in Kicad, but for agility reasons, I ended up doing it in Proteus.  

![Perfboard](img/collage.jpg)  

An Octave simulation was used to define and calculate all of the system dimensions. The script can be extended to perform a simple structural analysis, and to optimize the design in many ways.  

![Simulation animation](octave/anim.gif)  

This gif animation was made using the STL-to-GIF Python script of [Daniel Aguirre](https://github.com/DAguirreAg).  

![Model animation](python/model.gif)  


### Additional materials

  - 13 bolts M2.5 x 25mm  
  - 17 nuts M2.5  
  - 1 bolt M5  
  - 5 nuts M5  
  - 4 thumbtacks  
  - 1 150x90x20 mm wood plank  