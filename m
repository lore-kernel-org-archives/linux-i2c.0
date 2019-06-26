From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/2] i2c: bcm2835: Move IRQ request after clock code
 in probe
Date: Wed, 26 Jun 2019 15:16:11 +0200
Message-ID: <20190626131611.GD801@ninjato>
References: <20190621105250.19858-1-nh6z@nh6z.net>
 <20190621105250.19858-2-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4776707521702111692=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190621105250.19858-2-nh6z@nh6z.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: f.fainelli@gmail.com, wahrenst@gmx.net, swarren@wwwdotorg.org, team@nwdigitalradio.com, eric@anholt.net, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============4776707521702111692==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2019 at 03:52:49AM -0700, Annaliese McDermond wrote:
> If any of the clock code in the probe fails and returns, the IRQ
> will not be freed.  Moving the IRQ request to last allows it to
> be freed on any errors further up in the probe function.  devm_
> calls can apparently not be used because there are some potential
> race conditions that will arise.
>=20
> Fixes: bebff81fb8b9 ("i2c: bcm2835: Model Divider in CCF")
>=20
> Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>

Applied to for-next, thanks!


--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0TcBsACgkQFA3kzBSg
KbaeQhAAlH5Fv73WNS3Hs724iNcA4HCx+cCQ3SQCuU5Z/VnDG3exwNTaiwW6RsmV
AqMSZyO5B6Pm0Umt5MwzdI9H4dJ2Nf+3HEvUEvqc3fAMbxPguMhf7DhXH29DX89S
5ophbbmY6rD/7WCpjvJPFGvgTXgPpKkt9soqI/DJPfnH/Mpf+7uXMwsJk4jjzTIF
po7L4uxY5fH7+swxzUN+YzpSZ8Ao+Cb99ewXfM53gsuzWQEgZnlGREsTpSyt891f
DKy9SDZ5XVyDl3c+P8UOmpC/PrHc7fTp3szyuW9/GnrcpNh+3edmSSg6d0GoBJ5+
0KK9efwCE/2HRcGNJIUIuI2xgjWnnkd0QZavB1D9MDe16XS5K4m62zUZEbP78BXU
DQPUHgZKa31ZamIRDT6qaJR+e6voPhEsV5hJMwCuKi48LzxM+Sf67C5uYzaf/ive
9PSgOUMZwEliQ7CDW+7+7SlB5KWcTHjRZgz9mbtZ7hP9auFGdtR54Hxi4P4Y6gie
HIiwoRsMHi8AyynqZh4jfCXeJHEevkYdvxEDJND2byqm/BtD2iEOmQNdtbKeTiFq
6ajSpPdf0PBNMY8BarAKuPg4I/HIKtxm4Co8jI+OJ+FwziBE2mTmTZtC6MU8GhrK
BBJogbQMrTmA61902d1JpACGuplHEZ35eD3nAKRG5A0i3CrUGMU=
=8z//
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--


--===============4776707521702111692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4776707521702111692==--
