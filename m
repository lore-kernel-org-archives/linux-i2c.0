From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c: slave support framework improvements
Date: Thu, 28 Jul 2016 09:41:57 +0200
Message-ID: <20160728074157.GA2693@katana>
References: <20160723195114.GA2104@katana>
 <27421469430128@web19h.yandex.ru>
 <20160725072151.GA1599@katana>
 <354241469432837@web19h.yandex.ru>
 <20160725082813.GA3376@katana>
 <1025301469437877@web19h.yandex.ru>
 <20160725094117.GB3376@katana>
 <1391831469440835@web19h.yandex.ru>
 <499754e2-f60a-5170-21f3-d756f768dd0d@axentia.se>
 <168841469551868@web14h.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50871 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbcG1HmH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 28 Jul 2016 03:42:07 -0400
Content-Disposition: inline
In-Reply-To: <168841469551868@web14h.yandex.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kachalov Anton <mouse@mayc.ru>
Cc: Peter Rosin <peda@axentia.se>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


I didn't read all, just found my name in this paragraph.

> > I'm also a bit surprised that you are allowed to create a new (dummy) d=
evice
> > with an address that is already taken on a downstream mux client adapte=
r.
> > Is that a feature in the i2c core, or is it a bug? Wolfram?
>=20
> This is what I mean under the "populate all the slave devices beforehand".
> From the i2c bus point of view, I just adding one device per bus. It's al=
lowed.
> From the adapter point of view, I duplicates clients with the same addr.

The slave device must be attached to the muxed adapter. There, the
address should be free. The parent adapter should be reconfigured
depending on the mux setting.

At least, that's the theory, dunno if this really works. I thought you
would be doing this already?


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXmbdFAAoJEBQN5MwUoCm2H00QAJQ0q0fJc/3y4ra1RLkX6Jf3
WWIInO97zbxiM22VsmGbFwmiAHUK3QGwxzvzZba0npQMvCFDQhjvYla7R5gKxKJ5
JgvCVA4U6G658Xw4w8HM7qqqx1CTJjhr9gTKpXQaACcx2EFpQVanEVWi6Pg4/jZ3
owAMCwRsCZYATWbh/MTUFAXIyeKa2KOfpEMkywOmgJU85cbsUubO7d7NA42luY/A
9TtBFb+brQ8F0lTZvYHlha7c6bA2E1YD8zcW4fzy1ZH4OPKbds/vhhMsCmNzYYKh
lhUrMsr4O/W6MtxfCQyvfuHYgXg7MQfh7vQzZpcI2DQt9jQYXZdthSU1a24qWOT2
Rwk7yfiL9ov6ZT1DWYUO23LXTaDY3LqCalLpz0gN4nXTCqudrCHc3E/0xYjqsOeB
SXt+sbxLbEsx04LHUFic7Nj7fBo3AKU4UMA/Y5TaBCYiLLfH2OjLYvPU2jo/BGRF
+83La6O/GIrlOX2G1vc24hNLN7696UUVPCUYMAGDhpN9Cs0KdcC7RXo4EHsKdoTk
xD7g4Jyf6kLuQEdjX2S6FdhQUQEwAH4yZtb+/hGLsGz5z8k5vev0zA5d0XrfoJlu
L43BnIuF3fmqQY5E/5nW/xWKrPEkGH27ij8LmmsMjzIDrfOiCz4ISxEGPh65/tti
uo6QBNueg/HaqrNxSR7l
=oVWS
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
