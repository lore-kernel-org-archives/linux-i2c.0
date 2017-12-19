From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2 2/7] i3c: Add core I3C infrastructure
Date: Tue, 19 Dec 2017 10:13:36 +0100
Message-ID: <20171219101336.337d0afc@bbrezillon>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
        <20171214151610.19153-3-boris.brezillon@free-electrons.com>
        <20171219085250.GC15010@kroah.com>
        <20171219100900.35c0f66e@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20171219100900.35c0f66e@bbrezillon>
Sender: linux-doc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.orglinux-
List-Id: linux-i2c@vger.kernel.org

On Tue, 19 Dec 2017 10:09:00 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> On Tue, 19 Dec 2017 09:52:50 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Dec 14, 2017 at 04:16:05PM +0100, Boris Brezillon wrote:  
> > > +/**
> > > + * i3c_device_match_id() - Find the I3C device ID entry matching an I3C dev
> > > + * @i3cdev: the I3C device we're searching a match for
> > > + * @id_table: the I3C device ID table
> > > + *
> > > + * Return: a pointer to the first entry matching @i3cdev, or NULL if there's
> > > + *	   no match.
> > > + */
> > > +const struct i3c_device_id *
> > > +i3c_device_match_id(struct i3c_device *i3cdev,
> > > +		    const struct i3c_device_id *id_table)
> > > +{
> > > +	const struct i3c_device_id *id;
> > > +
> > > +	/*
> > > +	 * The lower 32bits of the provisional ID is just filled with a random
> > > +	 * value, try to match using DCR info.
> > > +	 */
> > > +	if (!I3C_PID_RND_LOWER_32BITS(i3cdev->info.pid)) {
> > > +		u16 manuf = I3C_PID_MANUF_ID(i3cdev->info.pid);
> > > +		u16 part = I3C_PID_PART_ID(i3cdev->info.pid);
> > > +		u16 ext_info = I3C_PID_EXTRA_INFO(i3cdev->info.pid);
> > > +
> > > +		/* First try to match by manufacturer/part ID. */
> > > +		for (id = id_table; id->match_flags != 0; id++) {
> > > +			if ((id->match_flags & I3C_MATCH_MANUF_AND_PART) !=
> > > +			    I3C_MATCH_MANUF_AND_PART)
> > > +				continue;
> > > +
> > > +			if (manuf != id->manuf_id || part != id->part_id)
> > > +				continue;
> > > +
> > > +			if ((id->match_flags & I3C_MATCH_EXTRA_INFO) &&
> > > +			    ext_info != id->extra_info)
> > > +				continue;
> > > +
> > > +			return id;
> > > +		}
> > > +	}
> > > +
> > > +	/* Fallback to DCR match. */
> > > +	for (id = id_table; id->match_flags != 0; id++) {
> > > +		if ((id->match_flags & I3C_MATCH_DCR) &&
> > > +		    id->dcr == i3cdev->info.dcr)
> > > +			return id;
> > > +	}
> > > +
> > > +	return NULL;
> > > +}
> > > +EXPORT_SYMBOL_GPL(i3c_device_match_id);    
> > 
> > I just picked one random export here, but it feels like you are
> > exporting a bunch of symbols you don't need to.  Why would something
> > outside of the i3c "core" need to call this function?  
> 
> Because I'm not passing the i3c_device_id to the ->probe() method, and
> if the driver is supporting different variants of the device, it may
> want to know which one is being probed.
> 
> I considered retrieving this information in the core just before probing
> the driver and passing it to the ->probe() function, but it means
> having an extra i3c_device_match_id() call for everyone even those who
> don't care about the device_id information, so I thought exporting this
> function was a good alternative (device drivers can use it when they
> actually need to retrieve the device_id).
> 
> Anyway, that's something I can change if you think passing the
> i3c_device_id to the ->probe() method is preferable.
> 
> > Have you looked
> > to see if you really have callers for everything you are exporting?  
> 
> Yes, I tried to only export functions that I think will be needed by
> I3C device drivers and I3C master drivers. Note that I didn't post the
> dummy device driver I developed to test the framework (partly because
> this is 

Sorry, I hit the send button before finishing my sentence :-).

"
Note that I didn't post the dummy device driver [1] I developed to test
the framework (partly because the quality of the code does not meet
mainline standards and I was ashamed of posting it publicly :-)), but
this driver is using some of the exported functions.
"

[1]https://github.com/bbrezillon/linux-0day/commit/10054caf3493524b6ae352a1bdcb71e82c885a6e
