From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH v2 00/13] eeprom: support for at24cs and at24mac
Date: Wed, 20 Apr 2016 16:38:59 +0200
Message-ID: <CAMpxmJVwFtLNi9cWXpEgY-5hJ+BE4VXPCAzkweCJCW6ezA=Ucg@mail.gmail.com>
References: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
	<20160416211733.GD1522@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:36454 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933011AbcDTOjA (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 20 Apr 2016 10:39:00 -0400
Received: by mail-io0-f171.google.com with SMTP id u185so54227606iod.3
        for <linux-i2c@vger.kernel.org>; Wed, 20 Apr 2016 07:38:59 -0700 (PDT)
In-Reply-To: <20160416211733.GD1522@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>

2016-04-16 23:17 GMT+02:00 Wolfram Sang <wsa@the-dreams.de>:
> Hi,
>
> On Mon, Apr 11, 2016 at 11:57:16AM -0700, Bartosz Golaszewski wrote:
>> Chips from the at24cs EEPROM series have an additional read-only
>> memory area containing a factory pre-programmed serial number. In
>> order to access it, a dummy write must be executed before reading
>> the serial number bytes.
>>
>> Chips from the at24mac familiy, apart from the serial number, have
>> a second special memory area containing a factory programmed
>> EUI-48/EUI64 mac address.
>>
>> The read-only serial/mac memory area is accessible on a different i2c
>> slave address (addr + 0x08). This patchset makes it possible to
>> instantiate a separate at24 device on this second address and access
>> the read-only area through the regular eeprom sysfs attribute or the
>> new nvmem subsystem.
>>
>> This series also contains several patches intoducing some minor tweaks
>> and refactoring.
>>
>> Tested with at24cs32 and at24cs02 chips (for both 16 and 8 bit address
>> pointers). I have no means of testing the support for at24mac chips, I
>> relied solely on the datasheet.
>
> Thanks for adding at24mac nonetheless!
>
> I still don't understand why you want to add this to at24 instead of
> doing a seperate driver for it? You basically tie a read_function to an
> nvmem device. You don't need the special smbus handling, cutting large
> requests into chunks, write support, size flags and all this from at24.
> And with the function pointers, it makes the already complex code a bit
> more complex.
>

Hi Wolfram,

while you're right that this makes the code more complex, I can see
some space for overall improvement of the driver's code quality with
function pointers.

The read and write routines are quite complex and decide which
operations to use (smbus or i2c) on the fly every time they're called.
Why not split them into several simpler functions (each implementing a
single way of talking to EEPROM) that would be assigned in probe()
depending on the chip type and adapter's functionalities? Would you be
willing to accept a series that does it?

> IMO, this could be solved by a simple, seperate driver. You could start
> with at24 and remove unneeded stuff. I think there should be mainly
> nvmem-init code and your read routines left. I also think this new
> driver should be allowed to set the "compat" option of the nvmem
> framework, so you'll get the "eeprom" file, too.
>
> Or am I overlooking something?
>

I think creating two new drivers for something as simple as that is
overkill. Especially when it's a backwards compatible sub-family of
chips we're talking about. How about leaving this in at24 and instead
cleaning the driver up a bit with the approach I suggested above?

Best regards,
Bartosz Golaszewski
