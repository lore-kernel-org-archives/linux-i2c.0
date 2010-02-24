From: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Wed, 24 Feb 2010 14:01:56 +0200
Message-ID: <af0693f01002240401g1aeaf840ld06a156a06be9dbf@mail.gmail.com>
References: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
	 <20100128085904.4e202de1@hyperion.delvare>
	 <af0693f01001280132l4002af0fgf3137fa27ce8555e@mail.gmail.com>
	 <20100128105340.41aecf64@hyperion.delvare>
	 <af0693f01002182310i6678e4b5h80feb14b24b37742@mail.gmail.com>
	 <20100219105841.2bd8b16c@hyperion.delvare>
	 <af0693f01002220812n5a6060cejc00d1ebbd7b9424d@mail.gmail.com>
	 <20100222225805.00432574@hyperion.delvare>
	 <af0693f01002231521q4f99eb63ocd607670625fadfa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <af0693f01002231521q4f99eb63ocd607670625fadfa-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Here is my code:

------------
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <stdlib.h>

#include "i2c-dev.h"
#include "i2cbusses.h"
#include "util.h"

/* actually smbus allows up to 32 and i2c even more */
#define I2CRWL_MAX_PARAMS 10
#define I2CRWL_PARAMS_SHIFT 3

static int i2c_writel(int fd, int datac, char *datav[])
{
        int i;
        unsigned char buf[I2CRWL_MAX_PARAMS];
        unsigned int data;

        for (i =3D 0; i < datac && i < I2CRWL_MAX_PARAMS; i++) {
                sscanf(datav[i], "%x", &data);
                buf[i] =3D (unsigned char)data;
        }

        if (i2c_smbus_write_i2c_block_data(fd, buf[0], datac - 1,
&buf[1]) < 0) {
                perror("\n");
                return 1;
        }

        return 0;
}


static void help(const char *progname)
{
        fprintf(stderr,
                        "Usage: %s I2CBUS CHIP-ADDRESS DATA0 [DATA1
=2E.. DATAn]\n"
                        "  I2CBUS is an integer or an I2C bus name\n"
                        "  CHIP-ADDRESS is an integer (0x03 - 0x77)\n"
                        "  DATAx is data to be written to the chip,
where 0 <=3D x <=3D n\n\n", progname);
        exit(1);
}

int main(int argc, char *argv[])
{
        int fd, i2cbus, addr, ret =3D 0;
        char filename[20];

        if ((argc < I2CRWL_PARAMS_SHIFT + 1) || (I2CRWL_MAX_PARAMS +
I2CRWL_PARAMS_SHIFT < argc))
                help(argv[0]);

        i2cbus =3D lookup_i2c_bus(argv[1]);
        if (i2cbus < 0)
                help(argv[0]);

        addr =3D parse_i2c_address(argv[2]);
        if (addr < 0)
                help(argv[0]);

        fd =3D open_i2c_dev(i2cbus, filename, 0);
        if (fd < 0)
                exit(1);

        if (ioctl(fd, I2C_SLAVE, addr) < 0) {
                ret =3D 1;
                perror("");
                goto out;
        }


        if (i2c_writel(fd, argc - I2CRWL_PARAMS_SHIFT,
&argv[I2CRWL_PARAMS_SHIFT])) {
                ret =3D 1;
                goto out;
        }


out:
        close(fd);

        return ret;
}
------------

BTW, I've disabled the FEATURE_BLOCK_BUFFER

--- i2c-i801.c     2010-02-24 10:50:50.060209638 +0200
+++ i2c-i801.c.orig    2010-02-24 13:55:29.664070673 +0200
@@ -603,7 +603,6 @@
                /* fall through */
        case PCI_DEVICE_ID_INTEL_82801DB_3:
                i801_features |=3D FEATURE_SMBUS_PEC;
-               i801_features |=3D FEATURE_BLOCK_BUFFER;
                break;
        }

and now everything works smoothly. I2C write transaction of arbitrary
length are seen even by scope :)

In case if I don't, here is what I get:

$ dmesg | tail
Transaction timeout
Terminating the current operation
=46ailed terminating the transaction
=46ailed clearing status flags at end of transaction ...

Thanks,
=46elix R.

On Wed, Feb 24, 2010 at 1:21 AM, Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> w=
rote:
> Hi Jean,
>
> On Mon, Feb 22, 2010 at 11:58 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> w=
rote:
>> Hi Felix,
>>
>> On Mon, 22 Feb 2010 18:12:41 +0200, Felix Rubinstein wrote:
>>> Hi Jean/i2c guys,
>>>
>>> I'm having hard time to send straight I2C transaction of arbitrary =
length.
>>> I use i2c_smbus_write_i2c_block_data(fd, buf[0], datac - 1, &buf[1]=
);
>>> from user-space to send the aforementioned transaction, but I get
>>> operation not permitted as a result.
>>> I tried to understand what's going on in the driver and found out t=
hat
>>> timeout occurs.
>>
>> Unlikely. If a timeout occurred, the error message would say so.
>>
>> What is the exact error message? Can we see your complete code?
>
> Sure, I'm not at the office right now, but will post it asap.
>
> But hey, I think I've found an issue here.
> Let's delve into the i801 driver code for a moment please.
>
> in i801_transaction:
> ...
> /* We will always wait for a fraction of a second! */
> =A0 =A0 =A0 =A0 do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D inb_p(SMBHSTSTS);
> =A0 =A0 =A0 =A0 } while ((status & SMBHSTSTS_HOST_BUSY) && (timeout++=
 < MAX_TIMEOUT));
> ...
>
> The data sheet states for HST_STS reg for HOST_BUSY bit:
> 1 =3D Indicates that the ICH9 is running a command from the host inte=
rface. No SMB
> registers should be accessed while this bit is set, except the BLOCK =
DATA BYTE
> Register. The BLOCK DATA BYTE Register can be accessed when this bit =
is set only
> when the SMB_CMD bits in the Host Control Register are programmed for=
 Block
> command or I2C Read command. This is necessary in order to check the
> DONE_STS bit.
>
> Remember my case? I'm issuing plain I2C multi byte (straight I2C with
> arbitrary length) transaction, in ICH9 words SMB_CMD is set to Block
> command. Since E32B is enabled, DONE_STS is irrelevant for us in this
> case. As I understand, in this case we should relay on interrupts and
> not on polling, as both: E32B and Block (write) command are enabled.
>
> That is why in my case I'm seeing timeout > MAX_TIMEOUT.
>
> As an alternative, I could try without E32B?
>
> What do you think?
>
> Thanks,
> Felix R.
>
