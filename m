From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH v2 00/13] eeprom: support for at24cs and at24mac
Date: Mon, 2 May 2016 09:42:35 +0200
Message-ID: <20160502074235.GB2015@tetsubishi>
References: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
 <20160416211733.GD1522@katana>
 <CAMpxmJVwFtLNi9cWXpEgY-5hJ+BE4VXPCAzkweCJCW6ezA=Ucg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59132 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbcEBHmj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 2 May 2016 03:42:39 -0400
Content-Disposition: inline
In-Reply-To: <CAMpxmJVwFtLNi9cWXpEgY-5hJ+BE4VXPCAzkweCJCW6ezA=Ucg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The read and write routines are quite complex and decide which
> operations to use (smbus or i2c) on the fly every time they're called.
> Why not split them into several simpler functions (each implementing a
> single way of talking to EEPROM) that would be assigned in probe()
> depending on the chip type and adapter's functionalities? Would you be
> willing to accept a series that does it?

That sounds like an interesting idea, in deed. I can't promise accepting
it yet obviously, because I haven't seen any code yet. But I think it is
worth pursuing. Maybe you could start hacking and keep going as long as
you think it is an improvement to the driver?

Thanks,

   Wolfram


--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJXJwTqAAoJEBQN5MwUoCm2EDMP+K5WMYvqKI9Jg8Qp0rIB+qpW
Bv2atBOSSAuuisbYrGMdPeyAL7aFS5mQMKZhbPBSo2UfiDFT2XWMPwt78aMTBb+Y
XNIixPbAQTGHqq4nSIGIxCjLWIJ5Uvs5EONctEd/SwukjsNGELLa0AqfzQq/Alk+
Mbp3ffvAr/fls7+Vx+VlQslcMuEx+CfKLuLuOx3wKiqLwtMzzEJhBPKDlLodcwnX
vBF6xFw00R9SvpNoNcGSzzi92egCHeNnp+kfvMED33kWDRFhWoEl8m8vp2QBrJ2v
2MOJQ8iDc7xY9riIDdw4oDbOl+7ROFieP8SKy8Asd3cn4tM3SUB54bTMMW9Y3Gwg
jylb6JRtwX3ckzV0eFZL7kI/oyvuPrmayUMbFPwvfAVuXUt/B1i8Z9A5m7EitDk8
dtz+hLVfDtuUp4Q5bwUxKSqKhLKz3di3kDmtC3+Cwozk6sPzxgosRFLxkPk6664b
tfNXPXBrLURrBm9dCLNtbR4RjtJn+U0d9wmoamTWUtjIX95MK0icVX2fUjVr8/NX
zOaDoVMjcf0f4cnVZ7NYcMQO8QTSOTipprh3U6bQGco8UzNSRcwBAtReMCDnR0TB
Cm1RhUhc7YFlqh7BCh+Ezp245hBwkDJ5FogEmsq2Hc1gxxKm7Jx96zDPjOi55gM0
3SRg6Vo+OIBow8JwqH0=
=28UY
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
