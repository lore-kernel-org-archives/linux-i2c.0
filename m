From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 0/3] i2c: Hookup typec power-negotation to the PMIC
 and charger
Date: Thu, 19 Oct 2017 16:42:51 +0200
Message-ID: <20171019144251.hmvkaijwbgamaqoo@katana>
References: <20171011094121.6108-1-hdegoede@redhat.com>
 <CAHp75VeqskRsmedvA3eAx27o8WeZzH44880T=Q=+1mD+1nSSAg@mail.gmail.com>
 <e875d3d3-d62c-7363-e596-9c0dbeadce5d@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bz6kgvecgtc7ntfr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e875d3d3-d62c-7363-e596-9c0dbeadce5d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--bz6kgvecgtc7ntfr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The first patch, although it is an i2c-core change, is really
> quite simple. I believe anyone can review it. But it does need
> someone other then me to take a proper look (and not just do
> a code only review) because it is a core change. Maybe there
> is another way to solve the problem (persistent / predictable
> device-names for i2c devices instantiated through board-data),
> but I don't think so.

My plan is to hopefully meet Mark Brown (SPI and regulator maintainer)
at ELCE next week and have a chat with him about this series. If all
goes well, I'll merge it for v4.15.


--bz6kgvecgtc7ntfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnouesACgkQFA3kzBSg
Kbaziw/8CudcqHk04BCiiS7OV3iTZ+YxPGaSgxBKztRz0mm9vy57YN/DWKDhkjae
2qE+fDjLKNZLRcBSBAdOVgrbFT7fomdfKjIbYAq70/IxX2YgBlOYNlf+3fHwbnLB
kU3CfOzQgNBglUHqENCpDg03o83+hT95uvrgJF11P4JQ5FLrFFNcugSV+5a896Dx
dAKA1g9HDn7cVfYlVPRhNjMqmAGneO+baItJ30l6XA4a+W/w/TebUr0lK7118+bQ
pK12t19xOxPhVVamegX8+i/UDD3vcwAJ5UwVL2VgbLIBopuFYfr8WdgHhKQ/oqAM
NH5jCwxVg9AcnAW7ZlTWuQY2xw/HvqCUquAA+rSN8YShOvXbmJ3s3cyMbR7ImCFc
a67frvKkGOncgpqqnWrv6DaMcgVe3w1RiBzMN1apOh7MwjTR7XvgVcKsWqBwVGS6
zpfDYRy+UFbbE2b8sPW5geVRe7F3dCGfQLzNinqsvPHuGZYt8sqSpmxLmueJW3Uo
EM+7tpQPd+3YsYTcTc+JnU19g4PfuTpMQBwYywyo711IZhEAExp1oduqqSyxdcSi
kjJE76At5LCfEiFq3Snb+HvpnRTmhzpFdeom+pDWjjCo7+t9eAfMExthKCbAYVS4
wHYILYAH/Swsy+eowAdvn/LBve9aKUkZuB41Qj9TkchO/cs3QDU=
=XV0X
-----END PGP SIGNATURE-----

--bz6kgvecgtc7ntfr--
