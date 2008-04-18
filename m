From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Fri, 18 Apr 2008 16:06:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0804181555560.15372@shell4.speakeasy.net>
References: <1207914198-8561-1-git-send-email-w.sang@pengutronix.de>
	<20080414143925.31b55b39@hyperion.delvare>
	<200804140857.33732.david-b@pacbell.net>
	<200804171417.23753.david-b@pacbell.net>
	<Pine.LNX.4.58.0804172346580.10592@shell2.speakeasy.net>
	<20080418103149.GA4245@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080418103149.GA4245-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 18 Apr 2008, Wolfram Sang wrote:
> On Fri, Apr 18, 2008 at 01:07:51AM -0700, Trent Piepho wrote:
>
> > So the loop tries the write for the first time, fails (which is perfectly
> > acceptable), then sleeps for more than timeout jiffies.  The timeout
> > expires and the write is never tried again.
> Ehrm, the conditions for the while loop are OR-ed not AND-ed. So, even if
> time_before changes to false, 'retries < 3' will keep the loop running.
> I think this minimum of three tries will also cover the other issues you
> (correctly) mentioned.

Oh, of course.  I had ignored the retries because it seemed like a bad
idea.  If the timeout is based on time, why does it matter how many tries
there were?

Still, if you want to wait at least 25 ms, on a HZ=1000 system you might
wait only 3 ms.  And on a HZ=100 system, you'll wait at least 60 ms when
the timeout only needed to be 25 ms.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
