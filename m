From: rpjday@crashcourse.ca
Subject: can't write more than one byte to AT24C64 EEPROM using "eeprog"
Date: Tue, 25 Jul 2017 08:51:31 -0400
Message-ID: <20170725085131.Horde.ogXTYHLwBV6pmCIUgV7abh7@crashcourse.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from cpanel2.indieserve.net ([199.212.143.6]:38275 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbdGYMvc (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 25 Jul 2017 08:51:32 -0400
Received: from [::1] (port=49824 helo=cpanel2.indieserve.net)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1dZzJD-0002XL-TN
        for linux-i2c@vger.kernel.org; Tue, 25 Jul 2017 08:51:31 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org


   warning: doing this from memory since someone just walked off with my
test system, but i'll try to get all the details in:

   in order to read a 4-byte manufacturer string from the EEPROM, i used
"eeprog", which worked delightfully (displaying for Lenovo):

   # eeprog /dev/i2c-0 0x50 -16 -f -r 0x0060:4
   LNVO

so reading from the EEPROM using "eeprog" seems to work just fine.
but when i tried to write a string there:

   # echo -n "rday" | eeprog /dev/i2c-0 0x50 -16 -f -w 0x0060

i got a "i2c_write_3b" error (that's all i can remember of it),
and when i checked memory, only the first character ("r") had
been written at address 0x0060, the rest of the characters were
unchanged.

   as a test, i used "eeprog" to write the remaining characters
one at a time (at addresses 0x0061, 0x0062 and 0x0063), and that
appeared to work just fine.

   am i doing something obviously silly? from the man page, it
seems i should be able to pass a string for writing.

rday
