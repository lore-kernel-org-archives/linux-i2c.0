From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v8 2/4] i2c: add support for Diolan DLN-2 USB-I2C adapter
Date: Thu, 16 Oct 2014 08:58:52 +0200
Message-ID: <20141016065852.GB1949@katana>
References: <1413384491-23703-1-git-send-email-octavian.purdila@intel.com>
 <1413384491-23703-3-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1413384491-23703-3-git-send-email-octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2014 at 05:48:09PM +0300, Octavian Purdila wrote:
> From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>=20
> This patch adds support for the Diolan DLN-2 I2C master module. Due
> to hardware limitations it does not support SMBUS quick commands.
>=20
> Information about the USB protocol interface can be found in the
> Programmer's Reference Manual [1], see section 6.2.2 for the I2C
> master module commands and responses.
>=20
> [1] https://www.diolan.com/downloads/dln-api-manual.pdf
>=20
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

For the I2C part:

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

I assume this goes together with the other patches. If I should pick it,
let me know.


--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUP2ysAAoJEBQN5MwUoCm2EL4P/2nEGEcmbkZOlRj3E9HRcOnV
k07zI8+Cr2fa4bMTM6vZkSJkG+iC3kwmwGszU0hdeMw0ysoBlp5IIkIFNHVln6A+
oNmTmhXnYbjzJvGyiWYarKS3wQ/r8DdT0FheQttTStN1qJhK4a32ID6/vJwFjbmU
fNHYdn+O3ReWxM6yKFdYoXdNWLjOcphndF7zJ4FYyFCz6di5CaY5FZ8UfFhQenoG
VPGsFqcyJjL4I+OjWPCqJW1dqimmYN/IYOj7pC8T/dZ3JASw2UG/fMg6ba0H2CQo
Cv/C0ilRmrTkTHF7pG7FE9r3MrnpulbIl2MlLwTBEd6bDJSMnGS/uBNFgVKOv9+6
CPsrvWvYcx34hckHsNZ1T+bHhYNqwrk7p/W84yzUNtb8EA/cd44aTbHA4Q1lJoPd
xwmoCVeLZX3wBJUas0leDyC99Y+3MOke8iyUxUPWYbddTCagDKGrtnupEv0oyeZM
6OHr4Lml+Ghvbn9yWzR7za8HyYzA2L8qdYofsSzJNosy6EkZMYV1F+cXMTlfUi6G
DgM1iwmazG10apxePJ6rbQDQE2ylOt6/Yq5tZpCsSSY4i+mF31ixBhbFH4VMofOT
7yIJQJOMG2VRfGo3/5GoqqOjTO8y+hpzkO2EFJ2an3az4E29oUaJmIGvuNdMsnM2
AW8ErWBNurh/f4LGQiE3
=SNVk
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
