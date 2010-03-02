From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Tue, 2 Mar 2010 22:22:03 +0100
Message-ID: <20100302222203.1eb67c3a@hyperion.delvare>
References: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
	<20100128085904.4e202de1@hyperion.delvare>
	<af0693f01001280132l4002af0fgf3137fa27ce8555e@mail.gmail.com>
	<20100128105340.41aecf64@hyperion.delvare>
	<af0693f01002182310i6678e4b5h80feb14b24b37742@mail.gmail.com>
	<20100219105841.2bd8b16c@hyperion.delvare>
	<af0693f01002220812n5a6060cejc00d1ebbd7b9424d@mail.gmail.com>
	<20100222225805.00432574@hyperion.delvare>
	<af0693f01002231521q4f99eb63ocd607670625fadfa@mail.gmail.com>
	<af0693f01002240401g1aeaf840ld06a156a06be9dbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <af0693f01002240401g1aeaf840ld06a156a06be9dbf-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Felix,

On Wed, 24 Feb 2010 14:01:56 +0200, Felix Rubinstein wrote:
> Here is my code:
> 
> ------------
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <sys/ioctl.h>
> #include <stdlib.h>
> 
> #include "i2c-dev.h"
> #include "i2cbusses.h"
> #include "util.h"
> 
> /* actually smbus allows up to 32 and i2c even more */
> #define I2CRWL_MAX_PARAMS 10
> #define I2CRWL_PARAMS_SHIFT 3
> 
> static int i2c_writel(int fd, int datac, char *datav[])
> {
>         int i;
>         unsigned char buf[I2CRWL_MAX_PARAMS];
>         unsigned int data;
> 
>         for (i = 0; i < datac && i < I2CRWL_MAX_PARAMS; i++) {
>                 sscanf(datav[i], "%x", &data);
>                 buf[i] = (unsigned char)data;
>         }
> 
>         if (i2c_smbus_write_i2c_block_data(fd, buf[0], datac - 1,
> &buf[1]) < 0) {
>                 perror("\n");

You'd rather use:

		perror("i2c_smbus_write_i2c_block_data");

so that error messages are clearer.

>                 return 1;
>         }
> 
>         return 0;
> }
> 
> 
> static void help(const char *progname)
> {
>         fprintf(stderr,
>                         "Usage: %s I2CBUS CHIP-ADDRESS DATA0 [DATA1
> ... DATAn]\n"
>                         "  I2CBUS is an integer or an I2C bus name\n"
>                         "  CHIP-ADDRESS is an integer (0x03 - 0x77)\n"
>                         "  DATAx is data to be written to the chip,
> where 0 <= x <= n\n\n", progname);
>         exit(1);
> }
> 
> int main(int argc, char *argv[])
> {
>         int fd, i2cbus, addr, ret = 0;
>         char filename[20];
> 
>         if ((argc < I2CRWL_PARAMS_SHIFT + 1) || (I2CRWL_MAX_PARAMS +
> I2CRWL_PARAMS_SHIFT < argc))
>                 help(argv[0]);
> 
>         i2cbus = lookup_i2c_bus(argv[1]);
>         if (i2cbus < 0)
>                 help(argv[0]);
> 
>         addr = parse_i2c_address(argv[2]);
>         if (addr < 0)
>                 help(argv[0]);
> 
>         fd = open_i2c_dev(i2cbus, filename, 0);
>         if (fd < 0)
>                 exit(1);
> 
>         if (ioctl(fd, I2C_SLAVE, addr) < 0) {
>                 ret = 1;
>                 perror("");

Same here, perror("ioctl(I2C_SLAVE)") or similar.

>                 goto out;
>         }
> 
> 
>         if (i2c_writel(fd, argc - I2CRWL_PARAMS_SHIFT,
> &argv[I2CRWL_PARAMS_SHIFT])) {
>                 ret = 1;
>                 goto out;
>         }
> 
> 
> out:
>         close(fd);
> 
>         return ret;
> }
> ------------
> 
> BTW, I've disabled the FEATURE_BLOCK_BUFFER
> 
> --- i2c-i801.c     2010-02-24 10:50:50.060209638 +0200
> +++ i2c-i801.c.orig    2010-02-24 13:55:29.664070673 +0200
> @@ -603,7 +603,6 @@
>                 /* fall through */
>         case PCI_DEVICE_ID_INTEL_82801DB_3:
>                 i801_features |= FEATURE_SMBUS_PEC;
> -               i801_features |= FEATURE_BLOCK_BUFFER;
>                 break;
>         }
> 
> and now everything works smoothly. I2C write transaction of arbitrary
> length are seen even by scope :)
> 
> In case if I don't, here is what I get:
> 
> $ dmesg | tail
> Transaction timeout
> Terminating the current operation
> Failed terminating the transaction
> Failed clearing status flags at end of transaction ...

Obviously, if disabling the block buffer makes the same transaction
work, then it has to be a bug in the driver. And the good news is: I
was able to reproduce the bug using your test program, on an ICH5
running kernel 2.6.27.45. On the same system, I can get SMBus block
reads to work with or without the block buffer, so block buffer support
is not entirely broken (if it was, we'd certainly have noticed earlier.)

Now ideally we need to figure out whether SMBus block writes are
affected as well. We already know that SMBus block reads are not, and
I2C block writes are. As I2C block reads are excluded (the block buffer
can not be used for them according to the datasheet, and the driver
already does the right thing), checking whether SMBus block writes are
affected will tell us whether all block writes are affected, or if I2C
block writes only are affected. This should help us find out where and
what the bug could be.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
