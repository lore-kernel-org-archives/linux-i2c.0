From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH V2 00/13] ARM: Add minimal Raspberry Pi 4 support
Date: Tue, 13 Aug 2019 13:42:35 -0700
Message-ID: <87mugc7q6c.fsf@anholt.net>
References: <1565713248-4906-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5941243146857783418=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1565713248-4906-1-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

--===============5941243146857783418==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Stefan Wahren <wahrenst@gmx.net> writes:

> This series adds minimal support for the new Raspberry Pi 4, so we are able
> to login via debug UART.
>
> Patch 1-2:   Prepare platform and DTS for the new SoC BMC2711
> Patch 3-6:   Enable clock support for BCM2711
> Patch 7-8:   Add I2C support for BCM2711
> Patch 9-12:  Add Raspberry Pi 4 DTS support
> Patch 13:    Update MAINTAINERS

Series is:

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAl1TILsACgkQtdYpNtH8
nuh8EQ/8CIWIRxuKEDNPwD+swJlhNQsyfP+MqfY6OENxoLeBv7u23S7jc6OEm9Si
9vszx+5zyVzb33gGJv/Tg0XUwiIEWu8R2cEbLAi366056yJ8SrMH9ibaSKU+OsMT
3uN+Px/ahVT1s6WFnmdsRCEwBdRoMjRztBpr4ssRKbXUxZGjjXFVYscOqXqCmu/+
6Z+D9EMe2yL08QqyEK1151HDNgzAqh3kECGJorPBq2V3aL0dJ/sv5Mg62fFO8kKA
kpqQfcEFwIhD3vbSlA6MNU6mC1tpLhhJTjMAcbwCXsE3A+TwUNioJva0L1OovsVH
3HN/4S5O4bXKf6O14tU+FLWDzh61SmAui8hpOOM6yLusJ/NuULnEYx8PeAp7Nh8K
4p0cXay44zdq47Jlt8fXc7MIhAeV5ofjqJvxj0par/mncrpOk6AonN13Ng8XjqGJ
+8LLs+xOrT0wk5RYAMRIzxn5XALtaquHJDL5sb/Vi3Z4sb7QDA+z6+jeHKqPVLO3
kbRmCAx0uE+yZrRXKlcmXTkP4z0pq0ZPC45zRwFR5iHQXdKQ5nvU1liJD1kE0UgL
5viA8cds+hQNsYhKGQbQMdqztBv/dBE3ZHPZCZRkgsSysrPPX77MJSvJPNMs9v0A
d8v2BZQXBmQqRtwaOc2yvjJ2K/w4uZhS1XOrWMyvir7kKDBgvZc=
=TJWO
-----END PGP SIGNATURE-----
--=-=-=--


--===============5941243146857783418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5941243146857783418==--
