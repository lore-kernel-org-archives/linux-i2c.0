From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: Add default configuration into the Nomadik I2C driver
Date: Mon, 6 Aug 2012 13:23:13 +0200
Message-ID: <CACRpkdZRCJXFGAVaD2eFWDhRX_=1G=MzDp=-PB6C3HKUpqkkWA@mail.gmail.com>
References: <1344243146-6598-1-git-send-email-linus.walleij@stericsson.com>
	<20120806102151.GB16996@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120806102151.GB16996-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "Cc:" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 6, 2012 at 12:21 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Date: Mon, 6 Aug 2012 11:04:14 +0100
> Subject: [PATCH 1/1] i2c: Add default configuration into the Nomadik I2C
>  driver.
>
> At this moment in time there is only one known configuration for the
> Nomadik I2C driver. By not holding that configuration in the driver
> adds some unnecessary overhead in platform code. The configuration
> as already been removed from platform code, this patch checks for any
> over-riding configurations. If there aren't any, the default is used.
>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Ah, I created my own solution for this as well by reverting back
some platform data.

This works too, but the patch does not apply to v3.6-rc1.
Please rebase and repost, then you can add my
Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Please not that you need to send I2C patches for embedded
to Wolfram Sang.

Wolfram, please pick this for the -rc series because it's a regression
in v3.6-rc1.

Yours,
Linus Walleij
