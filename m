From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: can't write more than one byte to AT24C64 EEPROM using
 "eeprog"
Date: Tue, 25 Jul 2017 13:51:50 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1707251344110.20856@localhost.localdomain>
References: <20170725085131.Horde.ogXTYHLwBV6pmCIUgV7abh7@crashcourse.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from cpanel2.indieserve.net ([199.212.143.6]:38053 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdGYRvx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 25 Jul 2017 13:51:53 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:43282 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1da3zs-0002MG-6U
        for linux-i2c@vger.kernel.org; Tue, 25 Jul 2017 13:51:52 -0400
In-Reply-To: <20170725085131.Horde.ogXTYHLwBV6pmCIUgV7abh7@crashcourse.ca>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org


  expanding on my earlier note since i got a few minutes to test:

On Tue, 25 Jul 2017, rpjday@crashcourse.ca wrote:

>  warning: doing this from memory since someone just walked off with
> my test system, but i'll try to get all the details in:
>
>  in order to read a 4-byte manufacturer string from the EEPROM, i
> used "eeprog", which worked delightfully (displaying for Lenovo):
>
>  # eeprog /dev/i2c-0 0x50 -16 -f -r 0x0060:4
>  LNVO
>
> so reading from the EEPROM using "eeprog" seems to work just fine.
> but when i tried to write a string there:
>
>  # echo -n "rday" | eeprog /dev/i2c-0 0x50 -16 -f -w 0x0060
>
> i got a "i2c_write_3b" error (that's all i can remember of it), and
> when i checked memory, only the first character ("r") had been
> written at address 0x0060, the rest of the characters were
> unchanged.
>
>  as a test, i used "eeprog" to write the remaining characters one at
> a time (at addresses 0x0061, 0x0062 and 0x0063), and that appeared
> to work just fine.
>
>  am i doing something obviously silly? from the man page, it seems i
> should be able to pass a string for writing.

so here's the result of running a few "eeprog" commands. first, read a
4-byte field where the manufacturer code is stored (lines might be
slightly mangled after saving to wordpad):

  # eeprog /dev/i2c-0 0x50 -16 -f -x -r 0x60:4
  eeprog 0.7.5, a 24Cxx EEPROM reader/writer
  Copyright (c) 2003 by Stefano Barbato - All rights reserved.
    Bus: /dev/i2c-0, Address: 0x50, Mode: 16bit
    Reading 4 bytes from 0x60
  .
  0060|  4c 4e 56 4f

if i print that in character, it displays properly as "LNVO" for
lenovo:

  # eeprog /dev/i2c-0 0x50 -16 -f -r 0x60:4
  eeprog 0.7.5, a 24Cxx EEPROM reader/writer
  Copyright (c) 2003 by Stefano Barbato - All rights reserved.
    Bus: /dev/i2c-0, Address: 0x50, Mode: 16bit
    Reading 4 bytes from 0x60
  LNVOroot@t1042d4rdb:~#
  ^^^^

so far, so good. now try to write a new 4-byte string to that same
location:

  # echo -n "RDAY" | eeprog /dev/i2c-0 0x50 -16 -f -w 0x60
  eeprog 0.7.5, a 24Cxx EEPROM reader/writer
  Copyright (c) 2003 by Stefano Barbato - All rights reserved.
    Bus: /dev/i2c-0, Address: 0x50, Mode: 16bit
    Writing stdin starting at address 0x60
  ..Error i2c_write_3b: No such device or address
  Error at line 162: write error
  root@t1042d4rdb:~#

from what i read on the man page, the above should work. weirdly, if i
dump that address again, the first byte has been overwritten:

  # eeprog /dev/i2c-0 0x50 -16 -f -r 0x60:4
  eeprog 0.7.5, a 24Cxx EEPROM reader/writer
  Copyright (c) 2003 by Stefano Barbato - All rights reserved.
    Bus: /dev/i2c-0, Address: 0x50, Mode: 16bit
    Reading 4 bytes from 0x60
  RNVOroot@t1042d4rdb:~#
  ^

at which point, yes, i can write one byte at a time:

  # echo -n "D" | eeprog /dev/i2c-0 0x50 -16 -f -w 0x61
  eeprog 0.7.5, a 24Cxx EEPROM reader/writer
  Copyright (c) 2003 by Stefano Barbato - All rights reserved.
    Bus: /dev/i2c-0, Address: 0x50, Mode: 16bit
    Writing stdin starting at address 0x61

and sure enough, the memory contents are now "RDVO".

  i'm baffled, and open to suggestions.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
