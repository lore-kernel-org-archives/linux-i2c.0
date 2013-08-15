From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c_mxs: Set ACK_MODE bit
Date: Thu, 15 Aug 2013 12:08:09 +0200
Message-ID: <20130815100809.GE2987@katana>
References: <1372780860-12972-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372780860-12972-1-git-send-email-fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: marex-ynQEQJNshbs@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, cb-/RsSufbtIHM@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2013 at 01:01:00PM -0300, Fabio Estevam wrote:
> According to mx23 erratum 2727:
>=20
> "2727 : I2C 9th Clock Pulse (ACK) not generated when RETAIN_CLOCK set.
>=20
> Description:
>=20
> When RETAIN_CLOCK is set, the ninth clock pulse (ACK) is not generated.=
=20
> However, the SDA line is read at the proper timing interval. If=20
> RETAIN_CLOCK is cleared, the ninth clock pulse is generated.
> Also, the HW_I2C_VERSION register incorrectly states the version is 1.2.=
=20
> It should be 1.3.
>=20
> Workaround:
> HW_I2C_CTRL1[ACK_MODE] has default value of 0. It should be set to 1 to=
=20
> enable the fix for this issue."
>=20
> It has also been noticed that mx28 needs to implement this fix in order t=
o have
> SMBus to work properly.
>=20
> Reported-by: Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>
> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

What's with this one? Bogus? Needed? Still needed after PIO rework?


--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDKiIAAoJEBQN5MwUoCm2298P/jNuGvCvriH2ci8DgI81NbNq
JByIN08Ai2d4QPwDyg2ruerg1s1M4EEpW+hMKJRex/2viYBUQ72kuT+nxfRvMpaL
GD4fcNP5/C4wcDAjnLrfz4k849mG1VV+P3G30vXsXUJhdn6mAPkQCB0qUiyfu3dR
vCeSJbalYfI0O9+R80woxNYDuEqLINXkugm7an4KxABYTt83ieT2dP1tAUuV9Cke
fE0U1G8B1EZitT8DYcQMweuVs8fpH+99iOO1bdqG+Ka5LQK49erHcxrtGXxN9+Ff
U6OK/Sg+KVnKQqAL61z7nGt9GUrU2Vwnp8tRHysui4wWRVth7phoo6xlH+xEMGTM
3yikrtmdUk22FVZQTq7Zh80aoH4mVHPZjYM+et6rJhSEC9CDSrmjzB8E/O1v/LwZ
QefhYOrdMmyrKPscTbSpxRuj6QaxGPgpP281MHBjn559CRPd6Mh9CJT7WwTiwc1c
g1jwbtvtED2sTj2xDIObfhev29uxKlQY2njYKhT+/YOUJubwcQTZ7xYFbkKlrfhC
Y5/diZOjf9vy1RYzYd1k3WSql/Hqy2/NkzMJpGa4kGYDPdNKWHUxPMZN+u2ujMfB
ORh8zXVJ94/rUnKprKLPpeYfra5rc3yQ8KAIzFKHpQiJVisOmnypK3oIkhz91LsK
8O+E5OQ9XRALlPQsIWge
=mSsb
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
