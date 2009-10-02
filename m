From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c: imx: check busy bit when START/STOP
Date: Fri, 2 Oct 2009 09:26:43 +0200
Message-ID: <20091002072643.GH27039@pengutronix.de>
References: <1254359613-21210-1-git-send-email-linuxzsc@gmail.com> <4e090d470910010103o611d9fb2t3acf93632216fc88@mail.gmail.com> <20091001083831.GD27039@pengutronix.de> <4e090d470910010211k4ce78763i1a5163ec6ea57fe8@mail.gmail.com> <20091001095239.GE27039@pengutronix.de> <4e090d470910010754r1ebc4455u6220ccfd803491b0@mail.gmail.com> <20091001163753.GA20103@pengutronix.de> <4e090d470910011757g261c693ehdca40ce43ebee2ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4e090d470910011757g261c693ehdca40ce43ebee2ec-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 02, 2009 at 08:57:04AM +0800, Richard Zhao wrote:
> On Fri, Oct 2, 2009 at 12:37 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>=
 wrote:
> >> > Ah, so 'make the driver work on i.MX51' is a good statement whic=
h should
> >> > be part of the commit message.
> >> Well, maybe I can mention it.
> >> But I think the good point is to present what you modified, not th=
e side effect.
> >
> > It is not the side effect but the intention :) As no code is change=
d without a
> > need, the reason really should be in the patch description.
> No, it's not intention. I'm just trying to make the controller work i=
n
> a right way. Without this patch, maybe some other fast cpus have
> problem too. I just tested mx31 and mx51. I will add "Without this
> patch, i2c on some fast SoCs (for example imx51) will not work". Is i=
t
> ok for you?

Please remember that we do not have i.MX51 support in mainline, so this
is irrelevant atm.

> >
> >> Yes. But I don't have multi-master system. So I can't say that.
> >> The code is just taken from Freescale latest code. Without it, It
> >> could also cause a device error. I forget the details. =A0Anyway, =
it
> >> doesn't make anything wrong.
> >
> > Do you know where the details are explained?
> No, I don't. I don't have device in hand now. If you have, could you
> please help do a simple test?
> Use hw to simulate multi-master system. Before execute xfer, you firs=
t
> pull down SDA, then pull down SDC. It simulates a START. and execute
> xfer to see whether IBB is set?

No, we won't do any tests on hardware.

At the moment we have a driver which is not multi master capable.
Looking at the datasheet the change you do seems not enough to change
this. So we should take a patch which changes something from which you
think it might be needed? And you don't even have the details at hand?

No.

Sascha

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
