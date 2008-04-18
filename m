From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Fri, 18 Apr 2008 09:48:15 -0700
Message-ID: <200804180948.15298.david-b@pacbell.net>
References: <1207914198-8561-1-git-send-email-w.sang@pengutronix.de>
	<200804171417.23753.david-b@pacbell.net>
	<Pine.LNX.4.58.0804172346580.10592@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0804172346580.10592-nuiHJn5p267P3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
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
To: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday 18 April 2008, Trent Piepho wrote:
> On Thu, 17 Apr 2008, David Brownell wrote:
> > > are left-overs from earlier revisions and can be thrown out?
> >
> > Both of those tests should be moved into the for() test,
> > so the tail end of the loop always does an msleep.  It'd
> > be clearer as:
> >
> > 	timeout = ... ;
> > 	retries = 0;
> > 	while (retries++ < 3 || time_before(jiffies, timeout)) {
> > 		... try write, quit loop on success ...
> > 		msleep(1);
> > 	}
> >
> > Yes, that loop has lots of leftovers.  :(
> 
> Certainly did.
> 
> Note that your loop has a flaw that can cause it to timeout incorrectly.

Well, a "do ... while (...)" would obviously be better; and that's
not actually a "re"try.

But also remember that the specified "timeout" is already way beyond
what most chips need ... and that it's currently measured starting
at some point *well after* the relevant (previous) write returned.
So there's limited practical significance to problems with that loop.
It can/should be improved, sure; I'll wait to see what Wolfram does.


> So the loop tries the write for the first time, fails (which is perfectly
> acceptable), then sleeps for more than timeout jiffies.  The timeout
> expires and the write is never tried again.

That specific scenario can't happen.  It's forced to "re"try a few times,
even if the vagaries of scheduling make it sleep "too long".


> Generally, if you want to wait at least a certain amount time for a
> condition to become true, you must be sure to check the condition at
> least once AFTER the time limit.

Fair enough.  But if you're going to be concerned about that, you
should also be concerned about the start point for this "timeout".
It should begin closer to when the previous write's STOP got to the
chip.


> Though it's less likely, on a preemptable kernel, you could be preempted
> between setting timeout and the loop check, in which case the write might
> never even be attempted at all!

Again, you overlook the "re"try count, which ensures there
will be at least a few attempts.


> Here's two examples of a good way to do this, depending on how you want
> the control flow to go.
> 
> 	unsigned long timeout = ... ;
> 	for (;;) {
> 		unsigned long wtime = jiffies;

Given preemption and other scheduling delays, "wtime" can be
arbitrarily long before the bytes start to arrive at the chip.
This suffers the same flaw you mentioned above.

> 		if (write() == success)
> 			break;
> 		if (time_after_eq(wtime, timeout)) {
> 			... failure ...
> 			return -ESOMETHING;
> 		}
> 		msleep(1);
> 	}
> 	... success ...
> 
> 
> 	unsigned long timeout = ... ;
> 	for (wtime = timeout; time_after(wtime, timeout);) {
> 		wtime = jiffies;
> 		if (write() == success) {
> 			... success ...
> 			return 0;
> 		}
> 		msleep(1);
> 	}
> 	... failure ...

Neither of those loops ever tries more than once, note.

- Dave




_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
