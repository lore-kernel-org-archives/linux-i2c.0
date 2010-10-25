From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [Device-drivers-devel] [PATCH] i2c: add irq_flags to board info
Date: Mon, 25 Oct 2010 01:45:41 +0100
Message-ID: <20101025004541.GD21564@trinity.fluff.org>
References: <1287359019-1476-1-git-send-email-vapier@gentoo.org> <20101018103610.77b7e605@endymion.delvare> <544AC56F16B56944AEC3BD4E3D5917713094520EDB@LIMKCMBX1.ad.analog.com> <20101018140136.2b44d29e@endymion.delvare> <544AC56F16B56944AEC3BD4E3D5917713094520FA6@LIMKCMBX1.ad.analog.com> <20101018163357.659efe25@endymion.delvare> <AANLkTi=fAYqxsGre9kOt9Z8nDXZ9JFjZtKUiMrE3Qn9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=fAYqxsGre9kOt9Z8nDXZ9JFjZtKUiMrE3Qn9b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Hennerich, Michael" <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "device-drivers-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <device-drivers-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 18, 2010 at 03:51:49PM -0400, Mike Frysinger wrote:
> On Mon, Oct 18, 2010 at 10:33, Jean Delvare wrote:
> > Why do we have set_irq_type() if we're not supposed to call it? I am
> > not claiming to be an expert in the area, but it seems totally
> > reasonable to me that the same piece of code instantiating an I2C
> > device is also responsible for setting its IRQ type.
> 
> but we're back to the same issue mentioned earlier -- you cant have a
> single kernel build with modules supporting multiple drivers
> simultaneously.  we like to ship development boards with a single
> kernel build on it with many modules.  then people can pick the addon
> boards they wish to prototype with at runtime by plugging in the card
> and loading the module.

I also dislike set_irq_type() as it doesn't check whether there is anyone
registered with the interrupt, which means that you could set the irq
type of someone else's irq.

I wonder if we should pass a struct resource instead, in case there
are multiple interrupt sources, as well as having it registered with
the right resource systems.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
