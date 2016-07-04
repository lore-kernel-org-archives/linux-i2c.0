From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 0/1] Portable Device Tree Connector -- conceptual
Date: Mon, 4 Jul 2016 17:22:26 +0200
Message-ID: <20160704152226.GJ6247@sirena.org.uk>
References: <1467503750-31703-1-git-send-email-frowand.list@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5N2+S1LJ+nNsdJJZ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:41570 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbcGDPXW (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 4 Jul 2016 11:23:22 -0400
Content-Disposition: inline
In-Reply-To: <1467503750-31703-1-git-send-email-frowand.list@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: frowand.list@gmail.com
Cc: robh+dt@kernel.org, david@gibson.dropbear.id.au, pantelis.antoniou@konsulko.com, stephen.boyd@linaro.org, grant.likely@secretlab.ca, mark.rutland@arm.com, mporter@konsulko.com, koen@dominion.thruhere.net, linux@roeck-us.net, marex@denx.de, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, panto@antoniou-consulting.com


--5N2+S1LJ+nNsdJJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 02, 2016 at 04:55:49PM -0700, frowand.list@gmail.com wrote:

> This is an extremely simple example to illustrate the concepts.  It is not
> meant to represent the complexity of a real board.
>=20
> To start with, assume that the device that will eventually be on a daught=
er
> board is first soldered onto the mother board.  The mother board contains
> two devices connected via bus spi_1.  One device is described in the .dts
> file, the other is described in an included .dtsi file.
> Then the device tree files will look like:

Can I suggest not using SPI as an example here?  It's particularly
messy since addresses are essentially just a random signal that can be
totally separate to the controller hardware which might be adding more
complexity early on in building up your model than is really desirable.
It will need to be dealt with but perhaps not right now.  I2C might be
easier.

The initial issue with SPI is that you really need to do something like
bring out individual slots on the bus rather than the bus as a whole
since you're going to need a remapping layer to map chip selects on the
module to chip selects on the host board.

--5N2+S1LJ+nNsdJJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXen8xAAoJECTWi3JdVIfQaucH/0A83ZrZkJ1ue7mFQAJnOjnP
6EZo3skp4dDpCyM562aF5ktNsR7NmneqCuJYvd9dcjuTuMtc0gOU8CpzPZyIPTwa
YMibm+UpnzBoGzz9lL6qKvICD1EuboLPJGbumR99B65avEaMHNUep36BIyztXIQI
IhFrjZ/KT7WcmwZgFRsGz3plqFEFecrEFQG0mdM9uuB3uVgyShzB83HFyWcfIWKW
xvqBFTNrpxtyRrOrVS05MdHVHmBP80kJLC+xNn3ea48LnwVLI1VhpWZRY/43esbF
FeGwLL48XPnIeZw8TDJIdkR4E9l0iclgEINDmFP+XSHNLACz/oPb5Rx/JEb3Y+4=
=1Jid
-----END PGP SIGNATURE-----

--5N2+S1LJ+nNsdJJZ--
