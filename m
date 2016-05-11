From: Jean Delvare <jdelvare@suse.de>
Subject: Re: i2c-i801 partially broken on Lynx Point PCH?
Date: Wed, 11 May 2016 10:43:22 +0200
Message-ID: <20160511104322.60521365@endymion>
References: <20160511093452.5bc2614c@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36085 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbcEKIn0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 11 May 2016 04:43:26 -0400
In-Reply-To: <20160511093452.5bc2614c@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Wed, 11 May 2016 09:34:52 +0200, Jean Delvare wrote:
> In commit 062737fb6d90 you added support for the Intel Lynx Point PCH
> to the i2c-i801 driver. I happen to have a machine with this chipset
> since a few weeks, and found that the i2c-i801 driver doesn't work
> properly on it. Specifically, the eeprom driver return 0xff for all
> EEPROM bytes. The at24 driver fails too, with a timeout.
> 
> After some testing using i2cdetect, i2cdump and i2cget, I found that
> some I2C transactions work (SMBUS_QUICK, SMBUS_READ_BYTE,
> SMBUS_READ_BYTE_DATA, SMBUS_READ_WORD_DATA, SMBUS_READ_BLOCK_DATA),
> however others do not (SMBUS_WRITE_BYTE, SMBUS_READ_I2C_BLOCK.) I can't
> easily test other transaction types as all I have on the SMBus are SPD
> EEPROMs on my memory modules.
> 
> Did you test the i2c-i801 driver on an actual Lynx Point PCH chipset?
> Or did you only add the PCI ID of the device, assuming it would work?

As an additional data point, I managed to find a machine on the SUSE
network with a Lynx Point PCH. I tested it and everything works fine
there. So not all systems with the Lynx Point PCH [8086:8c22] have the
problem.

One difference between my system and the working one is the PCI device
revision (04 for me, 05 for the working machine.) So maybe it has
something to do with the revision. Or maybe it's a problem with the way
the BIOS initializes the device (my system is from Dell, the working
one from Intel.)

-- 
Jean Delvare
SUSE L3 Support
