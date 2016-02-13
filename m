From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH] i2c: designware: balance clk enable/disable on removal
Date: Sun, 14 Feb 2016 01:16:31 +0300
Message-ID: <56BFAB3F.7080607@ispras.ru>
References: <1454106696-5867-1-git-send-email-khoroshilov@ispras.ru>
 <56AF69D3.4070300@linux.intel.com>
 <1454337845.32507.20.camel@linux.intel.com> <20160212185400.GH1520@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:53395 "EHLO mail.ispras.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbcBMWQe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 13 Feb 2016 17:16:34 -0500
In-Reply-To: <20160212185400.GH1520@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

On 12.02.2016 21:54, Wolfram Sang wrote:
> On Mon, Feb 01, 2016 at 04:44:05PM +0200, Andy Shevchenko wrote:
>> On Mon, 2016-02-01 at 16:21 +0200, Jarkko Nikula wrote:
>>> On 01/30/2016 12:31 AM, Alexey Khoroshilov wrote:
>>>> It seems clk_disable_unprepare() is missed in dw_i2c_plat_remove(),
>>>> so the patch adds it.
>>>>
>>>> Found by Linux Driver Verification project (linuxtesting.org).
>>>>
>>>> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
>>>> ---
>>>>   drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> b/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> index 438f1b4964c0..8f19b7b81fe0 100644
>>>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> @@ -267,6 +267,7 @@ static int dw_i2c_plat_remove(struct
>>>> platform_device *pdev)
>>>>   	i2c_del_adapter(&dev->adapter);
>>>>
>>>>   	i2c_dw_disable(dev);
>>>> +	i2c_dw_plat_prepare_clk(dev, false);
>>>>
>>> I tried this quickly and it appears more work is needed. When 
>>> CONFIG_PM_SLEEP is set then autosuspending will do the unprepare and 
>>> this patch causes double unprepare at remove. But when
>>> CONFIG_PM_SLEEP 
>>> is not set then indeed those clk calls are out of sync.
>>
>> Besides that I would suggest to check carefully error patch in the
>> probe(), i.e. handling error from i2c_dw_probe(). There maybe similar
>> issue is hidden.
> 
> So, waiting for V2 on this one.
> 

I have a fix for error handling of i2c_dw_probe(), but I am not sure
what is the right approach to handle CONFIG_PM_SLEEP case.

What is a safe way to distinguish a need for the unprepare in
dw_i2c_plat_remove()?
Should we try to avoid double i2c_dw_disable(dev) in the same case?

--
Alexey
