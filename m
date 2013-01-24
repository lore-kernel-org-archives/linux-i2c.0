From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] i2c: at91: add of_device_id entry for at91rm9200
Date: Thu, 24 Jan 2013 08:58:28 +0100
Message-ID: <5100E9A4.9020804@atmel.com>
References: <1354743732-11581-1-git-send-email-manabian@gmail.com>
 <20121218060232.GL23971@game.jcrosoft.org>
 <20130124072714.GH8364@nekote.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130124072714.GH8364@nekote.pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Joachim Eastwood <manabian@gmail.com>, nicolas.ferre@atmel.com, ludovic.desroches@atmel.com, linux-i2c@vger.kernel.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 01/24/2013 08:27 AM, Wolfram Sang wrote:
> On Tue, Dec 18, 2012 at 07:02:32AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 22:42 Wed 05 Dec     , Joachim Eastwood wrote:
>>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>>> ---
>>> Hi,
>>>
>>> AT91RM9200 is gaining DT support now so let's add an id to the i2c driver.
>>>
>>> Tested on custom RM9200 board. Since the driver doesn't support pinctrl
>>> muxing yet I had to add pinctrl hogs for the i2c pins in my dts for it
>>> to work.
>>
>> IIRC the i2c IP have quite a lots of issue on rm9200 and until sam9g45
>>
>> it not recommended to use it instead use i2c-gpio
>
> Ludovic, you know the driver best. Does it make sense to add this?

I didn't add this when I did the rework because there was no DT tree 
support for RM9200. The configuration for RM9200 IP is already in the 
driver and used for non DT platform so I think it makes sense to add this.

But as Jean-Christophe said, it's recommended to use the i2c-gpio driver 
since we know the first versions of the IP have several issues. However 
if it fits user usage, it is not forbidden to use it.

Regards

Ludovic

>
>>
>> Best Regards,
>> J.
>>>
>>> regards
>>> Joachim Eastwood
>>>
>>>   drivers/i2c/busses/i2c-at91.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
>>> index b4575ee..c504aa8 100644
>>> --- a/drivers/i2c/busses/i2c-at91.c
>>> +++ b/drivers/i2c/busses/i2c-at91.c
>>> @@ -584,6 +584,9 @@ static const struct platform_device_id at91_twi_devtypes[] = {
>>>   #if defined(CONFIG_OF)
>>>   static const struct of_device_id atmel_twi_dt_ids[] = {
>>>   	{
>>> +		.compatible = "atmel,at91rm9200-i2c",
>>> +		.data = &at91rm9200_config,
>>> +	} , {
>>>   		.compatible = "atmel,at91sam9260-i2c",
>>>   		.data = &at91sam9260_config,
>>>   	} , {
>>> --
>>> 1.8.0
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
