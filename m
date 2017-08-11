From: rpjday@crashcourse.ca
Subject: possible clarifications/suggestions for I2C man pages
Date: Fri, 11 Aug 2017 06:41:11 -0400
Message-ID: <20170811064111.Horde._C0AZIBvbLnSuYjG4OMcyvG@crashcourse.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from cpanel2.indieserve.net ([199.212.143.6]:43597 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752660AbdHKKlM (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 11 Aug 2017 06:41:12 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: jdelvare@suse.de


   trying to sneak stuff in before the 4.0 release so, from the perspective
of someone who only recently dug into this stuff in any detail, some
things that might help the man pages.

   first, some examples of each command would be spectacularly helpful,
rather than just relying on the synopsis. specifically, it would be useful
to see an example of each variant of a command, including the differences
when doing byte vs. word reads and writes. i realize the experts know
this stuff by heart, but examples are never a bad thing.

   also, i was just handed the following script loop for hex dumping an
EEPROM:

     i2cset -f -y 0 0x50 0x00 0x00
     for (( n=1; n < 8200; n++ )); do
         hex=$(i2cget -f -y 0 0x50)
         echo -en "\\${hex#0}"
     done | hexdump -C

which inspires a couple questions.

   first, i was not aware that simply calling "i2cget" over and over would
iterate through the registers; that's not mentioned in the i2cget man
page. the i2cget man page simply says,

"data-address specifies the address on that chip to read from, and is
an integer between 0x00 and 0xFF. If omitted, the currently active
register will be read (if that makes sense for the considered chip)."

is that normal behaviour for i2cget, or does it depend on the device?
or is this a dumb question?

   also, while i2cget can be handed an 8-bit address to read, as i read
here,

https://www.raspberrypi.org/forums/viewtopic.php?f=44&t=17590

if you want to read from a 16-bit address, you must (as above) first
use i2cset to specify that 16-bit address. the i2cget man page doesn't
seem to say anything about that, and that's a pretty useful thing to
know.

   apologies if any of the above turns out to be silly.

rday
