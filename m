From: "fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH] i2c: imx: double check IIF in case interrupt lost
Date: Thu, 14 Aug 2014 10:09:42 +0000
Message-ID: <96d6e524bc524305904730df24bf878f@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1408004954-29418-1-git-send-email-b38611@freescale.com>
 <20140814094204.GW5134@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140814094204.GW5134-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> Sent: Thurs=
day, August 14, 2014 5:42 PM
>To: Duan Fugang-B38611
>Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Subject: Re: [PATCH] i2c: imx: double check IIF in case interrupt lost
>
>Hello,
>
>On Thu, Aug 14, 2014 at 04:29:14PM +0800, Fugang Duan wrote:
>> In i2c_imx_read():
>> ...
>> result =3D i2c_imx_trx_complete(i2c_imx); if (result)
>> 		return result;
>> ..
>>
>> If the current byte read complete, "IIF" status is set, and pend up
>> one GIC interrupt. In irq handler, wake up the wait queue in
>> .i2c_imx_trx_complete().
>>
>> But, for imx6q platform with high bus and cpu loading test cases,
>> after long time test, sometime i2c interrupt is lost, but "IIF" is
>> set, according to current logic code, i2c_imx_trx_complete() still
>> return "-ETIMEDOUT", and then i2c host don't read the rest of data,
>> i2c driver stop transmit, disable controller and clock. Thus, i2c
>> device cannot wait clock and always drive the SDA line.
>>
>> So, SDA is pulled down by i2c device, which needs 9 clocks to recove=
ry
>> the SDA line.
>>
>> To avoid the issue, we can double check IIF bit after timeout for
>> waiting event in .i2c_imx_trx_complete(), if IIF bit is set, process
>> it in normal flow. The patch just to double check IIF in case interr=
upt
>lost.
>>
>> Signed-off-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-imx.c |   10 ++++++++--
>>  1 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-imx.c
>> b/drivers/i2c/busses/i2c-imx.c index aa8bc14..4b63771 100644
>> --- a/drivers/i2c/busses/i2c-imx.c
>> +++ b/drivers/i2c/busses/i2c-imx.c
>> @@ -285,11 +285,17 @@ static int i2c_imx_bus_busy(struct
>> imx_i2c_struct *i2c_imx, int for_busy)
>>
>>  static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx)  {
>> +	unsigned int temp;
>> +
>>  	wait_event_timeout(i2c_imx->queue, i2c_imx->i2csr & I2SR_IIF, HZ /
>> 10);
>>
>>  	if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
>> -		dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n", __func__);
>> -		return -ETIMEDOUT;
>> +		/* Double check IIF to avoid interrupt lost */
>> +		temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
>> +		if (!(temp & I2SR_IIF)) {
>> +			dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n",
>__func__);
>> +			return -ETIMEDOUT;
>> +		}
>This smells fishy. If possible the fix should be not to loose an inter=
rupt.
>Can you
>
>If I2SR_IIF is unset in i2c_imx->i2csr this means that
>i2c_imx_trx_complete was already run before since the last irq trigger=
ed.
>But if then imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR) returns the IIF fl=
ag
>set why doesn't the irq trigger? That would mean there is a hardware b=
ug,
>doesn't it? Is there a related Errata? Does it apply to all SoCs using
>this driver? Did you check that the irq handling in the driver isn't r=
acy?
After we debug, it seems that irq lost in the stress case.
Because we increase the timeout value to one "HZ" in wait_event_timeout=
(), and it=20
Return "0" means no interrupt. But when we read I2SR, IIF bit is set.
There have no racy in the driver code, so we judge there have interrupt=
 lost.=20

After apply the patch, it really solve the issue.
>
>Did you test using irq threading and high-priority tasks? Did you prov=
e
>that the situation in question really occurs? (I.e. wait_event_timeout
>returns with I2SR_IIF unset in i2c_imx->i2csr but set in IMX_I2C_I2SR.=
) I
>didn't check the code and maybe this might be prevented by the i2c
>framework, but maybe you have two waiters?
>
As above.  I don't try irq thread and high priority task method.

>Best regards
>Uwe
>
Lin>--
>Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =
     |
>Industrial ux Solutions                 | http://www.pengutronix.de/  =
|
