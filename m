From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v9 0/3] ARM: mediatek: Add driver for Mediatek I2C
Date: Sun, 24 May 2015 19:38:43 +0200
Message-ID: <20150524173843.GA4162@schokonusskuchen.bad>
References: <1432198410-6576-1-git-send-email-eddie.huang@mediatek.com>
 <CAGS+omB7UMrEdZiJXVK78ENEqH6fL_25-Q5Fj1Z0Buzjwp60JA@mail.gmail.com>
 <1432483752.8089.10.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432483752.8089.10.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, srv_heupstream@mediatek.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Xudong Chen <xudong.chen@mediatek.com>, Liguo Zhang <liguo.zhang@mediatek.com>, Linux I2C <linux-i2c@vger.kernel.org>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This series already reviewed in public more than six months. In the
> early version, 8173 CCF and Pinctrl not be accepted yet, so we don't put
> device node with this series. Now both CCF and pinctrl have been
> accepted, maybe it's time to add device node.I am glad that if this I2C
> version can be accepted, If not, I will send new series with device node
> in next round.

I think this is good to go. Further changes should probably done as
incremental patches. I am just waiting a little so people can add tags
to the patches.


--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVYgyjAAoJEBQN5MwUoCm2isoQAIrRCy8zxHQKvCHAFX+89TP+
kjXxD0LEj8/fOxeV43d8iDLgGfARRVEujuTV5k7PzHEaWC9++W42QSFRGyJmdGWb
CjSyPyEEoMQn3k7aHTMi/g0X+koY5/CFZlcVu5RkThBRo25kSG0mY8qxbEDq9QjB
Am6PomlUceWWo3AeAuGg9cfsJ5cPAWYRhyfiGjqfqBrmCEspb5cjckVJdRk7iiQ+
h3ioCMUM1J5A1+QOP7bKQ5R5sqgYi9ae5vBVq0jLKHqJSruYDZdrnXJm0cHtPoQX
I278RpGPAS4GPb4MJPhXBZQlXpZzVaZfaRKZrOdpNTE7rzH0sevARAMcwVYF0e38
Ca9YQrkBa5eELb4UAIUOcWfpAx7woalKGpUtx7Giu1LgekYqO5YgdI1eQiSzStP+
0EnP03pk2VNTZJ7TsbVWJgbElAF2xIWmAhlHfv9EZw4ZJ63C1d0CqOOt2JGAUtmF
8J8hWwioTJPLF5X8ZpYkcSMtVTX+RhyZ7pcVHVQlIF3dDwztSShwHF/a7GxY5aTL
iHVD3BX8FclBhSp0rngYaoZCY6Z0wlhY6POUFFArjPbN80slTa+KiEiJDfJAtPkA
8Q4K3wTaaz9DhQLN1jjuYUhh22ibbWiRAJvUXUzCrpC7QHXTxEIGK3oErD3xV+36
UQQZUbxsCD64jL4EhHUn
=+Yol
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
