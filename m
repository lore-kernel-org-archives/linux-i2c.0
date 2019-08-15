From: Max <max@enpas.org>
Subject: Re: [PATCH v2 1/4] i2c/busses: Add i2c-icy for I2C on m68k/Amiga
Date: Thu, 15 Aug 2019 13:52:47 +0200
Message-ID: <54185c85-8c26-916e-41b1-af9b55223e7b@enpas.org>
References: <20190812235237.21797-1-max@enpas.org>
 <20190814194714.GB9756@kunai>
 <f33ef44e-61e8-0392-7f5c-5a0bd7b42fff@enpas.org>
 <20190815071228.GA1054@kunai>
 <276714fb-6b3a-1e99-0744-bfd037305724@enpas.org>
 <20190815114809.GA1916@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815114809.GA1916@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
List-Id: linux-i2c@vger.kernel.org

On 08/15/2019 01:48 PM, Wolfram Sang wrote:
>> Well, the other option is to remove it, and then add it back once
>> somebody complains - which is unlikely to happen. The clock parameter
>> is PCF8584 specific anyway, and  I think removing it is a good option,
> 
> My suggestion is to do that incrementally. First, get your driver
> accepted. Second, do the cleanups which affect elektor as well later.

My suggestion is to not touch i2c-elektor at all for now, and remove the 'clock' parameter from the first iteration of i2c-icy. It can be added back in case someone complains, which I deem unlikely.


>> as I've done the same with getown() (where in i2c-elektor, 'own' sets
>> the PCF8584's own address).
> 
> I wondered about that. Can the PCF8584 really act as a slave, too?
> Somewhen I need to check its datasheet.

Yes it can, but this driver does not implement this.

In fact, I just remembered that the own address, while set, is not used at all in master mode!

Quote from the datasheet:
https://www.nxp.com/docs/en/data-sheet/PCF8584.pdf

  6.4 Own address register S0'

  When the PCF8584 is addressed as slave, this register
  must be loaded with the 7-bit I 2 C-bus address to which the
  PCF8584 is to respond. During initialization, the own
  address register S0' must be written to, regardless
  whether it is later used.


>> Question is, if I remove the parameter, I'd like it to be
>> non-destructive. Do you know of anything that can go wrong if the I2C
>> master is running the bus on a wrong clock?
> 
> Not sure if I understand you correctly, but if the bus freq is too fast
> then devices won't respond. Too slow is not a problem.

Okay, so we don't care. Cool, then it's safe to kick the 'clock' parameter from i2c-icy. All 2019 boards (which should be the vast majority in existence) came with a 12 MHz oscillator AFAIK, so the default should be good.


Max
