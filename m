From: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Subject: Re: [PATCH] driver/i2c/mux: Add register based mux i2c-mux-reg
Date: Wed, 17 Jun 2015 10:54:04 +0200
Message-ID: <1434531244.2069.111.camel@x220>
References: <1434475692-4611-1-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434475692-4611-1-git-send-email-yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

A nit and a question follow.

On Tue, 2015-06-16 at 10:28 -0700, York Sun wrote:
> --- /dev/null
> +++ b/drivers/i2c/muxes/i2c-mux-reg.c

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

This states the license is GPL v2.

> +MODULE_LICENSE("GPL");

According to include/linux/module.h this sates the license is GPL v2 or
later. So I think that either the comment at the top of this file or the
ident used in the MODULE_LICENSE() macro needs to change.

> +MODULE_ALIAS("platform:i2c-mux-reg");

As far as I understand it, this alias is only useful if there's a
corresponding struct platform_device, somewhere. Ie, this alias needs a
platform_device that will fire of a "MODALIAS=platform:i2c-mux-reg"
uevent when it's created. (I don't know exactly how all that works, so
I'm handwaving quite a bit here.) That would be platform_device with a
"i2c-mux-reg" name.

Did I get this right? Because then I think this MODULE_ALIAS() isn't
needed, as I couldn't find such a corresponding platform_device.

Thanks,


Paul Bolle
