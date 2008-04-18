From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Fri, 18 Apr 2008 01:07:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0804172346580.10592@shell2.speakeasy.net>
References: <1207914198-8561-1-git-send-email-w.sang@pengutronix.de>
	<20080414143925.31b55b39@hyperion.delvare>
	<200804140857.33732.david-b@pacbell.net>
	<200804171417.23753.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200804171417.23753.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Thu, 17 Apr 2008, David Brownell wrote:
> > are left-overs from earlier revisions and can be thrown out?
>
> Both of those tests should be moved into the for() test,
> so the tail end of the loop always does an msleep.  It'd
> be clearer as:
>
> 	timeout = ... ;
> 	retries = 0;
> 	while (retries++ < 3 || time_before(jiffies, timeout)) {
> 		... try write, quit loop on success ...
> 		msleep(1);
> 	}
>
> Yes, that loop has lots of leftovers.  :(

Certainly did.

Note that your loop has a flaw that can cause it to timeout incorrectly.

After the msleep's delay is used up, the process will enter the run
queue.  But there is no guarantee that the scheduler will select it to
run vs the other processes in the run queue!  It's entirely possible that
msleep(1) won't return for 1000s of ms.  On a 100 HZ system, 30 ms or
more would be quite common.  You get 20 just from the msleep, and 10 more
every time another processes runs.

So the loop tries the write for the first time, fails (which is perfectly
acceptable), then sleeps for more than timeout jiffies.  The timeout
expires and the write is never tried again.

Generally, if you want to wait at least a certain amount time for a
condition to become true, you must be sure to check the condition at
least once AFTER the time limit.  I.e, if you want to give the eeprom at
least 25 ms to respond, you need to try to write after at least 25 ms.
If 25 ms have passed, but the last time you tried to write was before 25
ms, then you didn't really give it 25 ms to respond.

Though it's less likely, on a preemptable kernel, you could be preempted
between setting timeout and the loop check, in which case the write might
never even be attempted at all!

Here's two examples of a good way to do this, depending on how you want
the control flow to go.

	unsigned long timeout = ... ;
	for (;;) {
		unsigned long wtime = jiffies;
		if (write() == success)
			break;
		if (time_after_eq(wtime, timeout)) {
			... failure ...
			return -ESOMETHING;
		}
		msleep(1);
	}
	... success ...


	unsigned long timeout = ... ;
	for (wtime = timeout; time_after(wtime, timeout);) {
		wtime = jiffies;
		if (write() == success) {
			... success ...
			return 0;
		}
		msleep(1);
	}
	... failure ...

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
