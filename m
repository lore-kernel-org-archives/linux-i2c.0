From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Thu, 17 Apr 2008 14:17:23 -0700
Message-ID: <200804171417.23753.david-b@pacbell.net>
References: <1207914198-8561-1-git-send-email-w.sang@pengutronix.de>
	<20080414143925.31b55b39@hyperion.delvare>
	<200804140857.33732.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200804140857.33732.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> In at24_ee_write:
> > +	/* Writes fail if the previous one didn't complete yet.  We'll
> > +	 * loop a few times until this one succeeds, waiting at least
> > +	 * long enough for one entire page write to work.
> > +	 */
> > +	timeout = jiffies + msecs_to_jiffies(AT24_EE_TIMEOUT);
> > +	for (retries = 0; retries < 3; retries++) {
> > +
> > +		if (at24->use_smbus) {
> > +			status = i2c_smbus_write_i2c_block_data(client,
> > +					offset, count, buf);
> > +			if (status == 0)
> > +				status = count;
> > +		} else {
> > +			status = i2c_transfer(client->adapter, &msg, 1);
> > +			if (status == 1)
> > +				status = count;
> > +		}
> > +		dev_dbg(&client->dev, "write %zd@%d --> %zd (%ld)\n",
> > +				count, offset, status, jiffies);
> > +
> > +		if (status == count)
> > +			return count;
> > +
> > +		if (retries < 3 || time_after(timeout, jiffies)) {
> > +			/* REVISIT:  at HZ=100, this is sloooow */
> > +			msleep(1);
> > +			continue;
> > +		}
> > +	}
>
> I assume 'retries < 3' (always true)

You mean, in that "if" at the end.


> and 'continue' (nothing follows) 

That particular "continue" is not necessary.


> are left-overs from earlier revisions and can be thrown out?

Both of those tests should be moved into the for() test,
so the tail end of the loop always does an msleep.  It'd
be clearer as:

	timeout = ... ;
	retries = 0;
	while (retries++ < 3 || time_before(jiffies, timeout)) {
		... try write, quit loop on success ...
		msleep(1);
	}

Yes, that loop has lots of leftovers.  :(


> My main 
> questions is 'msleep(1)' though: As I understand it, this means the
> for-loop will wait roughly 3ms on failures until it reports a timeout
> (assuming good precision of msleep).

That was obviously tested only at HZ=100 or with quick-ish
EEPROMs!  I seem to recall just doing enough work on it to
make sure it didn't break ... that wasn't a top priority.

That loop should (a) run at least a few times, maybe three;
and (b) not exit before the timeout passes.


> Comparing this to AT24_EE_TIMEOUT 
> (25 ms), it looks to me that the msleep value could be increased a
> little (maybe to AT24_EE_TIMEOUT / 3)? Or is i2c_transfer slow enough
> and can we count on that behaviour?

An msleep(1) -- when the platform can deliver it -- would
be desirable, since most EEPROMs don't actually need those
long delays.  Their writes finish in just a few msecs,
hardly anything needs that huge timeout.  At HZ=100 it's
likely to sleep 10 msec or more; that's OK, but slow.

The point of having an msleep() rather than just relying
on scheduler delay is that most EEPROMs do need some short
delay to finish their writes.  So a busy-wait is wasteful.

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
