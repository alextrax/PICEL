#include <cstdio>
#include "bitmap_image.hpp"

extern "C" {

struct pic {
   unsigned int width;
   unsigned int height;
   unsigned int bytes_per_pixel;
   unsigned char* data;
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

int save_file(char* filename, struct pic src_pic)
{
   bitmap_image image(src_pic.width, src_pic.height);
   unsigned int length        = src_pic.width * src_pic.height * src_pic.bytes_per_pixel;
   std::copy(src_pic.data, src_pic.data + length, image.data());
   image.save_image(filename);
   printf("saved image to %s\n", filename);
   return 0;

}

int save(struct pic src_pic)
{
   bitmap_image image(src_pic.width, src_pic.height);
   unsigned int length        = src_pic.width * src_pic.height * src_pic.bytes_per_pixel;
   std::copy(src_pic.data, src_pic.data + length, image.data());
   image.save_image("pic_output.bmp");
   return 0;

}


}
