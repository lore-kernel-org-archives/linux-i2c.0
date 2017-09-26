From: Jean Delvare <jdelvare@suse.de>
Subject: Re: possible clarifications/suggestions for I2C man pages
Date: Tue, 26 Sep 2017 09:55:38 +0200
Message-ID: <20170926095538.4bc34e02@endymion>
References: <20170811064111.Horde._C0AZIBvbLnSuYjG4OMcyvG@crashcourse.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37829 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965643AbdIZHzl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 26 Sep 2017 03:55:41 -0400
In-Reply-To: <20170811064111.Horde._C0AZIBvbLnSuYjG4OMcyvG@crashcourse.ca>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: rpjday@crashcourse.ca
Cc: linux-i2c@vger.kernel.org

On Fri, 11 Aug 2017 06:41:11 -0400, rpjday@crashcourse.ca wrote:
>    trying to sneak stuff in before the 4.0 release so, from the perspective
> of someone who only recently dug into this stuff in any detail, some
> things that might help the man pages.
> 
>    first, some examples of each command would be spectacularly helpful,
> rather than just relying on the synopsis. specifically, it would be useful
> to see an example of each variant of a command, including the differences
> when doing byte vs. word reads and writes. i realize the experts know
> this stuff by heart, but examples are never a bad thing.

Good point, noted.

>    also, i was just handed the following script loop for hex dumping an
> EEPROM:
> 
>      i2cset -f -y 0 0x50 0x00 0x00
>      for (( n=1; n < 8200; n++ )); do
>          hex=$(i2cget -f -y 0 0x50)
>          echo -en "\\${hex#0}"
>      done | hexdump -C
> 
> which inspires a couple questions.

The first thing this inspires me is that you really should be using the
at24 kernel driver instead of reading byte by byte from user-space. It
would be a lot faster, and safer too.

>    first, i was not aware that simply calling "i2cget" over and over would
> iterate through the registers; that's not mentioned in the i2cget man
> page. the i2cget man page simply says,
> 
> "data-address specifies the address on that chip to read from, and is
> an integer between 0x00 and 0xFF. If omitted, the currently active
> register will be read (if that makes sense for the considered chip)."
> 
> is that normal behaviour for i2cget, or does it depend on the device?
> or is this a dumb question?

It depends on the device. Many I2C devices have an internal register
storing the currently active address, and a short read (no address
provided) will read from it. On top of that, some I2C devices, most
notably EEPROMs, have an auto-increment feature which causes this
internal register to self-increment when read. This allows using short
reads to read the whole EEPROM byte by byte. Which is highly
inefficient, but sometimes the only way if the master has limited
capabilities.

This is documented in the i2cdump(8) man page, but not the i2cget(8)
man page. I agree it could be mentioned there as well.

>    also, while i2cget can be handed an 8-bit address to read, as i read
> here,
> 
> https://www.raspberrypi.org/forums/viewtopic.php?f=44&t=17590
> 
> if you want to read from a 16-bit address, you must (as above) first
> use i2cset to specify that 16-bit address. the i2cget man page doesn't
> seem to say anything about that, and that's a pretty useful thing to
> know.

The core problem here is that there are no semantics attached to I2C
transactions. Only bytes flying in either direction. The i2c-tools
were primarily written with SMBus in mind, which is a subset of I2C
with semantics attached. 16-bit addressed EEPROMs are not
SMBus-compliant, which is why the semantics described in the manual
pages do not match. Specifically:

i2cset -f -y 0 0x50 0x00 0x00
                    ^^^^ ^^^^

These two bytes are "data-address" and "value" according to our
documentation, which follows the SMBus conventions, but when using that
on an 16-bit addressed EEPROM, they actually constitute a single 16-bit
value, which is written to the internal address pointer register of the
EEPROM.

Short of making the manual pages very vague to avoid making any
assumption about the semantics, it's simply impossible to cover all
possibilities.

-- 
Jean Delvare
SUSE L3 Support
