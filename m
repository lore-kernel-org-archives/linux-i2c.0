From: Aaron Sierra <asierra@xes-inc.com>
Subject: Re: [PATCH v6] at24: Support SMBus read/write of 16-bit devices
Date: Fri, 18 Dec 2015 13:47:50 -0600 (CST)
Message-ID: <1758302572.65470.1450468070959.JavaMail.zimbra@xes-inc.com>
References: <1914980865.104978.1447718293775.JavaMail.zimbra@xes-inc.com> <1637462042.105214.1447718539047.JavaMail.zimbra@xes-inc.com> <20151211131939.GC2742@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:54034 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932554AbbLRTtA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 18 Dec 2015 14:49:00 -0500
In-Reply-To: <20151211131939.GC2742@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org, Christian Gmeiner <christian.gmeiner@gmail.com>, Nate Case <ncase@xes-inc.com>

----- Original Message -----
> From: "Wolfram Sang" <wsa@the-dreams.de>
> Sent: Friday, December 11, 2015 7:19:40 AM
> 
> On Mon, Nov 16, 2015 at 06:02:19PM -0600, Aaron Sierra wrote:
> > Previously, the at24 driver would bail out in the case of a 16-bit
> > addressable EEPROM attached to an SMBus controller. This is because
> > SMBus block reads and writes don't map to I2C multi-byte reads and
> > writes when the offset portion is 2 bytes.
> > 
> > Instead of bailing out, this patch settles for functioning with single
> > byte read SMBus cycles. Writes can be block or single-byte, depending
> > on SMBus controller features.
> > 
> > Read access is not without some risk. Multiple SMBus cycles are
> > required to read even one byte. If the SMBus has multiple masters and
> > one accesses this EEPROM between the dummy address write and the
> > subsequent current-address-read cycle(s), this driver will receive
> > data from the wrong address.
> > 
> > Functionality has been tested with the following devices:
> > 
> >     AT24CM01 attached to Intel ISCH SMBus
> >     AT24C512 attached to Intel I801 SMBus
> > 
> > Read performance:
> >     3.6 KB/s with 32-byte* access
> > 
> >     *limited to 32-bytes by I2C_SMBUS_BLOCK_MAX.
> > 
> > Write performance:
> >     248 B/s with 1-byte page (default)
> >     3.9 KB/s with 128-byte* page (via platform data)
> > 
> >     *limited to 31-bytes by I2C_SMBUS_BLOCK_MAX - 1.
> > 
> > Signed-off-by: Nate Case <ncase@xes-inc.com>
> > Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> > Reviewed-by: Jean Delvare <jdelvare@suse.de>
> > ---
> >  v2 - Account for changes related to introduction of
> >       i2c_smbus_read_i2c_block_data_or_emulated()
> >  v3 - Consolidate three patches into one
> >     - Expand comments regarding SMBus multi-master read risks.
> >     - Rely on current-address-read for improved read performance (i.e. one
> >       dummy address write followed by multiple individual byte reads).
> >       This improves performance from 1.4 KiB/s to 3.6 KiB/s.
> >     - Use struct at24_data's writebuf instead of kzalloc-ing
> >     - Only limit write_max by 1-byte when accessing a 16-bit device with
> >       block writes instead of attempting to preserve a power-of-two.
> >     - Style fixes (indentation, parentheses, unnecessary masking, etc.)
> >  v4 - Address 16-bit safety in Kconfig
> >     - Set "count" to zero later in at24_smbus_read_block_data()
> >     - Fix over-80-columns issues in at24_eeprom_read()
> >     - Fix write_max off-by-one in at24_probe()
> >     - Check SMBus functionality needed for 16-bit device reads
> >     - Homogenize indentation of SMBus functionality checks for SMBus write
> >  v5 - 16-bit device read needs READ_BYTE not READ_BYTE_DATA
> >     - Clarify write_max limiting with smbus_max
> >     - Add X-ES copyright
> >  v6 - Update comment associated with SMBus functionality testing for 16-bit
> >       device read (READ_BYTE not READ_BYTE_DATA)
> > 
> >  drivers/misc/eeprom/Kconfig |   5 +-
> >  drivers/misc/eeprom/at24.c  | 132
> >  +++++++++++++++++++++++++++++++++++++++-----
> >  2 files changed, 122 insertions(+), 15 deletions(-)
> 
> I remember I had a lengthy discussion with Guenter Roeck about 16 bit
> support via smbus. I don't have the bandwidth right now to recap the
> discussion and check if the concerns apply to your implementation as
> well. Could you check this thread
> 
> https://lkml.org/lkml/2015/2/4/436
> 
> and report back if it applies to your patch as well? This would speed up
> the review significantly.

Wolfram,
The real bus-level multi-master issue is still present. However, it is
documented via comments in the driver and warnings in the Kconfig.

The other (and apparently bigger) issue of a single master experiencing
corruption due to simultaneous access through i2c-dev and this driver
appears to have been resolved. The i2cdump, i2cget, and i2cset utilities
refuse to access any device that has a driver bound to it. My attempts
to cause corruption using i2cdump were met with the following message
until I unregistered the at24 driver from the device:

   # i2cdump 8 0x54
   No size specified (using byte-data access)
   Error: Could not set address to 0x54: Device or resource busy

-Aaron S.
