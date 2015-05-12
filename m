From: wsa@the-dreams.de
Subject: Re: [PATCH v2 3/3] i2c / ACPI: Assign IRQ for devices that have
 GpioInt automatically
Date: Tue, 12 May 2015 15:09:32 +0200
Message-ID: <20150512130932.GE4447@schokonusskuchen.bad>
References: <1430908148-201129-1-git-send-email-mika.westerberg@linux.intel.com>
 <1430908148-201129-4-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430908148-201129-4-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Octavian Purdila <octavian.purdila@intel.com>, Robert Dolca <robert.dolca@intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2015 at 01:29:08PM +0300, Mika Westerberg wrote:
> Following what DT already does. If the device does not have ACPI Interrupt
> resource but instead it has one or more GpioInt resources listed below it,
> we take the first GpioInt resource, convert it to suitable Linux IRQ numb=
er
> and pass it to the driver instead.
>=20
> This makes drivers simpler because the don't need to care about GPIOs at
> all if only thing they need is interrupt.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVUfuMAAoJEBQN5MwUoCm225UQAKbxxHTDYjguPfGuh6+rJFLv
3XybK5GlAWXm0EgTZ9waQHqM2uEVh26wWG/1nEce2u5SsmXxvZdC+jdSxKrWvaf5
dCU3ki6wQbMQKh4KURk/0hhz5jnt2Izk0KrTVvOCDakJraysMFfQHfnn2teN2aD6
k+psTCfMfQTkW3ElZ9fiGzujXijoUBhPHaDYdMPiVJwKgCt5Ej8h0qL0kJJoBx5U
UtBapRg3x38IGhcsfaQ9k2GGS/5IsLc3KLxZt1NJF4d31sVeSm1lLwJYvOOpmhkc
vty4aHF6AcGj7bm9ZWZ9w3hpWNrGNF7hx5MicV0rf3qJ0h4t26Y0kNIpkbpiiNOK
3/HHRhci2+N4lvAop13BNa7I48IXRyRtS9tzMxeM99K88KMdE4P2gaE9uarjgwGO
J6RU8p9fzXmF9HuU3CGopOROYJcvjLOKTCu2m7BgILt8ToTu4P31+X7EuGcvOmtc
9nMEs1+bHfX4laQaUPISrrpLK6453lx8ACXL6HNYEQaiND0NK4SaW1/b3yDBVaOw
6yonVIVe2BelqM5vpsmFNxeO59oOVSM7YuBi21ytkfudYxsTA5dYCyelgve/8ogN
aeGnBEb0MEPyQBlha+BkrGuSLEYdM2x5DFJCRt9CUeTGSBqZCjcj+D9ilNUZMuuY
npLzNj42Zb53WghF0IEj
=XuaH
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
