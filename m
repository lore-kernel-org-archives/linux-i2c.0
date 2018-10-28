From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1 3/3] i2c: imx: don't print error if DMA is not
 configured
Date: Sun, 28 Oct 2018 22:11:24 +0000
Message-ID: <20181028221123.GE1882@kunai>
References: <20181018112615.29362-1-o.rempel@pengutronix.de>
 <20181018112615.29362-4-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3621030605916531936=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181018112615.29362-4-o.rempel@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org, NXP Linux Team <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org


--===============3621030605916531936==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Content-Disposition: inline


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 01:26:15PM +0200, Oleksij Rempel wrote:
> At least on i.MX5x variants is DMA event for I2C muxed with SDHC. So
> it is project specific configuration and not an error.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

So, the first patch is not I2C realm, and the second is dropped. No
comment about the third one?

And is maybe someone from Pengutronix interested in maintaining this
driver? Uwe maybe? That would speed up things for it...


--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvWNAsACgkQFA3kzBSg
KbYVEA/+L+prOst9klRsesCQYQHMFGxETDe3+vkfW55f8xX3aJarLzrsYe4HJGJO
JSwkss53xFUTfCAaAgfOY8zl1mkAZGC6hXS95sYWZMKVggKvI9DbVBZtSk66yeAC
xVh/qjNWHh4p0hA5gAzTZvGZXEdbDj81n/dDRln4Le1EbNa3fV0yZ/a/8oR2+4ok
MfLW3Ffjxxm0dPzTCKXe4L+fyVPklA71pZnifm6CmTqgA67BvHazLYhzybQZ5RLR
FiRyTLhlWySE+ZABNUu2gcKnUxRr0V6F8CDSa9Me37ckmezYxpS8tzekoGbP+9PN
Wg/EK8k/aruZpufImUhaZmGt1e6vi21Ms4dr2PJS6llS0MF3nVdF2qgLALgKhNyU
craYp99r/xzWqTh1f4dCBJPaAHYuwDZN9qlCVd2eF+8sL8jAnRuBv7gf511qbez5
UEutdTge5XKydA9k32wJRW8njItGyeoO2owCf0nfCjVb3sk4T1rdGJo47dT7+2Qs
tUrp6n+REnsxP1520DxmYeW/xgfxN0Tr0dr/32oOT0BTI6x/47gJWb6RI0Twxg/S
wLfdsXeqZoIQ0DkyaTxz05ZnYX0m/cwyku2KfF5HBxLy/bpgDwQH2Z3coz3caK7O
J1EkxLTSMKezmX8wV5BaZFHPh56isWv+dPBgFsMkAxUGmXOjIYs=
=qihK
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--


--===============3621030605916531936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3621030605916531936==--
