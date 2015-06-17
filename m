From: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Subject: Re: [Patch v3] driver/clk/clk-si5338: Add common clock framework
 driver for si5338
Date: Wed, 17 Jun 2015 11:29:28 +0200
Message-ID: <1434533368.2069.135.camel@x220>
References: <1434472269-27601-1-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434472269-27601-1-git-send-email-yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Andrey Filippov <andrey-MoRZu3FOBbXQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2015-06-16 at 09:31 -0700, York Sun wrote:
> COMMON_CLK in Kconfig is changed from bool to tristate so all common
> clock framework drivers can be selected by users.

A bool to tristate change isn't needed to make it possible to set a
symbol manually. That's achieved by adding a prompt (which the patch
also does).

This change adds a prompt to the symbol that enables the framework. But,
as far as I can see, clock drivers depending on that framework already
can be set manually. So that's another reason the above looks incorrect
to me.

Note that the "help" of COMMON_CLK contains:
    Architectures utilizing the common struct clk should select
    this option.

Does the architecture this patch targets perhaps not select COMMON_CLK?
If that's the case, it seems you should change that architecture
instead.

> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig

>  config COMMON_CLK
> -	bool
> +	tristate "Common Clock"
>  	select HAVE_CLK_PREPARE
>  	select CLKDEV_LOOKUP
>  	select SRCU

I told you yesterday that setting this to tristate allows over a dozen
new modules to be created. I'd be surprised if that doesn't break stuff
left and right without additional changes (which this patch lacks).

Thanks,


Paul Bolle
