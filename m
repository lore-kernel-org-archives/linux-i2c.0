From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] eeprom: at24: check if the chip is functional in probe()
Date: Thu, 11 Aug 2016 17:55:33 +0200
Message-ID: <20160811155533.GA2185@katana>
References: <1470837257-15521-1-git-send-email-bgolaszewski@baylibre.com>
 <20160810140715.GB1607@katana>
 <CAMpxmJVgvxXfdp97y-ud=35H+X13wFR22kzeLS4FnDZQ7NT2sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48030 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932267AbcHKPzl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 11 Aug 2016 11:55:41 -0400
Content-Disposition: inline
In-Reply-To: <CAMpxmJVgvxXfdp97y-ud=35H+X13wFR22kzeLS4FnDZQ7NT2sA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >> +     err =3D at24_read(at24, 0, &c, 1);
> >
> > Can't we do this before registering dummy clients and nvmem registratio=
n?
> >
>=20
> It should be ok for nvmem, but I'm not sure about the clients:
> at24_translate_offset() will return one of the registered client
> structures and though it should generally work for the first byte (it
> would always be at24->client[0]), it won't be "rock solid" anymore.

Agreed.


--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXrJ/0AAoJEBQN5MwUoCm2y2kQAIgyXYQhQlZCboH4Kp1xve4X
0wwjm3MGovvqpTftNKGyLTTYVCI1S7gMSWeeFaAJ3qtvgbC4gJv0ple6emmpibkb
XOVNlBIkp/Sow673vyblVdHqUjsQf/K3MOBpsAWClhdPh72p1t9/AHB97XocoXFa
M2p4CZ0PtMGXrmkILlcFDOz8kQWwR6Qy+K3uiqTH/I9GRHCMsG4+IrLmf6ROeMtj
0Tz0W4VTFK6too7c5sMW3HTLhb8VggOT3PbOhKY7oe8/kUZv5a5p2aviJLpzCpPe
YR3fclidaI2qJkckonmEiL7z7cSELTN/P9iHlsIHMzdhEh/cPYM8zMzB297VS0UB
xA4M45rlrz58m4SR8vtHRKeiljznAzsjvPQ5pj8GIahpKRV5IB1JkQ1F6M+VQYrB
4wBlWkTtYtaOi/es/InTw6Y3ZPwKw6HWi+xTP9F4oOEWaxC0w/S9PknUkEvFUqw9
qvaNCBNKGffRDoX7vSfmzXXPzcf3aUlGg+yOIf8LM64OVIw3xLGcKnElCYjkVNju
tWSUvEBgH6sYpDBMoQvrpRcigIY0lDDDqf0XHdlAIqO7v0q2ADGImzZUsjxotnLG
541/rpQMpC+qh92fY1meuMaaHqdSXXNqWuYlACWaaxg+wCl4MTMA8rnpuOJeQhSb
sl6rqeqA9fOBSqax/mgb
=fULQ
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
