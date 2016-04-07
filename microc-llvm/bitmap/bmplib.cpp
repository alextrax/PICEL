#include <cstdio>
#include "bitmap_image.hpp"

extern "C" {

int get_width(char* filename)
{
   bitmap_image image(filename);

   if (!image)
   {
      printf("Error - Failed to open: %s\n", filename);
      return 0;
   }

   return image.width();

}

int get_height(char* filename)
{
   bitmap_image image(filename);

   if (!image)
   {
      printf("Error - Failed to open: %s\n", filename);
      return 0;
   }

   return image.height();

}

}
