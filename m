From: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Subject: Re: [PATCH 1/4] x86: Add basic support for the Congatec CGEB BIOS
 interface
Date: Fri, 12 Jun 2015 11:35:18 +0200
Message-ID: <1434101718.2271.166.camel@x220>
References: <1434055734-3602-1-git-send-email-christian.gmeiner@gmail.com>
	 <1434055734-3602-2-git-send-email-christian.gmeiner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434055734-3602-2-git-send-email-christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

A few nits.

On Thu, 2015-06-11 at 22:48 +0200, Christian Gmeiner wrote:
> --- /dev/null
> +++ b/drivers/mfd/congatec-cgeb.c

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

> +/*
> + * cgeb_invoke - invoke CGEB BIOS call.

s/cgeb_invoke/cgeb_call/

> + *
> + * @board:     board context data
> + * @p:         CGEB parameters for this call
> + * @fct:       CGEB function code
> + * @return:    0 on success or negative error code on failure.
> + *
> + * Call the CGEB BIOS code with the given parameters.
> + */
> +unsigned int cgeb_call(struct cgeb_board_data *board,
> +		 struct cgeb_function_parameters *p, cgeb_function_t fct)
> +{
> +	[...]
> +}

> +static int __init cgeb_init(void)
> +{
> +	[...]
> +}
> +
> +static void cgeb_exit(void)
> +{
> +	[...]
> +}
> +
> +module_init(cgeb_init);
> +module_exit(cgeb_exit);

cgeb_exit is only used through module_exit(). So I guess it could be
marked __exit, right?

> +MODULE_LICENSE("GPL");

The comment at the top of this file states the license is GPL v2. The
MODULE_LICENSE() macro states, according to include/linux/module.h, that
the license is GPL v2 or later. So I think one of these two needs to
change.

I spotted the same license mismatch in 2/4, 3/4 and 4/4.

Thanks,


Paul Bolle

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
