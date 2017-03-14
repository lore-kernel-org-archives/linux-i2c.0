From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v3 04/10] i2c: meson: use i2c core for DT clock-frequency
 parsing
Date: Tue, 14 Mar 2017 12:16:29 +0100
Message-ID: <305fc647-ffbe-c4b6-fba7-3b4f057cd181@baylibre.com>
References: <a0ebd65b-712d-2b15-dcc6-3b8a9a619770@gmail.com>
 <27b52215-3cbe-b407-c439-216fdace3745@gmail.com>
 <cd619caf-66b6-5b06-844f-4c8962fe860a@baylibre.com>
 <05593a02-9b4d-b937-deea-eef1161a0a10@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34101 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdCNLQk (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 14 Mar 2017 07:16:40 -0400
Received: by mail-wr0-f172.google.com with SMTP id l37so121768387wrc.1
        for <linux-i2c@vger.kernel.org>; Tue, 14 Mar 2017 04:16:39 -0700 (PDT)
In-Reply-To: <05593a02-9b4d-b937-deea-eef1161a0a10@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, linux-amlogic@lists.infradead.org
Cc: linux-i2c@vger.kernel.org, wsa@the-dreams.de, Jerome Brunet <jbrunet@baylibre.com>

On 03/13/2017 08:03 PM, Heiner Kallweit wrote:
> Am 13.03.2017 um 10:01 schrieb Neil Armstrong:
>> On 03/11/2017 07:23 PM, Heiner Kallweit wrote:
>>> We don't have to parse the DT manually to retrieve the bus frequency
>>> and we don't have to maintain an own default for the bus frequency.
>>> Let the i2c core do this for us.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
>>> ---
>>> v2:
>>> - added Reviewed-by
>>> v3:
>>> - changed order of patches
>>> ---
>>>  drivers/i2c/busses/i2c-meson.c | 8 +++-----
>>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
>>> index e597764e..ac0ac82d 100644
>>> --- a/drivers/i2c/busses/i2c-meson.c
>>> +++ b/drivers/i2c/busses/i2c-meson.c
>>> @@ -38,7 +38,6 @@
>>>  #define REG_CTRL_CLKDIV_MASK	((BIT(10) - 1) << REG_CTRL_CLKDIV_SHIFT)
>>>  
>>>  #define I2C_TIMEOUT_MS		500
>>> -#define DEFAULT_FREQ		100000
>>>  
>>>  enum {
>>>  	TOKEN_END = 0,
>>> @@ -387,15 +386,14 @@ static int meson_i2c_probe(struct platform_device *pdev)
>>>  	struct device_node *np = pdev->dev.of_node;
>>>  	struct meson_i2c *i2c;
>>>  	struct resource *mem;
>>> -	u32 freq;
>>> +	struct i2c_timings timings;
>>>  	int irq, ret = 0;
>>>  
>>>  	i2c = devm_kzalloc(&pdev->dev, sizeof(struct meson_i2c), GFP_KERNEL);
>>>  	if (!i2c)
>>>  		return -ENOMEM;
>>>  
>>> -	if (of_property_read_u32(pdev->dev.of_node, "clock-frequency", &freq))
>>> -		freq = DEFAULT_FREQ;
>>> +	i2c_parse_fw_timings(&pdev->dev, &timings, true);
>>>  
>>>  	i2c->dev = &pdev->dev;
>>>  	platform_set_drvdata(pdev, i2c);
>>> @@ -453,7 +451,7 @@ static int meson_i2c_probe(struct platform_device *pdev)
>>>  		return ret;
>>>  	}
>>>  
>>> -	meson_i2c_set_clk_div(i2c, freq);
>>> +	meson_i2c_set_clk_div(i2c, timings.bus_freq_hz);
>>>  
>>>  	return 0;
>>>  }
>>>
>>
>> Hi Heiner,
>>
>> I'm sorry, but you should *really* update the dt-bindings.
>>
>> The dt bindings are now strictly related to how the driver is implemented, or which
>> attributes are used, but how the device tree node should conform to.
>>
>> In this particular case, in the recent addition of "standard" i2c attributes for
>> speed and timings, you should refer to this "i2c.txt" file to specify how the node
>> should conform.
>>
>> And finally, this patch would be correct since the node will be supposed to conform
>> to the correct bindings.
>>
> I checked the DT documentation of all i2c drivers. Just two include something similar
> to what you request:
> 
> i2c-rcar.txt
> no remark for property clock-frequency
> i2c-scl-falling-time-ns: see i2c.txt
> 
> nvidia,tegra186-bpmp-i2c.txt
> See ../i2c/i2c.txt for details of the core I2C binding.
> 
> So you request a comment like the one in the tegra driver documentation?

Exactly.

> 
> The supported properties as such don't change in the meson driver, only
> clock-freqeuncy is supported as optional parameter.
> The timing properties are parsed by the core call but they are not used by the
> driver, so I don't think we are allowed to mention them in the documentation.
> Else a reader of the documentation may expect that setting such a timing
> parameter actually changes the behavior of the driver.

Ignore the fact the driver does not parse them, they are marked as optional
in the bindings, so the "DT author" will know they won't be necessarily parsed
or used.
Consider the bindings to be a contract between the DTS and the driver, the DTS
*must* respect the bindings with the mandatory properties and nodes, and can add
optional properties without insurance they will be used.
On the other side, the driver that respects the bindings knows that the mandatory
properties and nodes *must* be present (and *should* fail if not present), and knows
some optional properties and nodes can be present to specify some supplementary parameters,
but in this case fallbacks *must* be available.

> 
> Heiner
> 
>> Neil
>>
> 
