From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Fri, 18 Apr 2008 16:26:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0804181614310.15372@shell4.speakeasy.net>
References: <1207914198-8561-1-git-send-email-w.sang@pengutronix.de>
	<200804171417.23753.david-b@pacbell.net>
	<Pine.LNX.4.58.0804172346580.10592@shell2.speakeasy.net>
	<200804180948.15298.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200804180948.15298.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 18 Apr 2008, David Brownell wrote:
> > So the loop tries the write for the first time, fails (which is perfectly
> > acceptable), then sleeps for more than timeout jiffies.  The timeout
> > expires and the write is never tried again.
>
> That specific scenario can't happen.  It's forced to "re"try a few times,
> even if the vagaries of scheduling make it sleep "too long".

Yeah, I missed that.  Though it's still possible that the last write
attempt will be only 3 ms after the loop started, even if the timeout is
supposed to be longer.


> > Generally, if you want to wait at least a certain amount time for a
> > condition to become true, you must be sure to check the condition at
> > least once AFTER the time limit.
>
> Fair enough.  But if you're going to be concerned about that, you
> should also be concerned about the start point for this "timeout".
> It should begin closer to when the previous write's STOP got to the
> chip.

As long as the start point is after the last write, and we know it is, then
the timeout is correct.  You want to be sure at least X ms have elapsed
since the previous write operation finished and the last failed attempt at
the current current.  Starting the timeout closer to the previous write's
STOP would let you avoid waiting longer than necessary, but it's not needed
for correctness.

> > Here's two examples of a good way to do this, depending on how you want
> > the control flow to go.
> >
> > 	unsigned long timeout = ... ;
> > 	for (;;) {
> > 		unsigned long wtime = jiffies;
>
> Given preemption and other scheduling delays, "wtime" can be
> arbitrarily long before the bytes start to arrive at the chip.
> This suffers the same flaw you mentioned above.

I'm afraid I don't follow you.  How is possible for this loop to timeout
before the chip has been given the minimum time needed to respond?

>
> > 		if (write() == success)
> > 			break;
> > 		if (time_after_eq(wtime, timeout)) {
> > 			... failure ...
> > 			return -ESOMETHING;
> > 		}
> > 		msleep(1);
> > 	}
> > 	... success ...
> >
> >
> > 	unsigned long timeout = ... ;
> > 	for (wtime = timeout; time_after(wtime, timeout);) {
              this should be !time_after
> > 		wtime = jiffies;
> > 		if (write() == success) {
> > 			... success ...
> > 			return 0;
> > 		}
> > 		msleep(1);
> > 	}
> > 	... failure ...
>
> Neither of those loops ever tries more than once, note.

Sure they do.  They will aways try *at least* once, maybe more times
depending on how many chances they get before enough time has elapsed.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
