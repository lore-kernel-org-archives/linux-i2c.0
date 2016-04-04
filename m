From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 01/18] i2c: guarantee that I2C_M_RD will be 0x0001 forever
Date: Mon, 4 Apr 2016 12:47:19 +0200
Message-ID: <20160404104719.GC1383@katana>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
 <1459709101-24462-2-git-send-email-wsa@the-dreams.de>
 <1459765571.2503.15.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60337 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754504AbcDDKrX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 4 Apr 2016 06:47:23 -0400
Content-Disposition: inline
In-Reply-To: <1459765571.2503.15.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Didn't see a comment as stated though.

Yeah, it is hidden in the refactoring :/

 > +					/* I2C_M_RD is guaranteed to  be 0x0001! */

   Wolfram


--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXAkY3AAoJEBQN5MwUoCm2avoQAIfW7VDm5RxJV9l32jBpSIHO
b3H/qi5VOjOZIkaiiCSSU7yFUl/UFS+s3EMTInUs+cWTteO0dGKkGaVRUSvLsJOH
PNJeRXUxRQsdXl5w//PPN3PdzNTaEOG11rvqcWpZ44zMweIRI8UzMmFD3qmTRUNO
8mgvpq+zYxPylItJ82lePhRvgYgPOD4hC3314aqbswP0bx5P6AbfIA9KRR23Cw5W
OMMVI0KrjPfPLU+LVM1wfO/1PbbNI3xDmaGlo0MBvQgJBLPlYLeXPMX2osQ4IW+8
LGrOt1SkVkv7HBZwP+0lgwfz60+kpUIWI4yGXO8QsUhKp/dA50m/CTWYs+7ePU4z
LAKYrlNAsaPRY1elybk1gcTk4OiKEl/Q5yEj9bxqJs5t3/s2qX0spJ7UFvxAfC5Q
dbTkrLVGpVkIH+mngWImjHs4526ibESKyKxAHT/nD/w4s4kkNHe7Hsz0MoahrpR2
W2eJaeoxb4WTw0wYYHV0rxWbS1rvsq1l7kOUiSHr8WZhZG2SwKZL+OK/lqVmN52G
/ItEijLdIxMKHxjtLvOMbT/rUHd1nVJUlQdsSOkXXbjTf5PFB4hxHWuH2aZxT6K1
DR7f/Iodn6M8JCsEzSQgjo/ayRBL0YhWNPvSskshipE1Q3P0Vk2EHgGxpYz/9Asl
nNUOPRkzOcfBC/dGhZM0
=Jm/C
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
