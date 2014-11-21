From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [1/5] i2c: i2c-davinci: switch to use platform_get_irq
Date: Fri, 21 Nov 2014 13:01:17 +0200
Message-ID: <546F1B7D.1020209@ti.com>
References: <1416477788-5544-2-git-send-email-grygorii.strashko@ti.com> <20141120214838.GA346@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141120214838.GA346-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 11/20/2014 11:48 PM, Uwe Kleine-K=F6nig wrote:
> Hello Grygorii,
>=20
> On Thu, Nov 20, 2014 at 12:03:04PM +0200, Grygorii Strashko wrote:
>> Switch Davinci I2C driver to use platform_get_irq(), because
>> - it is not recommened to use
>>    platform_get_resource(pdev, IORESOURCE_IRQ, ..) for requesting IR=
Q's
>>    resources any more, as they can be not ready yet in case of DT-bo=
oting.
>> - it makes code simpler
>>
>> CC: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>> CC: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>> CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> CC: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/i2c/busses/i2c-davinci.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i=
2c-davinci.c
>> index 4d96147..9bbfb8f 100644
>> --- a/drivers/i2c/busses/i2c-davinci.c
>> +++ b/drivers/i2c/busses/i2c-davinci.c
>> @@ -640,13 +640,13 @@ static int davinci_i2c_probe(struct platform_d=
evice *pdev)
>>   {
>>   	struct davinci_i2c_dev *dev;
>>   	struct i2c_adapter *adap;
>> -	struct resource *mem, *irq;
>> -	int r;
>> +	struct resource *mem;
>> +	int r, irq;
>>  =20
>> -	irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> -	if (!irq) {
>> -		dev_err(&pdev->dev, "no irq resource?\n");
>> -		return -ENODEV;
>> +	irq =3D platform_get_irq(pdev, 0);
> One bad thing about platform_get_irq is its unusual handling of irq=3D=
0.
> I'm pretty sure you don't want to use this value, so adding something
> like:
>=20
> 	if (!irq)
> 		irq =3D -ENXIO
>=20
> would be welcome because the usual value for "invalid irq" is 0 and n=
ot
> -ESOMETHING. platform_get_irq is one of the very few functions that
> don't adhere to this convention. With handling <=3D 0 as error your c=
ode
> is immune to changes in this area. Although I notice that
> platform_get_irq got worse in this respect to handle -EPROBE_DEFER. h=
mm.
>=20
> Apart from your change I wonder if platform_get_irq should handle
> of_irq_get returning 0 as an error.

I think you are right and It seems like, the check for !irq should
be added/restored for OF case in platform_get_irq() too.

Also, I've simulated irq =3D=3D 0 case - the .probe() failed with error=
 -EINVAL
which is returned by request_threaded_irq() because of !irq_settings_ca=
n_request(desc).
 i2c_davinci 2530000.i2c: failure requesting irq 0
 i2c_davinci: probe of 2530000.i2c failed with error -22

I'm not sure that above will work for everyone because it depends on AR=
CH_IRQ_INIT_FLAGS
and ARCH_IRQ_INIT_FLAGS =3D (IRQ_NOREQUEST | IRQ_NOPROBE) for ARM.

>=20
>> +	if (irq < 0) {
>> +		dev_err(&pdev->dev, "can't get irq resource ret=3D%d\n", irq);
> Please don't print an error if irq=3D-EPROBE_DEFER.
ok.

regards,
-grygorii
