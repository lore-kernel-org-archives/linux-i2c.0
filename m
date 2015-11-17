From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v6] at24: Support SMBus read/write of 16-bit devices
Date: Tue, 17 Nov 2015 17:52:14 +0100
Message-ID: <20151117175214.73a8cf68@endymion.delvare>
References: <1914980865.104978.1447718293775.JavaMail.zimbra@xes-inc.com>
	<1637462042.105214.1447718539047.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59279 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932163AbbKQQwR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 17 Nov 2015 11:52:17 -0500
In-Reply-To: <1637462042.105214.1447718539047.JavaMail.zimbra@xes-inc.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Aaron Sierra <asierra@xes-inc.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Christian Gmeiner <christian.gmeiner@gmail.com>, Nate Case <ncase@xes-inc.com>

On Mon, 16 Nov 2015 18:02:19 -0600 (CST), Aaron Sierra wrote:
> Previously, the at24 driver would bail out in the case of a 16-bit
> addressable EEPROM attached to an SMBus controller. This is because
> SMBus block reads and writes don't map to I2C multi-byte reads and
> writes when the offset portion is 2 bytes.
> 
> Instead of bailing out, this patch settles for functioning with single
> byte read SMBus cycles. Writes can be block or single-byte, depending
> on SMBus controller features.
> 
> Read access is not without some risk. Multiple SMBus cycles are
> required to read even one byte. If the SMBus has multiple masters and
> one accesses this EEPROM between the dummy address write and the
> subsequent current-address-read cycle(s), this driver will receive
> data from the wrong address.
> 
> Functionality has been tested with the following devices:
> 
>     AT24CM01 attached to Intel ISCH SMBus
>     AT24C512 attached to Intel I801 SMBus
> 
> Read performance:
>     3.6 KB/s with 32-byte* access
> 
>     *limited to 32-bytes by I2C_SMBUS_BLOCK_MAX.
> 
> Write performance:
>     248 B/s with 1-byte page (default)
>     3.9 KB/s with 128-byte* page (via platform data)
> 
>     *limited to 31-bytes by I2C_SMBUS_BLOCK_MAX - 1.
> 
> Signed-off-by: Nate Case <ncase@xes-inc.com>
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> ---
>  v2 - Account for changes related to introduction of
>       i2c_smbus_read_i2c_block_data_or_emulated()
>  v3 - Consolidate three patches into one
>     - Expand comments regarding SMBus multi-master read risks.
>     - Rely on current-address-read for improved read performance (i.e. one
>       dummy address write followed by multiple individual byte reads).
>       This improves performance from 1.4 KiB/s to 3.6 KiB/s.
>     - Use struct at24_data's writebuf instead of kzalloc-ing
>     - Only limit write_max by 1-byte when accessing a 16-bit device with
>       block writes instead of attempting to preserve a power-of-two.
>     - Style fixes (indentation, parentheses, unnecessary masking, etc.)
>  v4 - Address 16-bit safety in Kconfig
>     - Set "count" to zero later in at24_smbus_read_block_data()
>     - Fix over-80-columns issues in at24_eeprom_read()
>     - Fix write_max off-by-one in at24_probe()
>     - Check SMBus functionality needed for 16-bit device reads
>     - Homogenize indentation of SMBus functionality checks for SMBus write
>  v5 - 16-bit device read needs READ_BYTE not READ_BYTE_DATA
>     - Clarify write_max limiting with smbus_max
>     - Add X-ES copyright
>  v6 - Update comment associated with SMBus functionality testing for 16-bit
>       device read (READ_BYTE not READ_BYTE_DATA)
> 
>  drivers/misc/eeprom/Kconfig |   5 +-
>  drivers/misc/eeprom/at24.c  | 132 +++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 122 insertions(+), 15 deletions(-)
> (...)

Sweet, thanks for your patience.

Now it's up to Wolfram.

-- 
Jean Delvare
SUSE L3 Support
