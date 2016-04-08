#include <cstdio>
#include "bitmap_image.hpp"

extern "C" {

struct pic {
   int width;
   int height;
   int bytes_per_pixel;
   const unsigned char* data;
};

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

struct pic load(char* filename)
{
   bitmap_image image(filename);
   struct pic new_pic;
   if (!image)
   {
      printf("Error - Failed to open: %s\n", filename);
      return new_pic;
   }
   
   new_pic.width = image.width();
   new_pic.height = image.height();
   new_pic.bytes_per_pixel = image.bytes_per_pixel();
   new_pic.data = image.data();

   return new_pic;

}


}
