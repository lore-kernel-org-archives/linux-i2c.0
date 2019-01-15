From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 1/2] i2c: imx: notify about real errors on dma
 i2c_imx_dma_request
Date: Tue, 15 Jan 2019 22:54:45 +0100
Message-ID: <20190115215445.rjfio7i6sx62qfh5@ninjato>
References: <20190109055650.32259-1-o.rempel@pengutronix.de>
 <20190109055650.32259-2-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4377716257774821401=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190109055650.32259-2-o.rempel@pengutronix.de>
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


--===============4377716257774821401==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="adxe6fxfy6ffefo3"
Content-Disposition: inline


--adxe6fxfy6ffefo3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 06:56:49AM +0100, Oleksij Rempel wrote:
> At least on i.MX5x, the DMA events for I2C and SDHC use the same channel
> and there can only be a single user. So in this case there should be no
> message emitted that looks like an error if the I2C device doesn't have
> an assigned DMA channel. In contrast real problems that were only
> emitted at debug level before should be described at a higher level
> to be better visible and so understandable.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Applied to for-next, thanks!


--adxe6fxfy6ffefo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw+VqQACgkQFA3kzBSg
KbZYzg/8DX24pwd269Tj7OwNPC1q6F9JhXMMeOaHtaCGHTGv/+DgHszzNjM5GjlP
K7QWmsBHV3voq7ARex2Lpg61DA7jj7VEzYmObya5/Qg7uTF46GV6g/ZdjlWUoXjx
HCUcy55NTRkkELXqGSVZ4nbWtPpr4hGQvze/+lW2x71Wcv8fH9p25zVoW4IkK/uQ
ohk90VCkFQsWtGvaLE+EE+Bt682VYtd84TftdxYBhzPqY//UZ1+eUJ7005A9SzvN
UKZNC5HV00KTa0jAvSvc1ZN1Gwt8LxNfrIbThAqdaOxIIyseMvW9W1BaiMbC/gQD
9xIDcNo9n3goma0/kAR329Q682NWNRLJbBsc0t7g5EjeWL7+xlD4sCbbOI1Ps/Sp
6rm5i+8uxfyRIQIMWNJtp5sbV4gs5gtstqVW5EVEjsLfw4QLyTdCFTJEw1+zbuQS
DEiWfOPQH2gBpO+gg/HG7I0AgwwMeLQHyDSDSWcUVIJq9G6VBL91sMMa/mIdM0ia
cl48mjLAebXonnzL0afpLi6u0sEUiWh1VpM6WRHltNwEjLT09/rw4FDDnoxsdlYz
ceEKwzCvwlf2RSQXyKQC6RsuUTzBRVcfgIE4h8L5kzwkCJ/x+nOiB3EFQ/HIJk5E
m/rrKjGWf/G6P6YUsBCOPKF3F3x64Qv3o8qvUVyU6lxhXwNBt9k=
=GeoI
-----END PGP SIGNATURE-----

--adxe6fxfy6ffefo3--


--===============4377716257774821401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4377716257774821401==--
