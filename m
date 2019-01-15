From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 2/2] i2c: imx: improve the error handling in
 i2c_imx_dma_request()
Date: Tue, 15 Jan 2019 22:54:49 +0100
Message-ID: <20190115215449.vm7u5zyhtjzz2ovo@ninjato>
References: <20190109055650.32259-1-o.rempel@pengutronix.de>
 <20190109055650.32259-3-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7496490799210449605=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190109055650.32259-3-o.rempel@pengutronix.de>
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


--===============7496490799210449605==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6sutkt7n3bvq2ygo"
Content-Disposition: inline


--6sutkt7n3bvq2ygo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 06:56:50AM +0100, Oleksij Rempel wrote:
> Improve the error handling in i2c_imx_dma_request() and let it return an =
error
> indication that the caller then can handle accordingly.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Applied to for-next, thanks!


--6sutkt7n3bvq2ygo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw+VqkACgkQFA3kzBSg
KbbIxhAApWTw1dmnUjsQLwlxrSG2VHCnt2SaZO5TOp35uR2UuirlZm73z+B6oZEG
S8Q+Utcg8BfMiZiueeEvIXFp/Ovomq3e+DZKv8382sYyh+v1CwNVMXU580JKLllX
V6qEsaGTOc166N+Tz1v4mCnEewRptcegwvXjdjwo/iJugEiWj9N702KrORwOrCi+
jne0bBI6Ug8hEXo65VyBh5uCadhCS3C41FzuHRL0mnFKZFq9WcrU7XsucoYRLom+
/OKtOiYeM7RM2+dNYFW/ttSAWTdloIiahXBf4MzhX9558Gw4RZH8ScySxJJ5JXLg
z3RjDCF66GWoT/5TSWe8Rz7/F9FvmHZQDUyykXEHThKNjfSgNALsN1dy5popx53b
/HcGz6oA/8aXBHJi/41Bh+1js2sbFVef1Fug5g8evVMRve8d5DflkAiJiWmyu133
sgTvfQ4g6fWpwuYGl3J1XdYW3b8HZ9bIzuOJ3OmiKSCDk0Z6Ef1D01SLtJI27ETg
WNP8ajAakqkODm0XIUQjJDQxzrkYunT5MAQ8K/wBPAyiueFa9QCrk457IlNXKv+Q
/G2bVjNzp1jjbhw1HzunertH+u69MTFWcsbtfOFGqbvqRpKxbvjrF+aYC9ZjQGKS
o6thGb4Pk0KXdozWC0NBtCibhhGUFmXOyjWTbdY+Vx6jTDtaYss=
=Mw6t
-----END PGP SIGNATURE-----

--6sutkt7n3bvq2ygo--


--===============7496490799210449605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7496490799210449605==--
