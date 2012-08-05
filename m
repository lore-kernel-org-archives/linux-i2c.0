From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH v2 0/2] I2C: SIS964: Bus driver
Date: Sun, 5 Aug 2012 14:04:54 +0200
Message-ID: <20120805140454.3e7a9606@endymion.delvare>
References: <1344008145-14579-1-git-send-email-amaury.decreme@gmail.com>
	<20120803180712.1e768042@endymion.delvare>
	<CAPXEm73QX7haU5p7HU+=+qo5wnivt6j+WH5bQGZ0ZK0Ek2Cuyw@mail.gmail.com>
	<20120803190758.34e67b1e@endymion.delvare>
	<CAPXEm72mv=j+D-7FU_VMCy0vesFV2TKa6xufWVcTkpgq=mddcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAPXEm72mv=j+D-7FU_VMCy0vesFV2TKa6xufWVcTkpgq=mddcQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Amaury =?UTF-8?B?RGVjcsOqbWU=?= <amaury.decreme@gmail.com>
Cc: ben-linux@fluff.org, w.sang@pengutronix.de, rob@landley.net, jeffrey.t.kirsher@intel.com, akpm@linux-foundation.org, davem@davemloft.net, gregkh@linuxfoundation.org, joe@perches.com, ralf@linux-mips.org, dirk.brandewie@gmail.com, jayachandranc@netlogicmicro.com, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mhoffman@lightlink.com, amalysh@web.de, "=?UTF-8?B?5p2O5b+X5p2R?= (nelson)" <nelson@sis.com>
List-Id: linux-i2c@vger.kernel.org

Salut Amaury,

On Sat, 4 Aug 2012 00:38:29 +0000, Amaury Decr=C3=AAme wrote:
> > There's nothing confusing, drivers supporting several devices are
> > legion. If the devices are really almost compatible, reusing an
> > existing driver is the way to go.
>=20
> With that in mind, here is an alpha preview of what the patch will
> look like if SIS964 support is added in i2c-sis630.

If that's all that is needed to get the SIS964 supported, then we
definitely don't want a separate driver.

> diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c=
-sis630.c
> index 5d6723b..861d58b 100644
> --- a/drivers/i2c/busses/i2c-sis630.c
> +++ b/drivers/i2c/busses/i2c-sis630.c
> @@ -33,6 +33,8 @@
>         Fixed logical error by restoring of Host Master Clock
>     31.07.2003
>         Added block data read/write support.
> +   03.08.2012
> +       Added support of SiS964 - Amaury Decr=C3=AAme <amaury.decreme=
@gmail.com>
>  */
>=20
>  /*
> @@ -41,6 +43,7 @@
>     Supports:
>         SIS 630
>         SIS 730
> +       SIS 964
>=20
>     Note: we assume there can only be one device, with one SMBus inte=
rface.
>  */
> @@ -55,22 +58,22 @@
>  #include <linux/acpi.h>
>  #include <linux/io.h>
>=20
> +/* SIS964 id, defined here as we are the only file using it */
> +#define PCI_DEVICE_ID_SI_964   0x0964
> +
>  /* SIS630 SMBus registers */
> -#define SMB_STS                        0x80    /* status */
> -#define SMB_EN                 0x81    /* status enable */
> -#define SMB_CNT                        0x82
> -#define SMBHOST_CNT            0x83
> -#define SMB_ADDR               0x84
> -#define SMB_CMD                        0x85
> -#define SMB_PCOUNT             0x86    /* processed count */
> -#define SMB_COUNT              0x87
> -#define SMB_BYTE               0x88    /* ~0x8F data byte field */
> -#define SMBDEV_ADDR            0x90
> -#define SMB_DB0                        0x91
> -#define SMB_DB1                        0x92
> -#define SMB_SAA                        0x93
> -
> -/* register count for request_region */
> +#define SMB_STS                        0x00 + offset   /* status */
> +#define SMB_CNT                        0x02 + offset   /* control */
> +#define SMBHOST_CNT            0x03 + offset   /* host control */
> +#define SMB_ADDR               0x04 + offset   /* address */
> +#define SMB_CMD                        0x05 + offset   /* command */
> +#define SMB_COUNT              0x07 + offset   /* byte count */
> +#define SMB_BYTE               0x08 + offset   /* ~0x8F data byte fi=
eld */
> +#define SMB_SAA                        0x13 + offset   /* host slave
> alias address */

Your email client apparently folds long lines, you'll have to fix that
when you resend.

The above definitions are dangerous. At the very least you need
parentheses around. Better would be to pass the offset as a parameter.
Best would be to only define the constants and add the offset in
the calling code. There are only 8 locations so it should be easy.

> +
> +/* register count for request_region
> + * As we don't use SMB_PCOUNT 20 is ok for SiS630 and SiS964
> + */
>  #define SIS630_SMB_IOREGION    20
>=20
>  /* PCI address constants */
> @@ -107,9 +110,13 @@ static unsigned short acpi_base;
>  static int supported[] =3D {
>         PCI_DEVICE_ID_SI_630,
>         PCI_DEVICE_ID_SI_730,
> +       PCI_DEVICE_ID_SI_964,
>         0 /* terminates the list */
>  };
>=20
> +/* SMB registers offset */
> +static int offset;

Please move this declaration close to acpi_base.

It would be more efficient to not introduce an offset variable but
rather smbus_base =3D acpi_base + offset. That way you save an addition
each time you access a register.

> +
>  static inline u8 sis630_read(u8 reg)
>  {
>         return inb(acpi_base + reg);
> @@ -412,6 +419,10 @@ static int __devinit sis630_setup(struct pci_dev
> *sis630_dev)
>                 return -ENODEV;
>         }
>=20
> +       if (supported[i] =3D=3D PCI_DEVICE_ID_SI_964)
> +               offset =3D 0xE0;
> +       else
> +               offset =3D 0x80;
>         /*
>            Enable ACPI first , so we can accsess reg 74-75
>            in acpi io space and read acpi base addr
> @@ -474,6 +485,7 @@ static struct i2c_adapter sis630_adapter =3D {
>=20
>  static DEFINE_PCI_DEVICE_TABLE(sis630_ids) =3D {
>         { PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503) },
> +       { PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_964) },
>         { PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_LPC) },
>         { 0, }
>  };
> @@ -482,6 +494,7 @@ MODULE_DEVICE_TABLE (pci, sis630_ids);
>=20
>  static int __devinit sis630_probe(struct pci_dev *dev, const struct
> pci_device_id *id)
>  {
> +       dev_dbg(&dev->dev, "salut");

Bien le bonjour =C3=A0 toi aussi :)

>         if (sis630_setup(dev)) {
>                 dev_err(&dev->dev, "SIS630 comp. bus not detected,
> module not inserted.\n");
>                 return -ENODEV;
>=20

--=20
Jean Delvare
