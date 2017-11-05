From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6] eeprom: at24: Add OF device ID table
Date: Sun, 5 Nov 2017 22:53:44 +0100
Message-ID: <20171105215344.a5nyk7xmcdl22tpd@ninjato>
References: <20171001104948.21663-1-javierm@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="op6e2gj3vgmkb6lu"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48506 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750724AbdKEVxq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 5 Nov 2017 16:53:46 -0500
Content-Disposition: inline
In-Reply-To: <20171001104948.21663-1-javierm@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>


--op6e2gj3vgmkb6lu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2017 at 12:49:48PM +0200, Javier Martinez Canillas wrote:
> The driver doesn't have a struct of_device_id table but supported devices
> are registered via Device Trees. This is working on the assumption that a
> I2C device registered via OF will always match a legacy I2C device ID and
> that the MODALIAS reported will always be of the form i2c:<device>.
>=20
> But this could change in the future so the correct approach is to have an
> OF device ID table if the devices are registered via OF.
>=20
> To maintain backward compatibility with old Device Trees, only use the OF
> device ID table .data if the device was registered via OF and the OF node
> compatible matches an entry in the OF device ID table.
>=20
> Suggested-by: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>=20

Applied to for-next, thanks for keeping at it!


--op6e2gj3vgmkb6lu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln/iGQACgkQFA3kzBSg
KbbtAA/+K8f7YQ1mV01nSix6bUI5z5BXVWRgaWhMzLLdBRK2iD9z/mabHBO/KMof
xQnHVKThNEm6aRllnb6N5V1yL5yaViRfNuGRLWE3hJltRihf7NV/nRhTFl63Kzpn
zmC6+dJ9DPlKz/B2BME1GY8yaOzd9g+LkR/caG9rhUJ0IxjWgjnrQS9yU1kgVAR2
O9OS6IjC05iDYaVxAG3IEYatOr9ZB4ogmVQndLUfjlLr29YPBWKfnTSIifR9AS8x
da81wEqqwa9Lcq0HY9gdMusnYrNOCyKdzCKc6JvAdoLpzhkaXyojHy28uQZd9cu+
tvNaL6amPLcEHTTTjypTfZ76Ilhr8EekjIkfbmUKErCxWnM3hc843LFryfWV1nZi
ooloizW3jOief1fs13iLJq/ALWq0MAlGP+24wwJI0FgCssTkIGgP32BHZgRchN31
7vDZw0K8BIC+QUDPCej9sDspA1sZLCBAkYobn5lbsSSG2ljL1X/LCtfi5ZRtbfSR
4RVdCX6QMTTk7pFuUVVq/80WJlUZqf0ni4GqX/xcjCYfdxYugaISxegc9CJeW18p
JZWkBgoVTGmWkgifXTMOtjHTL4ruukU9vZTarQya42JEmPDZsHrDe8gCn85j+hXi
qErUfPWDXpZuY/04LV9rwRyjiicLZLhR3avKupk88prNmzm+Z90=
=GHMK
-----END PGP SIGNATURE-----

--op6e2gj3vgmkb6lu--
