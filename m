From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] eeprom: at24: check if the chip is functional in probe()
Date: Wed, 10 Aug 2016 16:07:15 +0200
Message-ID: <20160810140715.GB1607@katana>
References: <1470837257-15521-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470837257-15521-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 10, 2016 at 03:54:17PM +0200, Bartosz Golaszewski wrote:
> The at24 driver doesn't check if the chip is functional in its probe
> function. This leads to instantiating devices that are not physically
> present. For example the cape EEPROMs for BeagleBone Black are defined
> in the device tree at four addresses on i2c2, but normally only one of
> them is present.
>=20
> If the userspace doesn't know the location in advance, it will need to
> check if reading the nvmem attributes fails to determine which EEPROM
> is actually there.
>=20
> Try to read a single byte in probe() and bail-out with -ENODEV if the
> read fails.

That's basically OK...

>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/misc/eeprom/at24.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 3cdf8e1..ed1e4eb 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -593,6 +593,7 @@ static int at24_probe(struct i2c_client *client, cons=
t struct i2c_device_id *id)
>  	struct at24_data *at24;
>  	int err;
>  	unsigned i, num_addresses;
> +	char c;

u8?

> =20
>  	if (client->dev.platform_data) {
>  		chip =3D *(struct at24_platform_data *)client->dev.platform_data;
> @@ -780,6 +781,15 @@ static int at24_probe(struct i2c_client *client, con=
st struct i2c_device_id *id)
>  	if (chip.setup)
>  		chip.setup(at24->nvmem, chip.context);
> =20
> +	err =3D at24_read(at24, 0, &c, 1);

Can't we do this before registering dummy clients and nvmem registration?

> +	if (err) {
> +		dev_err(&client->dev,
> +			"error reading the test byte from EEPROM: %d\n", err);

I don't think we should print an error in case of ENODEV.

> +		nvmem_unregister(at24->nvmem);
> +		err =3D -ENODEV;
> +		goto err_clients;
> +	}
> +
>  	return 0;
> =20
>  err_clients:
> --=20
> 2.7.4
>=20

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXqzUTAAoJEBQN5MwUoCm2j18P+wQHNLtHULATtyebcxfzkIyz
JYbLgQf/5BaeCv4jziclIbCadegTHE9Zi6zwKE/duHJOseidP2fyoaSEv0guVejb
PO8p6UlQrByFWV/QOG4NHXXiXP/oLfQyLQzbo5fd6WHPiWcLMkN6yITbbK5flwRT
Scl29pgLsZ/l5b0fFG2GJcXkgajnwa167wT1aFJD90R/oQt5sJOz+2d8jXwp9mLG
WXOHwQIb48hI+nzsiMBFuk2f1lzZJuEDE8VaC7AigT5Dmf543HEq7Bcir3Sdldij
3pfOusIW4Hr9sc6UfQgd637OmepeR02iQep0bnFa3WUZX2WF97QsswSrORGqggZe
QWJDCnStPPsIKzFR0QGR1Vs+NcdDOHM35xHq1vtLF3OYGyU0UWFJ9IZlXvKPjYKi
1vJyXTt4zoeSJABAV9kiaAGU7VMZiva1k586MMoxPYhb2FZz45i1M69qJOwt98l9
wf/gIHpPhaluVYaJzPsPv4vraMit59QfSjspHCs6RENGOACXK81lDF0zF/dzASX/
rDyVSHhwQ38F7F60Z20csZzSTjn9B1uYw95sjnK8fstxYY2Bi9b3D1lwoOSyOMz1
F5G/rK5QsJISaMPqdUbDYgUWhXLVTbFwIfY9jcyPLKVV2mcUI4Tg36v4l2MUuvon
mHQ7W4YHERChKB8Eb8if
=5HXV
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
