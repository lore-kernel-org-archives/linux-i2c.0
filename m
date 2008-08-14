From: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [RFC] PXA3xx: Add support for power i2c bus
Date: Thu, 14 Aug 2008 13:28:54 +0300
Message-ID: <48A408E6.4000506@compulab.co.il>
References: <48A3F2EB.8030809@compulab.co.il>
	<f17812d70808140202k2edd82dfhea421a649dea85d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <f17812d70808140202k2edd82dfhea421a649dea85d7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ARM Linux <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



Eric Miao wrote:
> On Thu, Aug 14, 2008 at 4:55 PM, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org> wrote:
>> This patch adds support for power i2c bus on PXA3xx processor.
>>
>> Signed-off-by: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
>>
> 
> I'd like the i2c driver to be converted to ioremap() and {read,write}l()
> first before this can happen.

It is already using {read,write}l() unless I'm realy missing something...


> pxa27x_set_i2c_power_info()
> 
> and
> 
> pxa3xx_set_i2c_power_info()
> 
> are OK to co-exist, no need for a unified version. IOW, I'd prefer
> the previous invocations of pxa_set_i2c_power_info() to be
> renamed "pxa27x_set_i2c_power_info()"

Ok.

> The caller is supposed to know which to call.
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
