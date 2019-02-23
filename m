From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 0/2] i2c: designware: Add support for a bus clock
Date: Sat, 23 Feb 2019 10:32:07 +0100
Message-ID: <20190223093207.GC1018@kunai>
References: <1550765459-14519-1-git-send-email-gareth.williams.jx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550765459-14519-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gareth Williams <gareth.williams.jx@renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>
List-Id: linux-i2c@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2019 at 04:10:57PM +0000, Gareth Williams wrote:
> The Synopsys I2C Controller has a peripheral clock that some SoCs=20
> require to access the registers. This series also details the new clock
> property in the bindings documentation.

Your SoB is missing for patch 1. And besides my ack, I'd still like some
feedback from the actual driver maintainers.


--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxxExcACgkQFA3kzBSg
Kbbf4g//TujUaeMwqhkaKlx4ZBmDq4MuNjaJkLFxuwd6+UM/aLM4g81XAUhNIF8f
Rj0fDiMgsxOGmxlq668hN8vayZen0fcCYM2yAhjfMstIhALWF10x8ckupGd82YMm
BAJ1eigAf02PO9Af/JDPlAdGHmoCQ6bkbawB7QFlfTqkaBrPJPOjdL2V0kO+Orh8
jhuuZLr2X2IdmYzx+egDvL7AWDypuruwonJTFpw5reosqKPmRzH6IZJ4w+iFo2G6
8bjSvpoyyci83TTaLFuhMcxvVH/42Izq7vHq9uRIgJakcr7TSitOPhx3Pl+Y8PLL
/rJYSt1jwozxMA1dIbB3thjF/hW8qe7KgZByKd46ax3P5iikKoYlkWal5CW+OIEI
D1TKycw9tXGlcVGKHJK+kVmOOOihp7gD5cNmg4bqULiYe+sEAzVhVTY+xzkL3eM5
vBtRRB5TdZeDNJ0kDZbXLlJgPJSnTgYZpbMsRPy40w7WLj5mw7/Zg6xBul3sYiu8
cYdq8jHGhavXhgOWeJN23hYdF3ly/SLSMfoswbRWBZ3zzCSjrKu1+8tRfVvGS+Gh
HzTuDa09MgX50JwsNw+XSzPugZWDFrEG1l9rS7yuR6e31b6bHxVKZjsky8i8u68F
AJZYZS7V5lIUgE8WXl6T/DXU5DGM/1Wzxd/zzOnCt5wnfGhosHc=
=H1Po
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
