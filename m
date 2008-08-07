From: Dmitry Baryshkov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-pxa: fix scheduling while
	atomic	in	i2c_pxa_abort()
Date: Thu, 7 Aug 2008 10:12:54 +0000 (UTC)
Message-ID: <g7ehr6$i0n$2@ger.gmane.org>
References: <20080805111711.GA4807@doriath.ww600.siemens.net>
	<20080806223816.GD2716@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
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

Ben Dooks wrote:

> On Tue, Aug 05, 2008 at 03:17:11PM +0400, Dmitry Baryshkov wrote:
>> i2c_pxa_abort can be called from the atomic context. Change it to use
>> mdelay and counted loop.
> 
> if this can be called from an atomic context, is there a distinct
> possibility you are going to stop execution of the entire cpu for the
> time it takes to sort this out? Is it possible to disable the interrupt
> request, fire a work-struct to deal with this and then re-enabled the
> controller once it is finished?

If the bus isn't stalled by some hanged device, the reset will happen very
fast, so I don't see a reason to take that route.

However I'd implement the suggestion by Eric to choose mdelay or msleep
based on the atomicity of the context.

>  
>> Signed-off-by: Dmitry Baryshkov
>> <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>




-- 
With best wishes
Dmitry



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
