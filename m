From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: mv64xxx: propagate the return value of
 platform_get_irq()
Date: Tue, 16 May 2017 23:28:12 +0200
Message-ID: <20170516212812.brbmsqjvntwgjcgd@ninjato>
References: <1494936445-27331-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1494936445-27331-2-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rhekclgrlf6b4yam"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:35969 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752740AbdEPV2T (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 16 May 2017 17:28:19 -0400
Content-Disposition: inline
In-Reply-To: <1494936445-27331-2-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>


--rhekclgrlf6b4yam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2017 at 02:07:25PM +0200, Thomas Petazzoni wrote:
> platform_get_irq() returns an error code, so instead of inventing our
> own error code (-ENXIO), return the one provided by
> platform_get_irq(). Most notably, this allows an -EPROBE_DEFER
> returned by platform_get_irq() to be propagate as the return value of
> ->probe(), which allows deferred probing of the interrupt controller.
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks! I squashed the two commits into one because then I can count it
as a bugfix and apply it to for-current. I hope you are fine with this.


--rhekclgrlf6b4yam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkbbugACgkQFA3kzBSg
KbZgsQ//Z1N/0D07ecUt5MoHMJ0frxZWu+6SBgag5JLzdRVGxOOCw8FVYskITY7Q
mA+ltN9StTTY5V6YhOLLNWna66bRAii0zseF04gvN41Z2NdC+kDuUHIZa81HOYdW
wNYJQNAsTJ+AfpwWJwLSDxpbvqhBCVsN4vv9hm46F1dlcS6CCaCn1zFriTSs6XIi
soF+69pwca3ZzzWqy++7klKdyUZ+PDZ7E9GHmr43a7ntERNHFZ+M571WgtatKpQs
Tmjd8++pT7U8znJ+tjDfhy2hP1wydrZWBGELKLCEFm2uFPgV0gl/phlnPtnXOgfJ
GpguKUHmT92VeKCPUeqm/6ZV6QLd2Dp7fKjnKeeE2SUqKaQPvzUN8sdklmSq172e
zW04gsPp2OJZCSjDW/viIdFLdcKiKzm/IOX4gkNOgqyG8W1Bsr4FbH7cN1zIwMPS
m6vHrw6dF3uHwYhuD+5YQZQe334wP4GJ7FoggXZPnxtVJ68r85h3QLBrEPVPeeIK
F0AYxfk9P5UER8JMGfO1mxKVIKjU/Ae1RUY+d03wp2f6EoNpzO7z2uZYJSTUPvKM
KV+JgnYlL+RqlyFc5MGm7BCv3Ax9m94mTqujsgLIs3LI4pPl8M+G1fnwTBYZFVF2
3HNHJRUDwrhT/TBNIArxEp/ftH2bzMBMm/7cSV7rlh7JQLC2R2Y=
=9UOd
-----END PGP SIGNATURE-----

--rhekclgrlf6b4yam--
