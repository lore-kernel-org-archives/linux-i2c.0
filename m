From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: core: Remove needless structure member zero
 initialization
Date: Tue, 12 May 2015 21:03:48 +0200
Message-ID: <20150512190348.GA4449@schokonusskuchen.bad>
References: <1430311477-21759-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430311477-21759-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2015 at 03:44:36PM +0300, Jarkko Nikula wrote:
> No need to clear one struct i2c_client member variable since memset has
> already cleared all of them. Remove also one space intendation from err
> label.

Ehrm, why change this now when you remove the code block in the next
patch anyhow? :)

Also, the indentation thing is very likely intentional. Sadly, I can't
remember why at this moment, but I remember that when I tried to grep
something I understood why some people put a space in front of labels

>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 987c124432c5..051aa3a811a8 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -283,7 +283,6 @@ acpi_i2c_space_handler(u32 function, acpi_physical_ad=
dress command,
>  	memset(&client, 0, sizeof(client));
>  	client.adapter =3D adapter;
>  	client.addr =3D sb->slave_address;
> -	client.flags =3D 0;
> =20
>  	if (sb->access_mode =3D=3D ACPI_I2C_10BIT_MODE)
>  		client.flags |=3D I2C_CLIENT_TEN;
> @@ -361,7 +360,7 @@ acpi_i2c_space_handler(u32 function, acpi_physical_ad=
dress command,
> =20
>  	gsb->status =3D status;
> =20
> - err:
> +err:
>  	ACPI_FREE(ares);
>  	return ret;
>  }
> --=20
> 2.1.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVUk6UAAoJEBQN5MwUoCm2jTUP/25+yr3T6L14+bc+1tvpwo/5
mB66gwqk7vBEzPezOcFhl0TSY5itlbKP4bIw5aplLCCw0+5Gg/rYVfYgXPSxigB7
snxRsE4apbMNRIKjTFEqMCFr09JK9mcENU52ykQ5TlK7FJ7XRRkgKIC+2Qk+o3Qw
psJfCRTSDe0V6BqUfVGgLY5/NT+yBCctbuvl80qmChsQou4uErRBzi4otN7uKG8T
P13eCQrscQajO2RpptUjVgfFKjn09e08jzxSeI1ozEveimqPa/BwryaVdZgjFXDX
GaWmLrSII0xYIEsSJGacBdc4ysCSXifInsyyTaNgCKsUV1AjlXJi7pJp3iFJA4GM
3i7nXor+Bpx1l82OYuzZ8sjOTaASYL5+A4UpvlPGF6xS2kDSovVjSRbXE0sCcIIc
e2k44U1izqDssdDY+nvb7H6Q6BQSUGguZUPGfCysFrU7Z/uMO3yhCiONtuhHADm6
xcnJghLl46ZR9NUfgsxsbfMAQ4QsgJLbtd8xs4j58XC1mONsg9bDoo+3d/1IOT5J
LFtFvrQZn2jeXt9abTYIFNoVlxCU1Q2SgdrJNl6Hj/x8iV/CGdhDSRmUHF69LRX7
rzlxDRUCKEayHoFdVmGtJYS3tOF68yVyG6Re4CTQuO327DTGG2N1IIRxVWSqonjF
pNVnTVEQsqyJD00heY0l
=4n0U
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
