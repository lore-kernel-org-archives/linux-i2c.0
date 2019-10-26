From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH RFC] i2c: bcm2835: Store pointer to bus clock
Date: Sat, 26 Oct 2019 17:33:15 +0200
Message-ID: <20191026153314.GA5137@kunai>
References: <1572093288-6223-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7678244681165576323=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1572093288-6223-1-git-send-email-wahrenst@gmx.net>
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
Cc: Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Annaliese McDermond <nh6z@nh6z.net>, Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============7678244681165576323==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> a NULL pointer dereference on driver unload. It seems that we can't fetch
> the bus clock via devm_clk_get in bcm2835_i2c_remove. As an alternative

Uh, yes, devm_* doesn't make sense in a remove function. We could
probably use plain clk_get/put here, but a pointer seems fine, too.



--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl20ZzYACgkQFA3kzBSg
KbakVA/+K2R/9SirG2DNayuOk52DPILr/uDihZvMo7UkD0EyCWhk+q/hJSTAZZD9
+cgGElLwuKJ6egXWaUuN9rgEIsjRU7kfnuBAf6lstPeLUWBJM8Xzl7OprTKVX0FH
hGXR86MehWVEfAcAvTOKYrDAB2jTuwTiYasdQmF2jHipgdN8gOl5NRErGBfWPApq
ICAr4I7PuwOrRqT8cXyX5j7A1USDx4GBa1424aygQ892SLc+r5chSmlEvGOxQZ40
QRxdVhGlHDWvO5C/kvppVvKxI/BwQN2mQ9el/bkkFBEYuqKC0bv1aMkAAothWRP2
o0yNRQcqz4aZv07ve/RuyMxQyFXJMjIutHs72SwiHhlpVNxIg2PiyEYDx02wS36v
ZTLnMnZWfYIEHmTkpyzgcZh12WKWpCSUmDWuJCofslPadCXhxWYYt6GNMr1oEeac
4HbSW28ngj1zM8buQRQPt1bgGfFNcVLHi8uZqAzi9vfBBIo/mFF3d44adxB/h1JN
BfYCcVODBDYABWIAAKLstydW7LLy5EjgpOQLe+DHb7+XjRKsU0VkVARCsGSDcSd1
TkRuGJCYaF0cJ2cW/k1MnROE9C+W6M2fAZJfrWB8gOO0EmWMsSeMt5GzaARjTUq0
1iBLQYhmi+SQNUHL882J8mrGY+95bdXJk06S9WVtChiai3GRdJM=
=xaw5
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--


--===============7678244681165576323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7678244681165576323==--
