From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [lm-sensors] [PATCH] i2c multiplexer driver for Proliant
 microserver N36L
Date: Sat, 3 Dec 2011 08:27:57 -0800
Message-ID: <20111203162757.GA24302@ericsson.com>
References: <CAKdnbx7xeygkOK=BR+3vUrWT3GEt=PZrxgrEMvEB5nkOfAF0bg@mail.gmail.com>
 <20111127225514.GO19115@trinity.fluff.org>
 <CAKdnbx4u6+_WJjjMJ3jnDLSU8eJ0yXX0Mg-dcr=3F4FaOd2R=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKdnbx4u6+_WJjjMJ3jnDLSU8eJ0yXX0Mg-dcr=3F4FaOd2R=g@mail.gmail.com>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddi De Pieri <eddi-soWH+0lSOSbR7s880joybQ@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Dec 03, 2011 at 10:31:30AM -0500, Eddi De Pieri wrote:
> This patch add support to multiplexed smbus for proliant microserver
> N36L and may be applicable to other configuration based on sb8xx
> southbus.
>=20

Did you read Documentation/SubmittingPatches ?

The patch doesn't follow the canonical patch format, I can see that lin=
es are split,
the patch isn't based on the linux root directory but on some other dir=
ectory which
I guess you expect the reader to figure out, the patch description incl=
udes lots
of information which is irrelevant for the changelog, and it is based o=
n 2.6.32
instead of the current release and thus pretty much guaranteed not to a=
pply
to the current kernel version. All that w/o even looking into the code.

The patch implements an I2C multiplexer but doesn't use the I2C multipl=
exer
infrastructure. I am not one of the I2C maintainers, but that alone wou=
ld cause me
to reject this patch (on top of all the other reasons above).

Guenter

> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -l
> i2c-0   smbus           SMBus piix4 adapter (SDA0)              SMBus=
 adapter
> i2c-1   smbus           SMBus piix4 adapter (SDA2)              SMBus=
 adapter
> i2c-2   smbus           SMBus piix4 adapter (SDA3)              SMBus=
 adapter
> i2c-3   smbus           SMBus piix4 adapter (SDA4)              SMBus=
 adapter
> root@proliant:/usr/src/lm-sensors/eddi#
>=20
> yes SDA1 is reserved... so i can't multiplex it
>=20
> root@proliant:/usr/src/lm-sensors/eddi# sensors
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:       +24.5=C2=B0C  (high =3D +70.0=C2=B0C, crit =3D +100.0=C2=
=B0C)
>=20
> w83795adg-i2c-1-2f
> Adapter: SMBus piix4 adapter (SDA2)
> in0:         +1.02 V  (min =3D  +0.00 V, max =3D  +2.05 V)
> in1:         +1.52 V  (min =3D  +0.00 V, max =3D  +2.05 V)
> in2:         +1.10 V  (min =3D  +0.00 V, max =3D  +2.05 V)
> in3:         +0.89 V  (min =3D  +0.00 V, max =3D  +2.05 V)
> in12:        +3.35 V  (min =3D  +0.00 V, max =3D  +6.14 V)
> in13:        +3.28 V  (min =3D  +0.00 V, max =3D  +6.14 V)
> fan1:        703 RPM  (min =3D  329 RPM)
> temp1:       +23.0=C2=B0C  (high =3D +109.0=C2=B0C, hyst =3D +109.0=C2=
=B0C)
>                       (crit =3D +109.0=C2=B0C, hyst =3D +109.0=C2=B0C=
)  sensor =3D thermal diode
> temp2:       +33.2=C2=B0C  (high =3D +105.0=C2=B0C, hyst =3D +105.0=C2=
=B0C)
>                       (crit =3D +105.0=C2=B0C, hyst =3D +105.0=C2=B0C=
)  sensor =3D thermal diode
> temp5:       +14.0=C2=B0C  (high =3D +39.0=C2=B0C, hyst =3D +39.0=C2=B0=
C)
>                       (crit =3D +44.0=C2=B0C, hyst =3D +44.0=C2=B0C) =
 sensor =3D thermistor
> beep_enable:disabled
>=20
> jc42-i2c-0-18
> Adapter: SMBus piix4 adapter (SDA0)
> temp1:       +20.5=C2=B0C  (low  =3D  +0.0=C2=B0C, high =3D  +0.0=C2=B0=
C)  ALARM
>                       (crit =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C) =
 ALARM
>=20
>=20
> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 0
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
>=20
> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 1
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- UU
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- 61 -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
>=20
> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 2
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- 4c -- -- --
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
>=20
> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 3
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
>=20
> pay attention that the msleep seems to be really needed...
>=20
> Signed-off-by: Eddi De Pieri <eddi-soWH+0lSOSbR7s880joybQ@public.gmane.org>
>=20
> Regards,
>=20
> Eddi
>=20
> follows patch....
>=20
> diff -u -N -r 2.6.32.orig/i2c-piix4.c 2.6.32/i2c-piix4.c
> --- 2.6.32.orig/i2c-piix4.c     2011-11-16 17:07:03.000000000 +0100
> +++ 2.6.32/i2c-piix4.c  2011-11-16 15:21:17.000000000 +0100
> @@ -97,7 +97,8 @@
>  static unsigned short piix4_smba;
>  static int srvrworks_csb5_delay;
>  static struct pci_driver piix4_driver;
> -static struct i2c_adapter piix4_adapter;
> +struct i2c_adapter piix4_adapter;
> +EXPORT_SYMBOL_GPL(piix4_adapter);
>=20
>  static struct dmi_system_id __devinitdata piix4_dmi_blacklist[] =3D =
{
>         {
> @@ -246,10 +247,22 @@
>                         "0x%x already in use!\n", smba_idx);
>                 return -EBUSY;
>         }
> -       outb_p(smb_en, smba_idx);
> -       smba_en_lo =3D inb_p(smba_idx + 1);
> -       outb_p(smb_en + 1, smba_idx);
> -       smba_en_hi =3D inb_p(smba_idx + 1);
> +       outb_p(smb_en, smba_idx);               //seleziono il regist=
ro 0x2c
> +       smba_en_lo =3D inb_p(smba_idx + 1);       //leggo il dato L d=
el registro 0x2c
> +       outb_p(smb_en + 1, smba_idx);           //seleziono il regist=
ro 0x2c + 1
> +       smba_en_hi =3D inb_p(smba_idx + 1);       //leggo il dato H d=
el registro 0x2c
> +
> +       outb_p(smb_en, smba_idx);               //seleziono il regist=
ro 0x2c
> +       outb_p(smba_en_lo & 0xF9 , smba_idx + 1); //seleziono la port=
a 0 00 0
> +       outb_p(smb_en + 1, smba_idx);           //seleziono il regist=
ro 0x2c + 1
> +       outb_p(smba_en_hi, smba_idx + 1);
> +
> +       outb_p(smb_en, smba_idx);               //seleziono il regist=
ro 0x2c
> +       smba_en_lo =3D inb_p(smba_idx + 1);       //leggo il dato L d=
el registro 0x2c
> +       outb_p(smb_en + 1, smba_idx);           //seleziono il regist=
ro 0x2c + 1
> +       smba_en_hi =3D inb_p(smba_idx + 1);       //leggo il dato H d=
el registro 0x2c
> +
> +
>         release_region(smba_idx, 2);
>=20
>         if ((smba_en_lo & 1) =3D=3D 0) {
> @@ -258,6 +271,8 @@
>                 return -ENODEV;
>         }
>=20
> +       dev_info(&PIIX4_dev->dev,"Selected Default Smbus Port 0x%x",
> (smba_en_lo & 0x6) >> 1);
> +
>         piix4_smba =3D ((smba_en_hi << 8) | smba_en_lo) & 0xffe0;
>         if (acpi_check_region(piix4_smba, SMBIOSIZE, piix4_driver.nam=
e))
>                 return -ENODEV;
> @@ -466,7 +481,7 @@
>         .functionality  =3D piix4_func,
>  };
>=20
> -static struct i2c_adapter piix4_adapter =3D {
> +struct i2c_adapter piix4_adapter =3D {
>         .owner          =3D THIS_MODULE,
>         .class          =3D I2C_CLASS_HWMON | I2C_CLASS_SPD,
>         .algo           =3D &smbus_algorithm,
> diff -u -N -r 2.6.32.orig/i2c-piix4-n36l.c 2.6.32/i2c-piix4-n36l.c
> --- 2.6.32.orig/i2c-piix4-n36l.c        1970-01-01 01:00:00.000000000=
 +0100
> +++ 2.6.32/i2c-piix4-n36l.c     2011-11-16 16:02:01.000000000 +0100
> @@ -0,0 +1,247 @@
> +/*
> + * i2c-piix4-n36l.c - i2c-piix4 extras for the HP proliant
> microserver n36l motherboard
> + *
> + * Copyright (C) 2004, 2008 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> + * Copyright (C) 2011  Eddi De Pieri <eddi-soWH+0lSOSbR7s880joybQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +/*
> + * We select the channels by sending commands to the sb800 southbus
> + * the selection bit
> + * http://support.amd.com/us/Embedded_TechDocs/45482.pdf
> + *  Smbus0En - RW =C3=A2=E2=82=AC=E2=80=9C 16 bits - [PM_Reg: 2Ch]
> + *  Field Name Bits Default Description
> + *  SmBus0En 0 0b Set to 1 to enable SMBUS0 function and decoding.
> + *  SmBus0Sel 2:1 00b SmBus port selection when PM_Reg 2Fh bit 0 is =
set to 0
> + *  00: Port 0
> + *  01: Port 2
> + *  10: Port 3
> + *  11: Port 4
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <asm/io.h>
> +
> +extern struct i2c_adapter piix4_adapter;
> +
> +static struct i2c_adapter *n36l_adapter;
> +static struct i2c_algorithm *n36l_algo;
> +
> +/* Wrapper access functions for multiplexed SMBus */
> +static DEFINE_MUTEX(piix4_lock);
> +
> +/* We remember the last used channels combination so as to only swit=
ch
> +   channels when it is really needed. This greatly reduces the SMBus
> +   overhead, but also assumes that nobody will be writing to the PCA=
9556
> +   in our back. */
> +static u8 last_channels;
> +
> +static inline s32 piix4_access_channel(struct i2c_adapter * adap, u1=
6 addr,
> +                                       unsigned short flags, char re=
ad_write,
> +                                       u8 command, int size,
> +                                       union i2c_smbus_data * data,
> +                                       u8 channels)
> +{
> +       int error;
> +       unsigned short smba_idx =3D 0xcd6;
> +       u8 smba_en_lo, smba_en_hi, smb_en =3D 0x2c;
> +
> +       mutex_lock(&piix4_lock);
> +
> +       if (last_channels !=3D channels) {
> +               union i2c_smbus_data mplxdata;
> +               mplxdata.byte =3D channels;
> +
> +               /* Determine the address of the SMBus areas */
> +               if (!request_region(smba_idx, 2, "smba_idx")) {
> +                       dev_err(&piix4_adapter.dev, "SMBus base addre=
ss index region "
> +                               "0x%x already in use!\n", smba_idx);
> +                       return -EBUSY;
> +               }
> +
> +               outb_p(smb_en, smba_idx);               //seleziono i=
l registro 0x2c
> +               smba_en_lo =3D inb_p(smba_idx + 1);       //leggo il =
dato L del registro 0x2c
> +               outb_p(smb_en + 1, smba_idx);           //seleziono i=
l registro 0x2c + 1
> +               smba_en_hi =3D inb_p(smba_idx + 1);       //leggo il =
dato H del registro 0x2c
> +
> +               msleep(50);
> +               outb_p(smb_en, smba_idx);               //seleziono i=
l registro 0x2c
> +               outb_p((smba_en_lo & 0xF9 )+ ( channels << 1) , smba_=
idx + 1);
> //seleziono la porta 0 00 0
> +               outb_p(smb_en + 1, smba_idx);           //seleziono i=
l registro 0x2c + 1
> +               outb_p(smba_en_hi, smba_idx + 1);
> +
> +               msleep(50);
> +
> +               release_region(smba_idx, 2);
> +
> +               dev_info(&piix4_adapter.dev,"Selected Smbus Port 0x%x=
", (smba_en_lo
> & 0x6) >> 1);
> +
> +               last_channels =3D channels;
> +
> +       }
> +
> +       error =3D piix4_adapter.algo->smbus_xfer(adap, addr, flags, r=
ead_write,
> +                                             command, size, data);
> +
> +
> +       mutex_unlock(&piix4_lock);
> +       return error;
> +}
> +
> +static s32 piix4_access_virt0(struct i2c_adapter * adap, u16 addr,
> +                              unsigned short flags, char read_write,
> +                              u8 command, int size,
> +                              union i2c_smbus_data * data)
> +{
> +       return piix4_access_channel(adap, addr, flags, read_write, co=
mmand,
> +                                    size, data, 0);
> +}
> +
> +static s32 piix4_access_virt1(struct i2c_adapter * adap, u16 addr,
> +                              unsigned short flags, char read_write,
> +                              u8 command, int size,
> +                              union i2c_smbus_data * data)
> +{
> +       return piix4_access_channel(adap, addr, flags, read_write, co=
mmand,
> +                                    size, data, 1);
> +}
> +
> +static s32 piix4_access_virt2(struct i2c_adapter * adap, u16 addr,
> +                              unsigned short flags, char read_write,
> +                              u8 command, int size,
> +                              union i2c_smbus_data * data)
> +{
> +       return piix4_access_channel(adap, addr, flags, read_write, co=
mmand,
> +                                    size, data, 2);
> +}
> +
> +static s32 piix4_access_virt3(struct i2c_adapter * adap, u16 addr,
> +                              unsigned short flags, char read_write,
> +                              u8 command, int size,
> +                              union i2c_smbus_data * data)
> +{
> +       return piix4_access_channel(adap, addr, flags, read_write, co=
mmand,
> +                                    size, data, 3);
> +}
> +
> +static int __init piix4_n36l_init(void)
> +{
> +       int i, error;
> +
> +       if (!piix4_adapter.dev.parent)
> +               return -ENODEV;
> +
> +       printk(KERN_INFO "Configure the AMD SB800 Multiplexer\n");
> +
> +       /* Unregister physical bus */
> +       error =3D i2c_del_adapter(&piix4_adapter);
> +       if (error) {
> +               dev_err(&piix4_adapter.dev, "Physical bus removal fai=
led\n");
> +               goto ERROR0;
> +       }
> +
> +       printk(KERN_INFO "Enabling SMBus multiplexing for Hp Proliant
> Microserver N36l\n");
> +       /* Define the 4 virtual adapters and algorithms structures */
> +       if (!(n36l_adapter =3D kzalloc(5 * sizeof(struct i2c_adapter)=
,
> +                                     GFP_KERNEL))) {
> +               error =3D -ENOMEM;
> +               goto ERROR1;
> +       }
> +       if (!(n36l_algo =3D kzalloc(5 * sizeof(struct i2c_algorithm),
> +                                  GFP_KERNEL))) {
> +               error =3D -ENOMEM;
> +               goto ERROR2;
> +       }
> +
> +       /* Fill in the new structures */
> +       n36l_algo[0] =3D *(piix4_adapter.algo);
> +       n36l_algo[0].smbus_xfer =3D piix4_access_virt0;
> +       n36l_adapter[0] =3D piix4_adapter;
> +       snprintf(n36l_adapter[0].name, sizeof(n36l_adapter[0].name),
> +                "SMBus piix4 adapter (SDA0)");
> +       n36l_adapter[0].algo =3D n36l_algo;
> +       n36l_adapter[0].dev.parent =3D piix4_adapter.dev.parent;
> +       for (i =3D 1; i < 4; i++) {
> +               n36l_algo[i] =3D *(piix4_adapter.algo);
> +               n36l_adapter[i] =3D piix4_adapter;
> +               snprintf(n36l_adapter[i].name, sizeof(n36l_adapter[i]=
=2Ename),
> +                        "SMBus piix4 adapter (SDA%d)", i + 1);
> +               n36l_adapter[i].algo =3D n36l_algo+i;
> +               n36l_adapter[i].dev.parent =3D piix4_adapter.dev.pare=
nt;
> +       }
> +       n36l_algo[1].smbus_xfer =3D piix4_access_virt1;
> +       n36l_algo[2].smbus_xfer =3D piix4_access_virt2;
> +       n36l_algo[3].smbus_xfer =3D piix4_access_virt3;
> +
> +       /* Register virtual adapters */
> +       for (i =3D 0; i < 4; i++) {
> +               error =3D i2c_add_adapter(n36l_adapter+i);
> +               if (error) {
> +                       printk(KERN_ERR "i2c-piix4-n36l: "
> +                              "Virtual adapter %d registration "
> +                              "failed, module not inserted\n", i);
> +                       for (i--; i >=3D 0; i--)
> +                               i2c_del_adapter(n36l_adapter+i);
> +                       goto ERROR3;
> +               }
> +       }
> +
> +       return 0;
> +
> +ERROR3:
> +       kfree(n36l_algo);
> +       n36l_algo =3D NULL;
> +ERROR2:
> +       kfree(n36l_adapter);
> +       n36l_adapter =3D NULL;
> +ERROR1:
> +       /* Restore physical bus */
> +       i2c_add_adapter(&piix4_adapter);
> +ERROR0:
> +       return error;
> +}
> +
> +static void __exit piix4_n36l_exit(void)
> +{
> +       if (n36l_adapter) {
> +               int i;
> +
> +               for (i =3D 0; i < 5; i++)
> +                       i2c_del_adapter(n36l_adapter+i);
> +               kfree(n36l_adapter);
> +               n36l_adapter =3D NULL;
> +       }
> +       kfree(n36l_algo);
> +       n36l_algo =3D NULL;
> +
> +       /* Restore physical bus */
> +       if (i2c_add_adapter(&piix4_adapter))
> +               printk(KERN_ERR "i2c-piix4-n36l: "
> +                      "Physical bus restoration failed\n");
> +}
> +
> +MODULE_AUTHOR("Eddi De Pieri <eddi-soWH+0lSOSbR7s880joybQ@public.gmane.org");
> +MODULE_DESCRIPTION("n36l SMBus multiplexing");
> +MODULE_LICENSE("GPL");
> +
> +module_init(piix4_n36l_init);
> +module_exit(piix4_n36l_exit);
>=20
>=20
> On Sun, Nov 27, 2011 at 11:55 PM, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote=
:
> >
> > On Fri, Nov 25, 2011 at 11:07:21PM +0100, Eddi De Pieri wrote:
> >> This patch add support to multiplexed smbus for proliant microserv=
er
> >> N36L and may be applicable to other configuration based on sb8xx
> >> southbus.
> >>
> >> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -l
> >> i2c-0   smbus           SMBus piix4 adapter (SDA0)              SM=
Bus adapter
> >> i2c-1   smbus           SMBus piix4 adapter (SDA2)              SM=
Bus adapter
> >> i2c-2   smbus           SMBus piix4 adapter (SDA3)              SM=
Bus adapter
> >> i2c-3   smbus           SMBus piix4 adapter (SDA4)              SM=
Bus adapter
> >> root@proliant:/usr/src/lm-sensors/eddi#
> >
> > patch should go inline so it can be reviewed, thanks.
> >
> > --
> > Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/
> >
> > Large Hadron Colada: A large Pina Colada that makes the universe di=
sappear.
> >
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
