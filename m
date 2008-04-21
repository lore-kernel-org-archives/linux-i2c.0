From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Mon, 21 Apr 2008 11:17:46 +0200
Message-ID: <fuhm3r$sok$1@ger.gmane.org>
References: <1207914198-8561-1-git-send-email-w.sang@pengutronix.de>	<20080414143925.31b55b39@hyperion.delvare>	<200804140857.33732.david-b@pacbell.net>	<200804171417.23753.david-b@pacbell.net>	<Pine.LNX.4.58.0804172346580.10592@shell2.speakeasy.net>	<20080418103149.GA4245@pengutronix.de>
	<Pine.LNX.4.58.0804181555560.15372@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0804181555560.15372-13q4cmjDBaTP3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Trent Piepho wrote:

> Oh, of course.  I had ignored the retries because it seemed like a bad
> idea.  If the timeout is based on time, why does it matter how many tries
> there were?
Because then you have a guaranteed number of tries, even if the timeout 
value was reached due to some reason.

> Still, if you want to wait at least 25 ms, on a HZ=1000 system you might
> wait only 3 ms.  
I'm sorry, I fail to see this. If there are more than three retries, 
then there is still the time_before-condition which keeps the loop 
running until the timeout is reached, no?

> And on a HZ=100 system, you'll wait at least 60 ms when
> the timeout only needed to be 25 ms.
Yes, because there is this policy to retry at least three times. Maybe 
it is an idea to introduce a module parameter which lets the user select 
a suitable retry parameter?

    Wolfram

-- 
   Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
