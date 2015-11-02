From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 3/5] i2c-piix4: Request base address index region
 once for SB800
Date: Mon, 02 Nov 2015 14:02:40 +0200
Message-ID: <1446465760.6332.88.camel@linux.intel.com>
References: <1446395529-9987-1-git-send-email-fetzer.ch@gmail.com>
	 <1446395529-9987-4-git-send-email-fetzer.ch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21142 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbbKBMCs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 2 Nov 2015 07:02:48 -0500
In-Reply-To: <1446395529-9987-4-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christian Fetzer <fetzer.ch@gmail.com>, linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com

On Sun, 2015-11-01 at 17:32 +0100, Christian Fetzer wrote:
> Request the SMBus base address index region once in piix4_probe. This
> is particularly useful when using the multiplexed adapter in SB800 as
> it avoids requesting and releasing the region on every transfer.


> @@ -616,16 +612,26 @@ static int piix4_add_adapter(struct pci_dev
> *dev, unsigned short smba,
> =C2=A0
> =C2=A0static int piix4_probe(struct pci_dev *dev, const struct
> pci_device_id *id)
> =C2=A0{
> +	unsigned short smba_idx =3D 0xcd6;
> =C2=A0	int retval;
> =C2=A0
> =C2=A0	if ((dev->vendor =3D=3D PCI_VENDOR_ID_ATI &&
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->device =3D=3D PCI_DEVICE_ID=
_ATI_SBX00_SMBUS &&
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->revision >=3D 0x40) ||
> -	=C2=A0=C2=A0=C2=A0=C2=A0dev->vendor =3D=3D PCI_VENDOR_ID_AMD)
> +	=C2=A0=C2=A0=C2=A0=C2=A0dev->vendor =3D=3D PCI_VENDOR_ID_AMD) {
> +

Redundant empty line.

> +		if (!request_region(smba_idx, 2, "smba_idx")) {
> +			dev_err(&dev->dev, "SMBus base address index
> region "
> +				"0x%x already in use!\n", smba_idx);

Do not split string literals, something like following will be okay.

dev_err(&dev->dev,
=C2=A0 "SMBus base address index region 0x%x already in use!\n",
=C2=A0 =C2=A0smba_idx);


> +			return -EBUSY;
> +		}
> +		piix4_smb_idx_sb800 =3D smba_idx;
> +
> =C2=A0		/* base address location etc changed in SB800 */
> =C2=A0		retval =3D piix4_setup_sb800(dev, id, 0);
> -	else
> +	} else {
> =C2=A0		retval =3D piix4_setup(dev, id);
> +	}


--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
