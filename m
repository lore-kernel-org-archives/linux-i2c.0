From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v1 2/3] i2c: imx: probe dma only only on i.MX50 and later.
Date: Fri, 19 Oct 2018 12:17:03 +0200
Message-ID: <20181019101703.qmgljhldymq3xtj3@pengutronix.de>
References: <20181018112615.29362-1-o.rempel@pengutronix.de>
 <20181018112615.29362-3-o.rempel@pengutronix.de>
 <20181019071243.t5bwcmnnlqrgtajj@pengutronix.de>
 <20181019090100.6vcergf6txgxt7fo@pengutronix.de>
 <20181019092145.6zihrnduyypzo5x2@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9207950894810238720=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181019092145.6zihrnduyypzo5x2@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org, NXP Linux Team <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org


--===============9207950894810238720==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mibcikfkof3hn62k"
Content-Disposition: inline


--mibcikfkof3hn62k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2018 at 11:21:45AM +0200, Uwe Kleine-K=F6nig wrote:
> On Fri, Oct 19, 2018 at 11:01:00AM +0200, Oleksij Rempel wrote:
> > On Fri, Oct 19, 2018 at 09:12:43AM +0200, Uwe Kleine-K=F6nig wrote:
> > > Hello Oleksij,
> > >=20
> > > On Thu, Oct 18, 2018 at 01:26:14PM +0200, Oleksij Rempel wrote:
> > > > The DMA support for I2C was introduced on i.MX50. So,
> > > > avoid of DMA probing on not supported versions.
> > >=20
> > > What is the obvious downside of trying to use DMA on i.MX21? If the
> > > purpose is just to suppress the message
> > >=20
> > > 	can't request DMA tx channel
> > >=20
> > > , that goes away with patch 3, too.
> > >=20
> > > Note that if we agree that i.MX50 (and later) isn't compatible to
> > > i.MX21, all device trees should be fixed accordingly. IMHO the
> > > difference "There is a DMA engine connected only on some
> > > implementations" doesn't give enough incentive to claim that i.MX21 a=
nd
> > > i.MX50 must not share the compatible.
> >=20
> > I don't see any sense to do allocation and add extra probes just to find
> > what we already know from compatible.
>=20
> I think it's perfectly fine to only notice that there is no DMA support
> when trying to set it up. It has slight runtime overhead, yes, but being
> able to handle imx21 and imx50 in the same way is a nice advantage that
> I don't want to throw away easily.
>=20
> If you care about the allocation, you can do do the calls to
> dma_request_chan first and assign to local variables before the
> allocation of *dma.

Ok, then we can drop this patch.

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--mibcikfkof3hn62k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlvJrxUACgkQdQOiSHVI
77QXAwgAj78EfTt4efZDEp+YavsSBAb2yL4yflgAHlwVzxKwBfZKeg0UQHhk8Kll
HY+BjbxTMhanoec809WINAS504CGMLklg6nwEmc3YtvKAIcPyp76p2gJDb4GbMKj
KyTYrc4Z5VL6GiZFBrcnXxP4nLhHKbtLStqN3l6Ca5ZGT5J1/aypjEwicJZt5pAy
/sTyR9J3j+8ydXk0n6aFfRt0Q0y3lnCCDkfXM2vlLwgi6C7aT+Ho27+JCQE4lO5A
dAQHmWAuxvfYOyRFrIv4Lnu0HEGx2W29J45Eu8biQW/jxmQd+graUJUYCv+Bj5gr
YSMLfBmKppTBHM+uW3V4bPZz+j+PDA==
=siPD
-----END PGP SIGNATURE-----

--mibcikfkof3hn62k--


--===============9207950894810238720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9207950894810238720==--
