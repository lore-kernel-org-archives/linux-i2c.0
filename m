From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Introducing a kernel driver for the DS28E17 Onewire to I2C
 master bridge; Feature request: introduce I2C_FUNC_STOP
Date: Fri, 15 Jul 2016 20:26:00 +0900
Message-ID: <20160715112559.GA1695@tetsubishi>
References: <578612EB.1060709@gmx.de>
 <20160714095812.GA1563@tetsubishi>
 <57878B55.1030200@gmx.de>
 <20160714131921.GE4149@tetsubishi>
 <5788C54C.20705@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37811 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932483AbcGOL0L (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 15 Jul 2016 07:26:11 -0400
Content-Disposition: inline
In-Reply-To: <5788C54C.20705@gmx.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Kandziora <jjj@gmx.de>
Cc: linux-i2c@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> So, please discard my request for I2C_FUNC_STOP. It's not needed.

Great! Thanks for looking into it again.

> BUT, the DS28E17 can only do this for writes. Not for reads. Does it
> make sense to expose that feature and announce it as I2C_FUNC_NOSTART
> then?

I would say no, since it is not generic.

You should also populate an i2c_adapter_quirks structure and limit reads
to 256 (and maybe other stuff), if not done already.


--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXiMhHAAoJEBQN5MwUoCm2vLoP/1Jaqf5QtefwOGtaJiRJumrB
0l4wJeM7am1W7F7uP7sB1Djeyw5x0YgwMUcVTsNyLAZBb1tgAVIf6471XnEkaYpr
IURkUwxN43zAPbnT91R8qLcp9a5RgkQZC94VGvIiGJQR/+JtbQ+aqS+7poPHCjBN
kpyXqa2im7HpdH4lIjdrHmpMu97L0fqAv69Ywslop5ZCR40tDTdDbzRVjQFpIWwA
8OYYn97IlCpHhwANbzcaFQtVG9YTqR1AN2bwwCwazCo0tRzziLcPZDPGp9F7elAd
3iw2W+XisItaWdVqpBVy2AiYWUB2ny9yq0bPssTCV9S+CCU0gZnUxdnmpf8SW/hl
/8FLrnqpEMDrTYs4gTSEOkWkuVDfHOd0dACBV5rUF17BuFNugvTLo8CauBEhMCqr
RqajYK+u+Sf5dteiHk19C1z+DyE5MUy8wjHRUV83nHKTX2XovVuoDn0l0Db1trOI
OjEZRs02Hp3bXwUK7G2pqa7Z6wssFJgQlS4WrbwPv8jR1S/hlmkR7BI37NLdwapJ
VvWjprPRBV/6wnO1/hJF0BWpk5JkJJ6QWeNUEbg7flRgCfWFuO7hdQaCtVFoLewh
Dgv3peSnZCsGVJUVEBm+hTg1nodFzAE4US6+KTq7rDm70eZ7+rM9Xls4/mGDRuF3
bbWC0+r+5i5et2BgB7Dt
=kYiV
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
