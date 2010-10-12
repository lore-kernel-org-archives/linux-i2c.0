From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: skip address detection if provided in board_info
Date: Tue, 12 Oct 2010 13:34:25 +0200
Message-ID: <20101012133425.490e3c4c@endymion.delvare>
References: <1286838635-16474-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<20101012092822.6f4e4aa5@endymion.delvare>
	<20101012162140.429b03b3@feng-i7>
	<20101012104707.3318511d@endymion.delvare>
	<20101012173028.638cd3ae@po-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101012173028.638cd3ae@po-laptop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, i2c list <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Feng,

On Tue, 12 Oct 2010 17:30:28 +0800, Feng Tang wrote:
> On Tue, 12 Oct 2010 16:47:07 +0800
> Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > Of course i2c_detect gets called at times, otherwise we would delete
> > it altogether ;)
> > 
> > Please point me to the I2C adapter driver(s) you care about, and also
> > the platform init code for your system. I would like to see how it
> > looks like.
> > 
> > I think it would also help if I had a global picture of your project
> > and what you are trying to achieve. I presume we are talking about an
> > embedded system? With a custom kernel maybe? Which
> > platform/architecture?
> 
> Yes, we are working a x86 based embedded system, Intel's Moorestown
> and Medfield systems, its current platform init code is arch/x86/kernel/mrst.c,
> but the I2c init code hasn't been pushed upstream yet :(, but basically
> it get i2c devices info from a SFI table (drivers/sfi/) and use
> i2c_register_board_info for them.
> 
> The adapter driver is i2c-mrst.c which is not in current i2c subsystem yet,
> seems it has been submitted to i2c devel list before. And our platform
> has many identical adapters. 

I remember that driver, I reviewed it long ago (more than 1 year ago I
think). Apparently driver was renamed to i2c-intel-mid meanwhile. Still
not upstream indeed, but the last version of the driver posted by Alan
Cox [1] does _not_ set the i2c_adapter.class field.

[1] http://marc.info/?l=linux-i2c&m=128292492431251&w=2

> > (...)
> > But you normally only load the hwmon drivers you need on a given
> > machine. That's only a couple of them. Or are you, by any chance,
> > building a monolithic kernel with all hwmon drivers included? This
> > would indeed be a problem, the i2c subsystem isn't prepared for that.
> 
> Actually we run into a long boot time problem while we build in only
> one i2c device driver (drivers/hwmon/emc1403.c) which has 4 addresses
> in its address lit, it took more than 10 seconds for the driver to init
> on our platforms. So if we build in more i2c hwmon drivers, things
> will get much worse. That's why Jacob posted the patch.

This suggests that the i2c adapter driver is pretty bad at handling
NACKs when trying to access a non-existing device. It might be worth
checking if this can be improved, because that case could happen not
only during device detection but also in other circumstances.

> I did read code about setting adapter->class, seems most driver set its
> class in their proble function, trying set it in platform code may looks
> not very clean.

Actually this is very clean and by far my preferred way to solve your
problem. This is exactly how things are done on the PXA platform (check
i2c-pxa.c.)

> Yours suggestion of using a build time option definitely will shrink the
> kernel size. But our platform is under arch/x86, and one general rule is
> to one generic kernel config should work for all x86 platforms, so I'm
> afraid it can't solve our problem.

OK, fair enough.

> So I still prefer the option of adding a flag, and leave the choice for
> platform code whether to do the detect. If you agree, I would make a
> cleaner patch.

And I prefer that you set the class flag value in the platform data and
have your i2c adapter driver read it. This is already supported and
should work very fine without any change to i2c-core. I see no point in
adding a global flag when we already have a much finer-grained setting
available.

-- 
Jean Delvare
