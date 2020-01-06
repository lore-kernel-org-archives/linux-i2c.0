From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: bcm2835: Store pointer to bus clock
Date: Mon, 6 Jan 2020 15:52:34 +0100
Message-ID: <20200106145234.GK1290@ninjato>
References: <1578150800-8284-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4255348068685055134=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1578150800-8284-1-git-send-email-wahrenst@gmx.net>
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
Cc: Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--===============4255348068685055134==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HBg0C3yr6HVa1ZCc"
Content-Disposition: inline


--HBg0C3yr6HVa1ZCc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 04, 2020 at 04:13:20PM +0100, Stefan Wahren wrote:
> The commit bebff81fb8b9 ("i2c: bcm2835: Model Divider in CCF") introduced
> a NULL pointer dereference on driver unload. It seems that we can't fetch
> the bus clock via devm_clk_get in bcm2835_i2c_remove. As an alternative
> approach store a pointer to the bus clock in the private driver structure.
>=20
> Fixes: bebff81fb8b9 ("i2c: bcm2835: Model Divider in CCF")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Applied to for-current, thanks!


--HBg0C3yr6HVa1ZCc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl4TSbIACgkQFA3kzBSg
KbaxWw//WW0ZnyXB1Lcp1LObsRnDob5upLCtOBfS+j2zAWlFKsQc66oz/3q84bn7
jwv+pQ7HkLcgDiSy92VdUDvUxeAi/jxP3lg6oIWbuQFMAmw5+aZymPnUZBe/Jh2x
4/8iQtBLSP8BH9sNbBJrwFkagGCXQbz3crj7nLRMua+/JbAsqLzv7P26IpRHSxQb
32p5Yf4ktRX1WVta3N/vPC/cH4bNURXm+QfHDO45FeN8BWNyGGoL/G6l4Mik3gYm
z0s+Xjmq19hVqB9XGeq+k5wlP1yC/TMWCTL2XkiqXmZE3qpl506BU1y7aEfu8n2P
a2dDsqNg26qQsKh4ZO8dkjCk3uYJOOXYjwqtaBVsZKu5gBNVo8rhkbZlFYOJFVU7
SCR9hWwwmIHDB58NMeLfoXx53KXnwf+H7ChK9aZmI65fh4IqiFvnioRGr16xRjEs
I42Mtpf6cNBzLGKXQOILS3glNQ9X42BmC4c7O+TIe4Q/iT3Ssz06BKnEu30d+nM3
3Guvk1AYKRPch5MwJlguJPOQG0N2lCFajnqyuJyy9mX0225XlT6QamMLSNpbeUnO
km/mECaTFd0q3uCWuZBs8vjuTuv9O0CNsv4ACpGt/UbzzaPTpi0CvqLJPwTAbNHG
XLDPWBT8LjymYAqfppwgjSZd/NWXfCpPEiIu/rQg8k7m1nxUAXY=
=Ixd3
-----END PGP SIGNATURE-----

--HBg0C3yr6HVa1ZCc--


--===============4255348068685055134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4255348068685055134==--
