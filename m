From: Christian Fetzer <fetzer.ch@gmail.com>
Subject: Re: [PATCH] i2c-piix4: Fully initialize SB800 before it is registered
Date: Mon, 25 Jan 2016 22:55:31 +0100
Message-ID: <D0A90A2F-108F-4E70-8B7E-32FABFCD917E@gmail.com>
References: <20160125121707.7109c0d3@endymion.delvare>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35981 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796AbcAYVze convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 25 Jan 2016 16:55:34 -0500
Received: by mail-wm0-f41.google.com with SMTP id l65so81767603wmf.1
        for <linux-i2c@vger.kernel.org>; Mon, 25 Jan 2016 13:55:34 -0800 (PST)
In-Reply-To: <20160125121707.7109c0d3@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Hi Jean,

> Am 25.01.2016 um 12:17 schrieb Jean Delvare <jdelvare@suse.de>:
>=20
> This closes a race window where I2C device drivers attempt to access
> I2C buses which aren't fully initialized yet.
>=20

I=E2=80=99m not sure if it=E2=80=99s common to offer tags as first-time=
 contributor, but feel free to add
Tested-by: Christian Fetzer <fetzer.ch@gmail.com>

> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Christian Fetzer <fetzer.ch@gmail.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> ---
> drivers/i2c/busses/i2c-piix4.c |   19 +++++++++----------
> 1 file changed, 9 insertions(+), 10 deletions(-)
>=20
> --- linux-4.5-rc0.orig/drivers/i2c/busses/i2c-piix4.c	2016-01-22 14:0=
6:31.336751852 +0100
> +++ linux-4.5-rc0/drivers/i2c/busses/i2c-piix4.c	2016-01-25 12:08:07.=
812116538 +0100
> @@ -627,6 +627,7 @@ static struct i2c_adapter *piix4_main_ad
> static struct i2c_adapter *piix4_aux_adapter;
>=20
> static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba=
,
> +			     bool sb800_main, unsigned short port,
> 			     const char *name, struct i2c_adapter **padap)
> {
> 	struct i2c_adapter *adap;
> @@ -641,7 +642,8 @@ static int piix4_add_adapter(struct pci_
>=20
> 	adap->owner =3D THIS_MODULE;
> 	adap->class =3D I2C_CLASS_HWMON | I2C_CLASS_SPD;
> -	adap->algo =3D &smbus_algorithm;
> +	adap->algo =3D sb800_main ? &piix4_smbus_algorithm_sb800
> +				: &smbus_algorithm;
>=20
> 	adapdata =3D kzalloc(sizeof(*adapdata), GFP_KERNEL);
> 	if (adapdata =3D=3D NULL) {
> @@ -651,6 +653,8 @@ static int piix4_add_adapter(struct pci_
> 	}
>=20
> 	adapdata->smba =3D smba;
> +	adapdata->sb800_main =3D sb800_main;
> +	adapdata->port =3D port;
>=20
> 	/* set up the sysfs linkage to our parent device */
> 	adap->dev.parent =3D &dev->dev;
> @@ -680,17 +684,11 @@ static int piix4_add_adapters_sb800(stru
> 	int retval;
>=20
> 	for (port =3D 0; port < PIIX4_MAX_ADAPTERS; port++) {
> -		retval =3D piix4_add_adapter(dev, smba,
> +		retval =3D piix4_add_adapter(dev, smba, true, port,
> 					   piix4_main_port_names_sb800[port],
> 					   &piix4_main_adapters[port]);
> 		if (retval < 0)
> 			goto error;
> -
> -		piix4_main_adapters[port]->algo =3D &piix4_smbus_algorithm_sb800;
> -
> -		adapdata =3D i2c_get_adapdata(piix4_main_adapters[port]);
> -		adapdata->sb800_main =3D true;
> -		adapdata->port =3D port;
> 	}
>=20
> 	return retval;
> @@ -748,7 +746,7 @@ static int piix4_probe(struct pci_dev *d
> 			return retval;
>=20
> 		/* Try to register main SMBus adapter, give up if we can't */
> -		retval =3D piix4_add_adapter(dev, retval, "main",
> +		retval =3D piix4_add_adapter(dev, retval, false, 0, "main",
> 					   &piix4_main_adapters[0]);
> 		if (retval < 0)
> 			return retval;
> @@ -775,7 +773,8 @@ static int piix4_probe(struct pci_dev *d
> 	if (retval > 0) {
> 		/* Try to add the aux adapter if it exists,
> 		 * piix4_add_adapter will clean up if this fails */
> -		piix4_add_adapter(dev, retval, piix4_aux_port_name_sb800,
> +		piix4_add_adapter(dev, retval, false, 0,
> +				  piix4_aux_port_name_sb800,
> 				  &piix4_aux_adapter);
> 	}
>=20
>=20
>=20
> --=20
> Jean Delvare
> SUSE L3 Support
