From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] i2c-mux-gpio: test if the gpio can sleep
Date: Thu, 10 Oct 2013 21:51:08 +0200
Message-ID: <5257052C.4050206@metafoo.de>
References: <525667C4.3080309@nsn.com> <52566971.5020700@metafoo.de> <20131010194354.GC23512@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20131010194354.GC23512@katana>
Sender: linux-gpio-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ionut Nicu <ioan.nicu.ext@nsn.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Alexander Sverdlin <alexander.sverdlin@nsn.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 10/10/2013 09:43 PM, Wolfram Sang wrote:
> On Thu, Oct 10, 2013 at 10:46:41AM +0200, Lars-Peter Clausen wrote:
>
>>> +		if (gpio_cansleep(gpio))
>>> +			gpio_set_value_cansleep(gpio, val & (1 << i));
>>> +		else
>>> +			gpio_set_value(gpio, val & (1 << i));
>>
>> The proper way to do this is just always use the _cansleep() version.
>> gpio_set_value() only works for chips which do not sleep,
>> gpio_set_value_cansleep() works for both those who do sleep and those who do
>> not.
>
> To the gpio-list: Has it been considered to have sth. like
> gpio_set_value and gpio_set_value_nosleep? I'd think it makes more sense
> to have the specific function have the specific name.

It has been a few times, but I think the conclusion has always been that it is 
now too late to invert the semantics of gpio_set_value(). If you want to look 
up the discussions the keyword is gpio_set_value_atomic().

- Lars

