From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c/nomadik: runtime PM support
Date: Thu, 19 Apr 2012 19:07:09 +0200
Message-ID: <CACRpkdbfO3SKeDE8cRCy01opdfUURYG6_7mDZkbRjKhUVU1e1A@mail.gmail.com>
References: <1331213407-10135-1-git-send-email-linus.walleij@stericsson.com>
	<CACRpkdbQRB37kYfCwn6+xUxBkVVo9f3RwUk5pstVPcfK8bivZw@mail.gmail.com>
	<CACRpkdafU2Awaxx-2dXT_Z8S+dySx6YoV174rxJvdix81TBBpg@mail.gmail.com>
	<20120417143901.GA22406@pengutronix.de>
	<CANqRtoTbW2ew9ZwYmdJAaiD5qujZ-43eCfT=myDQdeYScwiBzQ@mail.gmail.com>
	<20120419111635.GE2206@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120419111635.GE2206-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Apr 19, 2012 at 1:16 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:

> I take this as a not-NACK ;) I don't want to dive too much into the
> nomadik power management as well, so I will trust the authors here.
> Since the driver is only used on this platform, I guess a different PM
> strategy can be fix later if needed.
>
> Linus, can you resend the patch another time, please?

I think I have second thoughts about this now, after talking to
some smart people. The base problem is that the I2C "regulator"
in this driver is a voltage domain and this should be handled by
power domains instead. (Some pain about that recently...)

So now I think we should remove the regulator handling
altogether, keep clk handling (which is currently distributed) and
respin on top of that.

Yours,
Linus Walleij
