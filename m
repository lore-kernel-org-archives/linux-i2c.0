From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c:at91: Add device tree property to set
 clock-frequency
Date: Wed, 12 Mar 2014 08:26:47 +0100
Message-ID: <20140312072647.GC2756@katana>
References: <1394511938-28653-1-git-send-email-mark.roszko@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394511938-28653-1-git-send-email-mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2014 at 12:25:38AM -0400, Marek Roszko wrote:
> This adds the ability to set "clock-frequency" in the device tree for the=
 at91
> i2cbus following the naming of other i2c bus implementations. If the prop=
erty
> is not set,the clock frequency will default to the previously used define=
=20
> of 100KHz.
>=20
> Signed-off-by: Marek Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks!


--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTIAw3AAoJEBQN5MwUoCm2N2AP/3ZgatLsrfba0jxBcDji+rHU
mk9hF/I/rWHHbxYIhljR9Pv/ZqrLeW1TRZPwRVxbcbMuMMVuVSJ7D0UDd/Ciplfj
UMMs/VnQMiSFUghfvOPYaKRqzL/uCDVm0UEEG860xfuOmWjLoPhlyZQNh2xmRcJO
TEA5EeWx9g1p3P2NWz3blPyQ9gV0KLCSo9ZY+2c2DunjP2ktFixQI2zEprflsbU1
Vv+1d9WcBMRkenlR0eGmLxgwEsrVW/MSYGayjq81pxvWcQ8c20OkMxmTrXeu/iFz
lOK1q2adGnuBCD/8gyEMVaClv+bMQoi2I8YFnKROpuwmeS7jvAcGMdKHwR6uflHd
0PZiFgFd3d7iVCAGRKnehdqziPzLq8iPUUQabMZYDiQNgaVqs9vW7e+ofe6p2puM
VUZSB7C2ILcp7RiS87vLmbJTPmHVCQHJa/X40S6lfP2hEaq6NFrUQCLIfVMPYH6y
X5IY/RG0gQ6eFSlyfJBH4GvJAcOL4REM4wGRswc9Fp6yM3wTrHdorsaXSDffsdtV
HAWnL09yhKl9cKEs/g5YcjHwNI93Zucjer2NPdgnErf6n/KfVuhknmbbj3nB9DhD
f0JTkRJXysCgatSJfvPISwsAWLcLL/A9SBkUv+ZE4goz2Hje+OdPG22Ldj/iy058
Tz0SPaNIg20MrmW8wUsi
=Asij
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--
