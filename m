From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3] New-style I2C and SMBus EEPROM driver
	(with	device_ids)
Date: Tue, 10 Jun 2008 15:43:47 +0200
Message-ID: <20080610134347.GA4210@pengutronix.de>
References: <20080605193103.GA13062@pengutronix.de>
	<20080608115033.5dd91786@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9063509624776735568=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080608115033.5dd91786-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============9063509624776735568==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

thanks again for your review!

> As said before, I don't think it's needed, but if you and David insist
> on picking all addresses of the 24C00, so be it.

A new issue is now that some 24C01 also have this behaviour, so I guess the
flag should be renamed from AT24_FLAG_24C00 to AT24_FLAG_TAKE8ADDR or
something.

> > +/*--------------------------------------------------------------------=
-----*/
> > +
> > +static int at24_probe(struct i2c_client *client, const struct i2c_devi=
ce_id *id)
> > +{
> > +	struct at24_platform_data *chip;
> > +	bool writable;
> > +	bool use_smbus =3D false;
> > +	struct at24_data *at24;
> > +	int err;
> > +	unsigned i, num_addresses;
> > +	kernel_ulong_t magic;
> > +
> > +	if (id->driver_data) {
> > +		chip =3D kmalloc(sizeof(struct at24_platform_data), GFP_KERNEL);
> > +		if (!chip) {
>
> You allocate this just to copy it to another structure and free it
> immediately. Allocating the other structure (struct at24_data) earlier
> would save this temporary allocation. Alternatively, just put the struct
> at24_platform_data on the stack, it's small enough to do so.

I can't allocate at24_data beforehand, as I need to know num_addresses,
so I can then calculate the actual size of at24_data. Will use the stack.

> > +		if (!at24->client[i]) {
> > +			dev_err(&client->dev, "address 0x%04x unavailable\n",
>=20
> These are 7-bit addresses, so: 0x%02x.

I was unsure because of the 10-bit-addresses (and %03x looked even more
unusual). Will revert to %02x.

> > +/*
> > + * Chip data. Parameters are byte_len, page_size and flags
> > + */
> > +
> > +/* 128 bit chip, I2C A0-A2 ignored */
> > +#define AT24_DATA_24C00 128 / 8, 1, AT24_FLAG_24C00
> > +
> > +/* 1 Kbit chip, some have 16 byte pages: 24lc014, ... */
> > +#define AT24_DATA_24C01 1024 / 8, 8, 0
>=20
> The Atmel 24C01 datasheet says page size is 4 bytes, and the Microchip
> 24C01A datasheet says 2 bytes. So defaulting to 8 doesn't look safe.

Will go back to 2 because of Microchip. But 24C01 seems to have lots of
variants, which makes a generic entry difficult. Some would need
AT24_FLAG_24C00 (doesn't really matter), and AT24C01 needs 128
addresses?? (please, someone, prove me wrong)

> You're going to quite some extent to obfuscate simple things ;) All

I wanted to make the transition from at24_v2 to at24_v3 easier by
reusing the defines containing chip data. I agree though, that the
benefit is mainly for those who already dared to use this driver (is
there anyone besides David and me?), and not for upstream. Will try to
make it more simple.

> In the end, the only things that must go in at24.h are the definition
> of struct at24_platform_data and its flags. All the rest is internal to
> the driver and should go in at24.c.

I wanted to have the AT24_SIZE_* flags next to the struct, so I won't
forget to change their size if anything inside the struct will change.
Then again, I might work with sizeof here; the result will probably look
a bit nasty, too...

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfralfum Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIToUTD27XaX1/VRsRAun8AKChsbNQDk/dRJoLtAOY8vw4GiPSuwCgyVKA
hrROQCmzzKtp8s/uqarGYiA=
=xOao
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--


--===============9063509624776735568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============9063509624776735568==--
