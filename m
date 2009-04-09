From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Handling of i2c arbitration loss
Date: Thu, 9 Apr 2009 08:47:26 +0200
Message-ID: <20090409084726.3f2bd193@hyperion.delvare>
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
	<20090220124546.193e49f2@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090220124546.193e49f2-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 20 Feb 2009 12:45:46 +0100, Jean Delvare wrote:
> On Thu, 19 Feb 2009 22:23:25 +0100, Clifford Wolf wrote:
> > Hi Jean,
> > 
> > On Thu, Feb 19, 2009 at 05:26:05PM +0100, Jean Delvare wrote:
> > > > @@ -1000,7 +1000,8 @@ module_exit(i2c_exit);
> > > >   */
> > > >  int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg *msgs, int num)
> > > >  {
> > > > -	int ret;
> > > > +	unsigned long orig_jiffies = jiffies;
> > > 
> > > I think you should initialize orig_jiffies *after* you get the bus
> > > lock. Otherwise the behavior depends on how long you had to wait to get
> > > control of the bus. Or was is intended?
> > 
> > phew! this is a good question...
> > 
> > to be honest: I haven't thought about that one yet.
> > 
> > I think both approaches (including the wait for the lock in the timeout on
> > the one hand and just counting the time spent after getting the lock on the
> > other hand) would be valid..
> >
> > But I think it would be better to not include the wait-for-lock time and
> > move the initialization of orig_jiffies to after locking the mutex.
> 
> I agree... Please send an updated patch.

Clifford, any news? I didn't get any update for this patch. If I don't
get one soon, I'll have to just discard it.

-- 
Jean Delvare
