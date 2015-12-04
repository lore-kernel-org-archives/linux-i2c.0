From: Christophe Ricard <christophe.ricard@gmail.com>
Subject: Re: [PATCH v3 0/2] ACPI: Add irq_type to gpio interrupt
Date: Sat, 5 Dec 2015 00:36:19 +0100
Message-ID: <56622373.7020406@gmail.com>
References: <1448923673-2582-1-git-send-email-christophe-h.ricard@st.com>
 <20151201112127.GA1593@lahna.fi.intel.com>
 <CALD+uuxJw5tQ2XY99nHigXdNkcXGnng+r9NZ8H9TqUF9GbgW=A@mail.gmail.com>
 <20151201130324.GE1593@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36764 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbbLDXgY (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 4 Dec 2015 18:36:24 -0500
In-Reply-To: <20151201130324.GE1593@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Christophe Ricard <christophe-h.ricard@st.com>

Hi Mika,


On 01/12/2015 14:03, Mika Westerberg wrote:
[...]
>>     Now for the same kind of i2c driver using acpi description, the GpioInt
>>     polarity/type is at the moment never kept in the irq property.
>>     It is possible to check that following about the same path...
>>     i2c_device_probe (drivers/i2c/i2c-core.c), retrieves irq property from
>>     acpi_dev_gpio_irq_get but does not save the irq_type.
>>     This would allow not to have to use an additional gpio field and all
>>     the configuration step to configure the gpio interrupt correctly in a
>>     device driver and taking a real benefit of the GpioInt acpi keyword
>>     compare to GpioIo keyword.
>>     Most the of the drivers based on acpi description retrieve gpio number
>>     to assign an interrupt and a fix polarity. I believe my patchset
>>     proposal would improve this and allow to
>>     be much closer with devicetree.
>>     Do you see any issue with this ?
> No, but I wonder if it would be better to do this in acpi_dev_gpio_irq_get()
> instead of acpi_find_gpio() which gets called everytime a GPIO is looked up?
I believe, setting the irq type requires triggering and polarity data 
stored into a struct acpi_resource_gpio.

acpi_dev_gpio_irq_get call acpi_get_gpiod_by_index which run acpi_find_gpio.

Actually acpi_dev_gpio_irq_get is called everytime an i2c device slave 
is probed, acpi_find_gpio will get called to "register" gpios.
If done correctly, i think this will be done only once...

The only improvement i may see would be to add an extra field in the 
acpi_gpio_info structure in drivers/gpio/gpiolib.h (for example int 
irq_type).
And call irq_set_irq_type in acpi_dev_gpio_irq_get if the gpio is an 
interrupt.

I guess the current proposal and this one are equivalent...

What do you think ?

Best Regards
Christophe
