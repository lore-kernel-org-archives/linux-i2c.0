From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/2 V2] MXS: Set I2C timing registers for mxs-i2c
Date: Sat, 9 Jun 2012 15:10:31 +0200
Message-ID: <201206091510.31232.marex@denx.de>
References: <1339181689-22573-1-git-send-email-marex@denx.de> <201206091234.47309.marex@denx.de> <CAM=Q2cvvwXimLY358ET69U6qCsGoxenYMNtApYbhpn4cCC0nUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM=Q2cvvwXimLY358ET69U6qCsGoxenYMNtApYbhpn4cCC0nUg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Shubhrajyoti Datta,

> >> > +struct mxs_i2c_speed_config {
> >> > +       uint32_t        timing0;
> >> > +       uint32_t        timing1;
> >> > +       uint32_t        timing2;
> >> > +};
> >> > +
> >> > +const struct mxs_i2c_speed_config mxs_i2c_95kHz_config = {
> >> 
> >> You are using 95k?
> > 
> > Yes
> > 
> >> Didnt understand this.
> > 
> > What exactly, it's running (according to the datasheet) at 95kHz.
> 
> Did you intend 100k?

I intended to stick with the datasheet, if you manage to find explanation for 
why they chose 95kHz, I'd be interested to hear it ... btw. 24MHz/95kHz gives 
pretty weird divider, which is quite suspicious.

> and approximating due to clock ... or some other limitaion?

Doesn't seem to be the case, see "btw" part above.

> That is what I was trying to understand.
> 
> >> > +       .timing0        = 0x00780030,
> >> > +       .timing1        = 0x00800030,
> >> > +       .timing2        = 0x0015000d,
> >> > +};

Best regards,
Marek Vasut
