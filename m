From: Kalle Pokki <kalle.pokki-loK5ZF7nR+A@public.gmane.org>
Subject: Re: [PATCH] i2c-bfin-twi: Register adapter with a specific
	bus number
Date: Wed, 23 Jan 2008 10:54:45 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0801231047230.30599@pc-213-140-179-32.aina.net>
References: <Pine.LNX.4.64.0801222335050.11948@pc-213-140-179-32.aina.net>
	<1201075019.6725.7.camel@roc-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1201075019.6725.7.camel@roc-laptop>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 23 Jan 2008, Bryan Wu wrote:

> How do you think of following code, Kalle?
> 
> 	 /*
>          * If "dev->id" is negative we consider it as zero.
>          * The reason to do so is to avoid sysfs names that only make
>          * sense when there are multiple adapters.
>          */
>         p_adap->nr = dev->id >= 0 ? dev->id : 0;
> 
> I found some i2c-gpio, i2c-ibm_iic.c and i2c-pxa.c using this code,
> while others use your idea.

I don't see the point in ever defining dev->id as -1. None of the current 
users of i2c-bfin-twi does that. Another option could be to use dynamic 
bus numbers with dev->id == -1, but I think the only sane way to enumerate 
this kind of SOC busses is to fix the numbers in the machine 
initialization time.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
