From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] Documentation: i2c: Use PM ops instead of legacy
 suspend/resume
Date: Thu, 4 Dec 2014 19:09:26 +0100
Message-ID: <20141204180926.GC7944@katana>
References: <1417366352-22356-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417366352-22356-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2014 at 05:52:31PM +0100, Lars-Peter Clausen wrote:
> New drivers should use PM ops instead of the legacy suspend/resume
> callbacks. Update the I2C device driver guides to reflect this.
>=20
> Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>

Applied to for-next, thanks!


--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgKNWAAoJEBQN5MwUoCm2nLUQAIoMg1OY8IXrz2+1Xpe+SS1q
C4WcdipM2inLEeIET3aUebdJWZLYYZ1xEfZQBiquFmtvegaArUvnN29jxdd8bPCy
y36PX3hLSDg75rr7mUd5RvcMMW89Kx6xyCAPRxIwBD+uiWMf5WMms69RslMPi84i
qRKsgac+qhKr2BBDE+sIHiB0PtqbJOJXi0nTNynUvwITUmMNDw6YuOo21MnBgmHi
1k25xOe/1nshjxLDi5qTnu2KyPiQzL/vcqCW0d8UXsAdF5LQYorRxKwTvzZ2kJqY
9T1BshYT9JznHXpFOt+7UOQxovCaAhWrcftqsGd0vsE+LjOZ10HBp8LM8b2nJOsf
E0lzBzKLYw1t1SEBFs2T5Maj6h8Z63UD4BaVFS4Ln980UxxP0NzMHXD/8VzaB0Vu
PeDEP85K2Ygu71PssN9GwsiE5+vkBhakbb2vBV3y7BMBERFElpljS62icgmibOjX
NfsNQOTmhEbeLdBPKUPRhgcr1wXKaoE+fkD8/M8r8EC7vnYB7yBP4aipSWVgOHMW
wLegWoCpH/qMYtP8qa0x6nuDL8delHQIphpPz+aYHx/NaWG8zfBFhBTq1fn65p5x
ko3+YbzhAUn5pLVihA2KsPNQZMV+2gaZ4GyrnakDV+WAR0Zg8xUXLR44BAIWcOjc
WGkQLRsgxEn8c5A2rwnQ
=QEqq
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
