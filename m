From: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: new style i2c client problem: probe () is not called
Date: Tue, 13 May 2008 15:45:29 +0300
Message-ID: <g0c2qb$ue1$1@ger.gmane.org>
References: <g0bqa9$b3$1@ger.gmane.org>
	<20080513104921.GA4485@pengutronix.de>	<g0bub0$eqh$1@ger.gmane.org>
	<20080513141337.20068339@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080513141337.20068339-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

  > This code looks OK to me. But which driver handles i2c bus 0? Does your
> platform code create i2c bus 0? i2c-code will instantiate the ov7670
> i2c device when i2c bus 0 is created by i2c_add_numbered_adapter(). So
> if you don't see it created, I suspect that i2c bus 0 itself is never
> registered.
> 

Thanks, there was the problem. I have modified i2c adapter driver to use 
  i2c_add_numbered_adapter() instead i2c_add_adapter() and pass to the 
adapter->nr = pdev->id. now probe is called.

Jean, what do you think about adding my i2c driver to mainline kernel?
I've added this to Russel patch tracking system. Now it is a bit 
ugraded. Should I make new patch and send it here?


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
