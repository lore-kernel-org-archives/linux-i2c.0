From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: MAX1236 with smbus (CS5536 ACB0)
Date: Mon, 13 Oct 2008 12:11:37 +0100
Message-ID: <48F32CE9.8000109@cam.ac.uk>
References: <48F2A270.8060307@leipzig.freifunk.net>
	<20081013092548.3d58a320@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081013092548.3d58a320-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org




>>> root@OpenWrt:/# i2cdetect -y 0
>>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
>>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>> 40: -- -- -- -- -- -- -- -- -- -- -- -- 4c -- -- --
>>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>> 70: -- -- -- -- -- -- -- --    
>> but i cant access the MAX1236 on slave address 0x34.
>> (0x4c is the onbard LM90)
> 
> Maybe it's not wired properly?
> 
> If it is wired properly, then another possibility is that the MAX1236
> is doing clock stretching beyond what the CS5536 supports...
> 
>> Does "I2C no" means the CS5536 is a plain smbus without i2c support?
> 
> Yes and no. It means that the scx200_acb driver runs the CS5536 in
> SMBus mode without plain I2C support. But there is also the scx200_i2c
> driver (which I would love to see go away in favor of i2c-gpio but
> that's another story) which can use the same pins as GPIO to do plain
> I2C. If I read the MAX1236 datasheet properly, it uses transactions
> which aren't part of the SMBus set, so you may need to use the
> scx200_i2c driver, depending on what exactly you need to do with the
> MAX1236. There are still a few SMBus transactions which should work
> though, and that may be enough.
 

Hi,

A driver that should work with this chip is part of the
iio subsystem, so I have a fair bit of familiarity (though
only via 1238 rather than this exact model)

Done a bit of digging around and my original test code was

#include <fcntl.h>

#include "i2c-dev.h"

int main(int argc, char* argv[])
{
  
  struct i2c_smbus_ioctl_data arg;
  union i2c_smbus_data data;
  int adaptor_nr=atoi(argv[1]); //check this
  char filename[20];
  sprintf(filename,"/dev/i2c-%d",adaptor_nr);

  int file;
  if((file = open(filename, O_RDWR))<0)
    {
      printf("could not open /dev/i2c-%u\n", adaptor_nr);
      exit(-1);
    }
  if(ioctl(file,I2C_SLAVE, 0x34) < 0)
    {
      printf("could not set slave address \n");
      return -1;
    }
  
  arg.size = I2C_SMBUS_BYTE;
  arg.read_write = I2C_SMBUS_WRITE;
  arg.command = I2C_SMBUS_BYTE;
  
  data.byte = 8;
  arg.data = &data;
  
  char buf[2] = {0x79, 0x92};
  write(file,  buf,2);
  int i;
  for(i = 0; i < 20; i++)
    {
      read(file,buf,2);
      
      unsigned int a =0;
      a = (buf[0] & 0xF) << 8 | buf[1] ;
      printf("reading %u\n",a);

        sleep(1);
    }

}

No idea why I did it without using the smbus_write commands
though. The iio driver is i2c_transfers I'm afraid.

as for i2c detect, I've just blugeoned it into building for
the pxa271 board I'm using and it picks up a max1239 just fine.

Good luck!

Jonathan


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
