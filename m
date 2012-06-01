From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 2/3] i2c-nomadik: turn the platform driver to an amba driver
Date: Fri, 1 Jun 2012 09:53:15 +0800
Message-ID: <CACRpkdZXnuQe5NXyQBEZJD71Rs=+wvmXkw-4oT53FdU7KE7m2g@mail.gmail.com>
References: <cover.1338398567.git.rubini@gnudd.com>
	<349645b61d0b28f6e84f7ae1f2c8c28e12a11d92.1338398567.git.rubini@gnudd.com>
	<CACRpkdZ79=B8N7omxYY4UPotg8gYotfLeBRViYMr8hA-Uhie0w@mail.gmail.com>
	<4FC72DDF.7080209@codethink.co.uk>
	<CACRpkdZpjn0RBGY+CqqSW3ip0MSQUJSaqN0GD=a4THnPHNM-jg@mail.gmail.com>
	<20120531180204.GA28779@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120531180204.GA28779-eyGpkxvC2QLRELXczCotyA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alessandro Rubini <rubini-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org>
Cc: ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, giancarlo.asnaghi-qxv4g6HH51o@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 1, 2012 at 2:02 AM, Alessandro Rubini <rubini-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org> wrote:

> So I'll resubmit in the right way (-M, include/linux/platform_data)
> as soon as I have information for ftd fixup.

OK if nothing happens you can probably just go in and patch:
arch/arm/boot/dts/db8500.dtsi

I suspect it's just the compatible= that needs to be changed to
"arm,primecell" or just have that string added to the others that
are already there for each i2c device entry.

Yours,
Linus Walleij
