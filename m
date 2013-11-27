From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: raw read and write endian fix
Date: Wed, 27 Nov 2013 19:29:02 +0100
Message-ID: <20131127182902.GA16550@katana>
References: <1384971824-7707-1-git-send-email-taras.kondratiuk@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384971824-7707-1-git-send-email-taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Taras Kondratiuk <taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-networking-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2013 at 08:23:44PM +0200, Taras Kondratiuk wrote:
> I2C IP block expect LE data, but CPU may operate in BE mode.
> Need to use endian neutral functions to read/write h/w registers.
> I.e instead of __raw_read[lw] and __raw_write[lw] functions code
> need to use read[lw]_relaxed and write[lw]_relaxed functions.
> If the first simply reads/writes register, the second will byteswap
> it if host operates in BE mode.
>=20
> Changes are trivial sed like replacement of __raw_xxx functions
> with xxx_relaxed variant.
>=20
> Signed-off-by: Taras Kondratiuk <taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-current, thanks!


--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSljnuAAoJEBQN5MwUoCm2qXIP/2HMNusq/Z2UEkxgIdoIkF6N
AkyojhSLI7OfvRFuSvQEsbO+g1HnMy/ok0e38pYjiqTfL9W2znHJhDu5FvYTzlWE
VHsiTqStfpZFgjloIKsP2gqA7BpBZEPkU7Vwsv/wFIqAE6PMmqavpfCCFxZ1HLJx
sFuTtRc41ZzWhx0CAgClN9D0QFl2QasqYWzpAljsQtgwfwtds1xLpYxkeUCJCWBQ
vc7RgHF1SuXLSooYgAme7AXKC5T/+U2k2IN32SoCIFoX2uWqaQS5bACGSLZhCEWs
74o7mq78nzTjoeFSHaaiJxcfdB/fXe8U9jILugbbPJvQUa1Vkkjv78dvxYoYufup
veBO2r6t1QSiM7BHXRBq97YN6DSd9sxjJFOMTGnBGF+xCIEgkDA9vQOpFqHaxweB
1z2QYjKL7PubHqxRP/NtvE2Tv2ZzdeKOgr59wqe9wzGZwhgrwvyjda53cezC+EJM
tQw02BB+0/9MiIdEw/fhuhMCNClXo9Uiz/CRTToOCETvA7Skp1bY0M3bYvSlFkrp
HkJ7B5c4RJRmfnoMjHRKhzZb9qz3t1wT6puiRYTR8sPEav0+kTQrN1yYvwKRUp7n
J3RbCxqhsqd85F1+sFveNPvFS9agqTa5lCP4BwVZTCwU6zxAU3jvhBzHaNw4dI5Q
tK4FdXQ2N66v1SZMMVdu
=z6Gd
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
