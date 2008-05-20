From: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V5] I2C bus driver for IMX
Date: Tue, 20 May 2008 09:39:53 +0300
Message-ID: <g0ts1e$mm$1@ger.gmane.org>
References: <g0c44d$2ji$1@ger.gmane.org>
	<20080514213214.GB16881@fluff.org.uk>	<g0hbge$qm2$1@ger.gmane.org>
	<Pine.LNX.4.58.0805161003320.23876@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0805161003320.23876-13q4cmjDBaTP3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
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
Cc: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> Also lets you do some
> sort of macro:
> #define dprintk(dev, fmt, args...) dev_dbg(dev, "<%s> " fmt, __func__, ## args)
>  or
> #define dprintk(fmt, args...) dev_dbg(&i2c_imx->adapter.dev, "<%s> " fmt, __func__, ## args)


Thank you (and all others) for all comments and for help writing this driver. Regarding such macros, I think it is pointless. Because there is opinion, that all kernel drivers should look similar, and 
dev_dbg() is used in most drivers.
It is macro itself, therefore I think in the future would be easier to read and debug this driver with standard debug macro.

BR,
Darius


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
