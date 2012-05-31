From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 1/3] i2c-nomadik: move header from <plat/i2c.h> to <linux/i2c-nomadik.h>
Date: Thu, 31 May 2012 09:47:12 +0800
Message-ID: <CACRpkdY_bg5s_eKot8Ywbmb+SmixsJOSJW_jWjjenedjJng4Jg@mail.gmail.com>
References: <cover.1338398567.git.rubini@gnudd.com>
	<ca47a47e0a4db31545549ed978e1dc7b3aad4377.1338398567.git.rubini@gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ca47a47e0a4db31545549ed978e1dc7b3aad4377.1338398567.git.rubini-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alessandro Rubini <rubini-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Giancarlo Asnaghi <giancarlo.asnaghi-qxv4g6HH51o@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 31, 2012 at 1:45 AM, Alessandro Rubini <rubini-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org> w=
rote:

> The header and driver were only used by arm/mach-nomadik and
> arm/mach-u8500. =A0The STA2X11 I/O Hub exports on PCIe a number of
> devices, including i2c-nomadik. =A0This patch allows compilation of
> the driver under x86.
>
> Signed-off-by: Alessandro Rubini <rubini-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi-qxv4g6HH51o@public.gmane.org>

The new place to put pure platform data headers is:
include/linux/platform_data/i2c-nomadik.h so please use this.

Pls use git format-patch -M so we get a nice movement patch
without all the -/+ lines. (No big deal though.)

Yours,
Linus Walleij
