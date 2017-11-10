From: Jean Delvare <jdelvare@suse.de>
Subject: Support of DDR4 EEPROMs
Date: Fri, 10 Nov 2017 10:14:16 +0100
Message-ID: <20171110101416.14410124@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751983AbdKJJOU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 10 Nov 2017 04:14:20 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Wolfram Sang <wsa@the-dreams.de>

Hi all,

My topic for SUSE Hackweek 16 is to add support for DDR4 memory modules
to decode-dimms:
https://hackweek.suse.com/16/projects/add-support-for-ddr4-to-decode-dimms

I naively thought it would only be about modifying the perl script to
decode new fields and new values from the SPD EEPROM, however it turns
out that the EEPROM themselves are different. Instead of regular
24C02-style 256-byte EEPROMs, DDR4 memory modules use 512-byte EEPROMs.
The trick is that they still use only 1 I2C address each in the
0x50-0x57 range. You have to tinker with special commands in the
0x30-0x37 range to select one of 2 256-byte pages that will be
reachable through the 0x50-0x57 I2C address. And as far as I can, it
switched all EEPROMs at once, which won't be easy to implement.

The standard in question is JEDEC EE1004. I'm not sure if we should add
support to the at24 driver, or write a separate driver for such
EEPROMs. Before I start working on that, I would like to ask if anybody
is already working on it?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
