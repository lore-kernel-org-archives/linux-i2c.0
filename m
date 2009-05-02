From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c/chips: move max6875 to drivers/misc/eeprom
Date: Sat, 2 May 2009 09:25:43 +0200
Message-ID: <20090502092543.1ba62972@hyperion.delvare>
References: <1241209409-29378-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1241209409-29378-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Fri,  1 May 2009 22:23:29 +0200, Wolfram Sang wrote:
> This driver only reads the user EEPROM of that chip, so we can move it
> to the eeprom-directory in order to further clean up (and later remove)
> drivers/i2c/chips.

I'm all for it :)

> The Kconfig text was updated to match the current functionality,
> dropping the meanwhile obsoleted parts.
> 
> Defconfigs have been adapted.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
> 
> This is against linus-git of today. Jean, do you think such a patch 
> can make it at this point of the release cycle? It is a bit
> annoying because of all the defconfigs.

Well, not being a bug fix, I believe it will have to wait until the
next merge window. And yes we will have to check all the defconfigs
again right before merging it.

One minor comment:

> --- /dev/null
> +++ b/drivers/misc/eeprom/max6875.c
> @@ -0,0 +1,246 @@
> +/*
> +    max6875.c - driver for MAX6874/MAX6875
> +
> +    Copyright (C) 2005 Ben Gardner <bgardner-ohtLXRgXiI/QT0dZR+AlfA@public.gmane.org>
> +
> +    Based on i2c/chips/eeprom.c

Maybe drop the soon-to-be-removed path from this reference?

Thanks,
-- 
Jean Delvare
