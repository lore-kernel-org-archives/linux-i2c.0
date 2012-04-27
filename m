From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: disable QUEUE when sending is done
Date: Fri, 27 Apr 2012 11:51:56 -0300
Message-ID: <CAOMZO5A1_Z7T5md61OJWmXbx2qCjFEByjyGvjhxqhfxzwfLEVQ@mail.gmail.com>
References: <1335536631-28202-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335536631-28202-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Fri, Apr 27, 2012 at 11:23 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> =
wrote:

> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (i2c->cmd_err =3D=3D -ENXIO)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mxs_i2c_reset(=
i2c);
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(MXS_I2C_QUE=
UECTRL_QUEUE_RUN,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c->regs + MXS_I2C_QUEUECTRL_CLR);

When setting the QUEUE_RUN, do we really want to clear all the other
bits of QUEUECTRL_CLR register?

I am wondering if we should only set QUEUE_RUN bit here.

My mx28evk does not come with i2c eeprom. I hope I will solder one
soon so I can test it.

Thanks,

=46abio Estevam
