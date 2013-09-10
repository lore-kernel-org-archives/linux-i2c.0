From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH RESEND 1/2] i2c: prepare runtime PM support for I2C client devices
Date: Wed, 11 Sep 2013 00:32:55 +0200
Message-ID: <2029393.u6DaKBPszu@vostro.rjw.lan>
References: <1378733679-19500-1-git-send-email-mika.westerberg@linux.intel.com> <3397524.g9aUWuArnm@vostro.rjw.lan> <20130910213522.GG29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130910213522.GG29403-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday, September 10, 2013 10:35:22 PM Mark Brown wrote:
> On Tue, Sep 10, 2013 at 10:04:21PM +0200, Rafael J. Wysocki wrote:
> > On Tuesday, September 10, 2013 05:13:21 PM Mark Brown wrote:
> 
> > > OK, that is very much not the model which embedded systems follow, in
> > > embedded systems the driver for the device is fully in control of its
> > > own power.  It gets resources like GPIOs and regulators which allow it
> > > to make fine grained decisions.
> 
> > There are platforms where those resources are simply not available for
> > direct manipulation and we need to use ACPI methods for power management.
> 
> > Now, since those methods are used in pretty much the same way for all I2C
> > devices, we add a PM domain for that to avoid duplicating the same code in
> > all of the drivers in question (patch [2/2]).  Does that make sense to you?
> 
> It doesn't seem like a particular problem, but the existing usage does
> need to be preserved for the systems that use it so things like having
> auto as the default and updating the drivers seem like they're needed.
> 
> > > If we're starting to get a reasonable number of buses following the same
> > > pattern it seems like we're in a position to start 
> 
> > We need that for exactly 3 buses: platform (already done), I2C and SPI.
> 
> > No other bus types are going to use ACPI this way for PM, at least for the
> > time being, simply because PCI, USB and SATA/IDE have their own ways of doing
> > this (which are bus-specific) and the spec doesn't cover other bus types
> > directly (it defines support for UART, but we don't have a UART bus type).
> 
> > Moreover, because PCI and USB use ACPI for PM in their own ways, moving that
> > thing up to the driver core would be rather inconvenient.
> 
> That only applies to the power domains though, what Mika was saying was
> that the process for enabling runtime PM (just drop a reference) also
> becomes easier with this method regardless of anything else - that makes
> sense to me as something we might want to end up with so do we want to
> just move towards making that a default?

Possibly. :-)

At least I don't see any fundamental obstacles ...


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
