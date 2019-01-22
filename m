From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH -next] i2c: imx: Fix inconsistent IS_ERR and PTR_ERR in
 i2c_imx_dma_request()
Date: Tue, 22 Jan 2019 23:49:58 +0100
Message-ID: <20190122224958.fhui4wsbxkwlyq3v@ninjato>
References: <1547694894-69589-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2945236924282958945=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1547694894-69589-1-git-send-email-yuehaibing@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: eha@deif.com, s.hauer@pengutronix.de, kernel-janitors@vger.kernel.org, linux@rempel-privat.de, linux-i2c@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-imx@nxp.com, kernel@pengutronix.de, u.kleine-koenig@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org, peda@axentia.se, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
List-Id: linux-i2c@vger.kernel.org


--===============2945236924282958945==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vaiyalpw7x7el7e5"
Content-Disposition: inline


--vaiyalpw7x7el7e5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 03:14:54AM +0000, YueHaibing wrote:
> Change the call to PTR_ERR to access the value just tested by IS_ERR.
>=20
> Fixes: 5b3a23a3cc94 ("i2c: imx: notify about real errors on dma i2c_imx_d=
ma_request")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to for-next, thanks!


--vaiyalpw7x7el7e5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxHnhIACgkQFA3kzBSg
Kba3ig//USjhYGdbn997HGFCPU0owSFvWUiISdShBXFggJlrezFhcdHVv9YuunYJ
lB+DGLl/khc+mqy6I0F5nlWClgsoOgdx3OUVjLZYSN7D9MYtSSAsJjhbvXzYpXxV
xd8aIIpl5VVqZgUxH1O9yFiBfGXRLRsb5xrcN4gdcqk+f52+LLgrmaXmXWIX/6mB
KIHVJdH0Ux0xyRvFNuVZphWLbEu27GYg/g54nEDaa4wN3h7nngjdXVXUSMQ0aNUQ
OcNZC9KJl0gCo5GZUciJlWa+Hvw2GYXa+7Q2tmC+4d2rIEnwStkeB6IbX+XOgGTR
rtmQK5RpzeUFoIrN359t4rxMPbJhUAeOIqtr2XhNR8Y9SoaxP3qZEjO+DhneeTiC
A6pg4uIiyDS56Yz3hHX9P7jHxlox3d8C8hylu83ZYoUS2tSmQzfeHB6XT9HEtS6S
K9kQ/jbvBrjn8wMnYEQwXdas2BTBX56i4k4odVbyFjOzeC66msJjP9p6rJe45H94
y75RdycNL+rs2bmAzSXUsWpHnwJ9v5/rcII7lEffJpz83BqQKYZbk39p4BM5u/q7
Gn48ttNYe4gIb929l7kY1PRB0J8YJhfjbc/EdQjtTQiIzWOj8PGjK3P5pDoZPUfS
lO5Iuzg8ksPCLtAsGa6YeAO3RzGJNd8gBxs54DOnOYb4+xodJCQ=
=UEXE
-----END PGP SIGNATURE-----

--vaiyalpw7x7el7e5--


--===============2945236924282958945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2945236924282958945==--
