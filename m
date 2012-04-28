From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: disable QUEUE when sending is done
Date: Sat, 28 Apr 2012 12:26:01 +0200
Message-ID: <20120428102601.GO20039@pengutronix.de>
References: <1335536631-28202-1-git-send-email-w.sang@pengutronix.de>
 <CAOMZO5A1_Z7T5md61OJWmXbx2qCjFEByjyGvjhxqhfxzwfLEVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5A1_Z7T5md61OJWmXbx2qCjFEByjyGvjhxqhfxzwfLEVQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 27, 2012 at 11:51:56AM -0300, Fabio Estevam wrote:
> Hi Wolfram,
>=20
> On Fri, Apr 27, 2012 at 11:23 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org=
> wrote:
>=20
> > =A0 =A0 =A0 =A0if (i2c->cmd_err =3D=3D -ENXIO)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mxs_i2c_reset(i2c);
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(MXS_I2C_QUEUECTRL_QUEUE_RUN,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->=
regs + MXS_I2C_QUEUECTRL_CLR);
>=20
> When setting the QUEUE_RUN, do we really want to clear all the other
> bits of QUEUECTRL_CLR register?
>=20
> I am wondering if we should only set QUEUE_RUN bit here.
I didn't check the manual, but I guess writing to MXS_I2C_QUEUECTRL_CLR
just clears the QUEUE_RUN bit and nothing else?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
