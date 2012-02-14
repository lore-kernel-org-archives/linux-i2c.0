From: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Subject: Re: [RFC PATCH 5/7] ARM: davinci: i2c: add OF support
Date: Tue, 14 Feb 2012 08:16:40 +0100
Message-ID: <4F3A0A58.5030707@denx.de>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
 <1327308967-8092-6-git-send-email-hs@denx.de>
 <20120213233726.GK2999@freya.fluff.org>
Reply-To: hs-ynQEQJNshbs@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20120213233726.GK2999-RazCHl0VsYgkUSuvROHNpA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Ben,

Ben Dooks wrote:
> On Mon, Jan 23, 2012 at 09:56:05AM +0100, Heiko Schocher wrote:
>> add of support for the davinci i2c driver.
>>
>> Signed-off-by: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
>> Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
>> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
>> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>> Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>> Cc: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
>> ---
>>  .../devicetree/bindings/arm/davinci/i2c.txt        |   39 ++++++++++++++++++
>>  drivers/i2c/busses/i2c-davinci.c                   |   43 ++++++++++++++++++++
>>  2 files changed, 82 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/davinci/i2c.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/davinci/i2c.txt b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
>> new file mode 100644
>> index 0000000..94ec670
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
[...]
>> +Optional properties:
>> +- bus-delay: bus delay in usec
> 
> bus_delay sounds rather like frequency in a different name, what is it for?

from drivers/i2c/busses/i2c-davinci.c i2c_davinci_xfer_msg():

        /* Introduce a delay, required for some boards (e.g Davinci EVM) */
        if (pdata->bus_delay)
                udelay(pdata->bus_delay);

so I added this option to OF support too, but I do not know more about
this "feature" ...

[...]
>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
>> index a76d85f..6f59fae 100644
>> --- a/drivers/i2c/busses/i2c-davinci.c
>> +++ b/drivers/i2c/busses/i2c-davinci.c
>> @@ -38,9 +38,12 @@
[...]
>> +MODULE_DEVICE_TABLE(of, davinci_i2c_of_match);
>> +#else
>> +#define davinci_i2c_of_match NULL
>> +#endif
> 
> see of_match_ptr() and you won't need the #else.

Yep, already fixed, as Grant Likely commented.

>>  static int davinci_i2c_probe(struct platform_device *pdev)
>>  {
>>  	struct davinci_i2c_dev *dev;
>> @@ -676,7 +689,34 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>>  	dev->irq = irq->start;
>>  	platform_set_drvdata(pdev, dev);
>>  
>> +	if ((dev->dev->platform_data == NULL) &&
>> +		(pdev->dev.of_node)) {
> 
> If there's platform_data an of_node, what happens then?

Then platform_data is used.

>> +		struct device_node *pinmux_np;
>> +		struct davinci_i2c_platform_data *pdata;
>> +		u32 prop;
>> +
>> +		dev->dev->platform_data = &davinci_i2c_platform_data_default;
>> +		pdata = &davinci_i2c_platform_data_default;
>> +		if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
>> +			&prop))
>> +			pdata->bus_freq = prop / 1000;
>> +		if (!of_property_read_u32(pdev->dev.of_node, "bus-delay",
>> +			&prop))
>> +			pdata->bus_delay = prop;
>> +		if (!of_property_read_u32(pdev->dev.of_node, "id",
>> +			&prop)) {
>> +			pdev->id = prop;
>> +			pdev->dev.init_name = kzalloc(20, GFP_KERNEL);
>> +			sprintf((char *)pdev->dev.init_name,
>> +				"i2c_davinci.%d", pdev->id);
>> +		}
> 
> Is this _really_ necessary, looks a bit of a hack to me.

Yep, "id" completely removed, as Grant Likely commented too.

[...]

Thanks for looking through this. Posting v2 soon.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
