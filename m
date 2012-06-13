From: Eddi De Pieri <eddi-soWH+0lSOSbR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] i2c multiplexer driver for Proliant microserver N36L
Date: Wed, 13 Jun 2012 07:44:34 +0200
Message-ID: <CAKdnbx4MUfU086F7navt52WaoF4q_+3G+DHn7u2qic+FU50OiA@mail.gmail.com>
References: <CAKdnbx7xeygkOK=BR+3vUrWT3GEt=PZrxgrEMvEB5nkOfAF0bg@mail.gmail.com>
 <20111127225514.GO19115@trinity.fluff.org> <CAKdnbx4u6+_WJjjMJ3jnDLSU8eJ0yXX0Mg-dcr=3F4FaOd2R=g@mail.gmail.com>
 <20111203162757.GA24302@ericsson.com> <CAKdnbx54R9t-mS9-EvyT-618wVp-YH0YDO++=m5t-JqR6h=GCw@mail.gmail.com>
 <20111203180819.2ddbcb3a@endymion.delvare> <CAKdnbx5V=qfa5dshRudHx+M3o8Eb6qJXCVG+ZBaBwCeKaoQYNA@mail.gmail.com>
 <20111206093906.21dccf8d@endymion.delvare> <loom.20120215T165236-509@post.gmane.org>
 <CAM5MpD5R4xde4Li1NCDoErisXs7oRMAgW7swuCwga80MkU3VMw@mail.gmail.com> <CAM5MpD46pT1N2f5yZb0yW1O8CjH7B969TmvxDZztMfwBoyom3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM5MpD46pT1N2f5yZb0yW1O8CjH7B969TmvxDZztMfwBoyom3g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Thomas Brandon <tbrandonau-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

It works for me too

What about including this patch in the mainline?

Regards....

Eddi

Tested-by: Eddi De Pieri <eddi-soWH+0lSOSbR7s880joybQ@public.gmane.org>

On Mon, Feb 27, 2012 at 9:42 AM, Thomas Brandon <tbrandonau-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =
wrote:
>
> On Sun, Feb 26, 2012 at 10:30 PM, Mike Shestyrev wrote:
> > Hi Thomas,
> >
> > I've applied you patch to i2c-piix4.c, kernel 2.26.33, the machine =
is
> > N40L.
> > It works!! Thank you.
> > When probing SDA4 panel LEDs are turned off ant the power button st=
ops
> > to work.
> > SMBus pins can be programmed as GPIO optionally, and the guess is t=
hat
> > SMBus pins from some channel(s) are used to drive LEDs and to read
> > buttons,
> > and were programmed as GPIO by BIOS .
> >
> > Is it possible to read already programmed state for each channel
> > before initialization?
> > If it's GPIO - to skip it, if SMBus mode - to register.
> >
> > Regards,
> > /Mike.
>
> Thanks for testing Mike and glad to hear you had some success. Could
> you use Reply to all in Gmail to cc the mailing list.
> It is true that the pins are multiplexed and it looks like SDA4 is no=
t
> being used for SMBus, though it is set to the default which is part o=
f
> the PS2 interface (not present on the N40L) not GPIO. However I don't
> think this is a problem, I would assume that these settings would
> disconnect the SMBus module from those pins, though I could be wrong.
> Further testing shows that the problem was that the port selection wa=
s
> being changed by the driver and having the port set to anything other
> than port 0 was causing the problems when restarting. I have now
> modified the driver to restore the default value after each
> transaction which appears to have fixed the problem.
>
> There remains the problem that running sensors-detect on SDA3 causes =
a
> bus collision and locks up the bus. This also means you see the same
> reset issues and must remove the power cable to recover. I have
> tracked this down to the ds1621_detect routine performing a word writ=
e
> which hangs the chip at 0x4c. Removing this detection routine fixes
> the issue (whatever chip is there is not identified). I gather this i=
s
> not a problem with the driver per se but rather the inherently unsafe
> nature of sensors-detect and it is sensors-detect, if anything, that
> should be modified to fix the issue. I will look into that further an=
d
> move that to the lm_sensors mailing list. For now I have attached a
> modified version of sensors-detect which removes this chip.
>
> With the updated patch and the modified sensors-detect I have been
> able to probe all ports and have not encountered the power issue
> again. If no further issues are identified I will seperate the patch
> into stages and submit for review.
>
> Tom.
>
> --- linux-3.2.1-gentoo-r2/drivers/i2c/busses/i2c-piix4.c =A0 =A0 =A0 =
=A02012-01-05
> 10:55:44.000000000 +1100
> +++ dev/drivers/i2c/busses/i2c-piix4.c =A02012-02-27 04:35:11.0000000=
00
> +1100
> @@ -25,7 +25,10 @@
> =A0 =A0 =A0 =A0AMD Hudson-2
> =A0 =A0 =A0 =A0SMSC Victory66
>
> - =A0 Note: we assume there can only be one device, with one SMBus
> interface.
> + =A0 Note: we assume there can only be one device.
> + =A0 The device can register multiple i2c_adapters (up to
> PIIX4_MAX_ADAPTERS).
> + =A0 For devices supporting multiple ports the i2c_adapter should pr=
ovide
> + =A0 an i2c_algorithm to access them.
> =A0*/
>
> =A0#include <linux/module.h>
> @@ -40,6 +43,7 @@
> =A0#include <linux/dmi.h>
> =A0#include <linux/acpi.h>
> =A0#include <linux/io.h>
> +#include <linux/mutex.h>
>
>
> =A0/* PIIX4 SMBus address offsets */
> @@ -78,6 +82,9 @@
> =A0#define PIIX4_WORD_DATA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0C
> =A0#define PIIX4_BLOCK_DATA =A0 =A0 =A0 0x14
>
> +/* Multi-port constants */
> +#define PIIX4_MAX_ADAPTERS 4
> +
> =A0/* insmod parameters */
>
> =A0/* If force is set to anything different from 0, we forcibly enabl=
e the
> @@ -97,7 +104,14 @@ MODULE_PARM_DESC(force_addr,
> =A0static unsigned short piix4_smba;
> =A0static int srvrworks_csb5_delay;
> =A0static struct pci_driver piix4_driver;
> -static struct i2c_adapter piix4_adapter;
> +static struct i2c_adapter *piix4_adapters[PIIX4_MAX_ADAPTERS];
> +
> +/* SB800 globals */
> +DEFINE_MUTEX(piix4_mutex_sb800);
> +static u8 piix4_adapter_ports_sb800[4];
> +static const char *piix4_port_names_sb800[4] =3D {
> + =A0 =A0 =A0 "SDA0", "SDA2", "SDA3", "SDA4"
> +};
>
> =A0static struct dmi_system_id __devinitdata piix4_dmi_blacklist[] =3D=
 {
> =A0 =A0 =A0 =A0{
> @@ -284,6 +298,8 @@ static int __devinit piix4_setup_sb800(s
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&PIIX4_dev->dev, "Using SMI# f=
or SMBus.\n");
>
> + =A0 =A0 =A0 mutex_init(&piix4_mutex_sb800);
> +
> =A0 =A0 =A0 =A0dev_info(&PIIX4_dev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "SMBus Host Controller at 0x%x, revis=
ion %d\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 piix4_smba, i2ccfg >> 4);
> @@ -291,27 +307,27 @@ static int __devinit piix4_setup_sb800(s
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int piix4_transaction(void)
> +static int piix4_transaction(struct i2c_adapter *adap)
> =A0{
> =A0 =A0 =A0 =A0int temp;
> =A0 =A0 =A0 =A0int result =3D 0;
> =A0 =A0 =A0 =A0int timeout =3D 0;
>
> - =A0 =A0 =A0 dev_dbg(&piix4_adapter.dev, "Transaction (pre): CNT=3D%=
02x,
> CMD=3D%02x, "
> + =A0 =A0 =A0 dev_dbg(&adap->dev, "Transaction (pre): CNT=3D%02x, CMD=
=3D%02x, "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"ADD=3D%02x, DAT0=3D%02x, DAT1=3D%02x\=
n", inb_p(SMBHSTCNT),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0inb_p(SMBHSTCMD), inb_p(SMBHSTADD), in=
b_p(SMBHSTDAT0),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0inb_p(SMBHSTDAT1));
>
> =A0 =A0 =A0 =A0/* Make sure the SMBus host is ready to start transmit=
ting */
> =A0 =A0 =A0 =A0if ((temp =3D inb_p(SMBHSTSTS)) !=3D 0x00) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&piix4_adapter.dev, "SMBus busy=
 (%02x). "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&adap->dev, "SMBus busy (%02x).=
 "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Resetting...\n", temp=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0outb_p(temp, SMBHSTSTS);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((temp =3D inb_p(SMBHSTSTS)) !=3D 0=
x00) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&piix4_adapter.=
dev, "Failed! (%02x)\n",
> temp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&adap->dev, "Fa=
iled! (%02x)\n", temp);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EBUSY;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&piix4_adapter.=
dev, "Successful!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&adap->dev, "Su=
ccessful!\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> @@ -330,35 +346,35 @@ static int piix4_transaction(void)
>
> =A0 =A0 =A0 =A0/* If the SMBus is still busy, we give up */
> =A0 =A0 =A0 =A0if (timeout =3D=3D MAX_TIMEOUT) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&piix4_adapter.dev, "SMBus Time=
out!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&adap->dev, "SMBus Timeout!\n")=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D -ETIMEDOUT;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (temp & 0x10) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D -EIO;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&piix4_adapter.dev, "Error: Fai=
led bus
> transaction\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&adap->dev, "Error: Failed bus =
transaction\n");
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (temp & 0x08) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D -EIO;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&piix4_adapter.dev, "Bus collis=
ion! SMBus may be "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&adap->dev, "Bus collision! SMB=
us may be "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"locked until next har=
d reset. (sorry!)\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Clock stops and slave is stuck in m=
id-transmission */
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (temp & 0x04) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D -ENXIO;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&piix4_adapter.dev, "Error: no =
response!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&adap->dev, "Error: no response=
!\n");
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (inb_p(SMBHSTSTS) !=3D 0x00)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0outb_p(inb(SMBHSTSTS), SMBHSTSTS);
>
> =A0 =A0 =A0 =A0if ((temp =3D inb_p(SMBHSTSTS)) !=3D 0x00) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&piix4_adapter.dev, "Failed res=
et at end of "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&adap->dev, "Failed reset at en=
d of "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"transaction (%02x)\n"=
, temp);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 dev_dbg(&piix4_adapter.dev, "Transaction (post): CNT=3D=
%02x,
> CMD=3D%02x, "
> + =A0 =A0 =A0 dev_dbg(&adap->dev, "Transaction (post): CNT=3D%02x, CM=
D=3D%02x, "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"ADD=3D%02x, DAT0=3D%02x, DAT1=3D%02x\=
n", inb_p(SMBHSTCNT),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0inb_p(SMBHSTCMD), inb_p(SMBHSTADD), in=
b_p(SMBHSTDAT0),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0inb_p(SMBHSTDAT1));
> @@ -426,7 +442,7 @@ static s32 piix4_access(struct i2c_adapt
>
> =A0 =A0 =A0 =A0outb_p((size & 0x1C) + (ENABLE_INT9 & 1), SMBHSTCNT);
>
> - =A0 =A0 =A0 status =3D piix4_transaction();
> + =A0 =A0 =A0 status =3D piix4_transaction(adap);
> =A0 =A0 =A0 =A0if (status)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return status;
>
> @@ -454,6 +470,47 @@ static s32 piix4_access(struct i2c_adapt
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +/* Handles access to multiple SMBus ports on the SB800.
> + * The port is selected by bits 2:1 of the smb_en register (0x2C).
> + * NOTE: The selected port must be returned to the initial selection=
 to
> + * avoid problems on certain systems.
> + * Return negative errno on error.
> + */
> +static s32 piix4_access_sb800(struct i2c_adapter * adap, u16 addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned short flags, char read_writ=
e,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 command, int size, union i2c_smbu=
s_data * data)
> +{
> + =A0 =A0 =A0 unsigned short smba_idx =3D 0xcd6;
> + =A0 =A0 =A0 u8 smba_en_lo, smb_en =3D 0x2c;
> + =A0 =A0 =A0 u8 port;
> + =A0 =A0 =A0 int retval;
> +
> + =A0 =A0 =A0 mutex_lock(&piix4_mutex_sb800);
> +
> + =A0 =A0 =A0 if (!request_region(smba_idx, 2, "smba_idx")) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&adap->dev, "SMBus base address=
 index region "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "0x%x already in use!\n=
", smba_idx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ERROR;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 outb_p(smb_en, smba_idx);
> + =A0 =A0 =A0 smba_en_lo =3D inb_p(smba_idx + 1);
> +
> + =A0 =A0 =A0 port =3D *((u8*)adap->algo_data);
> + =A0 =A0 =A0 if ((smba_en_lo & 6) !=3D (port << 1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 outb_p((smba_en_lo & ~6) | (port << 1),=
 smba_idx + 1);
> +
> + =A0 =A0 =A0 retval =3D piix4_access(adap, addr, flags, read_write, =
command,
> size, data);
> +
> + =A0 =A0 =A0 outb_p(smba_en_lo, smba_idx + 1);
> + =A0 =A0 =A0 release_region(smba_idx, 2);
> +
> + =A0 =A0 =A0 ERROR:
> + =A0 =A0 =A0 mutex_unlock(&piix4_mutex_sb800);
> +
> + =A0 =A0 =A0 return retval;
> +}
> +
> =A0static u32 piix4_func(struct i2c_adapter *adapter)
> =A0{
> =A0 =A0 =A0 =A0return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
> @@ -461,18 +518,91 @@ static u32 piix4_func(struct i2c_adapter
> =A0 =A0 =A0 =A0 =A0 =A0I2C_FUNC_SMBUS_BLOCK_DATA;
> =A0}
>
> -static const struct i2c_algorithm smbus_algorithm =3D {
> +static const struct i2c_algorithm piix4_smbus_algorithm =3D {
> =A0 =A0 =A0 =A0.smbus_xfer =A0 =A0 =3D piix4_access,
> =A0 =A0 =A0 =A0.functionality =A0=3D piix4_func,
> =A0};
>
> -static struct i2c_adapter piix4_adapter =3D {
> - =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> - =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D I2C_CLASS_HWMON | I2C_CLA=
SS_SPD,
> - =A0 =A0 =A0 .algo =A0 =A0 =A0 =A0 =A0 =3D &smbus_algorithm,
> +static const struct i2c_algorithm piix4_smbus_algorithm_sb800 =3D {
> + =A0 =A0 =A0 .smbus_xfer =A0 =A0 =3D piix4_access_sb800,
> + =A0 =A0 =A0 .functionality =A0=3D piix4_func,
> =A0};
>
> -static const struct pci_device_id piix4_ids[] =3D {
> +static int __devinit piix4_setup_adapters(struct pci_dev *dev)
> +{
> + =A0 =A0 =A0 int retval;
> +
> + =A0 =A0 =A0 if (!(piix4_adapters[0] =3D kzalloc(sizeof(**piix4_adap=
ters),
> GFP_KERNEL)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 piix4_adapters[0]->owner =3D THIS_MODULE;
> + =A0 =A0 =A0 piix4_adapters[0]->class =3D I2C_CLASS_HWMON | I2C_CLAS=
S_SPD;
> + =A0 =A0 =A0 piix4_adapters[0]->algo =A0=3D &piix4_smbus_algorithm;
> +
> + =A0 =A0 =A0 /* set up the sysfs linkage to our parent device */
> + =A0 =A0 =A0 piix4_adapters[0]->dev.parent =3D &dev->dev;
> +
> + =A0 =A0 =A0 snprintf(piix4_adapters[0]->name, sizeof(piix4_adapters=
[0]->name),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "SMBus PIIX4 adapter at %04x", piix4_sm=
ba);
> +
> + =A0 =A0 =A0 if ((retval =3D i2c_add_adapter(piix4_adapters[0]))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "Couldn't register a=
dapter!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(piix4_adapters[0]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 piix4_adapters[0] =3D NULL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return retval;
> +}
> +
> +static int __devinit piix4_setup_adapters_sb800(struct pci_dev *dev)
> +{
> + =A0 =A0 =A0 int i, retval;
> +
> + =A0 =A0 =A0 /* Register 4 adapters */
> + =A0 =A0 =A0 for (i =3D 0; i < 4; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(piix4_adapters[i] =3D
> kzalloc(sizeof(**piix4_adapters), GFP_KERNEL))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "Out=
 of memory!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ERROR;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 piix4_adapters[i]->owner =3D THIS_MODUL=
E;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 piix4_adapters[i]->class =3D I2C_CLASS_=
HWMON |
> I2C_CLASS_SPD;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 piix4_adapters[i]->algo =A0=3D &piix4_s=
mbus_algorithm_sb800;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 piix4_adapter_ports_sb800[i] =3D i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 piix4_adapters[i]->algo_data =3D
> &(piix4_adapter_ports_sb800[i]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set up the sysfs linkage to our pare=
nt device */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 piix4_adapters[i]->dev.parent =3D &dev-=
>dev;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(piix4_adapters[i]->name,
> sizeof(piix4_adapters[i]->name),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "SB800 SMBus adapter %s=
 at %04x",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 piix4_port_names_sb800[=
i], piix4_smba);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((retval =3D i2c_add_adapter(piix4_a=
dapters[i]))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "Cou=
ldn't register SB800
> adapter %s (%d)!\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 piix4_port_names_sb800[i],
> retval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(piix4_adapters[i]=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 piix4_adapters[i] =3D N=
ULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ERROR;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return retval;
> +
> + =A0 =A0 =A0 ERROR:
> + =A0 =A0 =A0 dev_err(&dev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Error setting up SB800=
 adapters. Unregistering
> all adapters!\n");
> + =A0 =A0 =A0 for (i--; i >=3D 0; i--) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_del_adapter(piix4_adapters[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(piix4_adapters[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 piix4_adapters[i] =3D NULL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return retval;
> +}
> +
> +static DEFINE_PCI_DEVICE_TABLE(piix4_ids) =3D {
> =A0 =A0 =A0 =A0{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_=
82371AB_3) },
> =A0 =A0 =A0 =A0{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_=
82443MX_3) },
> =A0 =A0 =A0 =A0{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SL=
C90E66_3) },
> @@ -504,23 +634,18 @@ static int __devinit piix4_probe(struct
> =A0 =A0 =A0 =A0if ((dev->vendor =3D=3D PCI_VENDOR_ID_ATI &&
> =A0 =A0 =A0 =A0 =A0 =A0 dev->device =3D=3D PCI_DEVICE_ID_ATI_SBX00_SM=
BUS &&
> =A0 =A0 =A0 =A0 =A0 =A0 dev->revision >=3D 0x40) ||
> - =A0 =A0 =A0 =A0 =A0 dev->vendor =3D=3D PCI_VENDOR_ID_AMD)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* base address location etc changed in=
 SB800 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D piix4_setup_sb800(dev, id);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D piix4_setup(dev, id);
> -
> - =A0 =A0 =A0 if (retval)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> -
> - =A0 =A0 =A0 /* set up the sysfs linkage to our parent device */
> - =A0 =A0 =A0 piix4_adapter.dev.parent =3D &dev->dev;
> -
> - =A0 =A0 =A0 snprintf(piix4_adapter.name, sizeof(piix4_adapter.name)=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "SMBus PIIX4 adapter at %04x", piix4_sm=
ba);
> + =A0 =A0 =A0 =A0 =A0 dev->vendor =3D=3D PCI_VENDOR_ID_AMD) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* SB800 uses a different base address =
and has 4 SMBus
> ports */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((retval =3D piix4_setup_sb800(dev, =
id)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D piix4_setup_adapters_sb800(d=
ev);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((retval =3D piix4_setup(dev, id)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D piix4_setup_adapters(dev);
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 if ((retval =3D i2c_add_adapter(&piix4_adapter))) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "Couldn't register a=
dapter!\n");
> + =A0 =A0 =A0 if (retval) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0release_region(piix4_smba, SMBIOSIZE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0piix4_smba =3D 0;
> =A0 =A0 =A0 =A0}
> @@ -530,8 +655,16 @@ static int __devinit piix4_probe(struct
>
> =A0static void __devexit piix4_remove(struct pci_dev *dev)
> =A0{
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < PIIX4_MAX_ADAPTERS; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (piix4_adapters[i]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_del_adapter(piix4_a=
dapters[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(piix4_adapters[i]=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 piix4_adapters[i] =3D N=
ULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0if (piix4_smba) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_del_adapter(&piix4_adapter);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0release_region(piix4_smba, SMBIOSIZE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0piix4_smba =3D 0;
> =A0 =A0 =A0 =A0}
