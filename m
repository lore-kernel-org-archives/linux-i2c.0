From: Jochen Friedrich <jochen@scram.de>
Subject: Re: [i2c] [PATCH6/7] i2c: adds support for i2c bus on Freescale	CPM1/CPM2
 controllers
Date: Tue, 06 May 2008 17:19:39 +0200
Message-ID: <4820770B.1010002@scram.de>
References: <47FF71A9.4010907@scram.de> <20080506135113.GA4265@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764159AbYEFPUG@vger.kernel.org>
In-Reply-To: <20080506135113.GA4265@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel, Linux" <linux-kernel@vger.kernel.org>, Scott Wood <scottwood@freescale.com>, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

>> +	/* Begin transmission */
>> +	setbits8(&i2c_reg->i2com, 0x80);
> Hardcoded value. (I also wonder if 0x81 might be more suitable, as it
> keeps the "be-a-master"-bit set. Still, both values work with my setup.)

>> +#ifdef I2C_CHIP_ERRATA
>> +	/*
>> +	 * Chip errata, clear enable. This is not needed on rev D4 CPUs.
>> +	 * Disabling I2C too early may cause too short stop condition
>> +	 */
>> +	udelay(4);
>> +	clrbits8(&i2c_reg->i2mod, 1);
> I was unable to find the corresponding errata document, still I wonder
> if it is a 0 which should have been written? The text says "clear" and
> according to the reference manual, this means the bit should be 0.

setbits8() and clrbits8() use a bitmask as second argument.

setbits8(&i2c_reg->i2com, 0x80) will set bit 7 on the i2com register but 
leave bit 0 untouched. Likewise, clrbits8(&i2c_reg->i2mod, 1) will clear bit 0.

Thanks,
Jochen
