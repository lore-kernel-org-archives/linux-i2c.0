From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH-v3 04/11] i2c: pxa: Remove compile warnning in 64bit mode
Date: Fri, 10 Jul 2015 10:13:27 +0200
Message-ID: <20150710081327.GC1528@katana>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436210695-19159-5-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436210695-19159-5-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Yipeng Yao <ypyao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2015 at 12:54:48AM +0530, Vaibhav Hiremath wrote:
> From: Yipeng Yao <ypyao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>=20
> Fix below warning message, coming from 64 bit toolchain.
>=20
> drivers/i2c/busses/i2c-pxa.c:1237:15: warning: cast from pointer to integ=
er of different size [-Wpointer-to-int-cast]
>=20
> Signed-off-by: Yipeng Yao <ypyao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> [vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org: Updated Changelog]
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Acked-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>

Huh? Why long? Shouldn't that be casted to enum pxa_i2c_types?

> ---
>  drivers/i2c/busses/i2c-pxa.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index 632008f..4c92694 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1116,7 +1116,9 @@ static int i2c_pxa_probe_dt(struct platform_device =
*pdev, struct pxa_i2c *i2c,
>  		i2c->use_pio =3D 1;
>  	if (of_get_property(np, "mrvl,i2c-fast-mode", NULL))
>  		i2c->fast_mode =3D 1;
> -	*i2c_types =3D (u32)(of_id->data);
> +
> +	*i2c_types =3D (long)(of_id->data);
> +
>  	return 0;
>  }
> =20
> --=20
> 1.9.1
>=20

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVn36nAAoJEBQN5MwUoCm21WoP/2Upjzg15IDKoQRxYrTi0dR6
kpapa6etreKm4LRddsDE0+9tgbERUJlgszRjxXR/90hsUcvFrkuDb9jZhIJMNXS0
58r6Kjf+Jdv1RkskwB3p+wC+CKr7vFd+n0RfaPrheqVlUYVWXgyXtHGR6/lhZkHo
WJPnlkM1MgV29kVULY/BgHtWWP3Vjd8MEyxN+1H0qqHJB0vX5NiOVpt2+2cFErfy
BSOJpEA/cPJQrqUIMxQHkosl2qLgFm3bjfwqr7DDq5E01QLwZb4W3aW85OlRnHpZ
muFT7x4ajDYLQZNHkAzc7IKFitrg6LKDNWGyNRTgpfqxlY0MQq0jAu9nJHmZm/FI
ROeTFHkaSWx1/rtzll4kFbCx9n6VdT8UPWyFUm4lQZ3n2swzdRzpdEqIjnIeUGeP
bhgJ+t75K3qmLPPd4Kk1urKoAYn3lw69tLG6sDTlnl6LZvxiBysms4j/tyh/aIDm
zMT74mnUfIR1dpbLWdFkxEWglTcsoPBDayj5heRcbIsuaz3irAPN/pfugcsANsSA
fIOPjxapin6fkUTH6HqjOHE8kqClYHqHGJPefsh6hWJthtqkFU+Ov7tcDE3x6i8T
x0c+DUnVCQYd+FQZuw4ASnDvW88sZWaMIs2OrWkmQbyK/D4vk2te0f8p1GiuiYfK
ajOnckgzl47LmUxguY4y
=Bbo9
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
