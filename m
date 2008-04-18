From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Fri, 18 Apr 2008 10:59:53 +0200
Message-ID: <fu9nua$b0l$1@ger.gmane.org>
References: <1207914198-8561-1-git-send-email-w.sang@pengutronix.de>	<20080414143925.31b55b39@hyperion.delvare>	<200804140857.33732.david-b@pacbell.net>
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

David Brownell wrote:

> That was obviously tested only at HZ=100 or with quick-ish
> EEPROMs!
Ah, okay. I was aware that msleep(1) waits not less than 10ms with 
HZ=100. I simply wondered, how to reach the timeout value for bigger 
HZ-values.

> That loop should (a) run at least a few times, maybe three;
> and (b) not exit before the timeout passes.
...or (c) return successfully as soon as possible. This is why you used 
msleep(1) and not something like msleep(AT24_EE_TIMEOUT / 2). I got it :)

 > 	timeout = ... ;
 > 	retries = 0;
 > 	while (retries++ < 3 || time_before(jiffies, timeout)) {
 > 		... try write, quit loop on success ...
 > 		msleep(1);
 > 	}
This looks good, will include it!

    Wolfram

-- 
   Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
