From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1 3/3] i2c: imx: don't print error if DMA is not
 configured
Date: Mon, 29 Oct 2018 08:54:08 +0000
Message-ID: <20181029085408.GB4101@kunai>
References: <20181018112615.29362-1-o.rempel@pengutronix.de>
 <20181018112615.29362-4-o.rempel@pengutronix.de>
 <20181028221123.GE1882@kunai>
 <9a3fc087-2fe5-6d57-9b65-a05e176bf53d@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7681714518082318579=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <9a3fc087-2fe5-6d57-9b65-a05e176bf53d@pengutronix.de>
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


--===============7681714518082318579==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2018 at 09:07:56AM +0100, Oleksij Rempel wrote:
>=20
>=20
> On 28.10.18 23:11, Wolfram Sang wrote:
> > On Thu, Oct 18, 2018 at 01:26:15PM +0200, Oleksij Rempel wrote:
> > > At least on i.MX5x variants is DMA event for I2C muxed with SDHC. So
> > > it is project specific configuration and not an error.
> > >=20
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> >=20
> > So, the first patch is not I2C realm, and the second is dropped. No
> > comment about the third one?
> >=20
> > And is maybe someone from Pengutronix interested in maintaining this
> > driver? Uwe maybe? That would speed up things for it...
>=20
> Should i resend it as single patch?

I am fine with an ack here.


--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvWyq8ACgkQFA3kzBSg
Kbba8xAAqQ6UIuiXXX0qTxzHxJvIIeihnMv3DIOXuIhRD9uPXgXpyr25o/Oc7LQ6
J7hwTXF7H/BBYZc092v7cSKuAeTcjNM5zcYB8TFGRzmA1XD/tDNqA8E2OT+Nr2R4
2d8BwtCSH2C9cONVjQskkQ8ZSsnK/ZXa11Fydk9RuQitlKN4W6tavXzBspCd94we
P1E5nDo7IwZPaUb/NsBvddeH+YL2XVC9R6a9AhB8AgutybF/Bpi2Mn8d4bT031mv
7gV7IkOO4GOa2RPN5bQr9HgGHoFCdKfbRWmHSEqbal4vpgrtRtkZ5TSB2EhYcLQU
/553niIjoy/f2ER9SvPXKz+5xsWwn9NEdHlW4f9sq5TBmOY6ORPuCDm3VqSDfSm3
ebvoIgDLcH3V738/nlbeW83gwiDISUgcuWjWKjQkVWv7aZIMVB7uOmN4/IcbEglK
hFgzixpLafewJ/syQMQ4pBQ2BxaZJd0bjqBM2ZW4J5Jf5d5Vfv/cH0OEnSLRIEk6
XS47axoAtd7qVbpzJa7ijPN+zBsOGIbTXhMi8n51GGPs2DIJf0jHJ9AS3rS+GK0A
Gk+quyuz/8qFRI8QZG3JX9JzO1EccMO9cdVgM+HDruK/BlfMaHhydkQ9QzpRiYy9
xnmJ9KMZhX6lk8MyXoSWwDffQOIXQJTNLyPLXMeO37LzKxlFY0Q=
=JfI2
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--


--===============7681714518082318579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7681714518082318579==--
