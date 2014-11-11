From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 3/4] i2c-i801: Check if interrupts are disabled
Date: Tue, 11 Nov 2014 21:06:46 +0100
Message-ID: <20141111210646.02b77c68@endymion.delvare>
References: <20141110222655.13660613@endymion.delvare>
	<20141110223139.02aafde4@endymion.delvare>
	<20141111105853.GB3794@katana>
	<20141111153214.39dfaeb8@endymion.delvare>
	<20141111144107.GA1330@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141111144107.GA1330@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 11 Nov 2014 15:41:07 +0100, Wolfram Sang wrote:
> 
> > > > +		if (pcists & SMBPCISTS_INTS)
> > > > +			dev_warn(&dev->dev, "An interrupt is pending!\n");
> > > 
> > > You think it is better to not clear it?
> > 
> > I admit I did not think about it. As I am trying to better understand
> > the few mysterious failure cases that have been reported to me, I just
> > wanted to log everything out of the ordinary. I have no idea what's
> > considered the right thing to do in such a situation. Do you believe
> > that clearing the interrupt is the appropriate action in that case?
> 
> Depends on the driver, I'd say (which I haven't looked at in detail). If
> this causes the irq handler to be called as soon as the irq is
> registered, and if the state machine gets confused then, then it should
> be cleared beforehand, of course.

The driver should survive just fine if the irq handler is called early,
but lacking the context, it won't do anything useful. Essentially it
will clear the interrupt and wake up an empty queue.

My actual concern is that I don't know what that would mean if an
interrupt is pending at driver load time. If this is a leftover from a
previous driver removal, or from the machine initialization (BIOS) then
clearing it would be the right thing to do. But this could also mean
that something (e.g. ACPI) is using the hardware and we should not.
That being said, hitting the very moment where an interrupt is pending
would be pretty random, so we can hardly rely on that anyway. Or this
could mean that the interrupt setup is wrong somehow and we can't trust
the SMBPCISTS_INTS because it is always set. At this point I just don't
know.

Another thing I am wondering about, and thinking about it again (I wrote
this code several months ago) this is probably the reason why I added
the test in the first place: can a new interrupt be triggered as long
as the previous one has not been cleared? If not, that could explain
why the driver sometimes didn't work at all in interrupt mode on some
systems.

> If this is not the case, then it might be better to be less intrusive,
> spit the warning, and wait for somebody to show up with this message in
> the logs.

That was my intent, yes. We can always add an action later when we
understand the situation better. If we ever get such a report, which
might in fact never happen.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
