From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: mxs: Do not disable the I2C SMBus quick mode
Date: Mon, 19 Nov 2012 21:02:34 +0100
Message-ID: <201211192102.35055.marex@denx.de>
References: <1353216308-7338-1-git-send-email-marex@denx.de> <201211191913.20938.marex@denx.de> <CANqk_c9xk6mtiA5NpvoLy3bSdKPhF7yAUWfe_rRefZLMeOeHNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANqk_c9xk6mtiA5NpvoLy3bSdKPhF7yAUWfe_rRefZLMeOeHNQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Michals <tcmichals-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Tim Michals,

[...]

> > The register layout differs. You might want to check if all the register
> > programing is correct. Make sure the placement of various bits is
> > correct. Also
> > see how the DMA operates with the transfer length on MX23 and MX28 ...
> > there are
> > quite a few differences and I didn't test the driver on MX23 like that. I
> > recall
> > someone testing it on a different MX23 board but only by some "standard"
> > usage.
> 
> OK, will report back in a couple of weeks due holidays and current
> assignment load.

Ok, it might be better to apply these as they actually fix it on MX28 until you 
have a proper fix ready. We don't officially support MX23 with this driver 
anyway.

Best regards,
Marek Vasut
