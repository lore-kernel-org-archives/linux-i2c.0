From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH 3/6] i2c: add 'set_sda' to bus_recovery_info
Date: Tue, 5 Dec 2017 17:57:11 +0800
Message-ID: <53d5696c-6f0d-1717-5c9e-4facf397f284@electromag.com.au>
References: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
 <20171204123640.3382-4-wsa+renesas@sang-engineering.com>
 <CACRpkdZzwo9UhT08VDHXg6=eXdK80Pt1omZ4Xda_HFwguyNpaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:57904 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753222AbdLEJ5V (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 5 Dec 2017 04:57:21 -0500
In-Reply-To: <CACRpkdZzwo9UhT08VDHXg6=eXdK80Pt1omZ4Xda_HFwguyNpaw@mail.gmail.com>
Content-Language: en-AU
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Andrzej Hajda <a.hajda@samsung.com>

On 5/12/2017 16:39, Linus Walleij wrote:
> On Mon, Dec 4, 2017 at 1:36 PM, Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> 
>> This will be needed when we want to create STOP conditions, too, later.
>> Create the needed fields and populate them for the GPIO case if the GPIO
>> is set to output.
>>
>> Cc: Phil Reid <preid@electromag.com.au>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> Cc: Claudio Foellmi <claudio.foellmi@ergon.ch>
>> Cc: Andrzej Hajda <a.hajda@samsung.com>
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> (...)
>>   #include <linux/errno.h>
>> +#include <linux/gpio.h>
> 
> Please no.
> 
>> +                       if (gpiod_get_direction(bri->sda_gpiod) == GPIOF_DIR_OUT)
>> +                               bri->set_sda = set_sda_gpio_value;
> 
> Just compare it to zero. if (!gpiod_get_direction())
> 
> This flag is only for requesting GPIOs in the old API.
> We didn't add a define in the new API, it seemed overengineered.
> 

Perhaps the docs need updating?
as of 4.15-rc2 it says
  * Return GPIOF_DIR_IN or GPIOF_DIR_OUT, or an error code in case of error.

I can submit something if you wish.


-- 
Regards
Phil Reid
