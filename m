From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: disable QUEUE when sending is done
Date: Sat, 28 Apr 2012 15:33:35 +0200
Message-ID: <201204281533.35277.marex@denx.de>
References: <1335536631-28202-1-git-send-email-w.sang@pengutronix.de> <CAOMZO5A1_Z7T5md61OJWmXbx2qCjFEByjyGvjhxqhfxzwfLEVQ@mail.gmail.com> <20120428102601.GO20039@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120428102601.GO20039-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Uwe Kleine-K=F6nig,

> On Fri, Apr 27, 2012 at 11:51:56AM -0300, Fabio Estevam wrote:
> > Hi Wolfram,
> >=20
> > On Fri, Apr 27, 2012 at 11:23 AM, Wolfram Sang <w.sang@pengutronix.=
de>=20
wrote:
> > >        if (i2c->cmd_err =3D=3D -ENXIO)
> > >                mxs_i2c_reset(i2c);
> > > +       else
> > > +               writel(MXS_I2C_QUEUECTRL_QUEUE_RUN,
> > > +                               i2c->regs + MXS_I2C_QUEUECTRL_CLR=
);
> >=20
> > When setting the QUEUE_RUN, do we really want to clear all the othe=
r
> > bits of QUEUECTRL_CLR register?
> >=20
> > I am wondering if we should only set QUEUE_RUN bit here.
>=20
> I didn't check the manual, but I guess writing to MXS_I2C_QUEUECTRL_C=
LR
> just clears the QUEUE_RUN bit and nothing else?!

I think the RUN bit will be cleared by the controller anyway, so this p=
atch is=20
pointless.

>=20
> Best regards
> Uwe

Best regards,
Marek Vasut
