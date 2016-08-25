From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: sh_mobile: use proper device with
 dma_mapping_error
Date: Thu, 25 Aug 2016 18:50:10 +0200
Message-ID: <20160825165010.GK2856@katana>
References: <20160824091929.2082-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="opg8F0UgoHELSI+9"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46195 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759948AbcHYQuN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 25 Aug 2016 12:50:13 -0400
Content-Disposition: inline
In-Reply-To: <20160824091929.2082-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>


--opg8F0UgoHELSI+9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2016 at 11:19:28AM +0200, Wolfram Sang wrote:
> We must use the same device we used for mapping.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-current, thanks!


--opg8F0UgoHELSI+9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvyHCAAoJEBQN5MwUoCm252MP/3q0CT5M/vHonZ0qpqb/qCq5
eo9Al6J1KmybnyC0Xau3Vr3HztY/0MhpJN+pAtxvTjglQ8pKxTQT9AjEhJayBwLl
Gk/065Ix+JHpmdEusfzBntceF4xx2wad9u5YpgnWh87YrUrz/h1w4/FhjMqa5ZPY
zjkcsQIIM7zB/1FuAmGFMwe8aAGSHGj9MCwkm7tPGBEsFvGlEdJzxzDbiCwXm3LT
pfm6I984loxBj3FiHR+8vG1N+6K6gRchqRxlTkK3llD1T+vNdQLH5PKLSxA/PPJy
cXZbtS03CqQS3GtyR7caJ3txWpsW2uOyFQrVuOCMpL+yy5cvvpwlQg0UJIQvxWfm
CKWjY7gvHUjSr+qW8XYD2k0/FeoJy3bWkymhw92mTKcIExRaz3b1gdyGhgal+KPO
qcjp4bpXWQHJWMOog8yTTAM+XanLfQxP7KKGdM328YcLzGA22UKnCpW25167j3oW
7znyZ5vJDLTjb6HhnNG44xtB4U9Nc10bZoisQS++e8MlwKwb2yKF8unhR+8m25a3
iSMmqGI5Wea9CnLFaAhJINCpb/+/xINe4Mdmtak8fqyxWz0uMbBV7TZxCXsAvizh
1gOgiatt/fI0Il/jiZyQvWeaqqJNCB423zadluN2DO0PUk/cuYMEbaRFKYRUoo8s
N+zhEInIHdyLYmIJooLc
=Ce4l
-----END PGP SIGNATURE-----

--opg8F0UgoHELSI+9--
