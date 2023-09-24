# CSC2002S Assignment 4 SMNAIM002

## Files in this Repository:
* increase_brightness.asm (question 1 solution)
* greyscale.asm (question 2 solution)
* /sample_images (various test images used to debug code):
  - house_64_in_ascii_cr.ppm
  - house_64_in_ascii_crlf.ppm
  - house_64_in_ascii_lf.ppm *
  - jet_64_in_ascii_cr.ppm
  - jet_64_in_ascii_crlf.ppm
  - jet_64_in_ascii_lf.ppm *
  - tree_64_in_ascii_cr.ppm
  - tree_64_in_ascii_crlf.ppm
  - tree_64_in_ascii_lf.ppm *
* /output files (output image files after processing)
  - greyscale_House.ppm
  - greyscale_Jet.ppm
  - greyscale_Tree.ppm
  - greyscale1.ppm -> output already written.
  - increase_brightness_House.ppm
  - increase_brightness_Jet.ppm
  - increase_brightness_Tree.ppm
  - icnreaseBrightness1.ppm -> output already written. 

## How to run the files:
### increase_brightness.asm:
![image](https://github.com/aimeesimons/CSC2002S_Assignment4/assets/126353532/27258c19-7f3e-40fe-895d-952a1b77117c)
*.data section of the program
1. Proceed to /sample_images or proceed to the file in which you have a test image, and right click on it.
2. Select 'Copy Path'.
3. Paste this path between the quotation marks in line with the variable "filename" - If the path copied contains backslashes, and therefore, does not open, replace the backlashes with forward slashes.
4. Procced to the /output files directory and choose an output .ppm file. NB, you can try and match the title of the input image to the title of the created .ppm file. e.g house_64_in_ascii_lf.ppm -> increase_brightness_House.ppm
5. Copy the absolute path of the output file.
6. Paste this path between the quotation marks in line with the variable "outputFile". - If the path copied contains backslashes, and therefore, does not open, replace the backlashes with forward slashes.
7. Change the Header accordingly .i.e. variable 'colourHeader':
   * if the input has the following in the filename, then the header comment should be as follows:
     - "house" -> # Hse
     - "jet" -> # Jet
     - "tree: -> # Tre
9. Done! You may run using QTSpim.
NB! Please use an lf file when inputing an image (not cr or crlf file).

### greyscale.asm:
![image](https://github.com/aimeesimons/CSC2002S_Assignment4/assets/126353532/df8c8f2a-cc20-407e-a4f2-654a090c39f0)
*.data section of the program
1. Proceed to /sample_images or proceed to the file in which you have a test image, and right click on it.
2. Select 'Copy Path'.
3. Paste this path between the quotation marks in line with the variable "filename" - If the path copied contains backslashes, and therefore, does not open, replace the backlashes with forward slashes.
4. Procced to the /output files directory and choose an output .ppm file. NB, you can try and match the title of the input image to the title of the created .ppm file. e.g house_64_in_ascii_lf.ppm -> increase_brightness_House.ppm
5. Copy the absolute path of the output file.
6. Paste this path between the quotation marks in line with the variable "outputFile". - If the path copied contains backslashes, and therefore, does not open, replace the backlashes with forward slashes.
7. Change the Header accordingly .i.e. variable 'greyHeader':
   * if the input has the following in the filename, then the header comment should be as follows:
     - "house" -> # Hse
     - "jet" -> # Jet
     - "tree: -> # Tre
8. Done! You may run using QTSpim.
NB! Please use an lf file when inputing an image (not cr or crlf file).

