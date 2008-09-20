From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: tvp5150 new style i2c driver
Date: Sat, 20 Sep 2008 11:36:29 +0200
Message-ID: <20080920113629.08986320@hyperion.delvare>
References: <48D3C5A3.3080802@spesonline.com>
	<20080919222608.030a3801@hyperion.delvare>
	<48D41902.9020804@spesonline.com>
	<20080920101623.791ed72f@hyperion.delvare>
	<48D4BDF9.8050003@spesonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48D4BDF9.8050003-wNesuFfO2Ajz1n+OaKNE4w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Luca Santini <luca.santini-wNesuFfO2Ajz1n+OaKNE4w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 20 Sep 2008 11:10:17 +0200, Luca Santini wrote:
> Oh... ok. Some example? glue code beetween the codec and...?

I am not aware of an example (of embedded platform with a video decoder
chip on a generic I2C bus) in the kernel at this point. But it
shouldn't be too different from regular v4l code. The only difference
being that the I2C bus code will be in a separate module, so you need
to get a reference to the i2c_adapter your chip is on. Presumably you
know the bus numbers in advance so you should be able to use
i2c_get_adapter() for that.

> can i bypass v4l ?

You can certainly bypass v4l if you want. It might make sense if you
can't afford the overhead. But on the other hand, implementing the
standard v4l interface has the huge benefit that you can then use all
the standard tools, and I doubt the overhead is that much.

> (...)
> My short-term goal is only initialize the codec and set the input
> source to composite ('sources' was in this sense.).
> I think  - as a quick and dirty solution - i'll copy the init code
> from the kernel driver and do this in userspace using /dev/i2c-X
> interface. But that's very ugly... ...but on the other hand i
> don't need (and i don't know how to use) a full v4l interface...

Using i2c-dev should work fine, even though I agree it's not
particularly elegant.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
