From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Tue, 21 Apr 2009 15:05:11 +0200
Message-ID: <49EDC487.8010201@gmx.de>
References: <49ED6AD3.2060808@gmx.de> <49ED6F03.5050107@grandegger.com> <49ED9132.9050806@gmx.de> <20090421095112.GB3100@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090421095112.GB3100-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang said the following:
>> mailing list. Nevertheless loading modules at runtime is legal and
>> generally supported by LINUX.
> 
> Ack. And it does so...
> 
>> Defining all possible (I2C-)devices in DTS would give a mess. E.g. on
>> one board there will be ~30 temperature sensors, on the other none.
>> As every DTS entry will force a sysFs subdirectory there would be a
>> bunch of functionless directories - rather ugly.
> 
> Well, you should have a DTS for every flavour; that is what DTS are
> about. You do know that, do you?

You like it more complicated? Ok, here it is:
As Jean indicated in his reply, we will have to support hotplug. Most of
the above sensors won't exist a life time on some systems, on others all
could exist. I tried to keep out this issue to avoid a drift to the
discussion that hotplug is not _yet_ supported. I will^Wmust support
hotplug, either by using tree's code or by doing my own modifications.
> 
> Even if not, there would be a slighty messed directory on one specific
> device with how many units? Let's take the latest example of extending
> the DTS file with OS-specific information - this one is ugly, too, but
> has impact _for everyone using dts_ files. Think about the number of
> affected systems and you will hopefully understand why such patches are
> handled with extreme caution.

You talk about my reading of the class entry from DTS?
No, I don't understand how other systems are affected by this.
They don't read this entry of _my_ .dts file.
Seems there is a general misunderstanding...
> 
>> Because of the situation above I try to keep the ability of dynamic
>> instantiation. Jean hesitates, I feel because he sees I2C solely in
>> static manner.
> 
> He is taking care for every I2C communication on every Linux machine out
> there. He can't please everyone. On the other hand, you are free to
> modify the kernel as you please. It doesn't really have to be in
> mainline, does it?
If this would be a private problem, yes.
But I see this as a more general flaw:
Many adapters do initialization of .class in adapter code. A few do not.
I haven't checked, but assume the PPC ones, as they have DTS. Thats Ok,
as long DTS is really used. In at least one other adapter it is: Exactly
Wolfgang Grandegger, who is responsible for removal of the original
default initialization, showed me, that it is done in i2c-cpm!
> 
> BTW, I hope you saw that the "linux,i2c-class" property is considered
> deprecated. Thus, expect a patch from me removing it entirely as soon
> as the old binding model went away (there aren't even any users).
> 
And how do you want to implement setting the class attribute?
Allowing only clients that are mentioned in DTS? How should it work on
systems without DTS?
