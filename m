From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: Handle i2c DMA failure properly
Date: Fri, 16 Nov 2012 15:16:24 +0100
Message-ID: <20121116141624.GF7313@pengutronix.de>
References: <1352903508-18113-1-git-send-email-marex@denx.de>
 <CAOMZO5AVDXeu59ZwB35k_0yYx5XwTzdmtj+QXXEoQRMs7Br-KA@mail.gmail.com>
 <201211141622.22161.marex@denx.de>
 <CANqk_c-f3+a=f1QqWFxEpGcMQRqMD61eHiXNLyfzciJkzPGMRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ls2Gy6y7jbHLe9Od"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CANqk_c-f3+a=f1QqWFxEpGcMQRqMD61eHiXNLyfzciJkzPGMRA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Michals <tcmichals-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Tim,

On Wed, Nov 14, 2012 at 09:34:27PM -0600, Tim Michals wrote:
>    This patch
>    =EF=BF=BD@@ -150,8 +150,6 @@ static void mxs_i2c_reset(struct mxs_i2c
>    =EF=BF=BD       writel(i2c->speed->timing2, i2c->regs + MXS_I2C_TIMING=
2);
>    =EF=BF=BD
>    =EF=BF=BD       writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL=
1_SET);
>    -
>    -       dmaengine_terminate_all(i2c->dmach);
>    =EF=BF=BD}=EF=BF=BD=EF=BF=BD
>    This patch fixes current DMA requests which time out or error returned=
 by
>    the ISR.=EF=BF=BD
>    Tim

Please elaborate because I am confused. Did you see problems after
applying Marek's patch and if so, please describe in what circumstances
so we could reproduce.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Ls2Gy6y7jbHLe9Od
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCmSrgACgkQD27XaX1/VRuPqwCdFWR82Dd7s0B7D9SzxWA5J4tz
W30Ani5I50QDfPFQWjnngrNHFXdSl9cE
=MFxn
-----END PGP SIGNATURE-----

--Ls2Gy6y7jbHLe9Od--
