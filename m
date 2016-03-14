From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-core: do not use bus internal data
Date: Mon, 14 Mar 2016 10:28:10 +0100
Message-ID: <20160314092809.GC1383@katana>
References: <1457351357-13457-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20160314091819.GA27975@ulmo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160314091819.GA27975@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, gregkh@linuxfoundation.org
List-Id: linux-i2c@vger.kernel.org


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This doesn't work. I see a number of these WARN_ON()s trigger and I
> think the reason is that i2c_init() always fails now. The cause seems to
> be that i2c_init() calls i2c_add_driver(&dummy_driver), which will now
> always fail, because is_register is set to true *after* that call. There
> is no way I see I2C working at all after this patch.

Same conclusion here. Too much trust applied to the original patch, mea
culpa and sorry! Will send the fixup (tested!) in a minute.


--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW5oQpAAoJEBQN5MwUoCm2yowP/iJMns3ItdzBUAdiewqXbgHm
dld9e4x2HrQ2Ojpz49EF24WGP29s2ZP+Nh8U8uajvh3+ZwwZwi9oS3oE0XflLKGf
4qlKbJHAyd5f7y7FxYUa09nIq1dM01w0J4hVNU5Wnaahel4hELqG1JiLlnhjMuxk
/NTWPsASaSaVHqqUS4lYAe6R/MURhal2U4kFBaPa5fI+GOK/c0Eyr5HBEbLw8TwR
Gv/I1t5uk1Eq0nAW7eVs4MjSqSlcr+p6V2aZVE/gsFTvQMFQQ9LPTlBcugXCVXt4
TVv1NJhOkWSwy/iy/PIb0udW9chY5OeceOFxQL1ORkDPG8WJlMpGTsiyjy8e3tw2
4s03VHp9u35c6G8FmLYn2A68ng6IgZSkyMoyFoHyzJLNSUoB0OtdegSCdvhb5oJK
7oT2qkFAGwRAH6LJmJMQ7w2501PBvlarXFHwepSIgapQ+K9hM4kheua35r4Iu+xE
4ppsEWssCPy+/6S8w6jx7hOWCxEXdgE1SM6nSQRonTmQeVq2CHabplEHjSSZZ9a5
uKD4Nl49ndGoYugt/tc7p+i9Pl0K52o9mHbnVxvFTXDuVeMyKrYPiONWEQLqtRdA
lqi9Qy5yKH842zeYAtleDjica3Ud3ttPDM9GRQF0n6yBwgK1pzna+yHlVwNKNjpy
A1eYzmzyAZRz+gzJfzf1
=NeJW
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
