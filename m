From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/5] i2c: i2c-davinci: switch to use platform_get_irq
Date: Wed, 26 Nov 2014 18:28:05 +0200
Message-ID: <5475FF95.6030502@ti.com>
References: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com> <1417010393-30598-2-git-send-email-grygorii.strashko@ti.com> <20141126155431.GK4431@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141126155431.GK4431-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Looijmans <milo-software-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 11/26/2014 05:54 PM, Uwe Kleine-K=F6nig wrote:
> Hello Grygorii,
>
> On Wed, Nov 26, 2014 at 03:59:49PM +0200, Grygorii Strashko wrote:
>> Switch Davinci I2C driver to use platform_get_irq(), because
>> it is not recommened to use platform_get_resource(pdev, IORESOURCE_I=
RQ, ..)
>> for requesting IRQ resources any more, as they can be not ready yet
>> in case of DT-boot.
>>
>> CC: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>> CC: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>> CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> CC: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/i2c/busses/i2c-davinci.c | 20 ++++++++++++--------
>>   1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i=
2c-davinci.c
>> index 4d96147..7f54903 100644
>> --- a/drivers/i2c/busses/i2c-davinci.c
>> +++ b/drivers/i2c/busses/i2c-davinci.c
>> @@ -640,13 +640,17 @@ static int davinci_i2c_probe(struct platform_d=
evice *pdev)
>>   {
>>   	struct davinci_i2c_dev *dev;
>>   	struct i2c_adapter *adap;
>> -	struct resource *mem, *irq;
>> -	int r;
>> -
>> -	irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> -	if (!irq) {
>> -		dev_err(&pdev->dev, "no irq resource?\n");
>> -		return -ENODEV;
>> +	struct resource *mem;
>> +	int r, irq;
>> +
>> +	irq =3D platform_get_irq(pdev, 0);
>> +	if (irq <=3D 0) {
>> +		if (irq =3D=3D -EPROBE_DEFER)
>> +			return irq;
>> +		if (!irq)
>> +			irq =3D -ENXIO;
>> +		dev_err(&pdev->dev, "can't get irq resource ret=3D%d\n", irq);
>> +		return irq;
> The simpler and I think also more usual logic is:
>
> 	if (!irq)
> 		irq =3D -ENXIO;
> 	if (irq !=3D -EPROBE_DEFER)
> 		dev_err(...);
> 	return irq;
>
> Other than that the patch looks fine.

Ok. will change and add your ack.

regards,
-grygorii
