From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 0/3] i2c-nomadik changes
Date: Thu, 31 May 2012 09:55:33 +0800
Message-ID: <CACRpkdZqD0_5oRwBg2J7ZyCK9=ynGOZnSWrQmtCyph9C3W3jDA@mail.gmail.com>
References: <cover.1338398567.git.rubini@gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1338398567.git.rubini-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alessandro Rubini <rubini-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Giancarlo Asnaghi <giancarlo.asnaghi-qxv4g6HH51o@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 31, 2012 at 1:45 AM, Alessandro Rubini <rubini-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org> w=
rote:

> In the STA2X11 I/O hub we are exporting a number of AMBA peripherals
> to the PCI world. Using a generic pci-amba driver there is no further
> code for each device, provided they are already registered under the
> AMBA bus. =A0I already submitted the generic bridge
> (https://lkml.org/lkml/2012/5/28/194).

Yeah I buy this concept, it's a good way to share this code.

> The cell-id I used in the table are the one for ux500 (only as far as
> I know from the stn-8815 manuals) and the one for STA2X11.

I've tried a few times to get this driver working on the S8815 Calao
dongle version of Nomadik 8815, but failed miserably (I managed
to get DMA and MMC working, which I will likely try to merge.)
I'm still trying to figure out why sometimes now and then.

So this doesn't make anything worse anyway.

Thanks for this nice patch set!

Yours,
Linus Walleij
