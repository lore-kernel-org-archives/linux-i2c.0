From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/3] at24: Support SMBus block writes to 16-bit devices
Date: Tue, 3 Nov 2015 10:03:38 +0100
Message-ID: <20151103100338.60f55317@endymion.delvare>
References: <857238265.63776.1441301982531.JavaMail.zimbra@xes-inc.com>
	<1888937035.82162.1441309955075.JavaMail.zimbra@xes-inc.com>
	<20151102144209.19256228@endymion.delvare>
	<1202151825.60612.1446482122118.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39629 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633AbbKCJDl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 3 Nov 2015 04:03:41 -0500
In-Reply-To: <1202151825.60612.1446482122118.JavaMail.zimbra@xes-inc.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Aaron Sierra <asierra@xes-inc.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Christian Gmeiner <christian.gmeiner@gmail.com>

Hi Aaron,

On Mon, 2 Nov 2015 10:35:22 -0600 (CST), Aaron Sierra wrote:
> ----- Original Message -----
> > From: "Jean Delvare" <jdelvare@suse.de>
> > Sent: Monday, November 2, 2015 7:42:09 AM
> > On Thu, 3 Sep 2015 14:52:35 -0500 (CDT), Aaron Sierra wrote:
> > > @@ -612,7 +640,8 @@ static int at24_probe(struct i2c_client *client, const
> > > struct i2c_device_id *id)
> > >  			if (write_max > io_limit)
> > >  				write_max = io_limit;
> > >  			if (use_smbus && write_max > I2C_SMBUS_BLOCK_MAX)
> > > -				write_max = I2C_SMBUS_BLOCK_MAX;
> > > +				write_max = I2C_SMBUS_BLOCK_MAX >>
> > > +					!!(chip.flags & AT24_FLAG_ADDR16);
> > 
> > Looks bogus when AT24_FLAG_ADDR16 flag is set, in two ways:
> > 
> > 1* I2C_SMBUS_BLOCK_MAX is 32. If write_max was 33, you'll set it to
> >    33 >> 1 = 16. But if write_max was 31, you'll leave it to 31. Makes
> >    no sense to me.
> 
> That's true, I hadn't considered that case. I assumed page_size would
> be a power-of-two based on its name, though that isn't enforced anywhere.

It is checked but not enforced:

	if (!is_power_of_2(chip.page_size))
		dev_warn(&client->dev,
			"page_size looks suspicious (no power of 2)!\n");

The thing is that I don't think a write operation can cross a page
boundary.

But as I understand it, this piece of code in at24_eeprom_write()
takes care of that:

	/* Never roll over backwards, to the start of this page */
	next_page = roundup(offset + 1, at24->chip.page_size);
	if (offset + count > next_page)
		count = next_page - offset;

So in the above example, if page size is 32 and write_max is 31, you'll
still need 2 write operations per page. If you write the whole eeprom,
that's no different from having write_max at 16. But if page size is 64
or more, having write_max at 31 instead of 16 will improve the
performance. Also think of partial writes, they can always benefit from
greater write_max.

> > 2* Why I2C_SMBUS_BLOCK_MAX >> 1 in the first place? You only need to
> >    steal one byte from the data buffer for the extra address byte, so
> >    I'd expect write_max to be capped at I2C_SMBUS_BLOCK_MAX - 1.
> 
> I think that I had a vague concern about sending a non-power-of-two amount
> of data per transfer. I don't see why that should be an issue.

Should indeed not be an issue as long as you don't cross a page
boundary.

> > (...)
> > The code you added will never be executed anyway, because of this test
> > in at24_probe():
> > 
> > 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> > 		if (chip.flags & AT24_FLAG_ADDR16)
> > 			return -EPFNOSUPPORT;
> 
> That's true, if this patch is considered by itself. This test is
> updated by the 3rd patch in the series of three that I submitted.

The whole point of splitting the changes into multiple patches is that
they can be applied, tested and accepted (or rejected) independently.
Patches can depend on previous patch in the series but not on following
patches.

In general I am very much in favor of splitting the changes to make
reviews easier, but for this patch series, if there is no easy way to
split the changes, I believe it would make more sense to go with a
single patch.

> P.S. I submitted a v2 of these patches, but only 3/3 is affected.

I don't think I ever received v2 :(

-- 
Jean Delvare
SUSE L3 Support
