From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC V4 0/2] i2c: imx: add slave support
Date: Mon, 26 Jun 2017 18:14:03 +0200
Message-ID: <20170626161403.gnjkezmrnw6dtd5v@ninjato>
References: <1496890264-10150-1-git-send-email-joshua_frkuska@mentor.com>
 <e7565491-3efd-7528-7abf-506eb9edf374@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bt5aftcrlqpbxen7"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50067 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752071AbdFZQOM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 26 Jun 2017 12:14:12 -0400
Content-Disposition: inline
In-Reply-To: <e7565491-3efd-7528-7abf-506eb9edf374@mentor.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Frkuska, Joshua" <joshua_frkuska@mentor.com>
Cc: linux-i2c@vger.kernel.org, vladimir_zapolskiy@mentor.com, peda@axentia.se, syrchin@dev.rtsoft.ru


--bt5aftcrlqpbxen7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I have rebased and tested (as below) on the top of
> 5ff37d1a67e2fed0cae537ad682abb7f6647cca4 "Merge branch 'i2c/for-4.13' into
> i2c/for-next"

Can you send this rebased version as "PATCH" then? As long as
there is "RFC" in the header I don't consider it for inclusion.

And please include kernel@pengutronix.de for CC. They usually have an
interest in the imx driver.

Thanks,

   Wolfram


--bt5aftcrlqpbxen7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllRMscACgkQFA3kzBSg
KbaaiQ/+MI810FXVoX1bV1pAB0lTxQ44burLmJQXQU+Ppub/Uh2h6DIK5nvZzt65
XUlDMRfJtMZoGtwib8JUdcM7n6Zz8af+zRXQ15tnBJMqEy7QZA2hWHYKgdt00/6Y
z5HoVfeMcI3yBbq+yu/bjq4VYYFhYChl3VWhXyIPfivN7W4Q64zbxVJSZBIbXfn8
2QggvKhEKh4szV4oOIfBEa4qMg+eBM9AGKB0aI/+yC/3+LUy0HP8YdqLtIaQ42p0
Xkb/Aql4Cz6eq3M9EadIXX0SdVYfVf8+ElDF4eCS7P1Ua4XL6bcW9E0WNA9XWARu
moXy4OLStDm3nkDvG/fbRSSAAxt3cHB1rgONMzjmatDth2p58W6ZCQBfdkf+HJ7v
j3YjWG4woilHuGGgCaZZ037W5Kd2pQLEFRPaFNmpypXBUbOPlBSV3aE4lq9oA3cN
+ufSN7jmrdLOM9885j4rkUYhsjRRByi884c/sgNxHuISoYtpn8bu/pSqixJPjVgL
MrMSK411gdkQsjl0D6wpFyp41trAAHm5JaHlksqOGtvdvBesWGAreC7yiD4U+1Ek
vo4EuKNYtPrWA4zb3egq36wV46WEINzIoyny0OWwHnjFdcFZUdnSm9KwahjvVz7n
0U6ejHwXrGhtZm/OSl6zi23p+mCxse66u3uQPuSHLrjZxlylOPI=
=s4gY
-----END PGP SIGNATURE-----

--bt5aftcrlqpbxen7--
