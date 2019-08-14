From: Max Staudt <max@enpas.org>
Subject: Re: [PATCH v2 1/4] i2c/busses: Add i2c-icy for I2C on m68k/Amiga
Date: Thu, 15 Aug 2019 00:33:40 +0200
Message-ID: <f33ef44e-61e8-0392-7f5c-5a0bd7b42fff@enpas.org>
References: <20190812235237.21797-1-max@enpas.org>
 <20190814194714.GB9756@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814194714.GB9756@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Thanks for your input!
Replies below.


On 08/14/2019 09:47 PM, Wolfram Sang wrote:
>> +static int clock = 0x1c;
>> +module_param(clock, int, 0444);
> 
> 'clock' determines the bus speed?

Yes, but it also determines the frequency of the oscillator driving the PCF8584. It doesn't usually need to be touched, the current setting drives at the maximum I2C bus speed, with the maximum oscillator (12 MHz).
I kept it in because i2c-elektor also exposes it in the same way, and it seems useful.


>> +	i2c->adapter.class = I2C_CLASS_DEPRECATED;
> 
> This is only needed for drivers which used to have a class and decided
> to drop it. You can leave it empty.

Thanks, I'll drop it.


>> +	algo_data->data = (void *)i2c;
> 
> You don't need the cast, do you?

True. Dropped, thanks.


>> +MODULE_LICENSE("GPL");
> 
> Your SPDX header says GPL 2.0 only.

Thanks! I'll change it to "GPL v2", but unfortunately there is no option for "only" in include/linux/module.h.


Cheers

Max
