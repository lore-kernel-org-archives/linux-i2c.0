From: Jean Delvare <jdelvare@suse.de>
Subject: Re: i2c-tools - at24 vs eeprom - decode-dimms fails with the at24
 module
Date: Sat, 14 Mar 2020 21:41:13 +0100
Message-ID: <20200314214113.54e48d00@endymion>
References: <dc5201ea-de3f-f26c-c95e-fca392b521aa@nurealm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgCOBxt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 14 Mar 2020 21:53:49 -0400
In-Reply-To: <dc5201ea-de3f-f26c-c95e-fca392b521aa@nurealm.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: James Feeney <james@nurealm.net>
Cc: linux-i2c@vger.kernel.org

Hi James,

On Sat, 14 Mar 2020 09:22:57 -0600, James Feeney wrote:
> The log says "kernel: eeprom 3-0050: eeprom driver is deprecated, please use at24 instead", but decode-dimms will only work with the deprecated eeprom driver.  With the at24 module, "Number of SDRAM DIMMs detected and decoded: 0".  With the eeprom module, "Number of SDRAM DIMMs detected and decoded: 6". This is on Arch Linux, with linux 5.5.9.arch1-2, on an old Asus P6T DELUXE V2 with a Core i7.

While the legacy eeprom driver (poorly) auto-detected SPD EEPROMs, the
at24 driver requires SPD EEPOMs to be explicitly enumerated. There is
work in progress [1] to automate this in some cases (namely x86 systems
using the i2c-i801 SMBus controller driver) but for now you'll have to
do it yourself from user-space. How to do that is explained in section 4
of:

https://www.kernel.org/doc/Documentation/i2c/instantiating-devices

TL;DR: Something like:

# echo spd 0x50 > /sys/bus/i2c/devices/i2c-3/new_device

should do the trick, if i2c-3 is your SMBus and you have 1 memory
module in the first slot. If you have more memory modules, use
"modprobe i2c-dev ; i2cdetect 0" to find out the proper addresses in
the 0x50-0x57 range and repeat the command.

I guess I should resubmit this patch set to make it transparent to the
users.

[1] https://lore.kernel.org/lkml/20191014113950.1f989ba6@endymion/

-- 
Jean Delvare
SUSE L3 Support
