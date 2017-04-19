From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5 5/8] i2c: i2c-cbus-gpio: Add vendor prefix to retu
 node in example
Date: Wed, 19 Apr 2017 20:51:13 +0200
Message-ID: <20170419185113.msqhjm7fzqfeyjlk@ninjato>
References: <20170412172800.23035-1-javier@osg.samsung.com>
 <20170412172800.23035-6-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="prxj5jwemwr6lx47"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170412172800.23035-6-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--prxj5jwemwr6lx47
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2017 at 02:27:56PM -0300, Javier Martinez Canillas wrote:
> The example contains a device node for a retu device, but
> its compatible string doesn't have a vendor prefix.
>=20
> While being there, drop the -mfd suffix since isn't correct.
>=20
> Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Acked-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Wouldn't it be nice if we fix the driver also so it actually matches the
below compatible? I can't find such a change in linux-next.

> ---
>=20
> Changes in v5:
> - Add Rob Herring's Acked-by tag.
> - Add Aaro Koskinen's Acked-by tag.
> - Add Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>'s Acked-by tag.
>=20
> Changes in v4:
> - Avoid using MFD in Device Tree (Lee Jones).
>=20
> Changes in v3: None
> Changes in v2: None
>=20
>  Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt b/Do=
cumentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt
> index 8ce9cd2855b5..c143948b2a37 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt
> @@ -20,8 +20,8 @@ i2c@0 {
>  	#address-cells =3D <1>;
>  	#size-cells =3D <0>;
> =20
> -	retu-mfd: retu@1 {
> -		compatible =3D "retu-mfd";
> +	retu: retu@1 {
> +		compatible =3D "nokia,retu";
>  		reg =3D <0x1>;
>  	};
>  };
> --=20
> 2.9.3
>=20

--prxj5jwemwr6lx47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlj3saEACgkQFA3kzBSg
KbYNGA//RwtJGgzBnbUrB39nyzd2DuWPVHlX70cf4uudzSH3UHM/Sbl5EXrqwyKA
eqpJNaInqAClZyabwIVawUq6CS5W8M29CO1jZ0Iaxfppe+QepOJnq90AbGYHDNVj
MAgiWs3jbbmoj0eI6v3C7nrP8qctKQJLBnW2uSBc9HWKAkvFVyBvfg3BL2wDsx+/
dJwbHaOaieDsBZSiduSs2KO6u0QwdduU4vPoUBy/xlJcrqYXrjfXX9i7I13JDKgI
fMAdUs+FW/CS0wE5lwmT9a4b3Tb6Z4CpDE5qJwuiS4E+ZBV8EwgxrlOHV1Q+EctE
+fHZ+KurFiT0YmHsCuDvR8nudpp9BMT5SU/JCZxbE2es96VWHDpMDIyiDZrdGybd
ZzTcdYkWCqKugtYu7Kp2Tkb0Gw8gjjTmosj6PTh/66vra6YMrt1nx7kZM5igPmMG
3jrypr+Ur6EZRZ9/fgYCyvFBsP4zVqXLQhsinFg0MVk3c9XIkPfNr28ZYopv76qM
GYORhrcI1LNPBV6odgZvcC0HfS2nIb5DO5YoQK1cC2ZoTNEWpe5tZc6aYHbXUidg
UvloTbijfZDAAjxTq/9AtwQ8H66hQXjFHUVIxQA6rmQF9gNwLzU6A1JXnaJ20Cap
7nkKFSPwpcofVth/zlVFjjqVpBWKsi7pIM6/EGAyhXkFLGAKaww=
=SpES
-----END PGP SIGNATURE-----

--prxj5jwemwr6lx47--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
