From: Laszlo Papp <lpapp@kde.org>
Subject: Re: [RFC] Creating an eeprom class
Date: Wed, 22 Jan 2014 13:25:40 +0000
Message-ID: <CAOMwXhMvefuQJPZ_sbzySmvcyqkR+Lfh-11Gx3unGqyR2pREww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: patrickdepinguin@gmail.com, gregkh@linuxfoundation.org, linux-i2c@vget.kernel.org, curt@cumulusnetworks.com
List-Id: linux-i2c@vger.kernel.org

> On Sun, Jan 20, 2013 at 07:08:28PM +0100, Thomas De Schampheleire wrote:
>> [plaintext and fixed address of David Brownell]
>
> David passed away a year or so ago, so that's really not going to help :(
>
>> Hi,
>>
>> Several of the eeprom drivers that live in drivers/misc/eeprom export
>> a binary sysfs file 'eeprom'. If a userspace program or script wants
>> to access this file, it needs to know the full path, for example:
>>
>> /sys/bus/spi/devices/spi32766.0/eeprom
>>
>> The problem with this approach is that it requires knowledge about the
>> hardware configuration: is the eeprom on the SPI bus, the I2C bus, or
>> maybe memory mapped?
>>
>> It would therefore be more interesting to have a bus-agnostic way to
>> access this eeprom file, for example:
>> /sys/class/eeprom/eeprom0/eeprom
>>
>> Maybe it'd be even better to use a more generic class name than
>> 'eeprom', since there are several types of eeprom-like devices that
>> you could export this way.
>
> Does all of the existing "eeprom" devices use the same userspace
> interface?  If so, yes, having a "class" would make sense.

Was there any progress done? I saw the following thread, too, so
including CC in the loop:
http://www.spinics.net/lists/linux-i2c/msg13141.html

Needless to say that I am writing this email because I would also be
interested in a handy and convenient class interface - as opposed to
the raw bus specific path -, similarly to hwmon, gpio, leds, etc.

I could probably even try to volunteer, with very limited resources
admittedly, to get some driver done for our EEPROM if that is needed.
