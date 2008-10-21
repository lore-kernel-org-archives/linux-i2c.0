From: Mark Jackson <mpfj@mimc.co.uk>
Subject: Re: [i2c] [PATCH v2] Add support for Dallas DS28CM00 Unique ID chip
Date: Tue, 21 Oct 2008 20:40:07 +0100
Message-ID: <48FE3017.4080009@mimc.co.uk>
References: <48FDED5E.5080605@mimc.co.uk>	<20081021173505.2f7673e2@hyperion.delvare>	<48FE22A2.7030604@mimc.co.uk> <20081021211219.18fb7d84@hyperion.delvare> <48FE2ADC.8020203@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755246AbYJUTk3@vger.kernel.org>
In-Reply-To: <48FE2ADC.8020203@mimc.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: i2c@lm-sensors.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Mark Jackson wrote:
> Jean Delvare wrote:
>> Hi Mark,
>>
>> On Tue, 21 Oct 2008 19:42:42 +0100, Mark Jackson wrote:
>>> Jean Delvare wrote:
>>>> Nack. No new drivers under drivers/i2c/chips please, it's going away
>>>> soon.
>>> Okay ... where should any new drivers be located ?
>>
>> Depends of what the device does.
>> * Hardware monitoring chip drivers go to drivers/hwmon
>> * RTC chip drivers go to drivers/rtc
>> * I/O expander drivers go to drivers/gpio
>> If you can't find a suitable directory under drivers, either create a
>> new one if that makes sense, or put your driver under drivers/misc.
> 
> Ah, now I understand !!  I think drivers/misc is probably a good a place 
> as any,

In fact, I now realise that the device is *really* just a read-only eeprom.

So I'm guessing I don't need a custom driver, I can just use the existing
"at24" driver.

Ho hum ...
