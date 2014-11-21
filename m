From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [1/5] i2c: i2c-davinci: switch to use platform_get_irq
Date: Fri, 21 Nov 2014 08:03:26 -0600
Message-ID: <CAL_JsqJKhtzx9NKQ9R=m_4ReCUM9FP71mE7oRkScxPE7k881AA@mail.gmail.com>
References: <1416477788-5544-2-git-send-email-grygorii.strashko@ti.com>
 <20141120214838.GA346@pengutronix.de> <546F1B7D.1020209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <546F1B7D.1020209-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 21, 2014 at 5:01 AM, Grygorii Strashko
<grygorii.strashko-l0cyMroinI0@public.gmane.org> wrote:
> On 11/20/2014 11:48 PM, Uwe Kleine-K=C3=B6nig wrote:
>> Hello Grygorii,
>>
>> On Thu, Nov 20, 2014 at 12:03:04PM +0200, Grygorii Strashko wrote:
>>> Switch Davinci I2C driver to use platform_get_irq(), because
>>> - it is not recommened to use
>>>    platform_get_resource(pdev, IORESOURCE_IRQ, ..) for requesting I=
RQ's
>>>    resources any more, as they can be not ready yet in case of DT-b=
ooting.
>>> - it makes code simpler
>>>
>>> CC: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>>> CC: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>>> CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>> CC: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
>>> ---
>>>   drivers/i2c/busses/i2c-davinci.c | 14 +++++++-------
>>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/=
i2c-davinci.c
>>> index 4d96147..9bbfb8f 100644
>>> --- a/drivers/i2c/busses/i2c-davinci.c
>>> +++ b/drivers/i2c/busses/i2c-davinci.c
>>> @@ -640,13 +640,13 @@ static int davinci_i2c_probe(struct platform_=
device *pdev)
>>>   {
>>>      struct davinci_i2c_dev *dev;
>>>      struct i2c_adapter *adap;
>>> -    struct resource *mem, *irq;
>>> -    int r;
>>> +    struct resource *mem;
>>> +    int r, irq;
>>>
>>> -    irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>> -    if (!irq) {
>>> -            dev_err(&pdev->dev, "no irq resource?\n");
>>> -            return -ENODEV;
>>> +    irq =3D platform_get_irq(pdev, 0);
>> One bad thing about platform_get_irq is its unusual handling of irq=3D=
0.
>> I'm pretty sure you don't want to use this value, so adding somethin=
g
>> like:
>>
>>       if (!irq)
>>               irq =3D -ENXIO
>>
>> would be welcome because the usual value for "invalid irq" is 0 and =
not
>> -ESOMETHING. platform_get_irq is one of the very few functions that
>> don't adhere to this convention. With handling <=3D 0 as error your =
code
>> is immune to changes in this area. Although I notice that
>> platform_get_irq got worse in this respect to handle -EPROBE_DEFER. =
hmm.
>>
>> Apart from your change I wonder if platform_get_irq should handle
>> of_irq_get returning 0 as an error.
>
> I think you are right and It seems like, the check for !irq should
> be added/restored for OF case in platform_get_irq() too.

Changing the return values of platform_get_irq is tricky as it would
potentially break drivers because NO_IRQ can be 0 or -1 depending on
the arch. Drivers checking against specific values of NO_IRQ would
break. We've done some clean-up in this area, but I suspect more is
needed.

Rob
