From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: core: don't try to OF populate DDC i2c buses
Date: Sun, 11 Dec 2016 23:16:22 +0100
Message-ID: <20161211221622.GJ2552@katana>
References: <20161130115005.11508-1-l.stach@pengutronix.de>
 <d31d7cd0-4b00-4db0-2a51-cf3e553e6df8@mleia.com>
 <1480514806.2258.68.camel@pengutronix.de>
 <f259bd4b-788c-0bc2-25b8-7e0a735af859@mleia.com>
 <1480586832.17003.28.camel@pengutronix.de>
 <f50333f5-906b-fe9a-3e5b-e74522472d06@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JsihDCElWRmQcbOr"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:36108 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753872AbcLKWQZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 11 Dec 2016 17:16:25 -0500
Content-Disposition: inline
In-Reply-To: <f50333f5-906b-fe9a-3e5b-e74522472d06@mleia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, linux-i2c@vger.kernel.org, kernel@pengutronix.de, patchwork-lst@pengutronix.de


--JsihDCElWRmQcbOr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Lucas,

> Shallow review of DTS files and dpaux drivers let me say that the change
> below has no regressions (the change is untested):
>=20
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_hel=
per.c
> index 3e6fe82..f91ade1 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -1020,7 +1020,6 @@ int drm_dp_aux_register(struct drm_dp_aux *aux)
>  	aux->ddc.class =3D I2C_CLASS_DDC;
>  	aux->ddc.owner =3D THIS_MODULE;
>  	aux->ddc.dev.parent =3D aux->dev;
> -	aux->ddc.dev.of_node =3D aux->dev->of_node;
> =20
>  	strlcpy(aux->ddc.name, aux->name ? aux->name : dev_name(aux->dev),
>  		sizeof(aux->ddc.name));

Is this an acceptable approach? It makes sense to me from an I2C PoV.

I have to say that I second Vladimir's arguments. There shouldn't be any
other I2C devices on DDC, but surely there is somebody somewhere hacking
this bus to do something.

Regards,

   Wolfram


--JsihDCElWRmQcbOr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYTdA2AAoJEBQN5MwUoCm2AXoP/2lBFRTj+exoqkYVIOZi11my
19KWbEggAkypFinQp4t3WyMbgSwblluVCjRafZ6Z3+uVUaOW2V/YkALOdPsKZ5mh
7IWDyarKyCFfy6NGUPR/r8GutjG13np/mPQortagWg2HlfG0ytf6qvcnHKztdOHm
DpDud3VpI2DBS5VkiNDLoEbEJVRecUwVeUHOHLSt9UaBdyMCcdK4M6mjJaAVtX3S
/2E+p75UM0XP51fQl5LA15lEcBE4hA4N9rBQS/eibr7f4uGIrhgdWB3KiqERdfC3
JGPMaKAcf0faE6XahvtL2Lm4U39DBa2807M4HqjTqCtwZHAfVU3qd3/x6n9wYdFP
MSnmDi/c17gnUP1wxtoomZqa7Own81W+UPswE2K9ScARh6Mr+Hu7D7u0+Ew4gDwX
+0zxuHW3MmsyoZwZt9ilqj+z3A7ICCRanJ+w2QcN44X0RpgYaKuYCO8WULtwHKSZ
wmU3xs75KIeAWqQ6oJD+PyIWkvURcDAXcDLI5dY7/j5kBZv7ahhxukKnTBKCLU7w
ETw0RPflJhCqnakEgLQuoTDYmksgC6Aa43lc9TkqobOLQCIbK68qPRDspxCV58ic
szlzbRFT5UxZgi3zGT7BGE9VwLapzi5ESxe0RbeKMuPCGfANVcvg5XKW0rkUL9Al
8EKyn34n00H7S87uM5zp
=pRgv
-----END PGP SIGNATURE-----

--JsihDCElWRmQcbOr--
