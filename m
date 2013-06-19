From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c-mv64xxx: Abort the mv64xxx_of_config if
 clock-frequency is not provided
Date: Wed, 19 Jun 2013 12:19:40 +0200
Message-ID: <20130619101939.GG2950@katana>
References: <1371570024-11613-1-git-send-email-gregory.clement@free-electrons.com>
 <1371570024-11613-3-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371570024-11613-3-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2013 at 05:40:24PM +0200, Gregory CLEMENT wrote:
> From: Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
>=20
> This commit adds checking whether clock-frequency property acquisition
> has succeeded. Do not waste time to find baud factors if there is no
> information about the desired bus frequency in dts.
>=20
> [gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org: Reword the commit log]
>=20
> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Signed-off-by: Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>

What about setting it to 100kHz when not defined (and marking the
property optional in the docs)? That's convenient and common I'd say.

> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv=
64xxx.c
> index 74f8fcb..de384a1 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -591,7 +591,11 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
>  		goto out;
>  	}
>  	tclk =3D clk_get_rate(drv_data->clk);
> -	of_property_read_u32(np, "clock-frequency", &bus_freq);
> +
> +	rc =3D of_property_read_u32(np, "clock-frequency", &bus_freq);
> +	if (rc)
> +		goto out;
> +
>  	if (!mv64xxx_find_baud_factors(bus_freq, tclk,
>  				       &drv_data->freq_n, &drv_data->freq_m)) {
>  		rc =3D -EINVAL;
> --=20
> 1.8.1.2
>=20

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwYW7AAoJEBQN5MwUoCm2HM8QAKZb4j+8gZgB+pg6xsWvZJjd
zPwLDTlUzHndG5aw8lHuN8HvTAOKYOQ8se+I/cqIK5535TPQUm/TKN5QavmZtMM/
TmN1w0pjgjNVxpSr29wyMiBmpwu0coDhK7uiuo9DM5UWL5u4LE5dC8T9aq9ytveo
7uDQljrg4hK1Z2xXOpo2Bo2a0hJbyBNLY8Z3DuuXk+pLbBY1Qx4HvMEiLrmH0JpI
03Zzi5y3nBerzi8T92M9G9HuhnYgZDAPavYsP1twreR7p1cMGf5DUnOtaDzjA/Oc
DtvbM2HHJKfzS/ZY6kk9NA+UqpShjS1jGgIHrEKZK1MsVRAetS6hMBWZvMq7BRzu
/AXKfLUITG5g1uTKxv+JM3wR6nbQZEs2FkvMte4s1vSFXkt2g3YEmQEyeVGeKnZG
y6tNK75puUBsx+SzED+yQfRd+ARkgMSwICb9hPLFEke9F1RrqIkXLposxzcM3eHK
IY80iSwq62GZnVwggb9ltS0EarMSRc7vbMlPo8KGVFZwO8nxEybzoRf+7NfnbimR
alwFmIy6hh/eN2jxN9350LN8IZsWnC+p+KPGTYhJCwHODzZNuascWpDZHAXsyyx8
STCOFMbgEVyFwRltthIgFNkeEf2L2tSto96XR/M25B+2G/nFE1obgH0NDFQg647R
zHuvxxdAatHm+hJXLFDa
=2ATG
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--
