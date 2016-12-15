From: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2] i2c: designware: Cleaning and comment style fixes.
Date: Thu, 15 Dec 2016 15:53:07 +0000
Message-ID: <6fc278a6-dc22-37f8-0868-9f4359cfecf8@synopsys.com>
References: <d7b5a22ce09539c2af343c21ca69675bef6a0a10.1481812563.git.lolivei@synopsys.com>
 <f11794ec-439b-5fcd-65f4-c14c319cd627@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f11794ec-439b-5fcd-65f4-c14c319cd627-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 15-Dec-16 15:17, Peter Rosin wrote:
> On 2016-12-15 15:38, Luis Oliveira wrote:
>> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
>> index 26250b425e2f..3cb81fca7738 100644
>> --- a/drivers/i2c/busses/i2c-designware-core.h
>> +++ b/drivers/i2c/busses/i2c-designware-core.h
>> @@ -36,7 +36,7 @@
>>  #define DW_IC_CON_SPEED_FAST		0x4
>>  #define DW_IC_CON_SPEED_HIGH		0x6
>>  #define DW_IC_CON_SPEED_MASK		0x6
>> -#define DW_IC_CON_10BITADDR_MASTER	0x10
>> +#define DW_IC_CON_10BITADDR_MASTER		0x10
> 
> How is this an improvement?

It is not, I will fix it.

Thanks,
Luis
> 
> Cheers,
> peda
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
