From: zhangfei gao <zhangfei.gao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/2] i2c: designware: add two optional property tx/rx-fifo-size
Date: Sun, 11 Aug 2013 15:29:06 +0800
Message-ID: <CAMj5BkhsBJ77uvKuB_R0qL45b2v1Ums-UTPpE7-8h=MEE5Skfg@mail.gmail.com>
References: <1374844938-25505-1-git-send-email-zhangfei.gao@linaro.org>
	<1374844938-25505-3-git-send-email-zhangfei.gao@linaro.org>
	<20130810125015.GB18085@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130810125015.GB18085-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Aug 10, 2013 at 8:50 PM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> On Fri, Jul 26, 2013 at 02:22:18PM +0100, Zhangfei Gao wrote:
>> Some platform can not get fifo-size info form register DW_IC_COMP_PARAM_1.
>
> s/form/from/
>
> Why can they not get info from the register? Is it not implemented, or
> buggy? It would be nice to mention why.

Dear Mark

Thanks for asking me such question.
When trying to answer this question, I find this patch is not needed now.
It should be caused by my mistake.

Really appreciated.

>
>> Give chance to update rx-fifo-size and tx-fifo-size if provided in dts.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Acked-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
>> ---
>>  .../devicetree/bindings/i2c/i2c-designware.txt     |    7 +++++++
>>  drivers/i2c/busses/i2c-designware-platdrv.c        |    3 +++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
>> index 7fd7fa2..af0bf8f 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
>> @@ -6,6 +6,11 @@ Required properties :
>>   - reg : Offset and length of the register set for the device
>>   - interrupts : <IRQ> where IRQ is the interrupt number.
>>
>> +Optional properties:
>> +
>> + - rx-fifo-size : 1 cell, Rx fifo size
>> + - tx-fifo-size : 1 cell, Tx fifo size
>
> Units? I assume these are in bytes?
>
> It would be nice to mention in the bidning when you need these
> properties (i.e. only hwen you can't figure it out from
> DW_IC_COMP_PARAM_1 becase ________.
>
> Thanks,
> Mark.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
