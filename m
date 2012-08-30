From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c-eg20t: regression since i2c_add_numbered_adapter change
Date: Thu, 30 Aug 2012 17:19:15 +0800
Message-ID: <20120830171915.36b6d10b@feng-i7>
References: <4401854.hVfHzgeqjT@ws-stein>
	<20120823162852.29243e9c@feng-i7>
	<20120829204031.648a73e1@endymion.delvare>
	<4378288.tkkLiQ5MQ7@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4378288.tkkLiQ5MQ7@ws-stein>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Alexander,

On Thu, 30 Aug 2012 09:49:52 +0200
Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org> wrote:

> > 
> > Whenever you call i2c_register_board_info(), every I2C bus number
> > referenced in the I2C device list passed as a parameter is reserved for
> > static I2C bus numbers, dynamic I2C bus numbers will never overlap.
> > 
> > So in the quoted example, if i2c-isch is able to dynamically pick I2C
> > bus number 0 while i2c-eg20t want it statically, it means that either
> > no device was declared on bus 0 with i2c_register_board_info(), or
> > i2c_register_board_info() was called too late in the game.
> 
> In my case i2c_register_board_info is never called due to a non-existant platform setup (see below).

I think we can have that, and we did have that for a non-product platform,
it's easy to add a platform driver which can use dmidecode info to
identify itself.

> 
> > Note that there was an assumption at the time the code was written,
> > that there was no need or reason to reserve a static I2C bus number if
> > no slave device was declared on said I2C bus. I never much liked it but
> > it never caused problems so far. This means that either:
> > * you call i2c_register_board_info() to register your slave I2C devices
> >   and all the affected I2C bus drivers call i2c_add_numbered_adapter();
> >   or
> > * you don't call i2c_register_board_info() and all I2C bus drivers call
> >   i2c_add_adapter().
> > You can't mix, i.e. if you don't register any slave device on a bus but
> > the bus driver still calls i2c_add_numbered_adapter(), it may fail.
> > 
> > If this is a problem now on some systems, it should be easy enough to
> > work around by adding a specific function to reserve an I2C bus number
> > for static allocation, even without declaring any slave device on it.
> > This function would be called at the same time
> > i2c_register_board_info() typically is.
> 
> IMO the i2c_register_board_info only works in quite static setups. Especially with I2C-Busses attached to hotplugable PCI devices this way doesn't work reliable any more.
> The device come and go dynamically so you can't assume fixed mapping.

Can you specify the hotplugable?
1. A hotplugable i2c bus controller (say i2c_eg20t) with all fixed i2c
 devices connecting to it
2. i2c bus controller is fixed, while the i2c devices will be dynamically
 connected to it.
3. Both the bus controller and devices are dynamically hotplugged

Thanks,
Feng
