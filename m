From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Handling of i2c arbitration loss
Date: Fri, 20 Feb 2009 12:45:46 +0100
Message-ID: <20090220124546.193e49f2@hyperion.delvare>
References: <200812222101.mBML1kn7021201@imap1.linux-foundation.org>
	<20090108154604.2cade06e@hyperion.delvare>
	<200901081155.27866.david-b@pacbell.net>
	<20090109100145.GA12376@clifford.at>
	<20090214121745.39dfddf9@hyperion.delvare>
	<20090214180014.GA19352@clifford.at>
	<20090215113122.5bcc3f3d@hyperion.delvare>
	<20090216131026.GA17437@clifford.at>
	<20090219172605.7e70a797@hyperion.delvare>
	<20090219212325.GC16107@clifford.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090219212325.GC16107-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 19 Feb 2009 22:23:25 +0100, Clifford Wolf wrote:
> Hi Jean,
> 
> On Thu, Feb 19, 2009 at 05:26:05PM +0100, Jean Delvare wrote:
> > > @@ -1000,7 +1000,8 @@ module_exit(i2c_exit);
> > >   */
> > >  int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg *msgs, int num)
> > >  {
> > > -	int ret;
> > > +	unsigned long orig_jiffies = jiffies;
> > 
> > I think you should initialize orig_jiffies *after* you get the bus
> > lock. Otherwise the behavior depends on how long you had to wait to get
> > control of the bus. Or was is intended?
> 
> phew! this is a good question...
> 
> to be honest: I haven't thought about that one yet.
> 
> I think both approaches (including the wait for the lock in the timeout on
> the one hand and just counting the time spent after getting the lock on the
> other hand) would be valid..
>
> But I think it would be better to not include the wait-for-lock time and
> move the initialization of orig_jiffies to after locking the mutex.

I agree... Please send an updated patch.

> In the case of including the wait-for-lock time there should be a timeout
> handling added to the lock code so it only tries to get the lock for not
> longer than the timeout... So my code is broken eighter way... ;-)

That's a different issue. But I don't think we really need to handle
this case. You should never wait long before you get access to the bus.
If you do then there is a design problem which needs to be solved, and
timing out if you don't get the bus lock in a given amount of time
isn't going to solve it. If one really can't afford waiting for the bus
then the i2c_transfer() function should return immediately (as it
already does in the can't-sleep case.)

> > This assumes that adap->timeout is expressed in jiffies. Which
> > according to a comment in include/linux/i2c-dev.h, is the case, but
> > this must be for historical reasons. This never made sense to me, as it
> > means that the actual timeout value depends on the value of HZ.
> > 
> > The key problem here is that the timeout value is exported to
> > user-space and can be changed by user-space. And user-space normally
> > doesn't know the value of HZ... So the timeout value should be
> > expressed in a constant time unit.
> 
> I haven't had a look at the code but would it be so hard to convert the
> timeout value to ms or something alike when exporting the value to
> user-space and convert in the other direction on reading from user-space?

You are perfectly right. I came out to the same conclusion as I woke up
this morning. Sleep over it...

> imo jiffies is the best unit for time within the kernel and I would prefer
> having one place for the convertion instead of duplicating it in every
> single driver and multiple places in i2c-core..

Well you have to do the conversion in each driver either way, as
hard-coding a number of jiffies is a bad idea (makes the timeout depend
on the value of HZ). But I agree it is better to convert from ms to
jiffies once at initialization rather than each time we need to use the
timeout value.

I'll send a patch to the list now, addressing the issue in i2c-dev.
Your own work is unaffected by this.

-- 
Jean Delvare
