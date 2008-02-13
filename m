From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 6/6] Minor fixes for pxa-driver
Date: Wed, 13 Feb 2008 11:08:58 +0100
Message-ID: <20080213110858.784ed811@hyperion.delvare>
References: <20080121142010.988419876@pengutronix.de>
	<20080121143659.089906703@pengutronix.de>
	<20080213095839.5d99d48a@hyperion.delvare>
	<E913911567467945BBEB9277E27868B083D61E@msiexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <E913911567467945BBEB9277E27868B083D61E-3TKN+kxLw8+HXkj8w7BxOhL4W9x8LtSr@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Eric Miao <ymiao3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Eric,

On Wed, 13 Feb 2008 01:22:52 -0800, Eric Miao wrote:
> Hi wolfram,
> 
> I can help test this of cuz, yet I have a few questions:
> 
> 1. what's the exact reason of moving the i2c->adap.nr assignment to the
> begining, it looks this is unnecessary since I didn't find any dependency
> of the following code on i2c->adap.nr ??

There is a dependency:

-	sprintf(i2c->adap.name, "pxa_i2c-i2c.%u", dev->id);

+	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "pxa_i2c-i2c.%u",
+		 i2c->adap.nr);

We are using i2c->adap.nr instead of dev->id to generate the adapter
name. This is to avoid a name of "pxa_i2c-i2c.-1" if there is a single
platform device, "pxa_i2c-i2c.0" looks better I think.

> 
> 2. the remaining changes looks good, so they are clean up right? instead
> of trying to fix something

Yes, these are essentially cleanups, I don't think that anything bad
was really happening in practice before this patch.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
