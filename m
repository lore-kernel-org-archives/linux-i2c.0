From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: Re: i2c-eg20t: regression since i2c_add_numbered_adapter change
Date: Thu, 30 Aug 2012 13:08:09 +0200
Message-ID: <6208908.ZjG7eB9lJn@ws-stein>
References: <4401854.hVfHzgeqjT@ws-stein> <4378288.tkkLiQ5MQ7@ws-stein> <20120830171915.36b6d10b@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120830171915.36b6d10b@feng-i7>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thursday 30 August 2012 17:19:15, Feng Tang wrote:
> > IMO the i2c_register_board_info only works in quite static setups. Especially with I2C-Busses attached to hotplugable PCI devices this way doesn't work reliable any more.
> > The device come and go dynamically so you can't assume fixed mapping.
> 
> Can you specify the hotplugable?
> 1. A hotplugable i2c bus controller (say i2c_eg20t) with all fixed i2c
>  devices connecting to it
> 2. i2c bus controller is fixed, while the i2c devices will be dynamically
>  connected to it.
> 3. Both the bus controller and devices are dynamically hotplugged

I had scenario 1 in mind, but with more than 1 bus controller (say 2x i2c_eg20t). How can you set a fixed numbering if there are more controllers, each with maybe more than 1 bus?
Anyway, how can you provide a static bus numbering if there are more than one driver or more than one device per driver if the devices are hotplugable?

Best regards,
Alexander
