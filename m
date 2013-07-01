From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: iop3xxx: fix build failure after waitqueue changes
Date: Mon, 1 Jul 2013 07:50:51 +0200
Message-ID: <20130701055051.GA2976@katana>
References: <1372455352-26260-1-git-send-email-khilman@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372455352-26260-1-git-send-email-khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2013 at 02:35:52PM -0700, Kevin Hilman wrote:
> There has long been a syntax problem in iop3xx_i2c_wait_event() which
> has been somehow hidden by the macros in <linux/wait.h>.  After some
> recent cleanup/rework of the wait_event_* helpers, the bug has come
> out from hiding and now results in build failure:
>=20
> /work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c: In function 'iop3xx_i2=
c_wait_event':
> /work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:143: error: expecte=
d ')' before ';' token
> /work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:157: error: expecte=
d ')' before ';' token
> /work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:213: error: expecte=
d ')' before ';' token
> /work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:291: warning: ISO C=
90 forbids mixed declarations and code [-Wdeclaration-after-statement]
> /work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:551: error: expecte=
d ')' before ';' token
> /work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:565: error: expecte=
d ')' before ';' token
> /work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:764: error: expecte=
d ')' before ';' token
> /work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:778: error: expecte=
d ')' b
>=20
> Fix by removing stray ';'
>=20
> Signed-off-by: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-next, thanks! (Geez, that original code looks ugly...)


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR0Ri7AAoJEBQN5MwUoCm292IP/3f3VJBVZNALyp721qkjwNe7
KX5B06cxNK1WS34YT2u1XKXuPIh0aaxVRYaqnk1/ELktxg3VGdWh22vjLj85C+LP
/XuC24zZLzHzmZ20B486ODPntJNctFm9FZsR4r8p3Itl92O72Pb0HGMwX9YuWGpk
AS2QZe61FbPBrhzJy0Fke1XbqcPd/7RsA6zHplT5B6awt06qe5GJctBGz3e8n4vk
UDi6AslEqnFrQycr9DBA4fDFq/gifD5UIMhXe5NDmLQUNeHg0wAYYOR999KFFORI
YzDCdOtZzVKpYX3ubFwRwJjSoCy052bWAATwVpX2Wdaor7j5uvoOoYT1vEX2J1nH
Pi5Ht/eGVF/LGcJxuic204jKmL/mrEgvAJVzwfRq96v2gD7GPL73k6gqHEytAPuh
F8MlwLG77YrlKRNam73HPGHld62yJXpueXgLr9xE0ITlXLUuo716XBTehYzYuVuL
GdI7sEP2MkotMlL73oXo9Ro6c44N2T+8oXYnoAgwZOq5rlVazWKNtmbG3isS3ZWn
FG0u4ELaQB0AiISg1OMqJeBAmL/k/WPAsNQM4I6r9k5OML6jy7xvDdgcWuMGsJ7U
R/w9cfAb1qFl9KDE1uQjmwb9Q0KVLliKdI3Huw1WNoPY3p/QsgSg7Mjd7Aax5pC5
aB4hF4JnfpR9ZnrP5NKM
=B37V
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
