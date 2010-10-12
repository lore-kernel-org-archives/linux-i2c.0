From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: skip address detection if provided in board_info
Date: Tue, 12 Oct 2010 17:30:28 +0800
Message-ID: <20101012173028.638cd3ae@po-laptop>
References: <1286838635-16474-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<20101012092822.6f4e4aa5@endymion.delvare>
	<20101012162140.429b03b3@feng-i7>
	<20101012104707.3318511d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101012104707.3318511d-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, i2c list <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 12 Oct 2010 16:47:07 +0800
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> Hi Feng,
> 
> On Tue, 12 Oct 2010 16:21:40 +0800, Feng Tang wrote:
> > On Tue, 12 Oct 2010 15:28:22 +0800
> > Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > > On Mon, 11 Oct 2010 16:10:35 -0700, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
> > > wrote:
> > > > From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > > > 
> > > > If the address of a given device is already provided by platform
> > > > init code, e.g. from system firmware, there is no need to call
> > > > the driver's detect() function for finding the matching address
> > > > from the driver's address list.
> > > > 
> > > > Avoiding such detection might save boot time.
> > > 
> > > i2c_detect() is a no-op if adapter->class is 0, and if you have
> > > platform init data describing the chips on your I2C adapter then
> > > you certainly don't want to set the adapter class to anything
> > > other than 0.
> > > 
> > > So I'd rather avoid optimizing a case which isn't supposed to
> > > happen in the first place.
> > 
> > I checked the i2c devices drivers in drivers/hwmon/, most of them
> > set the class to I2C_CLASS_HWMON, and many i2c adapter drivers also
> > setting their class to I2C_CLASS_HWMON. So there is still many
> > cases for i2c_detect get called.
> 
> Of course i2c_detect gets called at times, otherwise we would delete
> it altogether ;)
> 
> Please point me to the I2C adapter driver(s) you care about, and also
> the platform init code for your system. I would like to see how it
> looks like.
> 
> I think it would also help if I had a global picture of your project
> and what you are trying to achieve. I presume we are talking about an
> embedded system? With a custom kernel maybe? Which
> platform/architecture?

Yes, we are working a x86 based embedded system, Intel's Moorestown
and Medfield systems, its current platform init code is arch/x86/kernel/mrst.c,
but the I2c init code hasn't been pushed upstream yet :(, but basically
it get i2c devices info from a SFI table (drivers/sfi/) and use
i2c_register_board_info for them.

The adapter driver is i2c-mrst.c which is not in current i2c subsystem yet,
seems it has been submitted to i2c devel list before. And our platform
has many identical adapters. 

> 
> > Under drivers/hwmon/, many i2c devices driver provide an list with
> > 4 or more addresses, imaging a platform with >= 5 i2c adapters
> > case, so it will take more than 20 i2c transfers to init one i2c
> > device driver, and in 10 or 20 seconds (if the timeout for a i2c
> > transfer of that adapter driver is 500ms or 1 second). It will be a
> > disaster if we build in all the drivers in drivers/hwmon/.
> 
> But you normally only load the hwmon drivers you need on a given
> machine. That's only a couple of them. Or are you, by any chance,
> building a monolithic kernel with all hwmon drivers included? This
> would indeed be a problem, the i2c subsystem isn't prepared for that.

Actually we run into a long boot time problem while we build in only
one i2c device driver (drivers/hwmon/emc1403.c) which has 4 addresses
in its address lit, it took more than 10 seconds for the driver to init
on our platforms. So if we build in more i2c hwmon drivers, things
will get much worse. That's why Jacob posted the patch.

I did read code about setting adapter->class, seems most driver set its
class in their proble function, trying set it in platform code may looks
not very clean.

Yours suggestion of using a build time option definitely will shrink the
kernel size. But our platform is under arch/x86, and one general rule is
to one generic kernel config should work for all x86 platforms, so I'm
afraid it can't solve our problem.

So I still prefer the option of adding a flag, and leave the choice for
platform code whether to do the detect. If you agree, I would make a
cleaner patch.

Thanks,
Feng

> 
> One possible workaround for this case would be to cache the results of
> i2c_default_probe(), to avoid probing the same address repeatedly.
> This will increase the memory consumption though, as we won't know
> when we can get rid of that cache. I think the best thing to do here
> is: just don't do that.
> 
> > So can we have a global flag like i2c_skip_autodetect, which is 0
> > by default, and could be set in platform init code to prevent the
> > detecting from really happen, if we are confident the platform code
> > has inited i2c board info correctly?
> 
> How is this different from the same platform init code clearing the
> adapter's class (or even better, not setting it in the first place)?
> And you don't need any code change for that.
> 
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index bea4c50..7727105 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -1493,6 +1493,9 @@ static int i2c_detect_address(struct
> > i2c_client *temp_client, return 0;
> >  }
> >  
> > +int i2c_skip_auto_detect;
> > +EXPORT_SYMBOL(i2c_skip_auto_detect);
> > +
> >  static int i2c_detect(struct i2c_adapter *adapter, struct
> > i2c_driver *driver) {
> >  	const unsigned short *address_list;
> > @@ -1501,7 +1504,7 @@ static int i2c_detect(struct i2c_adapter
> > *adapter, struct i2c_driver *driver) int adap_id =
> > i2c_adapter_id(adapter); 
> >  	address_list = driver->address_list;
> > -	if (!driver->detect || !address_list)
> > +	if (!driver->detect || !address_list ||
> > i2c_skip_auto_detect) return 0;
> >  
> >  	/* Set up a temporary client to help detect callback */  
> 
> If the point is to skip the whole detection logic on some embedded
> systems, then it might make more sense to make it a build-time option.
> A build-time option would have the benefit of shaving some code off
> your kernel binary: i2c_detect_address and i2c_detect in i2c-core.c,
> but also possibly in individual i2c device drivers and maybe
> ultimately in some i2c data structures. This is of course way more
> intrusive than your proposal, but depending on your actual goal, it
> might also be much more efficient and thus worth the effort.
> 
