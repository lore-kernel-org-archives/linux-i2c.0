From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v3 7/7] i2c: bcm2835: Add support for dynamic clock
Date: Wed, 28 Sep 2016 14:24:36 -0700
Message-ID: <87r383g1kb.fsf@eliezer.anholt.net>
References: <1475085056-5205-1-git-send-email-noralf@tronnes.org> <1475085056-5205-8-git-send-email-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:57414 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754273AbcI1VYj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 28 Sep 2016 17:24:39 -0400
In-Reply-To: <1475085056-5205-8-git-send-email-noralf@tronnes.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, swarren@wwwdotorg.org
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Noralf Tr=C3=B8nnes <noralf@tronnes.org> writes:

> Support a dynamic clock by reading the frequency and setting the
> divisor in the transfer function instead of during probe.

Is this fixing some particular case you could note in the commit
message?  As is, it makes me think that we should be using a notifier
for when the parent clock (that's the one I assume you're talking about
being dynamic) changes.  But maybe you're working around a variable VPU
clock being set by the firmware, because we don't have a notifier for
it?

I'm a bit worried because I think this is going to be pretty expensive
to be doing per transfer.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX7DUUAAoJELXWKTbR/J7oJ18P/jr6nysOd7RwBHSg70SLeZPw
iYgGAwVvyupu8JzIxzL8rGFXhm6G+PR3J4xfBAPu4+sPQr55+I+XEN0342dbsBlR
WAWDPw8VSijpDMaPr7GX1Y5ct6/VxBZ2KBL4q25kLcoJKBj1prcci+gnRFGA78ot
YDCJghLT2oVMP9l324dd6pXTMayxuPHUiOOdWvVsO92/vQ15MO+boxjDD7z7WP33
pzZ6gOkkqNPvQeRDuf6s+w5Q6YMHLgNFsPySnBpOzwgVRfBrAYfBVYR+miIL0fc3
8R23vcQER115BQl1sSMj6/aeb9bBplIO/OHzDI4WbfbBCuUBS8IbLMVXZgd+FjM3
meVMsxUA7nExHas+NWifypv5U4N+sMlLmg0dlWHMCUDqsp8b85x9d3lPIHNiaGC1
iN2jt3LqSXl6EK0j5M4kaoOHD5eatapE+6dAMOAmmQl11aG5JcFn+tyZmIlmQNei
juYUasAzaoLHZ46cJE4QJDzeBzxZJspDW4HY7BMiWGWUMIvFjcyWhcM4h7nzen0y
4IWdbUzfmwT8fs/e8+s0BDvR4XpYJr0CrM9k/vA0sFiIgi6rERAFoCVlFP8GY0Uu
vStOKTCErM8yBO/iCna0ENIqgKMlgnHCUCgrXHHL1/htxjv423LNKDtZ2sGCH8BL
LR4VY64eIG2tw4f3322Y
=CkLA
-----END PGP SIGNATURE-----
--=-=-=--
