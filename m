From: Jean Delvare <jdelvare@suse.de>
Subject: i2c-i801 partially broken on Lynx Point PCH?
Date: Wed, 11 May 2016 09:34:52 +0200
Message-ID: <20160511093452.5bc2614c@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59125 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271AbcEKHe4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 11 May 2016 03:34:56 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Hi Seth,

In commit 062737fb6d90 you added support for the Intel Lynx Point PCH
to the i2c-i801 driver. I happen to have a machine with this chipset
since a few weeks, and found that the i2c-i801 driver doesn't work
properly on it. Specifically, the eeprom driver return 0xff for all
EEPROM bytes. The at24 driver fails too, with a timeout.

After some testing using i2cdetect, i2cdump and i2cget, I found that
some I2C transactions work (SMBUS_QUICK, SMBUS_READ_BYTE,
SMBUS_READ_BYTE_DATA, SMBUS_READ_WORD_DATA, SMBUS_READ_BLOCK_DATA),
however others do not (SMBUS_WRITE_BYTE, SMBUS_READ_I2C_BLOCK.) I can't
easily test other transaction types as all I have on the SMBus are SPD
EEPROMs on my memory modules.

Did you test the i2c-i801 driver on an actual Lynx Point PCH chipset?
Or did you only add the PCI ID of the device, assuming it would work?

-- 
Jean Delvare
SUSE L3 Support
