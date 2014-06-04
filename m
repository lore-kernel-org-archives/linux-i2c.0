From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH 1/7] ACPICA: Only include ACPI asm files if ACPI is enabled
Date: Wed, 04 Jun 2014 23:29:33 +0200
Message-ID: <1603851.9SBouhvdWS@vostro.rjw.lan>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org> <3061297.feg5DGUjIt@vostro.rjw.lan> <20140604125137.GA18171@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140604125137.GA18171@lee--X1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday, June 04, 2014 01:51:37 PM Lee Jones wrote:
> On Wed, 04 Jun 2014, Rafael J. Wysocki wrote:
> 
> > On Wednesday, June 04, 2014 01:09:50 PM Lee Jones wrote:
> > > Any drivers which support ACPI and Device Tree probing need to include
> > > both respective header files.  Without this patch, if a driver is being
> > > used on a platform which does not support ACPI and subsequently does not
> > > have the config option enabled, but includes linux/acpi.h the build
> > > breaks with:
> > > 
> > >   In file included from ../include/acpi/platform/acenv.h:150:0,
> > >                    from ../include/acpi/acpi.h:56,
> > >                    from ../include/linux/match.h:2,
> > >                    from ../drivers/i2c/i2c-core.c:43:
> > >   ../include/acpi/platform/aclinux.h:73:23:
> > >    fatal error: asm/acenv.h: No such file or directory
> > >    #include <asm/acenv.h>
> > >                        ^
> > 
> > Which kernel does this happen with?
> 
> a0a962d (tag: refs/tags/next-20140602, refs/remotes/next/master)
>   Add linux-next specific files for 20140602

It looks like the problem is with include/linux/match.h that should not
include acpi/acpi.h directly.

But I can't find this file in the Linus' next branch even, so I guess it's
on its way to that branch?

Rafael
