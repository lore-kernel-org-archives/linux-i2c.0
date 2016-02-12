From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] i2c-piix4: Support alternative port selection
 register
Date: Fri, 12 Feb 2016 20:27:20 +0100
Message-ID: <20160212192720.GQ1520@katana>
References: <20160129104146.50f06562@endymion.delvare>
 <20160129104452.05e94c08@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HAv5+T9jbwMPl6Kw"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 85.76.238.89.in-addr.arpa.manitu.net ([89.238.76.85]:59271 "EHLO
	pokefinder.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbcBLT1Y (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 12 Feb 2016 14:27:24 -0500
Content-Disposition: inline
In-Reply-To: <20160129104452.05e94c08@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Christian Fetzer <fetzer.ch@gmail.com>


--HAv5+T9jbwMPl6Kw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 29, 2016 at 10:44:52AM +0100, Jean Delvare wrote:
> The SB800 register reference guide says that the SMBus port selection
> bits may not always be in register Smbus0En (0x2c) but could
> alternatively be found in register Smbus0Sel (0x2e) depending on the
> settings in register Smbus0SelEn (0x2f.) Add support for this
> configuration.

Were you able to test both cases?


--HAv5+T9jbwMPl6Kw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWvjIYAAoJEBQN5MwUoCm2GNYQAIPZ9pMypKzwinl5+vmboW04
4cSdBlJIAcUwaEGLc8vT81dPXyWeG+bi+ryR7Tsj+z38ubzW0MvOTCQCrUI113A0
D36IGB2L5zKAVUYvs1RU/oB2JJODRSSCGrBvhUSEzRQfJavNq2fB+Qb1vTN03ZMt
HfYUGekVBIDZAmz8Q4XqXuKis4k1m1FMhRt9RM+nHxE0z1Hm1+G5GB7h3oxQ7Jak
KFRYjZ9jitN+rzMHdrSbvitmUXJJdowA8fYU1TIpHX09bqwsEMt6DgzEoyDyqXwS
FDLB3tA3erHtQNkhDDYy2JO4Mm7WRiWBRd7TLiCETMKDMPTkKYC8DhW6DqI3UgIK
AFuof7s1ZUYx5wqfhelZSx4yXJ4KywpRDElGx17cowLzRl/uzrlyC9zTvhSSvjg1
01nDiGIjmXHddCcXc0RUB4wlZ0mDGPNxpFXl+diYYR1rOOKJ8aHl68ttNqk/RUdZ
P+N137Ts3Z8XrjDW0wdWv8j13QCVgzO9A5CiXYJqEijw5xQqQmELagxZWSEcq04H
rqxTgCizwJnc+oo+wik0pNdqy9v1iTMCPpanFM9kUbOo4qiMEPDBJNTZd6a+v5cf
sYtKXz6sSHIkYQjYcex4TL6T2rFyDdpQYiFX/zfywjd7QGUMQENlNzTUrj0ZPE95
Ig/L9Z8ZGA2ht76GAWZ4
=BTi4
-----END PGP SIGNATURE-----

--HAv5+T9jbwMPl6Kw--
