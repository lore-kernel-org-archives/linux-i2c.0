From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: rcar: fix resume by always initializing registers
 before transfer
Date: Wed, 19 Apr 2017 08:59:28 +0200
Message-ID: <20170419065928.GC1432@katana>
References: <20170418183835.13836-1-wsa+renesas@sang-engineering.com>
 <87o9vtl19p.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:33628 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932839AbdDSG7a (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 19 Apr 2017 02:59:30 -0400
Content-Disposition: inline
In-Reply-To: <87o9vtl19p.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Morimoto-san,

> I understand about I2C slave / multi-master case of pm_runtime_get/put.
> But in probe case (after rcar_i2c_init() move), we can't do like below ?
> this is more clear code for me.
>=20
> -------------
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 26f2ff2..db7f4d1 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -855,7 +855,6 @@ static int rcar_i2c_probe(struct platform_device *pde=
v)
>  	priv->dma_rx =3D priv->dma_tx =3D ERR_PTR(-EPROBE_DEFER);
> =20
>  	pm_runtime_enable(dev);
> -	pm_runtime_get_sync(dev);
>  	ret =3D rcar_i2c_clock_calculate(priv, &i2c_t);

rcar_i2c_clock_calculate() uses clk_get_rate, so clk must be active.

Regards,

   Wolfram


--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY9wrQAAoJEBQN5MwUoCm2racP/iDKAUXBYWEDRXreRKt3gWJC
L2pZ283ick4TTQGxaDnmW09Ot/E0izh0Lxuo3kelHE9Rt3g16+3rqHDKT+kIESsk
Jhh2gVEmE2TPdpxIyA3WvCewxbQtysvAz6QZPgpNSo0LQlC9pxg4TbptWGY56BRL
U1KFJRiN/rEe5dNzppRQhEcEG0ib+HRZNQJi6li7a3chMUXg2OkTQf52f9G0dEJX
pRrVA6Ok8Yk2l1lXWvufSWyFxAdeSmUGVfL9ArritISpbIebZupYEh3TtTBGd0df
XdHw9UBwIdpIk4StDMuBfbaN4spe+/kCLIkuEijhUiiCnUvcvxDkpUu6JzHZ1+OO
wirySlPtzTX7CSOAkHSDO9gVotV/4+mntzjeqr01cip6O0x6tMdUSTPuWwteKuBQ
VNN/AZxejrqlq8i1W+CyoEviSeJd9OpkqRadgh4mMekJzAxBKWC3u//G1tFsrgBc
W9iEhulHTpEY6YYKsKnLqQBNcdtjadRqhU03viUtlJgR1isoTLB1nHddEwr0y/l8
l4kytKXajUQ9T4EnA19haVkAV3qoh/9pQvKJbNgm2kqQ34z7QHtsHjzhYU7hYKgk
eRdOhxiv/6b9zUd+Ex0Up8jedKelqiyeXXA2cMlXbQpz7ZRiruQpHdKr7LPl4DQk
BHF1e+gSKY52EcHgAwTR
=qcpg
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
