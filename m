From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: nomadik: Add Device Tree support to the Nomadik I2C driver
Date: Tue, 4 Sep 2012 14:28:21 +0000
Message-ID: <201209041428.21409.arnd@arndb.de>
References: <20120831122323.GC5962@gmail.com> <5044C82E.5060207@gmail.com> <20120903152012.GH31163@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120903152012.GH31163-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Monday 03 September 2012, Lee Jones wrote:
> > But if you are handling both, then I agree that platform_data should
> > override DT.
> 
> I do agree with this, but I haven't stumbled over such a use-case yet.
> I have only provided; clock names, DMA settings and call-back information
> via AUX_DATA() thus far, and those are being removed too when a) the 
> correct bindings are mainlined and b) I have the time.

I'd prefer if you just disallow the case where pdata and DT have conflicting
information. We don't seem to have a clear rule that is enforced over the
kernel, so I don't think we can rely on either one taking precedence over
the other in general.

In this particular case, we don't have a single board file providing a
struct nmk_i2c_controller definition for platform data, so the best way
to handle this IMHO is to remove the header file with the platform
data definition, and just encode the defaults in the driver.

	Arnd
