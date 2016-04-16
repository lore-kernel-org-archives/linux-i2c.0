From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH v2 05/13] eeprom: at24: replace msleep() with
 usleep_range()
Date: Sat, 16 Apr 2016 22:58:03 +0200
Message-ID: <20160416205803.GC1522@katana>
References: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
 <1460401049-25459-6-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52691 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbcDPU6H (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 16 Apr 2016 16:58:07 -0400
Content-Disposition: inline
In-Reply-To: <1460401049-25459-6-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, srinivas.kandagatla@linaro.org, maxime.ripard@free-electrons.com, Andrew Lunn <andrew@lunn.ch>


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2016 at 11:57:21AM -0700, Bartosz Golaszewski wrote:
> We cannot expect msleep(1) to actually sleep for a period shorter than
> 20 ms. Replace all calls to msleep() with usleep_range().
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied to for-next, thanks!


--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXEqdbAAoJEBQN5MwUoCm2xY4P/11lygCUt3/GVP0UDVvYEMT1
Nn5LgE36mzCmZh5Xa8U93ZYBI/K/fxThP6aswnV9oxP1sY9/d1yZq6c9bgWNh+iz
WwT1WE1jYxnJoh0fuwpxw/6BaFgbjl8PjMRZeGu5TVwi4uUjqPfcJVRg6d/0LPd2
bJC+xSMf1Na2D/f+2kJXmZuSkqWiQB49mZcOw3SMwiL1MudO7tyFifMMmGTuWL7r
d3ma/LlotybaQjpKKTJUrVhC7kagTg5vHsOy9lOOG9TgZXAqywKfID29aVrqjRpD
OV3R5xkLSvi5B/VCGy7JJdgCc2puQ1Ia2hjkA1e2pIl6Filky/7tyOwzvzZlkq/k
cTpi3NCPgRQPFu5mEHUs9DYCk4R5peCucCuA2beUiMRk3nWOxgjgIuvbj6CDEgCg
5U4oAeiMl+l/yCORRMhsdT3K/oG1yfmVfyLPu6B7SGN9yFTqMj0fbLlwe4IxpJBI
7oPLFFNKVDkExURRVoFcyMeWC9Yd7iA8SGkq5cg1wCPhzJ0+MiYpKXUpvkUdq+uy
WuSbtlP2NaBSzn5LvIctSKVkWw1r8Cdm6Yt4J3GDxXDe8GGCGSlSHeGG0hyVZ4u9
t5uPIIXjfrGeumCHcu31Hgi4hdT3+0y/Ep/0zo50KoydkaUU4WYGE3P7NpU7Ob8k
krTkzvRDHQX2y4huyNJ6
=7V2X
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
