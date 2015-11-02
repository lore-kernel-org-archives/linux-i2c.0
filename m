From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 4/5] i2c-piix4: Add support for multiplexed main
 adapter in SB800
Date: Mon, 02 Nov 2015 14:09:42 +0200
Message-ID: <1446466182.6332.92.camel@linux.intel.com>
References: <1446395529-9987-1-git-send-email-fetzer.ch@gmail.com>
	 <1446395529-9987-5-git-send-email-fetzer.ch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2328 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150AbbKBMJo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 2 Nov 2015 07:09:44 -0500
In-Reply-To: <1446395529-9987-5-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christian Fetzer <fetzer.ch@gmail.com>, linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com, Thomas Brandon <tbrandonau@gmail.com>, Eddi De Pieri <eddi@depieri.net>

On Sun, 2015-11-01 at 17:32 +0100, Christian Fetzer wrote:
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
> +static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned
> short smba)
> +{
> +	unsigned short port;
> +	int retval;
> +	struct i2c_piix4_adapdata *adapdata;
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
> +	dev_err(&dev->dev, "Error setting up SB800 adapters. "
> +		"Unregistering all adapters!\n");

This one Mika told already about.
You might use as well

dev_err(&dev->dev,
=C2=A0"=E2=80=A6\n")


> +	for (port--; port >=3D 0; port--) {

Isn't look complicated? Like I comment in one of previous patches:

while (--port) {

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
> =C2=A0	unsigned short smba_idx =3D 0xcd6;
> @@ -629,19 +714,26 @@ static int piix4_probe(struct pci_dev *dev,
> const struct pci_device_id *id)
> =C2=A0
> =C2=A0		/* base address location etc changed in SB800 */
> =C2=A0		retval =3D piix4_setup_sb800(dev, id, 0);
> +		if (retval < 0)
> +			return retval;
> +
> +		/* Try to register multiplexed main SMBus adapter,
> +		=C2=A0* give up if we can't */

Block comment
/*
=C2=A0* text1
=C2=A0* text2
=C2=A0*/

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
