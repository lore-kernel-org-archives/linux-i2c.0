From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 2/5] i2c: Add STM32F4 I2C driver
Date: Thu, 15 Dec 2016 20:40:02 +0100
Message-ID: <20161215194001.GA1741@katana>
References: <1481559342-6106-1-git-send-email-cedric.madianga@gmail.com>
 <1481559342-6106-3-git-send-email-cedric.madianga@gmail.com>
 <20161213092031.d2ax2pnpzzicriel@pengutronix.de>
 <CAOAejn0Ej90amOZUC2wGNBsTAZVmcqEaViV1-TeoaspiADBkkg@mail.gmail.com>
 <20161215193307.436sggu4zy4zezoe@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2878745824930186740=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161215193307.436sggu4zy4zezoe@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Patrice Chotard <patrice.chotard@st.com>, linux@armlinux.org.uk, Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, M'boumba Cedric Madianga <cedric.madianga@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============2878745824930186740==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I thought (but I could be wrong) that if the driver is called
> "stm32f4-i2c", it is used to match "st,stm32f4-i2c" even without
> .of_match_table. If this doesn't work, please disregard my question.

This currently works only for *i2c client drivers*, it never did for i2c
adapters. And even for clients, this behaviour is going to be deprecated
somewhen. There are people working on it...


--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYUvGRAAoJEBQN5MwUoCm2F7QP/i9S8lZVcOruG/o817+e7Di5
votDjs/c8i8KpNBsI1bfBFCrC7MA2QMepuwWifC++2azgsokBTpYqLu6htZuj2Ro
hC12YeZvxVnkOyH4mV3xMAoYjcOdvAozxaw48vWvuhrfQzTqleBuGden8ndOP8AT
v4T1nqorv6BmmHNLWE4NWbNUXCdVlRkVzh7pfBFSbYSSekoOPO8mTgBYHPNL17nL
WCRsQGNzQFFyyIYlDdcG7LzLyFasonNELHaTqNOKvO3G+AH3+xXLyXTCXo2nBDRN
hstwywYC5G1E5Btcv27G0C+rG+/ZeehwzJz7sLzR3jbX8EI64Y00XbSAJA1+ZjYS
yL70l6FT97zkTs+gGGDVMl+3pSvStDNBYP2KX6fkVNnP4WOwrKP+nCrEtcnk3Maq
cVjznyJiT3pUsj9g/j7GhrSOaT8bTwFeg9ak5BeeYMQ9n6F45AX4oAFxZJBxcrA0
Z/ER10lUagPCiB7nShRYH8D+Htx/DTKmBwDEHifF6uo98yeIaesgyz0IMV6SG11c
MW7X3rz9BzrPu67TcfLzwMYNI9ToWXd0nerlvq5SBmxOA10J433oGr/z8ROuO2k4
1HxwgZuCcHQQTxar/oPtFvWl5CKUQVc07pPclMrhLPKSd1j2Sh1wW2Mx7Sa67yEj
I5zEIHXkU4JLffgmXVUu
=qHZZ
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--


--===============2878745824930186740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2878745824930186740==--
