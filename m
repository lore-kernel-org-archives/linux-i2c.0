From: Aaron Sierra <asierra@xes-inc.com>
Subject: Re: [PATCH v4] at24: Support SMBus read/write of 16-bit devices
Date: Tue, 10 Nov 2015 09:17:08 -0600 (CST)
Message-ID: <1596529027.15443.1447168628203.JavaMail.zimbra@xes-inc.com>
References: <780683105.92691.1447114576924.JavaMail.zimbra@xes-inc.com> <1982054415.93139.1447115111901.JavaMail.zimbra@xes-inc.com> <20151110103920.3762f682@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:21198 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994AbbKJPSO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 10 Nov 2015 10:18:14 -0500
In-Reply-To: <20151110103920.3762f682@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Christian Gmeiner <christian.gmeiner@gmail.com>, Nate Case <ncase@xes-inc.com>

----- Original Message -----
> From: "Jean Delvare" <jdelvare@suse.de>
> Sent: Tuesday, November 10, 2015 3:39:20 AM
> 
> Hi Aaron,
> 
> On Mon, 9 Nov 2015 18:25:11 -0600 (CST), Aaron Sierra wrote:
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
> >
> >  drivers/misc/eeprom/Kconfig |   5 +-
> >  drivers/misc/eeprom/at24.c  | 129
> >  +++++++++++++++++++++++++++++++++++++++-----
> >  2 files changed, 119 insertions(+), 15 deletions(-)
> 
> This is a significant addition of code so feel free to add your name at
> the top of at24.c.
> 
> We're almost there:
> 
> > diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> > index 5d7c090..3dfd2ed 100644
> > --- a/drivers/misc/eeprom/at24.c
> > +++ b/drivers/misc/eeprom/at24.c
> > (...)
> > @@ -527,10 +608,19 @@ static int at24_probe(struct i2c_client *client,
> > const struct i2c_device_id *id)
> >  
> >  	/* Use I2C operations unless we're stuck with SMBus extensions. */
> >  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> > -		if (chip.flags & AT24_FLAG_ADDR16)
> > -			return -EPFNOSUPPORT;
> > -
> > -		if (i2c_check_functionality(client->adapter,
> > +		if ((chip.flags & AT24_FLAG_ADDR16) &&
> > +		    i2c_check_functionality(client->adapter,
> > +				I2C_FUNC_SMBUS_READ_BYTE_DATA |
> > +				I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
> 
> It is I2C_FUNC_SMBUS_READ_BYTE that you use, not
> I2C_FUNC_SMBUS_READ_BYTE_DATA.

Sorry about that.
 
> > +			/*
> > +			 * We need SMBUS_WRITE_BYTE_DATA and
> > +			 * SMBUS_READ_BYTE_DATA to implement byte reads for
> > +			 * 16-bit address devices. This will be slow, but
> > +			 * better than nothing (e.g. read @ 3.6 KiB/s). It is
> > +			 * also unsafe in a multi-master topology.
> > +			 */
> > +			use_smbus = I2C_SMBUS_BYTE_DATA;
> > +		} else if (i2c_check_functionality(client->adapter,
> >  				I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> >  			use_smbus = I2C_SMBUS_I2C_BLOCK_DATA;
> >  		} else if (i2c_check_functionality(client->adapter,
> > (...)
> > @@ -598,8 +698,9 @@ static int at24_probe(struct i2c_client *client, const
> > struct i2c_device_id *id)
> >  
> >  			if (write_max > io_limit)
> >  				write_max = io_limit;
> > -			if (use_smbus && write_max > I2C_SMBUS_BLOCK_MAX)
> > -				write_max = I2C_SMBUS_BLOCK_MAX;
> > +			if (use_smbus && write_max >= I2C_SMBUS_BLOCK_MAX)
> > +				write_max = I2C_SMBUS_BLOCK_MAX -
> > +					!!(chip.flags & AT24_FLAG_ADDR16);
> 
> Beh. OK, it works, I will admit it's even kind of clever, but it also
> looks fragile and confusing to some degree. What is wrong with just
> spelling out the condition explicitly?
> 
> 			unsigned smbus_limit = (chip.flags & AT24_FLAG_ADDR16) ?
> 					       I2C_SMBUS_BLOCK_MAX - 1 :
> 					       I2C_SMBUS_BLOCK_MAX;
> 
> 			if (use_smbus && write_max > smbus_limit)
> 				write_max = smbus_limit;
> 
> This might not even be slower, and IMHO it is easier to understand.

There's nothing wrong with your suggestion. My original intent was to change
the test as little as necessary. I see the improved clarity of your
suggestion.

-Aaron S.
