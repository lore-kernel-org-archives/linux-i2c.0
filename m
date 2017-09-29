From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH v3 1/4] i2c: Switch to using gpiod interface for gpio bus
 recovery
Date: Fri, 29 Sep 2017 14:59:00 +0800
Message-ID: <249f3801-d7b0-dd27-a838-6e7ca6967447@electromag.com.au>
References: <1504073857-122449-1-git-send-email-preid@electromag.com.au>
 <1504073857-122449-2-git-send-email-preid@electromag.com.au>
 <1506595483.16112.137.camel@linux.intel.com>
 <2ecc500b-42ec-8f30-b8cf-fd646eaaa198@linux.intel.com>
 <1506596304.16112.155.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:53079 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750929AbdI2G7F (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 29 Sep 2017 02:59:05 -0400
In-Reply-To: <1506596304.16112.155.camel@linux.intel.com>
Content-Language: en-AU
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, mika.westerberg@linux.intel.com, wsa@the-dreams.de, tim@krieglstein.org, linux-i2c@vger.kernel.org

On 28/09/2017 18:58, Andy Shevchenko wrote:
> On Thu, 2017-09-28 at 13:54 +0300, Jarkko Nikula wrote:
>> On 09/28/2017 01:44 PM, Andy Shevchenko wrote:
>>>> interface. This will allow individual driver to be updated and
>>>> tested
>>>> individual to switch to using the gpiod interface.
>>>>    	int scl_gpio;
>>>>    	int sda_gpio;
>>>> +	struct gpio_desc *scl_gpiod;
>>>> +	struct gpio_desc *sda_gpiod;
>>>
>>> I think we even could get rid of plain integers completely.
>>> In case some call needs it we can derive it still from the
>>> descriptor.
>>>
>>
>> I guess it's still worth to split that into multiple patches and
>> those
>> driver conversion and integer removal can be follow up patches
>> somewhere
>> in the future?
> 
> I didn't check and my memory is clean about users.
> So, if there are users of those integers outside of I2C core, definitely
> we need more patches / iterations.
> 
There's a couple of drivers using those.
If my approach looks good then I can try and update those as well.

Question is does it all need to be in the one patch series?


-- 
Regards
Phil Reid
