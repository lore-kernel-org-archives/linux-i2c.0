From: Andreas Seidler <tetzlav-bXdiauyh1GQ7K2kJdssfr+TW4wlIGRCZ@public.gmane.org>
Subject: Re: MAX1236 with smbus (CS5536 ACB0)
Date: Wed, 15 Oct 2008 03:13:23 +0200
Message-ID: <gd3g3j$29i$1@ger.gmane.org>
References: <48F2A270.8060307@leipzig.freifunk.net>	<20081013092548.3d58a320@hyperion.delvare>
	<48F32CE9.8000109@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48F32CE9.8000109-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jonathan Cameron schrieb:
> A driver that should work with this chip is part of the
> iio subsystem, so I have a fair bit of familiarity (though
> only via 1238 rather than this exact model)

I found this subsystem too and its promising, but it depends on RTC with
periodic Interupts - and most of embedded hardware lacks of such RTCs.

is it possible to attach a ds1307 for this reason?


> Done a bit of digging around and my original test code was
> 
> #include <fcntl.h>
> 
> #include "i2c-dev.h"
> 
> int main(int argc, char* argv[])
> {
>   
>   struct i2c_smbus_ioctl_data arg;
>   union i2c_smbus_data data;
>   int adaptor_nr=atoi(argv[1]); //check this
>   char filename[20];
>   sprintf(filename,"/dev/i2c-%d",adaptor_nr);
> 
>   int file;
>   if((file = open(filename, O_RDWR))<0)
>     {
>       printf("could not open /dev/i2c-%u\n", adaptor_nr);
>       exit(-1);
>     }
>   if(ioctl(file,I2C_SLAVE, 0x34) < 0)
>     {
>       printf("could not set slave address \n");
>       return -1;
>     }
>   
>   arg.size = I2C_SMBUS_BYTE;
>   arg.read_write = I2C_SMBUS_WRITE;
>   arg.command = I2C_SMBUS_BYTE;
>   
>   data.byte = 8;
>   arg.data = &data;
>   
>   char buf[2] = {0x79, 0x92};
>   write(file,  buf,2);
>   int i;
>   for(i = 0; i < 20; i++)
>     {
>       read(file,buf,2);
>       
>       unsigned int a =0;
>       a = (buf[0] & 0xF) << 8 | buf[1] ;
>       printf("reading %u\n",a);
> 
>         sleep(1);
>     }
> 
> }
> 
> No idea why I did it without using the smbus_write commands
> though. The iio driver is i2c_transfers I'm afraid.
> 
> as for i2c detect, I've just blugeoned it into building for
> the pxa271 board I'm using and it picks up a max1239 just fine.

can i access the ringbuffer of this driver via sysfs or how userspace side
should work?


Regards
Andreas


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
