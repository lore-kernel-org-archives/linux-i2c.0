From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v10 4/7] i2c: fsi: Add abort and hardware reset procedures
Date: Fri, 6 Jul 2018 00:06:29 +0200
Message-ID: <20180705220629.rrin3sue6yrcfnnb@tetsubishi>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-5-git-send-email-eajames@linux.vnet.ibm.com>
 <20180626023849.op4rimmsnlv4rgwg@ninjato>
 <3dc50e6b-6985-1920-4f8c-dc7698e2f692@linux.vnet.ibm.com>
 <20180702181511.mv2fuiwjjdhyp43v@ninjato>
 <18b756ef-03d3-8103-3b52-c7bc220d4195@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ihitnwi5j25xyp32"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <18b756ef-03d3-8103-3b52-c7bc220d4195@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se
List-Id: linux-i2c@vger.kernel.org


--ihitnwi5j25xyp32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Eddie,

> Thanks for the details. I have sent up a new series which will only do the
> bus reset if SDA is low. With our current hardware configuration, this

Thanks.

> *should* be sufficient to recover all the possible errors. However, there
> are configurations where it will not be enough, in which case getting the
> data line stuck high or clock line stuck either high or low can occur,
> necessitating the full reset. But since I can't demonstrate those at the
> moment, I can't argue to include that now :)

For the record, I am *really* interested in these cases. Just from
reading the above I wonder how SDA can stuck high when being open drain,
and how you will create 9 SCL pulses if SCL is stuck low. But if we have
a test case, we will figure out something together.

Thanks,

   Wolfram


--ihitnwi5j25xyp32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAls+lmQACgkQFA3kzBSg
KbYs/w/9HBeG6njVI/OjBZtkDIX6SEDllwnlNp0TLiL2ANynxNwZAW4kk/hk7cuc
VdRro4JWVdqvsUQnh4peP1TpHGcSQgHKaqjBVSdHUd/iBMsbSiuspxboyS9jhNwM
VauHrH0V6R5bHRtbWm6RMufgl9iI8czxjN7lE7ciJwrA7O/pLobStubqmMHSPAzK
275trVZrZYBrJX8fMzwG5aBhjsjdTV9dzXhYtHX0yg64hQVn/o8YkhDuJb1Z+yEY
g9xEIa5YtJkVijCxUAzhtCrRlk0OeO8O9XL2/jJ95Ve0fuCyX8MuWPSeR40WCAT2
PMWKtA2OVhkYmYmyzzRJZMTCrGw08f19iZe5fmu9DIsAkAG/7oSPFti9OoHtCzh3
3YV7aA+7/ZPwiXGtj+Y0Oi+RzonXk5t6/d2blJ5s6q/2sNZVsKZedETN0YjJ38yD
Mse7+ZqIfFZjkOEKuvAYb5hyByhL9KsBQ+X5sDPxJCqNuxBx64jmyjK+Q4WCr6yZ
X+hNBJPNuVD2A+ydf1mxfQyZ5FJbU3Sva4Y/bK7GjSOmmy242NQA7+CcQuqQ1+2o
7H/5mIVuw3kE7xDveYCWKwrtIK1ri9huV/j5eOVRgBiHoYiT3T+s8XWHICrl4Fz4
U59GbGVBDWikCueX9svFVhbVZTuxvCzB5TnfS59CuKGuD6fx2n0=
=VwEB
-----END PGP SIGNATURE-----

--ihitnwi5j25xyp32--
