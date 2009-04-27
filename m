From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Mon, 27 Apr 2009 11:07:46 +0200
Message-ID: <49F575E2.1070005@grandegger.com>
References: <49ED6AD3.2060808@gmx.de> <49ED6F03.5050107@grandegger.com>	 <49ED9132.9050806@gmx.de> <20090421095112.GB3100@pengutronix.de>	 <49EDC487.8010201@gmx.de> <20090424085256.GA26169@pengutronix.de>	 <49F19A11.3090700@gmx.de> <9e4733910904240838k5f425d7m849cd6b7fad19f27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9e4733910904240838k5f425d7m849cd6b7fad19f27-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Delvare, Jean" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jon Smirl wrote:
> On Fri, Apr 24, 2009 at 6:53 AM, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org> wrote:
>> Wolfram Sang said the following:
>> ...
>>>> Allowing only clients that are mentioned in DTS?
>>> For now, yes. This is still the common case (=avoid probing). Until a
>>> mainline solution comes up (which is needed, I agree on that), not so
>>> common cases could simply patch the driver to add a .class field.
>>>
>> Especially it is ugly that devices which are mentioned in DTS but are
>> not present (because the component isn't plugged in or powered) get an
>> directory entry in /sys/bus/i2c/devices with bind, unbind, ...
>> This is my 'problem': I search for a clean way to instantiate on demand
>> with no zombies in case of missing H/W. I know there are problems in
>> identification of devices, but to remove all possibilities to try it
>> seems not a good way for me.
> 
> You might want to ask about this on the linux-ppc mailing list.
> 
> You're stuck because i2c hardware does not support hotplug. Since the
> hardware doesn't support hotplug there's no software support for it in
> the kernel. So you want to fall back to polled probing.
> 
> But probing is bad because it isn't standardized and coordinated, one
> device's probe can cause another device to destroy things (like set a
> voltage too high on a motherboard). Because of this probing can't be
> turned on in general.

To decide if a device exists and responds at a specified I2C address, it
would be sufficient to just read some data without causing trouble. Is
that assumption correct or have I missed something? Trying to identify
the device is a different issue and should be avoided.

Wolfgang.
