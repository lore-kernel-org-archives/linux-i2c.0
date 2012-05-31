From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 2/3] i2c-nomadik: turn the platform driver to an amba driver
Date: Thu, 31 May 2012 09:51:14 +0800
Message-ID: <CACRpkdZ79=B8N7omxYY4UPotg8gYotfLeBRViYMr8hA-Uhie0w@mail.gmail.com>
References: <cover.1338398567.git.rubini@gnudd.com>
	<349645b61d0b28f6e84f7ae1f2c8c28e12a11d92.1338398567.git.rubini@gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <349645b61d0b28f6e84f7ae1f2c8c28e12a11d92.1338398567.git.rubini-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alessandro Rubini <rubini-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Giancarlo Asnaghi <giancarlo.asnaghi-qxv4g6HH51o@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, May 31, 2012 at 1:45 AM, Alessandro Rubini <rubini-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org> wrote:

> The i2c-nomadik gateware is really a PrimeCell APB device. By hosting
> the driver under the amba bus we can access it more easily, for
> example using the generic pci-amba driver. The patch also fixes the
> mach-ux500 users to register an AMBA device, not a platform device.
>
> Signed-off-by: Alessandro Rubini <rubini-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi-qxv4g6HH51o@public.gmane.org>
> Cc: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Cc: STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
> Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

This will affect Lee Jones' device tree bindings for the same device.

You will need some add-on patch to the db8500 device tree moving this
over to the AMBA (PrimeCell) bus abstraction.

Lee can you test this and help Alessandro add the proper chunks to
the device tree as well?

Apart from that this looks good to me, I'll test it on the MOP500
as soon as I can.

Yours,
Linus Walleij
