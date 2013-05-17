From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 9/9] I2C: mv64xxx: fix race between FSM/interrupt and
	process context
Date: Fri, 17 May 2013 11:00:16 +0100
Message-ID: <20130517100016.GB18614@n2100.arm.linux.org.uk>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk> <E1Ud4xE-0004KB-2T@rmk-PC.arm.linux.org.uk> <20130517095149.GI17056@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130517095149.GI17056@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Mark A. Greer" <mgreer-luAo+O/VEmrlveNOaEYElw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, May 17, 2013 at 11:51:51AM +0200, Wolfram Sang wrote:
> >  {
> >  	switch(drv_data->action) {
> >  	case MV64XXX_I2C_ACTION_SEND_RESTART:
> > +		/* We should only get here if we have further messages */
> > +		BUG_ON(drv_data->num_msgs == 0);
> > +
> 
> ...
> 
> > @@ -453,16 +463,20 @@ static int
> >  mv64xxx_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> >  {
> >  	struct mv64xxx_i2c_data *drv_data = i2c_get_adapdata(adap);
> > -	int	i, rc;
> > +	int rc, ret = num;
> >  
> > -	for (i = 0; i < num; i++) {
> > -		rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i],
> > -						i == 0, i + 1 == num);
> > -		if (rc < 0)
> > -			return rc;
> > -	}
> > +	BUG_ON(drv_data->msgs != NULL);
> 
> Can't we handle this more gracefully than to halt the kernel? Like
> WARN_ON and resetting the controller or disabling the bus or...

Well, the latter really is something which should never ever happen,
and if it does happen it can only really be because something's
screwed up in the locking in the I2C layer.

The former is more probable, and I thought about that, but I don't
have any good alternative solution.  Given the problems I've seen,
I don't think resetting the controller is really an option, because
that'll likely cause the bus to lock (that's the original problem
which I'm trying to solve in this patch.)  The thing really does
have to work according to the I2C protocol otherwise stuff goes
irrecoverably wrong to the point of needing an entire system reset.
