From: "Tirdea, Irina" <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v3 1/8] i2c: core: Add support for best effort block
 read emulation
Date: Tue, 4 Aug 2015 13:51:13 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0ADC68@irsmsx105.ger.corp.intel.com>
References: <1435916017-12859-1-git-send-email-irina.tirdea@intel.com>
 <1435916017-12859-2-git-send-email-irina.tirdea@intel.com>
 <55991BE7.6050705@kernel.org>
 <1F3AC3675D538145B1661F571FE1805F2F067FA4@irsmsx105.ger.corp.intel.com>
 <20150801195320.GA1590@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150801195320.GA1590@katana>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Pandruvada, Srinivas" <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



> -----Original Message-----
> From: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Wolfram Sang
> Sent: 01 August, 2015 22:53
> To: Tirdea, Irina
> Cc: Jonathan Cameron; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Pandruvada, Srinivas; Peter Meerwald; linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH v3 1/8] i2c: core: Add support for best effort block read emulation
> 
> 
> > > I wonder what devices do if you do a word read beyond their end address?
> > > Perhaps in odd cases we should always fall back to byte reads?
> >
> > In my tests I can read beyond the end address, but I cannot be sure if this is OK for all
> > devices. This was actually a suggestion from Wolfram for v1, but maybe I'm missing
> > something.
> >
> > Wolfram, is it safe to read one byte beyond the end address or should I better use
> > only byte reads for odd lengths?
> 
> Well, from a device perspective, it is probably better to be safe than
> sorry and fall back to a single byte read. That means, however, that we
> need READ_WORD_DATA and READ_BYTE_DATA to be supported by the adapter.
> Should be OK, I don't think there are adapters which can only read words.
> 

OK. In this case, I would rather go back to how reading odd lengths was handled in
the first version of this patch: use word reads up to the last byte and read that last
byte using a byte read. In this way, odd and even lengths are both handled as
expected (by first falling back to word reads and then to byte reads).
Also, some adapters have performance issues when using more i2c transactions,
so using word instead of byte reads where is possible could help.
I'll send v4 like this and wait for your feedback.

> > > > + */
> > > > +s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
> > > > +					      u8 command, u8 length, u8 *values)
> > > > +{
> > > > +	u8 i;
> > > > +	int status;
> > > > +
> > > > +	if (length > I2C_SMBUS_BLOCK_MAX)
> > > > +		length = I2C_SMBUS_BLOCK_MAX;
> > > > +
> > > > +	if (i2c_check_functionality(client->adapter,
> > > > +				    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> > > > +		return i2c_smbus_read_i2c_block_data(client, command,
> > > > +						     length, values);
> 
> I am not very strict with the 80 char limit. I'd think the code is more
> readable if the two statements above would be oneliners. And for some
> other lines later as well.
> 
Ok. 
> > > > +	} else if (i2c_check_functionality(client->adapter,
> 
> No need for else since we return in the above if anyhow.

Ok. Will fix this.
> 
> > > > +					   I2C_FUNC_SMBUS_READ_WORD_DATA)) {
> > > > +		for (i = 0; i < length; i += 2) {
> > > > +			status = i2c_smbus_read_word_data(client, command + i);
> > > > +			if (status < 0)
> > > > +				return status;
> > > > +			values[i] = status & 0xff;
> > > > +			if ((i + 1) < length)
> > > > +				values[i + 1] = status >> 8;
> > > > +		}
> > > > +		if (i > length)
> > > > +			return length;
> > > > +		return i;
> > > > +	} else if (i2c_check_functionality(client->adapter,
> > > > +					   I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
> > > > +		for (i = 0; i < length; i++) {
> > > > +			status = i2c_smbus_read_byte_data(client, command + i);
> > > > +			if (status < 0)
> > > > +				return status;
> > > > +			values[i] = status;
> > > > +		}
> > > > +		return i;
> > > > +	}
> > > > +
> > > > +	dev_err(&client->adapter->dev, "Unsupported transactions: %d,%d,%d\n",
> > > > +		I2C_SMBUS_I2C_BLOCK_DATA, I2C_SMBUS_WORD_DATA,
> > > > +		I2C_SMBUS_BYTE_DATA);
> 
> I don't think the %d printouts are useful. Just say that the adapter
> lacks support for needed transactions. And I think the device which
> reports the error should be the client device, no?
> 

I actually looked at i2c_smbus_xfer_emulated that is printing a similar message along
with the unsupported transaction size. Probably the client should print these kind of
messages anyway, so I will remove the %d printouts. I can remove the dev_err entirely
if you think that is better.

Thanks,
Irina

> Thanks,
> 
>    Wolfram
