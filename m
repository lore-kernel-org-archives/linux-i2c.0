From: "Olivares, Ricardo Perez" <richo-l0cyMroinI0@public.gmane.org>
Subject: FW: [PATCH RESEND] I2C: OMAP: Add missing wakeup events
Date: Tue, 13 Oct 2009 16:27:24 -0500
Message-ID: <A69FA2915331DC488A831521EAE36FE401554D7449@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

 

-----Original Message-----
From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Aaro Koskinen
Sent: Tuesday, October 13, 2009 4:52 AM
To: Sonasath, Moiz
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: [PATCH RESEND] I2C: OMAP: Add missing wakeup events

Hello,

Sonasath, Moiz wrote:
>> From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor-l0cyMroinI0@public.gmane.org>
>>
>> Include wake up events for receiver overflow and transmitter 
>> underflow in OMAP_I2C_WE_REG configuration. Also fix a small typo.
>>
>> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-omap.c |    5 ++++-
>>  1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c 
>> b/drivers/i2c/busses/i2c-omap.c index 827da08..34ea9ed 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -92,8 +92,10 @@
>>  #define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost int ena */
>>
>>  /* I2C WE wakeup enable register */
>> -#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakup */
>> +#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakeup */
>>  #define OMAP_I2C_WE_RDR_WE	(1 << 13)	/* RX drain wakeup */
>> +#define OMAP_I2C_WE_ROVR_WE	(1 << 11)	/* RX overflow wakeup */
>> +#define OMAP_I2C_WE_XUDF_WE	(1 << 10)	/* TX underflow wakeup */
> 
> These bits are not documented in OMAP3430, they are reserved. How can they be used?

Hmm, that's a valid point. I will have to check if I can find more info on the background of this patch.

A.
--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
