From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Tue, 21 Apr 2009 16:11:47 +0200
Message-ID: <49EDD423.3050302@gmx.de>
References: <49ED6AD3.2060808@gmx.de>	<49ED6F03.5050107@grandegger.com>	<49ED9132.9050806@gmx.de> <20090421115936.28656d09@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090421115936.28656d09-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Sang, Wolfram" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare said the following:
> You apparently still have a hard time differentiating between devices
> and drivers. Loading modules at runtime != instantiating devices at
> runtime.
> 
Well, till now I assumed that you can't instantiate a device who's
driver isn't loaded. But I am eager to learn.

> (And both can be done, but if you can't define your needs, we won't go
> very far.)

I thought I had explained very often. I'll do it once again:
We load drivers at runtime directly after boot which does automatic
instantiation. There will occur further devices on bus after some time
(hotplug) and therefore we need later on instantiation without reloading
drivers. We cannot define which devices will exactly be plugged in, it
might even be possible that on same bus address there occur different
devices (as an possible option and not at same time of course). So
device detection is highly appreciated.
Do you need more info?

> 
>> Defining all possible (I2C-)devices in DTS would give a mess. E.g. on
>> one board there will be ~30 temperature sensors, on the other none.
>> As every DTS entry will force a sysFs subdirectory there would be a
>> bunch of functionless directories - rather ugly.
> 
> Why don't you define one DTS per board? I'm no embedded expert, but my
> understanding is that this is what other developers/designers do.
> 
--> my answer to W.G. at 15:05 (<49EDC487.8010201-Mmb7MZpHnFY@public.gmane.org>)

>> Because of the situation above I try to keep the ability of dynamic
>> instantiation. Jean hesitates, I feel because he sees I2C solely in
>> static manner.
> 
> Well there are 2 different issues here. First issue is relying on
> probing when a DTS would do. Many developers have done that before, and
> stopped doing it quickly, for a reason. We simply want to save you from
> doing the same mistake.

If you don't tell me the issue, I won't understand. DTS is no good
option as described multiple times.

> 
> Second issue is the warm-plugging of I2C devices. Linux doesn't support
> this at this point, we are working on it (actually I am working on the
> dependencies), but as long as support for basic multiplexing it isn't
> there, there's little point in discussing more complex (dynamic)
> schemes.
> 
> I had been explaining exactly this already, hadn't I?
> 
I took a look into the code of Rodolfo Giometti and it seemed to be in a
way I would have done it, if I wouldn't have been too late. In my
current working I assume this code as a basis.

Nevertheless my mailed patch has *nothing* to do with multiplexing.
It works on the problem that i2c-mpc has 0 as default class and so there
is no way to instantiate a new-style client that is not mentioned in DTS.

-- 
Michael
