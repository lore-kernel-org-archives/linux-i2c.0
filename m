From: Jean Delvare <jdelvare@suse.de>
Subject: Re: i2c-i801 partially broken on Lynx Point PCH?
Date: Wed, 18 May 2016 14:05:08 +0200
Message-ID: <20160518140508.7dfe192e@endymion>
References: <20160511093452.5bc2614c@endymion>
	<20160511104322.60521365@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53083 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbcERMFM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 18 May 2016 08:05:12 -0400
In-Reply-To: <20160511104322.60521365@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Seth Heasley <seth.heasley@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Wed, 11 May 2016 10:43:22 +0200, Jean Delvare wrote:
> On Wed, 11 May 2016 09:34:52 +0200, Jean Delvare wrote:
> > In commit 062737fb6d90 you added support for the Intel Lynx Point PCH
> > to the i2c-i801 driver. I happen to have a machine with this chipset
> > since a few weeks, and found that the i2c-i801 driver doesn't work
> > properly on it. Specifically, the eeprom driver return 0xff for all
> > EEPROM bytes. The at24 driver fails too, with a timeout.
> > 
> > After some testing using i2cdetect, i2cdump and i2cget, I found that
> > some I2C transactions work (SMBUS_QUICK, SMBUS_READ_BYTE,
> > SMBUS_READ_BYTE_DATA, SMBUS_READ_WORD_DATA, SMBUS_READ_BLOCK_DATA),
> > however others do not (SMBUS_WRITE_BYTE, SMBUS_READ_I2C_BLOCK.) I can't
> > easily test other transaction types as all I have on the SMBus are SPD
> > EEPROMs on my memory modules.
> > 
> > Did you test the i2c-i801 driver on an actual Lynx Point PCH chipset?
> > Or did you only add the PCI ID of the device, assuming it would work?
> 
> As an additional data point, I managed to find a machine on the SUSE
> network with a Lynx Point PCH. I tested it and everything works fine
> there. So not all systems with the Lynx Point PCH [8086:8c22] have the
> problem.
> 
> One difference between my system and the working one is the PCI device
> revision (04 for me, 05 for the working machine.) So maybe it has
> something to do with the revision. Or maybe it's a problem with the way
> the BIOS initializes the device (my system is from Dell, the working
> one from Intel.)

OK, I know what's going on.

Starting with the 8-Series/C220 chipsets, Intel introduced a new
configuration bit for the SMBus controller in register HOSTC (PCI
D31:F3 Address Offset 40h):

Bit 4  SPD Write Disable - R/WO.
       0 = SPD write enabled.
       1 = SPD write disabled. Writes to SMBus addresses 50h - 57h are
           disabled.

This bit is set on my machine, and not set on the machine on the SUSE
network, which is why the behavior differs.

I understand the idea of protecting SPD EEPROMs from accidental writes
(even though in practice most memory module vendors write-protect the
EEPROMs themselves.) However I am afraid Intel got the implementation
wrong. They appear to be simply checking bit 0 of the XMIT_SLVA
register to decide if a transaction is a read or a write. Unfortunately
this fails for the 2 best methods available to read EEPROMs:

* The I2C Block Read transaction must set this bit to 0 (write) even if
  it is a read transaction. This is explicitly mentioned in the
  datasheet (page 215, "For I2C Read command, the value written into
  bit 0 of the Transmit Slave Address Register (SMB I/O register,
  offset 04h) needs to be 0.")

* If using continuous byte reads (Receive Byte in SMBus terminology) to
  retrieve the contents of the EEPROM, the read pointer must be reset
  to 0 beforehand. This is done with a Send Byte transaction. While
  this transaction doesn't write data to the EEPROM, it is still
  blocked by the write protection mechanism.

So the only ways left to read the EEPROM contents are 1-byte reads or
at best 2-byte reads. This is far less efficient than I2C Block reads
or continuous byte reads.

Mika/Jarkko, is there any chance to get your hardware people involved?
I wonder if there is any workaround to this issue? Any chance to get
this fixed in future chipsets? Not sure about Send Byte but the write
protection should definitely not block I2C Block Read transactions.

For now we need to come up with a software workaround. I can think of 3
approaches:

1* Remove I2C_FUNC_SMBUS_READ_I2C_BLOCK from the list of supported
   transactions whenever SPD write protection is enabled. In practice I
   think I2C Block Read is only useful for EEPROMs anyway, so I doubt
   anyone else will miss it. This is clearly a hack, but it's quite
   simple. Then the eeprom and at24 drivers will automatically fall
   back to slower read methods.

2* Hack the eeprom and at24 drivers so that in case I2C Block Reads were
   supposed to work but do not, they fallback dynamically to the other
   read methods. The downside is that one-time failures would trigger
   the fallback too.

3* Introduce a finer-grained version of i2c_check_functionality() which
   takes the slave address as an extra parameter. The i2c-i801 driver
   would implement an extra callback function to handle it, and mask out
   I2C_FUNC_SMBUS_READ_I2C_BLOCK and all write transactions if the slave
   address is in the 0x50-0x57 range and the SPD protection bit is set.
   This is more work, enlarges the size of struct i2c_algorithm by one
   pointer, but is certainly cleaner than the two hacks above.

If anyone can think of any better solution, please let me know.

-- 
Jean Delvare
SUSE L3 Support
