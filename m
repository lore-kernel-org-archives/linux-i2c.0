From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Mon, 21 Apr 2008 10:20:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0804211005410.15697@shell2.speakeasy.net>
References: <1207914198-8561-1-git-send-email-w.sang@pengutronix.de>
	<20080414143925.31b55b39@hyperion.delvare>
	<200804140857.33732.david-b@pacbell.net>
	<200804171417.23753.david-b@pacbell.net>
	<Pine.LNX.4.58.0804172346580.10592@shell2.speakeasy.net>
	<20080418103149.GA4245@pengutronix.de>
	<Pine.LNX.4.58.0804181555560.15372@shell4.speakeasy.net>
	<fuhm3r$sok$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <fuhm3r$sok$1@ger.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 21 Apr 2008, Wolfram Sang wrote:
> Trent Piepho wrote:
> > Oh, of course.  I had ignored the retries because it seemed like a bad
> > idea.  If the timeout is based on time, why does it matter how many tries
> > there were?
> Because then you have a guaranteed number of tries, even if the timeout
> value was reached due to some reason.

Is there a reason to always try at least a certain number of times?

If it hasn't been long enough since the last write, the next write isn't
suppose to work.  That's the expected operation of the device.  But if it
has been long enough, and the write still fails, then it seems to me that
the behavior has changed from normal operation to an error.

> > Still, if you want to wait at least 25 ms, on a HZ=1000 system you might
> > wait only 3 ms.
> I'm sorry, I fail to see this. If there are more than three retries,
> then there is still the time_before-condition which keeps the loop
> running until the timeout is reached, no?

Except for the timing problem I pointed out before.  The timeout is checked
before the write takes place.  So if after the 3rd attempt the msleep(), or
kernel preemption, etc., delays for 22 ms or more, the next write will
never happen.

> > And on a HZ=100 system, you'll wait at least 60 ms when
> > the timeout only needed to be 25 ms.
> Yes, because there is this policy to retry at least three times. Maybe
> it is an idea to introduce a module parameter which lets the user select
> a suitable retry parameter?

I wouldn't have extra retries.  It's part of the chip's specs that there
has to be some delay, exactly how much we don't know, between writes.  But
is there an eeprom that says in its specs that writes are unreliable?  That
they may fail for no reason and should be tried multiple times?

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
