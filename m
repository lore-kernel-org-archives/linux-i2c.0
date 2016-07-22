From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 28/32] i2c: bcm2835: Set up the rising/falling edge
 delays.
Date: Fri, 22 Jul 2016 09:26:08 +0200
Message-ID: <20160722072608.GE1605@katana>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-29-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r7U+bLA8boMOj+mD"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50918 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452AbcGVH0X (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 22 Jul 2016 03:26:23 -0400
Content-Disposition: inline
In-Reply-To: <1464817421-8519-29-git-send-email-kraxel@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-rpi-kernel@lists.infradead.org, Eric Anholt <eric@anholt.net>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 01, 2016 at 11:43:37PM +0200, Gerd Hoffmann wrote:
> From: Eric Anholt <eric@anholt.net>
>=20
> We were leaving them in the power on state (or the state the firmware
> had set up for some client, if we were taking over from them).  The
> boot state was 30 core clocks, when we actually want to sample some
> time after (to make sure that the new input bit has actually arrived).
>=20
> Signed-off-by: Eric Anholt <eric@anholt.net>

Gerd, your Signed-off is missing here.


--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkcqQAAoJEBQN5MwUoCm2OUUQAK4A0FYVh9alDHNwxe0wBHgV
z8z9oftDDPWsfZy1h83nDdv0zSNYLUNOjsEIYhbyOdLQ4A7F+baDaEJ3TJRIAE2T
xjkeH13/rAtsyBenNDVyhxQzv7Dc5qI9BO2eZxTH2ymAO8rgHSqHkqucMe51dUzq
SP+hLyncV8fW9qc/s647M/T7j5o96jk5wZfeS2/eQuwmKWN1wUgZbqbaQ57HRIZj
tC/3jx3wZgMHaz3V2aQuykzsaGj6RdcDEsKjAOAvH5ThcIhnSTQ0UZBm6imLYi9U
kviRoDUtwlXX2fyUz7TJcq6a/4BPZyCcjTs+K7FHbGEeFtXia0I3+i9NKlHDG0fL
3yEf44YZQUxm99zoYUf02fk9jMz2noTH8RM1LC+98hfQoZDHxjMMzEVQHLs0xajO
1OEt7RtL8jVPMZgd4ZJfp9mjxawI3D6HXaVnCmU4uKtQ8MdDzWsDhS9CiuY7ZKSH
wsLenLfLbetZv4uqJhn9IigQ3r7lfyJc0KSjwBnCmfqxD6PzkaS5rFSsmBrIdPE4
FDqB1kCUm2Xsj5XUkASGF+Gw45loBqeWJj6WiDQocEM9BXJdN22dFMNyR4ePDiwv
kZ8wdmwm/lWL0Cwpl7fOWSQU1shuHRgvjy3vc0qwo1g+LYTN6qgGHG1pLJOilXBJ
GgwQH8B4ob/q67N//yN7
=rhvj
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--
