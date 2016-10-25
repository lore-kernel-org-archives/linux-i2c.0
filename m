From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Avoid aborted transfers with fast
 reacting I2C slaves
Date: Tue, 25 Oct 2016 12:10:14 +0200
Message-ID: <20161025101014.GI1597@katana>
References: <20160929130459.11345-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="y96v7rNg6HAoELs5"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49356 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935649AbcJYKKV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 Oct 2016 06:10:21 -0400
Content-Disposition: inline
In-Reply-To: <20160929130459.11345-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jukka Laitinen <jukka.laitinen@intel.com>


--y96v7rNg6HAoELs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 29, 2016 at 04:04:59PM +0300, Jarkko Nikula wrote:
> I2C DesignWare may abort transfer with arbitration lost if I2C slave pulls
> SDA down quickly after falling edge of SCL. Reason for this is unknown but
> after trial and error it was found this can be avoided by enabling non-ze=
ro
> SDA RX hold time for the receiver.
>=20
> By the specification SDA RX hold time extends incoming SDA low to high
> transition by n * ic_clk cycles but only when SCL is high. However it
> seems to help avoid above faulty arbitration lost error.
>=20
> Bits 23:16 in IC_SDA_HOLD register define the SDA RX hold time for the
> receiver. Be conservative and enable 1 ic_clk cycle long hold time in
> case boot firmware hasn't set it up.
>=20
> Reported-by: Jukka Laitinen <jukka.laitinen@intel.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-current, thanks!


--y96v7rNg6HAoELs5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYDy+GAAoJEBQN5MwUoCm2qZwP/1aUyGagQuvwOfJD20DbY9Me
XZS+6woCL7ZQYxzdTCjm+gL4yHUm4rMSpGgJ68R4/1FM7fSoCxS2fmUIyuW11VXT
HBeLMO/bBFDLAr0KveW1fln4iuA97YynvuJnROj7wUAPYldiUuBE2ee2MLCUcJqv
i8zvFR+rm7rSdGQba0mppjAsvoaRN1PGBX1xfYERAgtti95cJWcUNURTCU1LScLF
XWDQXsPZMmbg/ZbPzVtqwE0YUkL4aLH9M/EA7bbv59HTM4t++cWrJJfY9k2DwqtQ
SQXYNd0E7S0IamVHQ24wp/YGJXogq3GygK5yUlnPb/QTxgPXMvhAqrcIcoLYniT+
NokLzP+pZvIe2oFXlTH3rfb7LqD8ka1/Kaxjg9VXX+RUvvBgr9E6590dXfzx/sqV
AY5PAn5zTcRApzdVQAKuPPkP2eSYqb4LTMxJluq6cXC7W4NuI6/12+Ip+LYPbwZJ
3ehHLvs60CbuP5b3Mf/zPcZhqZPM1IbF11NTeEnDxVo/r6AFKLLWn/QZr3Wgw9Xs
MEFY/tkrNsePUm0k6OMOigu9tNNmivuEIBkEp1gNspwq8uvq/Tz8xewxDN3J070r
8B3BZnrAJ4CyMafhGW60GMCDF1MCFMCIyV3rw1MsLnWUOa6ZH3LmSr4Xno16pjDR
aoFPTypoO0HhTgkNh5ca
=3LKH
-----END PGP SIGNATURE-----

--y96v7rNg6HAoELs5--
