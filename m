From: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
Subject: Re: Handling of i2c arbitration loss
Date: Thu, 19 Feb 2009 22:23:25 +0100
Message-ID: <20090219212325.GC16107@clifford.at>
References: <200812222101.mBML1kn7021201@imap1.linux-foundation.org> <20090108154604.2cade06e@hyperion.delvare> <200901081155.27866.david-b@pacbell.net> <20090109100145.GA12376@clifford.at> <20090214121745.39dfddf9@hyperion.delvare> <20090214180014.GA19352@clifford.at> <20090215113122.5bcc3f3d@hyperion.delvare> <20090216131026.GA17437@clifford.at> <20090219172605.7e70a797@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090219172605.7e70a797-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Thu, Feb 19, 2009 at 05:26:05PM +0100, Jean Delvare wrote:
> > @@ -1000,7 +1000,8 @@ module_exit(i2c_exit);
> >   */
> >  int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg *msgs, int num)
> >  {
> > -	int ret;
> > +	unsigned long orig_jiffies = jiffies;
> 
> I think you should initialize orig_jiffies *after* you get the bus
> lock. Otherwise the behavior depends on how long you had to wait to get
> control of the bus. Or was is intended?

phew! this is a good question...

to be honest: I haven't thought about that one yet.

I think both approaches (including the wait for the lock in the timeout on
the one hand and just counting the time spent after getting the lock on the
other hand) would be valid..

But I think it would be better to not include the wait-for-lock time and
move the initialization of orig_jiffies to after locking the mutex.

In the case of including the wait-for-lock time there should be a timeout
handling added to the lock code so it only tries to get the lock for not
longer than the timeout... So my code is broken eighter way... ;-)

> > +		/* Retry automatically on arbitration loss */
> > +		for (ret = 0, try = 0; try <= adap->retries; try++) {
> > +			ret = adap->algo->master_xfer(adap, msgs, num);
> > +			if (ret != -EAGAIN)
> > +				break;
> > +			if (time_after(jiffies, orig_jiffies + adap->timeout))
> 
> This assumes that adap->timeout is expressed in jiffies. Which
> according to a comment in include/linux/i2c-dev.h, is the case, but
> this must be for historical reasons. This never made sense to me, as it
> means that the actual timeout value depends on the value of HZ.
> 
> The key problem here is that the timeout value is exported to
> user-space and can be changed by user-space. And user-space normally
> doesn't know the value of HZ... So the timeout value should be
> expressed in a constant time unit.

I haven't had a look at the code but would it be so hard to convert the
timeout value to ms or something alike when exporting the value to
user-space and convert in the other direction on reading from user-space?

imo jiffies is the best unit for time within the kernel and I would prefer
having one place for the convertion instead of duplicating it in every
single driver and multiple places in i2c-core..

> This problem isn't directly related to your patch, however so far
> drivers were handling the timeout internally so I didn't really care.
> Now that your patch will make use of the timeout value in i2c-core, I'd
> like to clarify the situation first.


yours,
 - clifford

-- 
"Perfection [in design] is achieved not when there is nothing left to
add, but rather when there is nothing left to take away."
 - Antoine de Saint-Exupery
