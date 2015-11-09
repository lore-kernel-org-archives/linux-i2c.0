From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 3/5] i2c-piix4: Request base address index region
 once for SB800
Date: Mon, 09 Nov 2015 12:40:18 +0200
Message-ID: <1447065618.31665.25.camel@linux.intel.com>
References: <1446896126-13369-1-git-send-email-fetzer.ch@gmail.com>
	 <1446896126-13369-4-git-send-email-fetzer.ch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24745 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbbKIKkR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 9 Nov 2015 05:40:17 -0500
In-Reply-To: <1446896126-13369-4-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christian Fetzer <fetzer.ch@gmail.com>, linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com

On Sat, 2015-11-07 at 12:35 +0100, Christian Fetzer wrote:
> Request the SMBus base address index region once in piix4_probe. This
> is particularly useful when using the multiplexed adapter in SB800 as
> it avoids requesting and releasing the region on every transfer.
>=20
> Signed-off-by: Christian Fetzer <fetzer.ch@gmail.com>
> ---
> =C2=A0drivers/i2c/busses/i2c-piix4.c | 37 ++++++++++++++++++++++++---=
---
> -------
> =C2=A01 file changed, 24 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-
> piix4.c
> index 0e4ae60..67ada1e 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -78,6 +78,9 @@
> =C2=A0/* Multi-port constants */
> =C2=A0#define PIIX4_MAX_ADAPTERS 4
> =C2=A0
> +/* SB800 constants */
> +#define SB800_PIIX4_SMB_IDX 0xCD6

Small letters for value?

> +
> =C2=A0/* insmod parameters */
> =C2=A0
> =C2=A0/* If force is set to anything different from 0, we forcibly en=
able
> the
> @@ -125,6 +128,9 @@ static const struct dmi_system_id piix4_dmi_ibm[]
> =3D {
> =C2=A0	{ },
> =C2=A0};
> =C2=A0
> +/* SB800 globals */
> +static bool piix4_smb_idx_sb800;
> +

By the way, could it be part of driver data, i.e. member of struct
i2c_piix4_adapdata?

>=C2=A0
> =C2=A0struct i2c_piix4_adapdata {
> =C2=A0	unsigned short smba;
> =C2=A0};
> @@ -232,7 +238,6 @@ static int piix4_setup_sb800(struct pci_dev
> *PIIX4_dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct pci_device_id *id=
, u8 aux)
> =C2=A0{
> =C2=A0	unsigned short piix4_smba;
> -	unsigned short smba_idx =3D 0xcd6;
> =C2=A0	u8 smba_en_lo, smba_en_hi, smb_en, smb_en_status;
> =C2=A0	u8 i2ccfg, i2ccfg_offset =3D 0x10;
> =C2=A0
> @@ -254,16 +259,10 @@ static int piix4_setup_sb800(struct pci_dev
> *PIIX4_dev,
> =C2=A0	else
> =C2=A0		smb_en =3D (aux) ? 0x28 : 0x2c;
> =C2=A0
> -	if (!request_region(smba_idx, 2, "smba_idx")) {
> -		dev_err(&PIIX4_dev->dev, "SMBus base address index
> region "
> -			"0x%x already in use!\n", smba_idx);
> -		return -EBUSY;
> -	}
> -	outb_p(smb_en, smba_idx);
> -	smba_en_lo =3D inb_p(smba_idx + 1);
> -	outb_p(smb_en + 1, smba_idx);
> -	smba_en_hi =3D inb_p(smba_idx + 1);
> -	release_region(smba_idx, 2);
> +	outb_p(smb_en, SB800_PIIX4_SMB_IDX);
> +	smba_en_lo =3D inb_p(SB800_PIIX4_SMB_IDX + 1);
> +	outb_p(smb_en + 1, SB800_PIIX4_SMB_IDX);
> +	smba_en_hi =3D inb_p(SB800_PIIX4_SMB_IDX + 1);
> =C2=A0
> =C2=A0	if (!smb_en) {
> =C2=A0		smb_en_status =3D smba_en_lo & 0x10;
> @@ -621,11 +620,20 @@ static int piix4_probe(struct pci_dev *dev,
> const struct pci_device_id *id)
> =C2=A0	if ((dev->vendor =3D=3D PCI_VENDOR_ID_ATI &&
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->device =3D=3D PCI_DEVICE_ID=
_ATI_SBX00_SMBUS &&
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->revision >=3D 0x40) ||
> -	=C2=A0=C2=A0=C2=A0=C2=A0dev->vendor =3D=3D PCI_VENDOR_ID_AMD)
> +	=C2=A0=C2=A0=C2=A0=C2=A0dev->vendor =3D=3D PCI_VENDOR_ID_AMD) {
> +		if (!request_region(SB800_PIIX4_SMB_IDX, 2,
> "smba_idx")) {
> +			dev_err(&dev->dev,
> +			"SMBus base address index region 0x%x
> already in use!\n",
> +			SB800_PIIX4_SMB_IDX);
> +			return -EBUSY;
> +		}
> +		piix4_smb_idx_sb800 =3D true;
> +
> =C2=A0		/* base address location etc changed in SB800 */
> =C2=A0		retval =3D piix4_setup_sb800(dev, id, 0);
> -	else
> +	} else {
> =C2=A0		retval =3D piix4_setup(dev, id);
> +	}
> =C2=A0
> =C2=A0	/* If no main SMBus found, give up */
> =C2=A0	if (retval < 0)
> @@ -692,6 +700,9 @@ static void piix4_remove(struct pci_dev *dev)
> =C2=A0		piix4_adap_remove(piix4_aux_adapter, true);
> =C2=A0		piix4_aux_adapter =3D NULL;
> =C2=A0	}
> +
> +	if (piix4_smb_idx_sb800)
> +		release_region(SB800_PIIX4_SMB_IDX, 2);
> =C2=A0}
> =C2=A0
> =C2=A0static struct pci_driver piix4_driver =3D {

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
