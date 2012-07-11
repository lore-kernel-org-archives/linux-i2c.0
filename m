From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/7] i2c-stu300: Use struct dev_pm_ops for power management
Date: Wed, 11 Jul 2012 23:56:09 +0200
Message-ID: <CACRpkdbLWTOAvqT==XoFuU2++Y_OvNBrGwWmATcPyK6EP90miw@mail.gmail.com>
References: <201207112121.11046.rjw@sisk.pl>
	<201207112126.36412.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201207112126.36412.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 11, 2012 at 9:26 PM, Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org> wrote:

> From: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
>
> Make the ST-Ericsson U300 I2C controller driver define its PM
> callbacks through a struct dev_pm_ops object rather than by using
> legacy PM hooks in struct platform_driver.
>
> Signed-off-by: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>

Great, thanks!
Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Yours,
Linus Walleij
