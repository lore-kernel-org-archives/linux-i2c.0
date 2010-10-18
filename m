From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] i2c: add irq_flags to board info
Date: Mon, 18 Oct 2010 08:38:25 -0700
Message-ID: <1287416305.2038.70.camel@helium>
References: <1287359019-1476-1-git-send-email-vapier@gentoo.org>
	 <20101018103610.77b7e605@endymion.delvare>
	 <544AC56F16B56944AEC3BD4E3D5917713094520EDB@LIMKCMBX1.ad.analog.com>
	 <20101018140136.2b44d29e@endymion.delvare>
	 <544AC56F16B56944AEC3BD4E3D5917713094520FA6@LIMKCMBX1.ad.analog.com>
	 <20101018163357.659efe25@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101018163357.659efe25-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "Hennerich, Michael" <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>, "device-drivers-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <device-drivers-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 2010-10-18 at 16:33 +0200, Jean Delvare wrote:


> 
> This is an interesting point. David, you're the one who added irq to
> struct i2c_client, you didn't add irq_flags then, did you have a good
> reason not to?

There was no evident need to do so.  The problem wasn't characterizing
the IRQ, but knowing what IRQ was associated with a given I2C chip.  The
IRQs would, as a rule, only have one behavior, known in advance by the
I2C chip's driver ... if it only had a way to know client->irq ...

In one model of IRQ setup (like PC BIOS), it's handled before drivers
do more than request the IRQ, and drivers just cope. irq_flags not
needed ... it's often a hardware-to-driver convention, likely matching
I2C chip defaults.  (Or more awkwardly, coping with whatever trigger
mode the platform uses).

In another model, drivers configure their chips according to desired
mode (level low, for the most common example, or edge triggered, etc)
and again, irq_flags not needed, but in this case the platform code
would have had *nothing* do do with such mode setup.



> 
> > There are drivers that work around this deficiency, by adding irq_flags to the bus clients dev.platform_data
> > See include/linux/spi/ads7846.h for one example.

Not a good example; that was changed earlier this year and, from a quick
glance, may not have tried much to avoid that change.  The driver had
worked for years with that alleged "deficiency".


- Dave
