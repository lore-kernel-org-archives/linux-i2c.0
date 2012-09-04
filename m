From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: nomadik: Add Device Tree support to the Nomadik
 I2C driver
Date: Tue, 4 Sep 2012 19:27:10 +0200
Message-ID: <CACRpkdZESujO=2BU3jeKiX3Cm+JY2UPEXwGkro75FWa5Gio5YQ@mail.gmail.com>
References: <20120831122323.GC5962@gmail.com>
	<5044C82E.5060207@gmail.com>
	<20120903152012.GH31163@gmail.com>
	<201209041428.21409.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201209041428.21409.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Alessandro Rubini <rubini-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 4, 2012 at 4:28 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:

> In this particular case, we don't have a single board file providing a
> struct nmk_i2c_controller definition for platform data, so the best way
> to handle this IMHO is to remove the header file with the platform
> data definition, and just encode the defaults in the driver.

Alessandro Rubini is actively working on bridging this (and
other amba_device primecells) to PCI, that is the reason why it
was recently converted to an amba_device. How is he then supposed to
get the proper parameters into the driver? Note that the PCI ID
is no help at all since the parameters depend on what is connected
to the I2C bus, not on what it itself is connected to. Isn't platform data
used in such cases?

Yours,
Linus Walleij
