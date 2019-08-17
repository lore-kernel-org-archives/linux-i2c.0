From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V2 08/13] i2c: bcm2835: Avoid clk stretch quirk for BCM2711
Date: Sat, 17 Aug 2019 10:30:16 +0200
Message-ID: <20190817083016.GA1315@kunai>
References: <1565713248-4906-1-git-send-email-wahrenst@gmx.net>
 <1565713248-4906-9-git-send-email-wahrenst@gmx.net>
 <20190814193628.GA9756@kunai>
 <bb924d04-b4a9-56c7-c7d5-31f3cc8c1da3@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2202619432611804165=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <bb924d04-b4a9-56c7-c7d5-31f3cc8c1da3@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>, Michael Turquette <mturquette@baylibre.com>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============2202619432611804165==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> quirks =3D (const struct i2c_adapter_quirks *)of_device_get_match_data(de=
v);
>=20
> would hit the line limit. Do you insists on the cast, because it's
> actually not required?

Not at all, I mixed sth up and forgot that of_device_get_match_data
returns void*.


--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1XuxQACgkQFA3kzBSg
KbZqww/8Caf0okFY7IK0Ft6q6YcN2wNLlAFl3EYp1noT/64s7GDZE/wIPPL/xf2K
wP3EXxEIlAqnI2b9dw+L5uF4UIKOJlMnH6xQC5mtm+xNWgyTzFG/10gb6vPMdVdY
8PsXASQzotqQW6BZUVMFwyTusvu7X6JXrMJm+fO8VPMjfyd+RPIV7IWiKddz+jo2
XV7FJWnnfWG2LU+EMpIyu2g3TzQAlZxEa6LZb4pkG1SG7Vi38g6Ne1vKxvHwRSFS
MeyW9G81d3nidCBlif+xpHG28hSv9hkK013M5JD4guTaOUMAgDUdVn5ds7zkKw1x
KsUeYmpH/UcCqrZ3vRFh5Fw4CqRZB+VydC5QOo7bDjUuWy+PgufGgNOe3pLYoH8f
ztWK9Il+DEUnT73OV6r+55MiRHXm7NaecC36v1lNsZUT/aCZqnUS29vt/u28Etvz
ESJxRIDLjoGSg8CGyW1/zqgHe0lCjZEZCpx0ou6VtjsDGLHrSfdqWHb5Nz5nQLg8
osUepGUo4rZ8ucapKZrYA6LJ7TkwaIRdHLUQQzJLceTOaZXeXGvrGaTX8r1Tg8bA
69FjU2hlqro5RNCJ9ECTsF8jXpQQ1EwXEJ8w7ck2OuZlkMSFq5TLIFcdLrNe31Xd
ampw0Qtlja1zafuXEgRsiemWsfXoy+7kxW7tK7QNtPmitWp2Ruw=
=Ip2v
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--


--===============2202619432611804165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2202619432611804165==--
