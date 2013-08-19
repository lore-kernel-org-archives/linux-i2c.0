From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: imx: Fix incorrect placement of __initdata
Date: Mon, 19 Aug 2013 19:52:13 +0200
Message-ID: <20130819175213.GB8626@katana>
References: <1375870703-16878-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1375870703-16878-1-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2013 at 03:48:23PM +0530, Sachin Kamat wrote:
> __initdata should be placed between the variable name and equal
> sign for the variable to be placed in the intended section.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

imx driver has changed in next and this patch is not needed anymore.


--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSEltMAAoJEBQN5MwUoCm2WJkP/2eaXffxYQKU+pt681dmd3Pl
7Pkn9z3eU9gC+M6x5GItoCrXGf9U+wqVxlGcsjoH+x37ULADRNyBpCaCUI8Lb82a
+edX5u8J+WMSKmuM4Lh65k54vXSzOLwLtoSzoaVmfoxlT9GeK/6le/UsvF7vamZD
X8qTgmAjNw1zI8zzeZEm9bQwftqqdhtyRh6NDhzXbYwEFhP/b85pwGncZTcSErSN
ZsRvh40looBIyEyI+Y+KwSBVr6rYIqZaxIoTRwaTy+uUHiIBGyKxxdpIp+vRDkY7
j2/yNXSKhtPro1tV9nDqxcbeagFQsd2QYsz6UVpYAwdFO+HYFpzJeGv443SvILn2
Fq4RSLf6G0POkPQZLHgmhPxc+CEqEyVQjrGxSL02jwgaM8PnZwdRtgkabC0XEZqs
NSsDTTTTfTCGyMbPW4O6kVRmtZRNqTVeKz5zKdUDaUYQNjK1lzD7P6caPHbAFfd5
U0Zk1vw06gmBhSISLBH8//oh93LUBD/ZuHw9NLB7wNT34FQTm8zfIGd3VqVtZjr1
LWnnMqny0QvTld18bBWzrq9Yh8MLxSW+lFqWUZjQcKWhCClIDn+Up6cotO0JHpLB
8wIHVRX0wNpax7ziq1TFp+bTgjHHn9bNtGCY7SNbv9lKuLmS4GzUzoHL1J2XsTQZ
bh+oiT1smKHgbhgjHSMr
=F6h4
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
