From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Tue, 21 Apr 2009 12:00:02 -0400
Message-ID: <9e4733910904210900r4c5d1a8en178ad106134b7e6d@mail.gmail.com>
References: <49ED6AD3.2060808@gmx.de> <49ED6F03.5050107@grandegger.com>
	 <49ED9132.9050806@gmx.de> <20090421115936.28656d09@hyperion.delvare>
	 <49EDD423.3050302@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49EDD423.3050302-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Sang, Wolfram" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 21, 2009 at 10:11 AM, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org> wrote:
> Jean Delvare said the following:
>> You apparently still have a hard time differentiating between devices
>> and drivers. Loading modules at runtime != instantiating devices at
>> runtime.
>>
> Well, till now I assumed that you can't instantiate a device who's
> driver isn't loaded. But I am eager to learn.
>
>> (And both can be done, but if you can't define your needs, we won't go
>> very far.)
>
> I thought I had explained very often. I'll do it once again:
> We load drivers at runtime directly after boot which does automatic
> instantiation. There will occur further devices on bus after some time
> (hotplug) and therefore we need later on instantiation without reloading
> drivers. We cannot define which devices will exactly be plugged in, it
> might even be possible that on same bus address there occur different
> devices (as an possible option and not at same time of course). So
> device detection is highly appreciated.
> Do you need more info?

Jean, haven't you told me multiple times that hotplug doesn't work for
i2c? How can you tell when a new device has been added to an i2c bus?

There is already code in the kernel that will dynamically load the
correct i2c device drivers based on the device tree. The i2c drivers
don't need to be build into the kernel. Just put drivers for all of
your devices onto the initrd.

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
