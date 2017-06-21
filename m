From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv2] i2c-mpc: Correct I2C reset procedure
Date: Wed, 21 Jun 2017 23:59:24 +0200
Message-ID: <20170621215924.GB2419@katana>
References: <20170511122033.22471-1-joakim.tjernlund@infinera.com>
 <1494947612.7509.24.camel@infinera.com>
 <1495547252.17446.60.camel@infinera.com>
 <20170529210419.GA2527@katana>
 <1496095395.17446.111.camel@infinera.com>
 <20170621213647.GA2419@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:40192 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751667AbdFUV70 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 21 Jun 2017 17:59:26 -0400
Content-Disposition: inline
In-Reply-To: <20170621213647.GA2419@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "oss@buserror.net" <oss@buserror.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Toggling 9x even means you could then write something somewhere
> which in case of a PMIC can be really dangerous.

I am partly wrong here because you send a START beforehand. And devices
are required to reset their state machine when they detect a START (I2C
Specs 3.1.10, Note 4). So, it *shouldn't* be dangerous. If all devices
follow that rule, that is...

However, you can only send START when SDA is not stuck. And still, this
whole toggling is to reanimate a stuck SDA. So, it still looks to me
that it doesn't make sense to have START & STOP around the toggling and
rather have a single STOP before you try toggling.

Makes sense?


--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllK7DsACgkQFA3kzBSg
KbZ7VhAAnmVO2lrEhnH7DVh7jbwP0c1MzltDciKIGzhWeclvTnkdzAXgQ7Gc8plc
FttnK2grHz6IXqlMLczHBdj8F1ISZSKq9vwhaV50/jzCC5xzbfiMV4WMKbshZ+Nu
I+XhjFtAzcyc52Wik30zz1+igj7lLReoKSL3l/W2oultFUglSFbx6BEwaVsiNn9x
n0JiMKrVt/QYC7kz+SnGhlEPI0SXmlE7SVgDIlqa344LQ1qlRvjoiwRi8sHtGP4m
7oGF3qodjcii6llPxdAXRXr2cA8cNhfgppupqJsIQRIl/YAsMQs4GHAEvWS7tKlA
Ik2/FkmnryMC+MfdpdMcUTayaP5SfbqfY6hkvpFJnWTGpzRC5tXJbW9xpgHaAhyI
FoQ52uIKo7QZ/66cKOwO3xmbHRP0FyQETAAplNaPr84xOYB0WQPl/Hxs0BQ+ahfn
97ELgJnM4njyQassSjzy4UkTtirSDvTPoEifQ8FiOwKYwaRtRltnlGLfMARzSNIw
BQJD9oszp60xYzM4N3H9JUkREml8mke+I3SXuS3/+1MMEMo7erHsMY7KGvstJjHK
UyftuO8ybJLDMqSyps9E0lOHM6Dr8L+qsGI8o52OUvFbTuRXfx9zORhZZN0r0O3F
09J87SrE/qPuVYt4z5fI4nuM1hxjgcHfj9ClBF/tGtG7PHwod28=
=3T1M
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
