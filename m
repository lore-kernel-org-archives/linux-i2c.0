From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v3 2/8] eeprom: at24: use
 i2c_smbus_read_i2c_block_data_or_emulated
Date: Tue, 4 Aug 2015 13:52:18 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0ADC7C@irsmsx105.ger.corp.intel.com>
References: <1435916017-12859-1-git-send-email-irina.tirdea@intel.com>
 <1435916017-12859-3-git-send-email-irina.tirdea@intel.com>
 <20150801195756.GB1590@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150801195756.GB1590@katana>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, Peter Meerwald <pmeerw@pmeerw.net>
List-Id: linux-i2c@vger.kernel.org



> -----Original Message-----
> From: Wolfram Sang [mailto:wsa@the-dreams.de]
> Sent: 01 August, 2015 22:58
> To: Tirdea, Irina
> Cc: Jonathan Cameron; linux-iio@vger.kernel.org; linux-i2c@vger.kernel.org; linux-kernel@vger.kernel.org; Pandruvada, Srinivas;
> Peter Meerwald
> Subject: Re: [PATCH v3 2/8] eeprom: at24: use i2c_smbus_read_i2c_block_data_or_emulated
> 
> > +		if (at24->use_smbus) {
> > +			status =
> > +			    i2c_smbus_read_i2c_block_data_or_emulated(client,
> > +								      offset,
> > +								      count,
> > +								      buf);
> 
> Please ignore checkpatch warnings for this one and find a nice readable
> way to squeeze that into two lines.

Sure, I will fix this.

Thanks,
Irina
