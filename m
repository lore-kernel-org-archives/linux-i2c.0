From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: Dynamically-allocated i2c_device_id vs MODULE_DEVICE_TABLE
Date: Sat, 24 Jan 2009 11:39:49 +0000
Message-ID: <20090124113948.GA7132@sirena.org.uk>
References: <497A3097.1030808@freescale.com> <20090124012817.GA31775@sirena.org.uk> <497A7BA4.2080908@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <497A7BA4.2080908-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 23, 2009 at 08:23:32PM -0600, Timur Tabi wrote:

> I think I see your point, though.  I'm calling i2c_add_driver, which  
> technically could result in my i2c_probe function being called multiple 
> times, if there are multiple matches in the device tree.  I'll have to 
> check that out on Monday.

Yes, it will - any device specific data must be registered when the
device is registered.  You may want to look at how the wm8900 handles
this, it makes use of the DAI registration functions to make this a
little nicer.  It does still have the same problem but is much closer to
the end result and means you can start registering the driver normally
now.

>> For now an idiomatic solution for ASoC drivers is to have a single
>> static variable that you use to get the socdev through.

> Well, that's what I do today.  I was hoping to avoid that, but if I'm 
> right about i2c_add_driver, then this trick doesn't really work either.

This really isn't something that can be worked around well in the
individual drivers.
