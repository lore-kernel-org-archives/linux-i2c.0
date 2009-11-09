From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: at24 driver - a possible problem
Date: Mon, 9 Nov 2009 09:46:38 +0100
Message-ID: <20091109094638.2f05b29f@hyperion.delvare>
References: <533f29860911050810w4d939b39x2ad11c189f13c977@mail.gmail.com>
	<20091106124905.GA3980@pengutronix.de>
	<533f29860911060457m70a1adfcr2dd11f0785748014@mail.gmail.com>
	<200911061258.52179.david-b@pacbell.net>
	<20091108202331.GA6374@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091108202331.GA6374-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Aleksandar Ivanov <ivanov.aleks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 8 Nov 2009 21:23:31 +0100, Wolfram Sang wrote:
> > > Correct me if I'm wrong but I would expect from a synchronous write()
> > > call to NOT finish before the data has been "phisically written".
> > > And in this case of course the read operation wouldn't need a waiting loop.
> > > What do you think?
> > 
> > Makes sense to me.  Another bug to fix.  :)
> 
> I think the waiting loop in the read-path won't hurt and will be convenient for
> a number of users. I also think it would be nice if O_SYNC would be supported,
> so the write will only return after the EEPROM finished the write cycle.
> 
> Still, the latter one beats me right now. The sysfs-bin-write gets a kobject
> and the O_SYNC is placed in the flags of a filp during open. Is there a some
> connection between those? I'm not even sure if O_SYNC should be handled at the
> sysfs-layer instead of inside the driver?

I'm not sure how sysfs could handle it. What backs up the sysfs file is
driver-specific, so only the driver knows how to ensure that the data
has been written. In the at24 driver case, the only way AFAICS is to
try to read one byte back from the EEPROM and only return when the read
is successful.

But looking at the sysfs API, I can't see a way to retrieve O_SYNC from
the driver, nor room for a callback that would let sysfs handle it. It
is entirely possible that sysfs simply has no support for O flags. This
would have to be discussed at a higher level.

-- 
Jean Delvare
