From: Marco Aurelio da Costa <costa-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org>
Subject: Re: pca9665
Date: Fri, 19 Sep 2008 09:09:53 -0300
Message-ID: <48D39691.1070905@gamic.com>
References: <48D12295.8080008@gamic.com> <20080919100819.GC4307@pengutronix.de>
	<48D38EF5.60303@gamic.com> <20080919115605.GE4307@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080919115605.GE4307-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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


Wolfram Sang wrote:
>
> Sounds like the right way to do it. I just wonder if we simply can
> enforce this change of platform_data or if we should provide some
> transition feature. Jean, Ben, others, what are your experiences?
>
>   
The way it does today is to pass an index for the frequency.
I can make the change so that it uses the 9564 by default, and if the 
frequency is set from 0 - 7 (not possible for a real frequency), I will 
use it as an index. We may put a warning that this usage is deprecated. 
Is this acceptable?

Marco

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
