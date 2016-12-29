From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on Dell machines
Date: Thu, 29 Dec 2016 10:00:57 +0100
Message-ID: <201612291000.58489@pali>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com> <20161229082936.GA4114@ozzy.nask.waw.pl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1670049.MPicJGMoIW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20161229082936.GA4114@ozzy.nask.waw.pl>
Sender: platform-driver-x86-owner@vger.kernel.org
To: =?utf-8?q?Micha=C5=82_K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

--nextPart1670049.MPicJGMoIW
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 29 December 2016 09:29:36 Micha=C5=82 K=C4=99pie=C5=84 wrote:
> > Dell platform team told us that some (DMI whitelisted) Dell
> > Latitude machines have ST microelectronics accelerometer at i2c
> > address 0x29. That i2c address is not specified in DMI or ACPI, so
> > runtime detection without whitelist which is below is not
> > possible.
> >=20
> > Presence of that ST microelectronics accelerometer is verified by
> > existence of SMO88xx ACPI device which represent that
> > accelerometer. Unfortunately without i2c address.
>=20
> This part of the commit message sounded a bit confusing to me at
> first because there is already an ACPI driver which handles SMO88xx
> devices (dell-smo8800).  My understanding is that:
>=20
>   * the purpose of this patch is to expose a richer interface (as
>     provided by lis3lv02d) to these devices on some machines,
>=20
>   * on whitelisted machines, dell-smo8800 and lis3lv02d can work
>     simultaneously (even though dell-smo8800 effectively duplicates
>     the work that lis3lv02d does).

No. dell-smo8800 reads from ACPI irq number and exports /dev/freefall=20
device which notify userspace about falls. lis3lv02d is i2c driver which=20
exports axes of accelerometer. Additionaly lis3lv02d can export also=20
/dev/freefall if registerer of i2c device provides irq number -- which=20
is not case of this patch.

So both drivers are doing different things and both are useful.

IIRC both dell-smo8800 and lis3lv02d represent one HW device (that ST=20
microelectronics accelerometer) but due to complicated HW abstraction=20
and layers on Dell laptops it is handled by two drivers, one ACPI and=20
one i2c.

Yes, in ideal world irq number should be passed to lis3lv02d driver and=20
that would export whole device (with /dev/freefall too), but due to HW=20
abstraction it is too much complicated...

> If I got something wrong, please correct me.  If I got it right, it
> might make sense to rephrase the commit message a bit so that the
> first bullet point above is immediately clear to the reader.
>=20
> > This patch registers lis3lv02d device at i2c address 0x29 if is
> > detected.
> >=20
> > Finally commit a7ae81952cda ("i2c: i801: Allow ACPI SystemIO
> > OpRegion to conflict with PCI BAR") allowed to use i2c-i801 driver
> > on Dell machines so lis3lv02d correctly initialize accelerometer.
> >=20
> > Tested on Dell Latitude E6440.
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > ---
> >=20
> >  drivers/i2c/busses/i2c-i801.c |   98
> >  +++++++++++++++++++++++++++++++++++++++++ 1 file changed, 98
> >  insertions(+)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-i801.c
> > b/drivers/i2c/busses/i2c-i801.c index eb3627f..188cfd4 100644
> > --- a/drivers/i2c/busses/i2c-i801.c
> > +++ b/drivers/i2c/busses/i2c-i801.c
> > @@ -1118,6 +1118,101 @@ static void dmi_check_onboard_devices(const
> > struct dmi_header *dm, void *adap)
> >=20
> >  	}
> > =20
> >  }
> >=20
> > +static acpi_status check_acpi_smo88xx_device(acpi_handle
> > obj_handle, +					     u32 nesting_level,
> > +					     void *context,
> > +					     void **return_value)
> > +{
> > +	struct acpi_device_info *info;
> > +	acpi_status status;
> > +	char *hid;
> > +
> > +	status =3D acpi_get_object_info(obj_handle, &info);
>=20
> acpi_get_object_info() allocates the returned buffer, which the
> caller has to free.

Ok, I will fix it in next patch iteration.

> > +	if (!ACPI_SUCCESS(status) || !(info->valid & ACPI_VALID_HID))
> > +		return AE_OK;
> > +
> > +	hid =3D info->hardware_id.string;
> > +	if (!hid)
> > +		return AE_OK;
> > +
> > +	if (strlen(hid) < 7)
> > +		return AE_OK;
> > +
> > +	if (memcmp(hid, "SMO88", 5) !=3D 0)
> > +		return AE_OK;
> > +
> > +	*((bool *)return_value) =3D true;
> > +	return AE_CTRL_TERMINATE;
> > +}
> > +
> > +static bool is_dell_system_with_lis3lv02d(void)
> > +{
> > +	bool found;
> > +	acpi_status status;
> > +	const char *vendor;
> > +
> > +	vendor =3D dmi_get_system_info(DMI_SYS_VENDOR);
> > +	if (strcmp(vendor, "Dell Inc.") !=3D 0)
> > +		return false;
> > +
> > +	/*
> > +	 * Check if ACPI device SMO88xx exists and if is enabled. That
> > ACPI +	 * device represent our ST microelectronics lis3lv02d
> > accelerometer but +	 * unfortunately without any other additional
> > information. +	 */
> > +	found =3D false;
> > +	status =3D acpi_get_devices(NULL, check_acpi_smo88xx_device, NULL,
> > +				  (void **)&found);
> > +	if (!ACPI_SUCCESS(status) || !found)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +/*
> > + * Dell platform team told us that these Latitude devices have
> > + * ST microelectronics accelerometer at i2c address 0x29.
> > + * That i2c address is not specified in DMI or ACPI, so runtime
> > + * detection without whitelist which is below is not possible.
> > + */
> > +static const char * const dmi_dell_product_names[] =3D {
> > +	"Latitude E5250",
> > +	"Latitude E5450",
> > +	"Latitude E5550",
> > +	"Latitude E6440",
> > +	"Latitude E6440 ATG",
> > +	"Latitude E6540",
> > +};
> > +
> > +static void register_dell_lis3lv02d_i2c_device(struct i801_priv
> > *priv) +{
> > +	struct i2c_board_info info;
> > +	const char *product_name;
> > +	bool known_i2c_address;
> > +	int i;
> > +
> > +	known_i2c_address =3D false;
> > +	product_name =3D dmi_get_system_info(DMI_PRODUCT_NAME);
> > +	for (i =3D 0; i < ARRAY_SIZE(dmi_dell_product_names); ++i) {
> > +		if (strcmp(product_name, dmi_dell_product_names[i]) =3D=3D 0) {
> > +			known_i2c_address =3D true;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!known_i2c_address) {
> > +		dev_warn(&priv->pci_dev->dev,
> > +			 "Accelerometer lis3lv02d i2c device is present "
> > +			 "but its i2c address is unknown, skipping ...\n");
>=20
> You are probably well aware of this, but checkpatch prefers keeping
> long log messages in one line.  I am pointing it out just in case.

Yes, but I do not know how to fix it. Splitting message into two lines=20
generates warning. Having long line generates warning too.

> > +		return;
> > +	}
> > +
> > +	memset(&info, 0, sizeof(struct i2c_board_info));
>=20
> How about just doing "struct i2c_board_info info =3D { 0 };" instead?

Ok.

> > +	info.addr =3D 0x29;
> > +	strlcpy(info.type, "lis3lv02d", I2C_NAME_SIZE);
> > +	i2c_new_device(&priv->adapter, &info);
> > +}
> > +
> >=20
> >  /* Register optional slaves */
> >  static void i801_probe_optional_slaves(struct i801_priv *priv)
> >  {
> >=20
> > @@ -1136,6 +1231,9 @@ static void i801_probe_optional_slaves(struct
> > i801_priv *priv)
> >=20
> >  	if (dmi_name_in_vendors("FUJITSU"))
> >  =09
> >  		dmi_walk(dmi_check_onboard_devices, &priv->adapter);
> >=20
> > +
> > +	if (is_dell_system_with_lis3lv02d())
> > +		register_dell_lis3lv02d_i2c_device(priv);
> >=20
> >  }
> >  #else
> >  static void __init input_apanel_init(void) {}
>=20
> I tested this patch on a Vostro V131, which is not on the whitelist,
> so all I got was the warning message, but to this extent, it works
> for me.

Hm... That means your notebook has ST microelectronics accelerometer=20
too. You could try to find it on i2c-i801 bus with userspace i2cdetect=20
program (part of i2c-tools) and get i2c address. If it will work we can=20
extend DMI name --> i2c address mapping and include your notebook too.

I have that list of confirmed Latitude devices since April 2015 but due=20
to problem with ACPI resource conflicts it was not possible to load i2c-
i801.ko bus driver. It was fixed only this year by commit a7ae81952cda.=20
So list of devices is probably not up-to-date and new appeared.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1670049.MPicJGMoIW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhk0MoACgkQi/DJPQPkQ1KrHQCgvIi9OPkfn1P5ifap5TYs/SfM
Fa4AoLMS79udWSciQbb1q//d0+fLUuMu
=Muhw
-----END PGP SIGNATURE-----

--nextPart1670049.MPicJGMoIW--
