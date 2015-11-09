From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 4/5] i2c-piix4: Add support for multiplexed main
 adapter in SB800
Date: Mon, 09 Nov 2015 12:45:42 +0200
Message-ID: <1447065942.31665.29.camel@linux.intel.com>
References: <1446896126-13369-1-git-send-email-fetzer.ch@gmail.com>
	 <1446896126-13369-5-git-send-email-fetzer.ch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64213 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574AbbKIKrs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 9 Nov 2015 05:47:48 -0500
In-Reply-To: <1446896126-13369-5-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christian Fetzer <fetzer.ch@gmail.com>, linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com, Thomas Brandon <tbrandonau@gmail.com>, Eddi De Pieri <eddi@depieri.net>

On Sat, 2015-11-07 at 12:35 +0100, Christian Fetzer wrote:
> The SB800 chipset supports a multiplexed main SMBus controller with
> four ports. The multiplexed ports share the same SMBus address and
> register set. The port is selected by bits 2:1 of the smb_en register
> (0x2C).
>=20
> Only one port can be active at any point in time therefore a mutex is
> needed in order to synchronize access.
>=20
> Tested on HP ProLiant MicroServer G7 N54L (where this patch adds
> support to access sensor data from the w83795adg).
>=20
> Cc: Thomas Brandon <tbrandonau@gmail.com>
> Cc: Eddi De Pieri <eddi@depieri.net>
> Signed-off-by: Christian Fetzer <fetzer.ch@gmail.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> =C2=A0drivers/i2c/busses/i2c-piix4.c | 105
> +++++++++++++++++++++++++++++++++++++++--
> =C2=A01 file changed, 100 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-
> piix4.c
> index 67ada1e..4beaa3d 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -23,6 +23,9 @@
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0Note: we assume there can only be one device,=
 with one or more
> =C2=A0=C2=A0=C2=A0=C2=A0SMBus interfaces.
> +=C2=A0=C2=A0=C2=A0The device can register multiple i2c_adapters (up =
to
> PIIX4_MAX_ADAPTERS).
> +=C2=A0=C2=A0=C2=A0For devices supporting multiple ports the i2c_adap=
ter should
> provide
> +=C2=A0=C2=A0=C2=A0an i2c_algorithm to access them.
> =C2=A0*/
> =C2=A0
> =C2=A0#include <linux/module.h>
> @@ -37,6 +40,7 @@
> =C2=A0#include <linux/dmi.h>
> =C2=A0#include <linux/acpi.h>
> =C2=A0#include <linux/io.h>
> +#include <linux/mutex.h>
> =C2=A0
> =C2=A0
> =C2=A0/* PIIX4 SMBus address offsets */
> @@ -129,10 +133,12 @@ static const struct dmi_system_id
> piix4_dmi_ibm[] =3D {
> =C2=A0};
> =C2=A0
> =C2=A0/* SB800 globals */
> +DEFINE_MUTEX(piix4_mutex_sb800);

Same question as for patch 3.

> =C2=A0static bool piix4_smb_idx_sb800;
> =C2=A0
> =C2=A0struct i2c_piix4_adapdata {
> =C2=A0	unsigned short smba;
> +	unsigned short port;
> =C2=A0};
> =C2=A0
> =C2=A0static int piix4_setup(struct pci_dev *PIIX4_dev,
> @@ -312,6 +318,8 @@ static int piix4_setup_sb800(struct pci_dev
> *PIIX4_dev,
> =C2=A0	else
> =C2=A0		dev_dbg(&PIIX4_dev->dev, "Using SMI# for SMBus\n");
> =C2=A0
> +	mutex_init(&piix4_mutex_sb800);
> +
> =C2=A0	dev_info(&PIIX4_dev->dev,
> =C2=A0		=C2=A0"SMBus Host Controller at 0x%x, revision %d\n",
> =C2=A0		=C2=A0piix4_smba, i2ccfg >> 4);
> @@ -526,6 +534,43 @@ static s32 piix4_access(struct i2c_adapter *
> adap, u16 addr,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/*
> + * Handles access to multiple SMBus ports on the SB800.
> + * The port is selected by bits 2:1 of the smb_en register (0x2C).
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
> +	mutex_lock(&piix4_mutex_sb800);
> +
> +	outb_p(smb_en, SB800_PIIX4_SMB_IDX);
> +	smba_en_lo =3D inb_p(SB800_PIIX4_SMB_IDX + 1);
> +
> +	port =3D adapdata->port;
> +	if ((smba_en_lo & 6) !=3D (port << 1))
> +		outb_p((smba_en_lo & ~6) | (port << 1),
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SB800_PIIX4_SMB_IDX + 1)=
;
> +
> +	retval =3D piix4_access(adap, addr, flags, read_write,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0command, size, data);
> +
> +	outb_p(smba_en_lo, SB800_PIIX4_SMB_IDX + 1);
> +
> +	mutex_unlock(&piix4_mutex_sb800);
> +
> +	return retval;
> +}
> +
> =C2=A0static u32 piix4_func(struct i2c_adapter *adapter)
> =C2=A0{
> =C2=A0	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
> @@ -538,6 +583,11 @@ static const struct i2c_algorithm
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
> @@ -613,6 +663,42 @@ static int piix4_add_adapter(struct pci_dev
> *dev, unsigned short smba,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned
> short smba)
> +{
> +	unsigned short port;

This one has to be at least signed and int to be aligned with patch 2.

> +	int retval;
> +	struct i2c_piix4_adapdata *adapdata;

These lines better to exchange.

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
> +		adapdata->port =3D port;
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
> +	return retval;
> +}
> +
> =C2=A0static int piix4_probe(struct pci_dev *dev, const struct
> pci_device_id *id)
> =C2=A0{
> =C2=A0	int retval;
> @@ -631,19 +717,28 @@ static int piix4_probe(struct pci_dev *dev,
> const struct pci_device_id *id)
> =C2=A0
> =C2=A0		/* base address location etc changed in SB800 */
> =C2=A0		retval =3D piix4_setup_sb800(dev, id, 0);
> +		if (retval < 0)
> +			return retval;
> +
> +		/*
> +		=C2=A0* Try to register multiplexed main SMBus adapter,
> +		=C2=A0* give up if we can't
> +		=C2=A0*/
> +		retval =3D piix4_add_adapters_sb800(dev, retval);
> =C2=A0	} else {
> =C2=A0		retval =3D piix4_setup(dev, id);
> +		if (retval < 0)
> +			return retval;
> +
> +		/* Try to register main SMBus adapter, give up if we
> can't */
> +		retval =3D piix4_add_adapter(dev, retval,
> +					=C2=A0=C2=A0=C2=A0&piix4_main_adapters[0]);
> =C2=A0	}
> =C2=A0
> =C2=A0	/* If no main SMBus found, give up */
> =C2=A0	if (retval < 0)
> =C2=A0		return retval;
> =C2=A0
> -	/* Try to register main SMBus adapter, give up if we can't
> */
> -	retval =3D piix4_add_adapter(dev, retval,
> &piix4_main_adapters[0]);
> -	if (retval < 0)
> -		return retval;
> -
> =C2=A0	/* Check for auxiliary SMBus on some AMD chipsets */
> =C2=A0	retval =3D -ENODEV;
> =C2=A0

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
