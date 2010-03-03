From: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Wed, 3 Mar 2010 18:36:40 +0200
Message-ID: <af0693f01003030836u55bc4b0akbdf402327bd10e0@mail.gmail.com>
References: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
	 <af0693f01001280132l4002af0fgf3137fa27ce8555e@mail.gmail.com>
	 <20100128105340.41aecf64@hyperion.delvare>
	 <af0693f01002182310i6678e4b5h80feb14b24b37742@mail.gmail.com>
	 <20100219105841.2bd8b16c@hyperion.delvare>
	 <af0693f01002220812n5a6060cejc00d1ebbd7b9424d@mail.gmail.com>
	 <20100222225805.00432574@hyperion.delvare>
	 <af0693f01002231521q4f99eb63ocd607670625fadfa@mail.gmail.com>
	 <af0693f01002240401g1aeaf840ld06a156a06be9dbf@mail.gmail.com>
	 <20100302222203.1eb67c3a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100302222203.1eb67c3a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Tue, Mar 2, 2010 at 11:22 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
>
> Hi Felix,
>
> On Wed, 24 Feb 2010 14:01:56 +0200, Felix Rubinstein wrote:
> > Here is my code:
> >
> > ------------
> > #include <stdio.h>
> > #include <unistd.h>
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <fcntl.h>
> > #include <sys/ioctl.h>
> > #include <stdlib.h>
> >
> > #include "i2c-dev.h"
> > #include "i2cbusses.h"
> > #include "util.h"
> >
> > /* actually smbus allows up to 32 and i2c even more */
> > #define I2CRWL_MAX_PARAMS 10
> > #define I2CRWL_PARAMS_SHIFT 3
> >
> > static int i2c_writel(int fd, int datac, char *datav[])
> > {
> > =A0 =A0 =A0 =A0 int i;
> > =A0 =A0 =A0 =A0 unsigned char buf[I2CRWL_MAX_PARAMS];
> > =A0 =A0 =A0 =A0 unsigned int data;
> >
> > =A0 =A0 =A0 =A0 for (i =3D 0; i < datac && i < I2CRWL_MAX_PARAMS; i=
++) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscanf(datav[i], "%x", &data);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[i] =3D (unsigned char)data;
> > =A0 =A0 =A0 =A0 }
> >
> > =A0 =A0 =A0 =A0 if (i2c_smbus_write_i2c_block_data(fd, buf[0], data=
c - 1,
> > &buf[1]) < 0) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 perror("\n");
>
> You'd rather use:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("i2c_smbus_write_i2c_block_data=
");
>
> so that error messages are clearer.
>
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> > =A0 =A0 =A0 =A0 }
> >
> > =A0 =A0 =A0 =A0 return 0;
> > }
> >
> >
> > static void help(const char *progname)
> > {
> > =A0 =A0 =A0 =A0 fprintf(stderr,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Usage: %s I2CBUS C=
HIP-ADDRESS DATA0 [DATA1
> > ... DATAn]\n"
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0I2CBUS is an i=
nteger or an I2C bus name\n"
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0CHIP-ADDRESS i=
s an integer (0x03 - 0x77)\n"
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0DATAx is data =
to be written to the chip,
> > where 0 <=3D x <=3D n\n\n", progname);
> > =A0 =A0 =A0 =A0 exit(1);
> > }
> >
> > int main(int argc, char *argv[])
> > {
> > =A0 =A0 =A0 =A0 int fd, i2cbus, addr, ret =3D 0;
> > =A0 =A0 =A0 =A0 char filename[20];
> >
> > =A0 =A0 =A0 =A0 if ((argc < I2CRWL_PARAMS_SHIFT + 1) || (I2CRWL_MAX=
_PARAMS +
> > I2CRWL_PARAMS_SHIFT < argc))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 help(argv[0]);
> >
> > =A0 =A0 =A0 =A0 i2cbus =3D lookup_i2c_bus(argv[1]);
> > =A0 =A0 =A0 =A0 if (i2cbus < 0)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 help(argv[0]);
> >
> > =A0 =A0 =A0 =A0 addr =3D parse_i2c_address(argv[2]);
> > =A0 =A0 =A0 =A0 if (addr < 0)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 help(argv[0]);
> >
> > =A0 =A0 =A0 =A0 fd =3D open_i2c_dev(i2cbus, filename, 0);
> > =A0 =A0 =A0 =A0 if (fd < 0)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(1);
> >
> > =A0 =A0 =A0 =A0 if (ioctl(fd, I2C_SLAVE, addr) < 0) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 perror("");
>
> Same here, perror("ioctl(I2C_SLAVE)") or similar.
>
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> > =A0 =A0 =A0 =A0 }
> >
> >
> > =A0 =A0 =A0 =A0 if (i2c_writel(fd, argc - I2CRWL_PARAMS_SHIFT,
> > &argv[I2CRWL_PARAMS_SHIFT])) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> > =A0 =A0 =A0 =A0 }
> >
> >
> > out:
> > =A0 =A0 =A0 =A0 close(fd);
> >
> > =A0 =A0 =A0 =A0 return ret;
> > }
> > ------------
> >
> > BTW, I've disabled the FEATURE_BLOCK_BUFFER
> >
> > --- i2c-i801.c =A0 =A0 2010-02-24 10:50:50.060209638 +0200
> > +++ i2c-i801.c.orig =A0 =A02010-02-24 13:55:29.664070673 +0200
> > @@ -603,7 +603,6 @@
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fall through */
> > =A0 =A0 =A0 =A0 case PCI_DEVICE_ID_INTEL_82801DB_3:
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i801_features |=3D FEATURE_SMBUS_PE=
C;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 i801_features |=3D FEATURE_BLOCK_BUFF=
ER;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > =A0 =A0 =A0 =A0 }
> >
> > and now everything works smoothly. I2C write transaction of arbitra=
ry
> > length are seen even by scope :)
> >
> > In case if I don't, here is what I get:
> >
> > $ dmesg | tail
> > Transaction timeout
> > Terminating the current operation
> > Failed terminating the transaction
> > Failed clearing status flags at end of transaction ...
>
> Obviously, if disabling the block buffer makes the same transaction
> work, then it has to be a bug in the driver. And the good news is: I
> was able to reproduce the bug using your test program, on an ICH5
> running kernel 2.6.27.45. On the same system, I can get SMBus block
> reads to work with or without the block buffer, so block buffer suppo=
rt
> is not entirely broken (if it was, we'd certainly have noticed earlie=
r.)
>
> Now ideally we need to figure out whether SMBus block writes are
> affected as well. We already know that SMBus block reads are not, and
> I2C block writes are. As I2C block reads are excluded (the block buff=
er
> can not be used for them according to the datasheet, and the driver
> already does the right thing), checking whether SMBus block writes ar=
e
> affected will tell us whether all block writes are affected, or if I2=
C
> block writes only are affected. This should help us find out where an=
d
> what the bug could be.

Ok, here is what I did.
I run the code with  i2c_smbus_write_block_data with E32B enabled,
i.e. the original version of the driver and SMBus multi-byte write
transactions were successful (I also verified it against the scope
analyzer).

But what I run the code with i2c_smbus_write_i2c_block_data, here is wh=
at I got:

# ./i2c_wl 0 0x28 0x1 0xff 0xff

i2c_smbus_write_i2c_block_data: Operation not permitted
l# ./i2c_wl 0 0x28 0x1 0xff 0xff 0xff 0xff
Success ...
# dmesg | tail
[  430.580131] i801_smbus 0000:00:1f.3: Transaction (post): CNT=3D14,
CMD=3D01, ADD=3D50, DAT0=3D02, DAT1=3D00
[  430.580312] i2c-adapter i2c-0: ioctl, cmd=3D0x708, arg=3D0x01
[  464.280155] i2c-adapter i2c-0: ioctl, cmd=3D0x703, arg=3D0x28
[  464.280155] i2c-adapter i2c-0: ioctl, cmd=3D0x708, arg=3D0x00
[  464.280155] i2c-adapter i2c-0: ioctl, cmd=3D0x720, arg=3D0xbfdaa63c
[  464.280155] i801_smbus 0000:00:1f.3: Transaction (pre): CNT=3D14,
CMD=3D01, ADD=3D50, DAT0=3D04, DAT1=3D00
[  464.280155] i801_smbus 0000:00:1f.3: SMBus busy (14). Resetting...
[  464.280155] i801_smbus 0000:00:1f.3: Successful!
[  464.287033] i801_smbus 0000:00:1f.3: Transaction (post): CNT=3D14,
CMD=3D01, ADD=3D50, DAT0=3D04, DAT1=3D00
[  464.287080] i2c-adapter i2c-0: ioctl, cmd=3D0x708, arg=3D0x01

In addition, the scope analyzer showed me that (when I run this
command ./i2c_wl 0 0x28 0x1 0xff 0xff) the last byte 0xff wasn't sent
on the bus. In contrary, every byte was on the bus with
i2c_smbus_write_block_data.

Thanks,
=46elix R.

>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
