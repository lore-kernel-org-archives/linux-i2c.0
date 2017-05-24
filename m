From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Error using at91-i2c driver in kernel 4.4.x
Date: Thu, 25 May 2017 01:07:08 +0200
Message-ID: <20170524230708.GA1456@katana>
References: <DM5PR05MB2954708999EFB8F1B593BC93BBFE0@DM5PR05MB2954.namprd05.prod.outlook.com>
 <DM5PR05MB29541B7EC525C8438538352ABBFE0@DM5PR05MB2954.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:32854 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161226AbdEXXHL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 24 May 2017 19:07:11 -0400
Content-Disposition: inline
In-Reply-To: <DM5PR05MB29541B7EC525C8438538352ABBFE0@DM5PR05MB2954.namprd05.prod.outlook.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bryan Evenson <bevenson@melinkcorp.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@atmel.com>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> As usual, five minutes after I ask a question I get further.  I tried
> changing the ioctl to I2C_SLAVE_FORCE, and now I can talk to my
> EEPROM.  I'm happy it's now working, but I'm concerned about why I now
> need to force the slave address.  Is this because I now need to set
> things up differently, or is it a problem with the driver?

=46rom userspace, you cannot access an I2C client which has a kernel
driver bound to it unless you use I2C_SLAVE_FORCE. And you really should
not do that because you could confuse the kernel driver.

Your old kernel probably did not bind a driver to the EEPROM, so you
could access it from userspace.

Since your DT now describes the EEPROM, why don't you simply access the
'eeprom' file in sysfs?


--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkmEhgACgkQFA3kzBSg
KbZJxw/9HG8afSJr4x2QZTnWyMJb0fGSXzH19+DbQPBjkqI6unNf6tEWiM6M6vb/
tp/Ts+/yn34x2INlWfRdDeCl7Kq578718ernYUKoqviUzsPxNxY74HjMNmGeGiPX
AepE9IxXT9O8PrHcNLe4s8jhRFkbME5vOI5w6XVT4kIZau/8/rhia0g/9ZLz4fFa
bAATvWRgk4LBgJjor0bHKBY3MvC1U/Gc7eU9Gxryg+55FZWIqsV8clEa2I4mgKbq
gsCRaOqo/V2rohs7VOWr/3nTOFYsN8YznHZBi4PhCariKfU73SCtI7QJn+NEbfVi
Qv+r8GSdeT32syzDvNmFEc2YXMRDh0+D05qz1D5SSsbQCkj9gXYzXmsRFfX5ZkgY
s8h0H0ZhAxKQEg7y5HEuhUAyVaB4QyeNv32fQPu/jDHvt4XCv+rkE3ssuwHLS4Kz
Mh6sGVpqXclt89o134OHpA8WTBe3DZrrwo04Lb+vXvF5dqkgF2LJvEpqTr0eXOJL
S6SDiqqvASBrqLVVNI8RPYKXpHgGXTKGcdkp2JLYwtHasglY2MoPgC9O+w/irtLv
MfFH5ioBDSrkhfgREx4YpV+lc/JOM0vunawDoTOxJh8y4bNbeEnN/PSx6mNXQ5Im
akP2TIEeOuPpxt3iObgKlS0qrp+Nab2sgauS5g3WEHDM88eud7Q=
=dVsP
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
