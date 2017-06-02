From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH 1/2] i2c: sh_mobile: remove platform_data
Date: Fri, 2 Jun 2017 22:53:16 +0200
Message-ID: <20170602205316.jlnjp442jcn3s3d3@ninjato>
References: <20170518211140.12023-1-wsa+renesas@sang-engineering.com>
 <20170518211140.12023-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kmxeewhzrtjxihet"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:43855 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbdFBUxS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 2 Jun 2017 16:53:18 -0400
Content-Disposition: inline
In-Reply-To: <20170518211140.12023-2-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--kmxeewhzrtjxihet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2017 at 11:11:39PM +0200, Wolfram Sang wrote:
> No platform currently upstream makes use of this platform_data anymore.
> The ones that did are converted to DT meanwhile. So, remove it. The old
> platforms likely don't have the 'clks_per_cnt' feature, otherwise it
> would have been implemented by now. And in the unlikely case they need
> to setup a different bus speed, we should rather go for a generic i2c
> platform data just for that.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--kmxeewhzrtjxihet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkx0DwACgkQFA3kzBSg
KbYPuBAAlyw0Bkd2iN7MPxg8xty5G9oSzD26GbfuUU1MV+Kt9Cn9cw/aAqZg9kem
uWsguTU/3J9ASJM9lRIIOwFuc1q7Dv9HNubpVJbbW3NfZoc/XIU43jQN8HL4A4GB
mTGgymwvEulhQOtqWfGZmu9SzaTqfZnpm760Qimgyxjm6xkjo2OuZN5Zv2hB7f++
Zr9AYDwakgpoG7l3Q3F38jcGTRstvm0naYGr1SVppKJUD2mE+bSbi7u4rU3Y0rwa
+QC24gAYEjS/n2iz4VdjOiLLYOMDOV98PQ/pnh50noitpZexaEHHiEj+hTNv7X1g
zBTialCR+GMvXAGc8AhVeI8kPwZL7kLLbTez/xX1AHX11v/5FzeJqRYypq6FN31K
e+RWo+DZMDmupbOQSgzOG7t90sb+v1v/BKBLEoNJciLTlJLmME3bfY6epjYf+9sj
YAVLkm5Q6QnyGP6QScVHNyAqLD95xuFF4z9z9TXf229cZ4JHfunkiAcDq4cGeVh2
fRfHQ2YPyCy4WLSC6Vs1uzr3lNfmc2Qij6bka0jYRTSFtyN6RLYAtTo9hEFTtLn3
gDdmCuHC+P5+WMzEIxXRElHyXAjtk69BbVeTYdVR0GlXADk3MEhIAJDinbjIy14Q
T/w2/jKsviBs4Uedsm12U/m9zP/JIMtOFZB8vehCW7LFfSHnoBw=
=0mXr
-----END PGP SIGNATURE-----

--kmxeewhzrtjxihet--
