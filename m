From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 00/14] ARM: dts: r8a779x: use demuxer for I2C
Date: Wed, 9 Nov 2016 18:28:14 +0100
Message-ID: <20161109172813.GA1545@katana>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
 <20161109084406.GA22213@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161109084406.GA22213@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> ARM: dts: lager: use demuxer for IIC3/I2C3

I think the sanest solution is to drop this patch forever. The WARN from
the regulator core is sparse in describing the problem yet it is
correct: The regulator is needed, by the CPU! :) And this will probably
be the smallest problem when trying to demux the bus which is used to
handle all DVFS operations. Let's stick to IIC3 here, I'd say. Gen3 even
has this one IIC instance for exactly the DVFS purpose.


--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYI1ytAAoJEBQN5MwUoCm2DaIQAK45sK2sbRCWpJnSJXTXkiv8
TVKsR/cKQ2H+AmS2qKybtN8lrvDlt19Z+H9iK+EjZFKF7rXWrxRGJhJWEzYy5+xV
bGmBksZSPtBsjjV+i6VLODHIvNFzgVIqJ8OQgVwBwDC4r6/PuoCis0gPEf8EKTwA
N08xWkKaZbuBzGon7/S09pEngNhQZHmoXyjB7ApYd1ReX6ZU04bA2ReQ2JWBw2ql
ni6PvJDP81m4/BDiXIht7PyHX0q/LxDpLy4KoD0sNT62i0WAn4iWsUTnDemfLT14
8uUYuYis7Z/tS2gb8/5hI3qDcdTh3paPj7hEb+E9Yopzc2hvTFE+5N1nEiBHimw8
bfOe+yfF3K03GRzzHMGwsnlKIer8/qxsLbA9xJ5sqhQodzG/uid5LDl8W7Dzq5kQ
OMs0vJc9+bEnQsg6RBec7AlvSAvmR8DmKRd8zVo12M+dwJXIuQz/q6U/huISjsfX
yapDGsqigMKe7ri71IId+QcWvlbYH+H0N+4C/3Y7kZjHMwP0oD/Ml/E/kEHnlKrd
ttAmP3X+6ZcVUDjeN/ZjwNIGZjvKW5g8Y+v7QSEMsE7gwa9UzxAmjIagmnBbtP+1
t4gUMzj0N2r1Ft1kKOGKbMOeH9aHump7Hc7JFvVfCxH+yngSO3hMzyORqDOzOJio
v0JAZt5ozH84Amf5zr2A
=Mt8Y
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
