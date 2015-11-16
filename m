From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 2/3] i2c-piix4: Add support for multiplexed main
 adapter in SB800
Date: Mon, 16 Nov 2015 11:29:14 +0200
Message-ID: <1447666154.31665.143.camel@linux.intel.com>
References: <1447587184-21965-1-git-send-email-fetzer.ch@gmail.com>
	 <1447587184-21965-3-git-send-email-fetzer.ch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61645 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718AbbKPJ3V (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 16 Nov 2015 04:29:21 -0500
In-Reply-To: <1447587184-21965-3-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christian Fetzer <fetzer.ch@gmail.com>, linux-i2c@vger.kernel.org
Cc: jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, galandilias@gmail.com, Thomas Brandon <tbrandonau@gmail.com>, Eddi De Pieri <eddi@depieri.net>

On Sun, 2015-11-15 at 12:33 +0100, Christian Fetzer wrote:
> The SB800 chipset supports a multiplexed main SMBus controller with
> four ports. The multiplexed ports share the same SMBus address and
> register set. The port is selected by bits 2:1 of the smb_en register
> (0x2C).
>=20
> Only one port can be active at any point in time therefore a mutex is
> needed in order to synchronize access.
>=20
> Additionally, the commit avoids requesting and releasing the SMBus
> base
> address index region on every multiplexed transfer by moving the
> request_region call into piix4_probe.
>=20
> Tested on HP ProLiant MicroServer G7 N54L (where this patch adds
> support to access sensor data from the w83795adg).

One nitpick below.

>=20
> +/*
> + * Handles access to multiple SMBus ports on the SB800.
>=20

> + * The port is selected by bits 2:1 of the smb_en register (0x2C).

(1)

> + * Returns negative errno on error.
> + *
> + * Note: The selected port must be returned to the initial selection
> to avoid
> + * problems on certain systems.
> + */
> +static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
> +		=C2=A0unsigned short flags, char read_write,
> +		=C2=A0u8 command, int size, union i2c_smbus_data *data)
> +{
> +	struct i2c_piix4_adapdata *adapdata =3D
> i2c_get_adapdata(adap);
> +	u8 smba_en_lo, smb_en =3D 0x2c;
> +	u8 port;
> +	int retval;
> +
> +	mutex_lock(adapdata->mutex);
> +
> +	outb_p(smb_en, SB800_PIIX4_SMB_IDX);
> +	smba_en_lo =3D inb_p(SB800_PIIX4_SMB_IDX + 1);
> +
> +	port =3D adapdata->port;
> +	if ((smba_en_lo & 6) !=3D (port << 1))

I think it would be nice to have a definition for magic number along
with (1).

/* The port is selected by bits 2:1 of the smb_en register (0x2C) */
#define SB800_PIIX4_PORT_IDX_MASK 0x06

> +		outb_p((smba_en_lo & ~6) | (port << 1),
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SB800_PIIX4_SMB_IDX + 1)=
;
> +
> +	retval =3D piix4_access(adap, addr, flags, read_write,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0command, size, data);
> +
> +	outb_p(smba_en_lo, SB800_PIIX4_SMB_IDX + 1);
> +
> +	mutex_unlock(adapdata->mutex);
> +
> +	return retval;
> +}
> +
> =C2=A0static u32 piix4_func(struct i2c_adapter *adapter)
> =C2=A0{
> =C2=A0	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
> @@ -539,6 +581,11 @@ static const struct i2c_algorithm
> smbus_algorithm =3D {
> =C2=A0	.functionality	=3D piix4_func,
> =C2=A0};
> =C2=A0
> +static const struct i2c_algorithm piix4_smbus_algorithm_sb800 =3D {
> +	.smbus_xfer	=3D piix4_access_sb800,
> +	.functionality	=3D piix4_func,
> +};
> +
> =C2=A0static const struct pci_device_id piix4_ids[] =3D {
> =C2=A0	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_82371AB_3) },
> =C2=A0	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_82443MX_3) },
> @@ -614,6 +661,53 @@ static int piix4_add_adapter(struct pci_dev
> *dev, unsigned short smba,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned
> short smba)
> +{
> +	struct mutex *mutex;
> +	struct i2c_piix4_adapdata *adapdata;
> +	int port;
> +	int retval;
> +
> +	mutex =3D kzalloc(sizeof(*mutex), GFP_KERNEL);
> +	if (mutex =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	mutex_init(mutex);
> +
> +	for (port =3D 0; port < PIIX4_MAX_ADAPTERS; port++) {
> +		retval =3D piix4_add_adapter(dev, smba,
> +					=C2=A0=C2=A0=C2=A0&piix4_main_adapters[port
> ]);
> +		if (retval < 0)
> +			goto error;
> +
> +		piix4_main_adapters[port]->algo =3D
> &piix4_smbus_algorithm_sb800;
> +
> +		adapdata =3D
> i2c_get_adapdata(piix4_main_adapters[port]);
> +		adapdata->sb800_main =3D true;
> +		adapdata->port =3D port;
> +		adapdata->mutex =3D mutex;
> +	}
> +
> +	return retval;
> +
> +error:
> +	dev_err(&dev->dev,
> +		"Error setting up SB800 adapters.
> Unregistering!\n");
> +	while (--port >=3D 0) {
> +		adapdata =3D
> i2c_get_adapdata(piix4_main_adapters[port]);
> +		if (adapdata->smba) {
> +			i2c_del_adapter(piix4_main_adapters[port]);
> +			kfree(adapdata);
> +			kfree(piix4_main_adapters[port]);
> +			piix4_main_adapters[port] =3D NULL;
> +		}
> +	}
> +
> +	kfree(mutex);
> +
> +	return retval;
> +}
> +
> =C2=A0static int piix4_probe(struct pci_dev *dev, const struct
> pci_device_id *id)
> =C2=A0{
> =C2=A0	int retval;
> @@ -621,20 +715,41 @@ static int piix4_probe(struct pci_dev *dev,
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
> +
> =C2=A0		/* base address location etc changed in SB800 */
> =C2=A0		retval =3D piix4_setup_sb800(dev, id, 0);
> -	else
> -		retval =3D piix4_setup(dev, id);
> +		if (retval < 0) {
> +			release_region(SB800_PIIX4_SMB_IDX, 2);
> +			return retval;
> +		}
> =C2=A0
> -	/* If no main SMBus found, give up */
> -	if (retval < 0)
> -		return retval;
> +		/*
> +		=C2=A0* Try to register multiplexed main SMBus adapter,
> +		=C2=A0* give up if we can't
> +		=C2=A0*/
> +		retval =3D piix4_add_adapters_sb800(dev, retval);
> +		if (retval < 0) {
> +			release_region(SB800_PIIX4_SMB_IDX, 2);
> +			return retval;
> +		}
> +	} else {
> +		retval =3D piix4_setup(dev, id);
> +		if (retval < 0)
> +			return retval;
> =C2=A0
> -	/* Try to register main SMBus adapter, give up if we can't
> */
> -	retval =3D piix4_add_adapter(dev, retval,
> &piix4_main_adapters[0]);
> -	if (retval < 0)
> -		return retval;
> +		/* Try to register main SMBus adapter, give up if we
> can't */
> +		retval =3D piix4_add_adapter(dev, retval,
> +					=C2=A0=C2=A0=C2=A0&piix4_main_adapters[0]);
> +		if (retval < 0)
> +			return retval;
> +	}
> =C2=A0
> =C2=A0	/* Check for auxiliary SMBus on some AMD chipsets */
> =C2=A0	retval =3D -ENODEV;
> @@ -669,7 +784,13 @@ static void piix4_adap_remove(struct i2c_adapter
> *adap)
> =C2=A0
> =C2=A0	if (adapdata->smba) {
> =C2=A0		i2c_del_adapter(adap);
> -		release_region(adapdata->smba, SMBIOSIZE);
> +		if (adapdata->port =3D=3D 0) {
> +			release_region(adapdata->smba, SMBIOSIZE);
> +			if (adapdata->sb800_main) {
> +				kfree(adapdata->mutex);
> +				release_region(SB800_PIIX4_SMB_IDX,
> 2);
> +			}
> +		}
> =C2=A0		kfree(adapdata);
> =C2=A0		kfree(adap);
> =C2=A0	}

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
