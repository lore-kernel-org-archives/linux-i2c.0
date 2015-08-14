From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [U-Boot] [PATCH v3 01/11] dm: serial: Update binding for PL01x
 serial UART
Date: Fri, 14 Aug 2015 12:22:31 +0200
Message-ID: <CACRpkdY1G0zgQ0mw3VP_rA89+kcaipCfJqoPpieVDTBjbeDa1Q@mail.gmail.com>
References: <1438954951-13329-1-git-send-email-sjg@chromium.org>
	<1438954951-13329-2-git-send-email-sjg@chromium.org>
	<CACRpkdZa2O1MqCVT8q2P0u0ciXK+6HFbQQGXB_-chimg=FbzQg@mail.gmail.com>
	<CAPnjgZ3V1KS7POEhsvj63OSB29MUtyaZGBoFR8JGPnaN=-fXVw@mail.gmail.com>
	<55CCBFB2.7050301@wwwdotorg.org>
	<20150813181346.GS25532@bill-the-cat>
	<1439492679.242.35.camel@freebsd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439492679.242.35.camel-h+KGxgPPiopAfugRpC6u6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ian Lepore <ian-h+KGxgPPiopAfugRpC6u6w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Joe Hershberger <joe.hershberger-acOepvfBmUk@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, U-Boot Mailing List <u-boot-0aAXYlwwYIKGBzrmiIFOJg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 13, 2015 at 9:04 PM, Ian Lepore <ian-h+KGxgPPiopAfugRpC6u6w@public.gmane.org> wrote:

> As the FreeBSD person who got our first SoC (imx6, only partially
> supported) converted to use the Linux DT files rather than our own
> homebrew mess we started with, I would say that my opinion of the
> existing DT information is that it is an extension of Linux device
> drivers written in a different language.

This is the first time I hear a story like this, tell us more!

This is exactly the kind of stuff we want to see posted on
devicetree-u79uwXL29TaiAVqoAR/hOA@public.gmane.org

> The information available is in no way independent of the Linux device
> drivers, it is exactly the information those drivers need.  It is often
> not the information needed in another OS with independently written
> drivers.  And especially it is not ordered and structured in a way that
> works well with the device enumeration and instantiation models used by
> another OS.

I have complained before that since the bindings are often merged
through the Linux kernel tree subsystem maintainers, they
ultimately decide on bindings. Unsurprisingly, they are as unlikely
to notice linuxisms as the Windows people designing ACPI
are unlikely to notice Windowsisms. But atleast we know we
are flawed and want to improve.

The best way to improve is to have people from other OSes on
the devicetree mailinglist and review the bindings there from
other-OS point of view.

> A great case in point would be i2c eeproms.  What a perfect opportunity
> DT would be to describe everything about the eeprom parts (total
> capacity, page read/write size, whether the page address bits extend
> into the bus-slave address bits, etc).  It seems to me that anything
> claiming to be an independent description of the hardware would have to
> include such things.  Instead, all the bindings define is the compatible
> string.  That's crazy.  Why?  Well, when I went and looked at the Linux
> eeprom drivers it became clear why:  that's all they need to know,
> because everything else is hard-coded in tables in the driver source.
>
> So if I want to write a FreeBSD i2c eeprom driver that uses DT data,
> what are my choices?  I have exactly one:  make my driver essentially a
> clone of the Linux driver, with all the same data hard-coded in source.

I bet Wolfram and other I2C people can comment on this, state
and future directions. Wolfram is known to care deeply about the
problem with DT contracts.

> All in all, it's not impossible for another OS to work with the DT
> information that begins its life in Linux, but it's not really easy.

Let's maker this better.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
