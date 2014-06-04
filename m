From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/7] ACPICA: Only include ACPI asm files if ACPI is
 enabled
Date: Wed, 4 Jun 2014 13:51:37 +0100
Message-ID: <20140604125137.GA18171@lee--X1>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
 <1401883796-17841-2-git-send-email-lee.jones@linaro.org>
 <3061297.feg5DGUjIt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3061297.feg5DGUjIt-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 04 Jun 2014, Rafael J. Wysocki wrote:

> On Wednesday, June 04, 2014 01:09:50 PM Lee Jones wrote:
> > Any drivers which support ACPI and Device Tree probing need to incl=
ude
> > both respective header files.  Without this patch, if a driver is b=
eing
> > used on a platform which does not support ACPI and subsequently doe=
s not
> > have the config option enabled, but includes linux/acpi.h the build
> > breaks with:
> >=20
> >   In file included from ../include/acpi/platform/acenv.h:150:0,
> >                    from ../include/acpi/acpi.h:56,
> >                    from ../include/linux/match.h:2,
> >                    from ../drivers/i2c/i2c-core.c:43:
> >   ../include/acpi/platform/aclinux.h:73:23:
> >    fatal error: asm/acenv.h: No such file or directory
> >    #include <asm/acenv.h>
> >                        ^
>=20
> Which kernel does this happen with?

a0a962d (tag: refs/tags/next-20140602, refs/remotes/next/master)
  Add linux-next specific files for 20140602

> > Cc: Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
> > Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > ---
> >  include/acpi/platform/aclinux.h | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platfor=
m/aclinux.h
> > index cd1f052..fdf7663 100644
> > --- a/include/acpi/platform/aclinux.h
> > +++ b/include/acpi/platform/aclinux.h
> > @@ -70,9 +70,10 @@
> >  #ifdef EXPORT_ACPI_INTERFACES
> >  #include <linux/export.h>
> >  #endif
> > -#include <asm/acenv.h>
> > =20
> > -#ifndef CONFIG_ACPI
> > +#ifdef CONFIG_ACPI
> > +#include <asm/acenv.h>
> > +#else
> > =20
> >  /* External globals for __KERNEL__, stubs is needed */
> > =20
> >=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
