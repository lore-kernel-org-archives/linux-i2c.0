From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [sodaville] [PATCH] i2c/i2c-dev: use dynamic minor allocation
Date: Fri, 3 Dec 2010 01:58:12 +0000
Message-ID: <20101203015812.GB20097@trinity.fluff.org>
References: <1290633788-25767-1-git-send-email-bigeasy@linutronix.de> <20101124225745.403d8f5f@endymion.delvare> <4CEE3DEA.7040107@linutronix.de> <20101125225246.59931602@endymion.delvare> <20101126180325.GA27332@www.tglx.de> <20101126204632.6ff96d57@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101126204632.6ff96d57-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 26, 2010 at 08:46:32PM +0100, Jean Delvare wrote:
> Hi Sebastian,
> 
> On Fri, 26 Nov 2010 19:03:25 +0100, Sebastian Andrzej Siewior wrote:
> > * Jean Delvare | 2010-11-25 22:52:46 [+0100]:
> > 
> > >Hi Sebastian,
> > Hi Jean,
> > 
> > >> > But my main question is: why do you want a unique (or you probably
> > >> > meant predictable - adapter numbers are already unique by design)
> > >> > adapter number in the first place? Other systems apparently are doing
> > >> > just fine without this.
> > >>
> > >> Both. I use this number for the device id. This one has to remain unique
> > >> or sysfs goes crazy.
> > >
> > >Which "device id" are you talking about, please? Of course sysfs
> > The pci driver [0] has in add_i2c_device() the following construct:
> > 
> >      pdev->id = dev->devfn << 3 | bar;
> > 
> > I'm talking about this device id. Here I have to remain unique and here I
> 
> Huh? Is pdev a platform device? So you are instantiating platform
> devices off a PCI device, and in turn each platform device gets to
> create an i2c_adapter device?

I think this is due to re-instantiating a platform_device based driver
without adding any extra driver registration to it.

I'm considering the idea that the relevant driver registeration should
be put into the i2c-pxa driver and select the relevant things...
 
> Now I understand why you needed to craft a unique id. I don't quite get
> why you came up with such a complicated setup in the first place
> though. What's wrong with just making the i2c_adapter devices direct
> children of the PCI device? Is this a limitation of
> of_i2c_register_devices() that it needs platform devices to operate on?
> 
> > though using the pci id would be a good idea. There should be no other
> > device using "pxa2xx-i2c" as the device name so I should be safe here.

Or add a new platform device name, it isn't difficult.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
