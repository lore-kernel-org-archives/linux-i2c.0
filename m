From: Max Staudt <max@enpas.org>
Subject: Re: [PATCH v2 1/4] i2c/busses: Add i2c-icy for I2C on m68k/Amiga
Date: Thu, 15 Aug 2019 14:10:56 +0200
Message-ID: <4661d2f3-13e1-ff62-22e1-e4391ccc38b2@enpas.org>
References: <20190812235237.21797-1-max@enpas.org>
 <20190814194714.GB9756@kunai>
 <f33ef44e-61e8-0392-7f5c-5a0bd7b42fff@enpas.org>
 <20190815071228.GA1054@kunai>
 <276714fb-6b3a-1e99-0744-bfd037305724@enpas.org>
 <20190815114809.GA1916@kunai>
 <54185c85-8c26-916e-41b1-af9b55223e7b@enpas.org>
 <20190815120430.GB1916@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815120430.GB1916@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
List-Id: linux-i2c@vger.kernel.org

On 08/15/2019 02:04 PM, Wolfram Sang wrote:
>>   When the PCF8584 is addressed as slave, this register
>>   must be loaded with the 7-bit I 2 C-bus address to which the
>>   PCF8584 is to respond. During initialization, the own
>>   address register S0' must be written to, regardless
>>   whether it is later used.
> 
> I see. It must be written a non-zero value to leave the monitor mode.
> But this really needs no callback, we can hardcode any non-zero value.
> If slave support is (ever) to be implemented, the own address will come
> from the I2C core.
The callback, just like getclock(), is from the existing i2c-algo-pcf, which I don't want to touch right now. So I'm afraid it has to stay, even if it returns a fixed number.

Touching or forking i2c-algo-pcf will be necessary in order to implement IRQ support, if I ever get around to it. I've wasted too much time on debugging IRQ support, and would rather do it another time, if ever ;)
I've left a comment block at the start of i2c-icy.c for anyone interested in the gory details.


If this is okay with you, I'll send another round of patches. :)


Thanks!

Max
