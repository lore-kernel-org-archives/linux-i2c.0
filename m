From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v3 2/2] i2c: imx:
 Add Vybrid VF610 I2C controller support
Date: Thu, 15 Aug 2013 11:48:52 +0200
Message-ID: <20130815094850.GB2987@katana>
References: <1375418648-22760-1-git-send-email-b35083@freescale.com>
 <1375418648-22760-2-git-send-email-b35083@freescale.com>
 <20130810140827.GC18085@e106331-lin.cambridge.arm.com>
 <B56CDBE15CE27145A4B77D2D24263E851FE7AC@039-SN1MPN1-004.039d.mgd.msft.net>
 <20130812164354.GF27165@e106331-lin.cambridge.arm.com>
 <52096E77.4040003@wwwdotorg.org>
 <20130813074620.GR26614@pengutronix.de>
 <520A5558.708@wwwdotorg.org>
 <20130813161214.GV26614@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130813161214.GV26614-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lu Jingchang-B35083 <B35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Estevam Fabio-R49496 <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Li Xiaochun-B41219 <B41219-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jin Zhengxiong-R64188 <R64188-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, pawel.moll-5wv7dgnIgG8@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I vote for having the exact SoC revision in the binding documentation
> rather than wildcards or references to the list of i.MX SoCs. Otherwise
> only the driver code gives a clue that the i2c driver matches imx1-i2c,
> imx21-i2c and vf610-i2c, but not imx31-i2c.

Dunno if I got all right, so adding my 2 cents:

Yes to adding each SoC to the binding docs. No to adding each SoC to the
driver as a seperate 'compatible' entry if not really needed to
distinguish IP versions. I mean imx31 should have two compatible entries
anyhow, one for imx31 and one for imx21 as fallback, no?

That all being said: Unless somebody objects, I'll pick the most recent
VF610 series today and leave the doc fixup for later.

Thanks,

   Wolfram


--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDKQBAAoJEBQN5MwUoCm2Zs4P/i9K2jTiSgBDOAes1VhUzxVz
tOTudzkYPCzp+LP4AWe6sc+cJxnnC3sQOlNPRNr9ecrZw1MfC3PvDX43lr7nd0p2
wuIjPcAnX8RkXTt3nBcGch/BH2xefS1WnQ/0MLhDRxs5SlGGLHBhAlV0KD6Y2aZH
dsS2zinUWM8z4Zr1t9eb0JS+p7wbvH4JuXY5cZMg3zn+KIbfFRtImfJ3kz6Ko/35
GluriBykleQT4z3h3sdAl9OwVCxuvlwBTZ5qX9XsyFFqeRmf7D4NyhlmbP8r7FI7
T8LVIoLKRwoFeg3GFvdRb15L7lI9JEKuTR283qBzsVYU3+BbR4OCv8aFvevG/oty
L6pZAn8AwvIqrahUf2EjShlTYQge/d4rjZmWmkiP2jqpA44KerjmlwPHdfvlOpHk
lkbQAnDeP1b5eZnS5dCe2gWh7bDpzOzdWVJ6gviQckIfaaLPvEzu50L80cTmaFHw
Orn/yc4VEFmE9y00rw8E9+QX/Dy/X2q3KUC4IU23cQQ61f/JfWKlllU2H4n5S7nr
C46xWRO0SoFqJUVngA4+3xCTgxGMmZfcRPQLjkojFm8pqL0A60Yon59v8qyxyN4I
y6G1VK11EQ5YzreV4UUWuBtC7mEkfo16ZPjOCvCl/+TZPCCAwik5GjhHsDjvoP7G
uEwb7O0fxqeGmkq3bE8N
=blSP
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
