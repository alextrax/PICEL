#include<stdio.h>
#include<stdlib.h>

//structure defiens bitmap header
struct BITMAPFILEHEADER{
   unsigned short type;//type of file (bit map)
   unsigned long size;//size of file
   unsigned short reserved1;//
   unsigned short reserved2;//
   unsigned long offsetbits;//off set bits
};



struct BITMAPINFOHEADER{
   unsigned long size;//bitmap size
   unsigned long width;//width of bitmap
   unsigned long height;//hight of bitmap
   unsigned short planes;
   unsigned short bitcount;
   unsigned long compression;// compression ratio (zero for no compression)
   unsigned long sizeimage;//size of image
   long xpelspermeter;
   long ypelspermeter;
   unsigned long colorsused;
   unsigned long colorsimportant;
};



struct SINGLE_PIXEL{
   unsigned char blue; //Blue level  0-255
   unsigned char green;//Green level 0-255
   unsigned char red;  //Red level 0-255
};

int main()
{

unsigned long int i=0;//to count pixels readed
unsigned long int S=0;//number of pixcels to read

struct BITMAPFILEHEADER source_head;//to store file header
struct BITMAPINFOHEADER source_info;//to store bitmap info header
struct SINGLE_PIXEL source_pix;// to store pixcels


FILE *fp;//file pointer for source file
FILE *Dfp;//file ponter for distenation file

if(!(fp=fopen("lena.bmp","rb")))//open in binery read mode
{
printf("\can not open file");//prind and exit if file open error
exit(-1);
}


Dfp=fopen("dist.bmp","wb");//opne in binery write mode
//read the headers to souirce file
fread(&source_head,sizeof(struct BITMAPFILEHEADER),1,fp);
fread(&source_info,sizeof(struct BITMAPINFOHEADER),1,fp);

//write the headers to distenation file
fwrite(&source_head,sizeof(struct BITMAPFILEHEADER),1,Dfp);
fwrite(&source_info,sizeof(struct BITMAPINFOHEADER),1,Dfp);

//calucate the number of pix to read
S=source_info.width*source_info.height;

/*void* src_array = malloc(sizeof(struct SINGLE_PIXEL) * S);
fread(src_array,sizeof(struct SINGLE_PIXEL),S,fp);
fwrite(src_array,sizeof(struct SINGLE_PIXEL),S,Dfp);
*/
printf("width: %u, height: %u", source_info.width, source_info.height);
//read, modefy and write pixcels
/*for(i=1;i<=S;i++)
{
//read pixcel form source file
fread(&source_pix,sizeof(struct SINGLE_PIXEL),1,fp);


//write pixcels to distenation file
fwrite(&source_pix,sizeof(struct SINGLE_PIXEL),1,Dfp);
}
*/
//close all fiels
fclose(fp);
fclose(Dfp);
return 0;
}