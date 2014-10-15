From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: Add generic support passing secondary devices
 addresses
Date: Wed, 15 Oct 2014 11:54:37 -0700
Message-ID: <1413399277.1902.51.camel@spandruv-desktop.jf.intel.com>
References: <1409925739-28188-1-git-send-email-jean-michel.hautbois@vodalys.com>
	 <20140922104555.GQ1786@lahna.fi.intel.com> <542023C8.8080802@metafoo.de>
	 <20140922134535.GZ1786@lahna.fi.intel.com> <54202E28.80500@metafoo.de>
	 <20140922144144.GF1786@lahna.fi.intel.com> <20141003104637.GC1349@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141003104637.GC1349@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Lars and Jean,

Are you taking this patch further to take care about ACPI related stuff
submitted by Mika?

Thanks,
Srinivas
On Fri, 2014-10-03 at 12:46 +0200, Wolfram Sang wrote: 
> > > Ok, looks like there are two main differences in the two implementations.
> > > 
> > > 1) The ACPI one uses a integer index and the DT one uses a string index to
> > > lookup the device.
> > > 
> > > The problem with the index lookup is that the order is binding specific. So
> > > it might be different between e.g. the devicetree binding and the ACPI
> > > binding. This makes it quite hard to use the API in a generic way and you'd
> > > end up with hacks like:
> > > 
> > > if (client->dev.of_node)
> > > 	index = 3;
> > > else if (ACPI_COMPANION(client->dev))
> > > 	index = 1;
> > > else
> > > 	index = 5;
> > > 
> > 
> > Indeed.
> > 
> > > So we might need a extra translation table which maps a name to a ACPI index
> > > and then we could use the name as the generic index in the driver.
> > 
> > Good thing is that ACPI 5.1 _DSD finally allows us to use similar naming
> > as the DT has been doing. Problem is that we need to support both the
> > new way *and* the older index lookup somehow :-/
> > 
> > > 2) The ACPI implementation returns the i2c_board_info and the adapter, while
> > > the DT implementation returns the instantiated I2C client device.
> > > 
> > > It might make sense to have both. I image that most drivers are just
> > > interested in creating a new client device and will simply pass the board
> > > info and adapter they got to i2c_new_device(). In this case it makes sense
> > > to have a helper function which already does this internally to avoid
> > > boilerplate code duplication.
> > 
> > I agree. How about making that helper a wrapper around the function that
> > returns both i2c_board_info and an adapter?
> > 
> > > There will probably some special cases though in which case the driver wants
> > > to get the adapter and the board info and then manually call
> > > i2c_new_device() after having done some additional steps.
> > 
> > Yes, if the alternative address happens to be on another bus. That
> > should at least be possible with this API.
> 
> Thanks for the discussion so far! I'll wait and see if some patches come
> out of it and mark this one as deferred for now.
> 
