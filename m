From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 5/7] ARM: davinci: i2c: add OF support
Date: Mon, 16 Jul 2012 21:46:17 +0530
Message-ID: <50043E51.8070702@ti.com>
References: <1338373143-7467-1-git-send-email-hs@denx.de>
 <1338373143-7467-6-git-send-email-hs@denx.de> <5000294C.5070606@ti.com>
 <5000F276.3080301@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5000F276.3080301-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: hs-ynQEQJNshbs@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 7/14/2012 9:45 AM, Heiko Schocher wrote:
> Hello Sekhar,
> 
> On 13.07.2012 15:57, Sekhar Nori wrote:
>> Hi Heiko,
>>
>> On 5/30/2012 3:49 PM, Heiko Schocher wrote:
>>> add of support for the davinci i2c driver.
>>>
>>> Signed-off-by: Heiko Schocher<hs-ynQEQJNshbs@public.gmane.org>
>>> Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
>>> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>>> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
>>> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> Cc: Ben Dooks<ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>>> Cc: Wolfram Sang<w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>>> Cc: Grant Likely<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>>> Cc: Sekhar Nori<nsekhar-l0cyMroinI0@public.gmane.org>
>>> Cc: Wolfgang Denk<wd-ynQEQJNshbs@public.gmane.org>
>>> Cc: Sylwester Nawrocki<s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> [...]

[...]

>>> diff --git a/drivers/i2c/busses/i2c-davinci.c
>>> b/drivers/i2c/busses/i2c-davinci.c
>>> index a76d85f..4e7a966 100644
>>> --- a/drivers/i2c/busses/i2c-davinci.c
>>> +++ b/drivers/i2c/busses/i2c-davinci.c

[...]

>>>   static int davinci_i2c_probe(struct platform_device *pdev)
>>>   {
>>>       struct davinci_i2c_dev *dev;
>>> @@ -676,6 +695,25 @@ static int davinci_i2c_probe(struct
>>> platform_device *pdev)
>>>       dev->irq = irq->start;
>>>       platform_set_drvdata(pdev, dev);
>>>
>>> +    if ((dev->dev->platform_data == NULL)&&
>>> +        (pdev->dev.of_node)) {
>>> +        u32 prop;
>>> +
>>> +        dev->pdata = devm_kzalloc(&pdev->dev,
>>> +            sizeof(struct davinci_i2c_platform_data), GFP_KERNEL);
>>> +        if (!dev->pdata) {
>>> +            r = -ENOMEM;
>>> +            goto err_free_mem;
>>> +        }
>>> +        memcpy(dev->pdata,&davinci_i2c_platform_data_default,
>>> +            sizeof(struct davinci_i2c_platform_data));
>>> +        if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
>>> +            &prop))
>>> +            dev->pdata->bus_freq = prop / 1000;
>>> +        if (!of_property_read_u32(pdev->dev.of_node, "bus-delay",
>>> +            &prop))
>>> +            dev->pdata->bus_delay = prop;
>>
>> You are leaving out two other platform data members (the gpio pins
>> corresponding to data and clock) from DT data. We should be able to
>> get that information from DT too, right?
> 
> Yes, but I had not ported the GPIO driver to OF ...

Okay. Understood. They can added once GPIO has been ported too and this
part is tested.

> 
>> So, I took this patch and tried to see if pdata maintenance can be
>> simplified and came with the diff below. Can you have a look and see
>> if this makes sense? I tested this using i2cdetect both with and
>> without DT.
> 
> Tested your patch on the enbw_cmc board with a LM75 on the enbw_cmc
> board, works fine. Can I post a "v6" of my patch, merged with your
> patch below and your Signed-off?

Yes, please do. You can post it as in independent patch (not as part of
a series) since the patch does not have any dependencies.

Thanks,
Sekhar
