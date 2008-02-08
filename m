From: "Andrej *" <union.kjesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c isa and 2.6.24
Date: Fri, 8 Feb 2008 23:46:54 +0100
Message-ID: <7ed6758e0802081446i455c6a4q488d8f39a15aa537@mail.gmail.com>
References: <7ed6758e0802080306v4ca26537ob578de47a03f8035@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <7ed6758e0802080306v4ca26537ob578de47a03f8035-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> Before 2.6.24 I had also i2c_isa module, but there isn't any in latest
> kernel, and I think that lack ot it is causing problem.
>
> How can I get temperature, voltage and fan readings for MB with 2.6.24 kernel?
>

I found that that temps etc. are shown when using kernel 2.6.23-14
with exact same config.
So I'm asuming that something changed in w83781d module.

Only change in Changelog for 2.6.24 is this:
 hwmon: (w83781d) Add missing curly braces

    Missing curly braces cause an if statement to be evaluated when it
    shouldn't. It happens to be harmless, but that's still worth fixing.
    Thanks to Riku Voipio for reporting.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
