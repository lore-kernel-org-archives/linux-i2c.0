From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 6/8] i2c: mux: inform the i2c mux core about how it is
 used
Date: Thu, 25 Aug 2016 18:24:32 +0200
Message-ID: <20160825162432.GF2856@katana>
References: <1471268431-5148-1-git-send-email-peda@axentia.se>
 <1471268431-5148-7-git-send-email-peda@axentia.se>
 <20160825161900.GD2856@katana>
 <856c696f-b0c4-63f0-ee50-1b96556cf6e0@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xaMk4Io5JJdpkLEb"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46046 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759384AbcHYQYm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 25 Aug 2016 12:24:42 -0400
Content-Disposition: inline
In-Reply-To: <856c696f-b0c4-63f0-ee50-1b96556cf6e0@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>


--xaMk4Io5JJdpkLEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2016 at 06:22:37PM +0200, Peter Rosin wrote:
> On 2016-08-25 18:19, Wolfram Sang wrote:
> >=20
> >> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i=
2c-mux-pca9541.c
> >> index 3cb8af635db5..f052c3067791 100644
> >> --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
> >> +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
> >> @@ -349,7 +349,8 @@ static int pca9541_probe(struct i2c_client *client,
> >>  	force =3D 0;
> >>  	if (pdata)
> >>  		force =3D pdata->modes[0].adap_id;
> >> -	muxc =3D i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data), 0,
> >> +	muxc =3D i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
> >> +			     I2C_MUX_ARBITRATOR,
> >=20
> > Does it make sense to rename the file to i2c-arb-* somewhen then? Just
> > asking, I'll apply the patch anyhow.
>=20
> There should be a clean branch with /only/ this series that both i2c and
> iio can share, to prevent merge problems. I said I'd make such a branch
> in the i2c-mux repo, but you are of course also welcome to provide that
> branch if you prefer...

No, this is fine. Send me a pull request and I'll merge.


--xaMk4Io5JJdpkLEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvxvAAAoJEBQN5MwUoCm2ArkP/2Ig5S+s033HTKoSiyitsWqL
s+zAx6kkqYHongJp9oBdi+Lxa1LeZTtmbv+hpT2rAYvYZECE4V0QeVcJ3Uv3EQez
9DSkbBW5tndK1lgjCNb+/11vFp7EHs/d5dP/7cxVFyAgntzkHEqe5Xv2+Hj6QCO4
0WRAkkJLJPLo04WztyaR8eO1L3FcLntHIubfny9hXSO2j4hC4l2Z6SdjJFyBZsWR
EaJrMgR+dAGrS5SeyMq2dTdp29JUjJvyDCf3TXQcy4wFGW2zTR5M9CGOJMOcYFHy
OOp4IGvsYNXTNOsEw67O4Pf5jMNm3d6OrxInQEiyVRqrMsGTnRiciOAN9LiZDfEY
DZHWVQQDzNOtzXdSWfBGLXJNVIGCoRwPAK4dK1oXL9Gyw+0ISIoRh6+mbuecsyZY
EKyREPixzHb0OUB8+pyoVW01wr/EBstQMENRuYWjYPfnuulfT22768tYppSsb/H4
MKDjz5nPGaNy0zM3QRIwSFKUmdtyL6+JTdF29PORymBvHG3jFlT0qpZjPViShb9V
Ta+k+vxMdHMYueoGKy2P9o8rujwSBeJu7LJShYMZ3GB9a8m3AO/ip7VTXcAwbvb/
kQAVx55t5V7hAWE99iUXpYoJ38yvg6JLnO2x/TTAjLyKHmWLrlJLkY7PH5insGhR
eGyex/1Ad+b+XkYySP8o
=JTYB
-----END PGP SIGNATURE-----

--xaMk4Io5JJdpkLEb--
