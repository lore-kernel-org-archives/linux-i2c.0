From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v2 2/7] i3c: Add core I3C infrastructure
Date: Tue, 19 Dec 2017 10:21:19 +0100
Message-ID: <20171219092119.GA32748@kroah.com>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
 <20171214151610.19153-3-boris.brezillon@free-electrons.com>
 <20171219085250.GC15010@kroah.com>
 <20171219100900.35c0f66e@bbrezillon>
 <20171219101336.337d0afc@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171219101336.337d0afc@bbrezillon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Przemyslaw Sroka <psroka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Arkadiusz Golec <agolec-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alan Douglas <adouglas-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Bartosz Folta <bfolta-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Damian Kos <dkos-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alicja Jurasik-Urbaniak <alicja-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Cyprian Wronka <cwronka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Suresh Punnoose <sureshp-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.orglinux-
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 19, 2017 at 10:13:36AM +0100, Boris Brezillon wrote:
> On Tue, 19 Dec 2017 10:09:00 +0100
> Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> 
> > On Tue, 19 Dec 2017 09:52:50 +0100
> > Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> > 
> > > On Thu, Dec 14, 2017 at 04:16:05PM +0100, Boris Brezillon wrote:  
> > > > +/**
> > > > + * i3c_device_match_id() - Find the I3C device ID entry matching an I3C dev
> > > > + * @i3cdev: the I3C device we're searching a match for
> > > > + * @id_table: the I3C device ID table
> > > > + *
> > > > + * Return: a pointer to the first entry matching @i3cdev, or NULL if there's
> > > > + *	   no match.
> > > > + */
> > > > +const struct i3c_device_id *
> > > > +i3c_device_match_id(struct i3c_device *i3cdev,
> > > > +		    const struct i3c_device_id *id_table)
> > > > +{
> > > > +	const struct i3c_device_id *id;
> > > > +
> > > > +	/*
> > > > +	 * The lower 32bits of the provisional ID is just filled with a random
> > > > +	 * value, try to match using DCR info.
> > > > +	 */
> > > > +	if (!I3C_PID_RND_LOWER_32BITS(i3cdev->info.pid)) {
> > > > +		u16 manuf = I3C_PID_MANUF_ID(i3cdev->info.pid);
> > > > +		u16 part = I3C_PID_PART_ID(i3cdev->info.pid);
> > > > +		u16 ext_info = I3C_PID_EXTRA_INFO(i3cdev->info.pid);
> > > > +
> > > > +		/* First try to match by manufacturer/part ID. */
> > > > +		for (id = id_table; id->match_flags != 0; id++) {
> > > > +			if ((id->match_flags & I3C_MATCH_MANUF_AND_PART) !=
> > > > +			    I3C_MATCH_MANUF_AND_PART)
> > > > +				continue;
> > > > +
> > > > +			if (manuf != id->manuf_id || part != id->part_id)
> > > > +				continue;
> > > > +
> > > > +			if ((id->match_flags & I3C_MATCH_EXTRA_INFO) &&
> > > > +			    ext_info != id->extra_info)
> > > > +				continue;
> > > > +
> > > > +			return id;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	/* Fallback to DCR match. */
> > > > +	for (id = id_table; id->match_flags != 0; id++) {
> > > > +		if ((id->match_flags & I3C_MATCH_DCR) &&
> > > > +		    id->dcr == i3cdev->info.dcr)
> > > > +			return id;
> > > > +	}
> > > > +
> > > > +	return NULL;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(i3c_device_match_id);    
> > > 
> > > I just picked one random export here, but it feels like you are
> > > exporting a bunch of symbols you don't need to.  Why would something
> > > outside of the i3c "core" need to call this function?  
> > 
> > Because I'm not passing the i3c_device_id to the ->probe() method, and
> > if the driver is supporting different variants of the device, it may
> > want to know which one is being probed.
> > 
> > I considered retrieving this information in the core just before probing
> > the driver and passing it to the ->probe() function, but it means
> > having an extra i3c_device_match_id() call for everyone even those who
> > don't care about the device_id information, so I thought exporting this
> > function was a good alternative (device drivers can use it when they
> > actually need to retrieve the device_id).
> > 
> > Anyway, that's something I can change if you think passing the
> > i3c_device_id to the ->probe() method is preferable.
> > 
> > > Have you looked
> > > to see if you really have callers for everything you are exporting?  
> > 
> > Yes, I tried to only export functions that I think will be needed by
> > I3C device drivers and I3C master drivers. Note that I didn't post the
> > dummy device driver I developed to test the framework (partly because
> > this is 
> 
> Sorry, I hit the send button before finishing my sentence :-).
> 
> "
> Note that I didn't post the dummy device driver [1] I developed to test
> the framework (partly because the quality of the code does not meet
> mainline standards and I was ashamed of posting it publicly :-)), but
> this driver is using some of the exported functions.
> "

We don't export functions that has no in-kernel users :)

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
