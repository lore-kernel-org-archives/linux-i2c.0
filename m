From: vitor <Vitor.Soares@synopsys.com>
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Date: Wed, 22 Aug 2018 17:43:34 +0100
Message-ID: <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719152930.3715-2-boris.brezillon@bootlin.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org

Hi Boris,


On 19-07-2018 16:29, Boris Brezillon wrote:
> +int i3c_bus_register(struct i3c_bus *i3cbus)
> +{
> +	struct i2c_dev_desc *desc;
> +
> +	i3c_bus_for_each_i2cdev(i3cbus, desc) {
> +		switch (desc->boardinfo->lvr & I3C_LVR_I2C_INDEX_MASK) {
> +		case I3C_LVR_I2C_INDEX(0):
> +			if (i3cbus->mode < I3C_BUS_MODE_MIXED_FAST)
> +				i3cbus->mode = I3C_BUS_MODE_MIXED_FAST;
> +			break;
> +
> +		case I3C_LVR_I2C_INDEX(1):
> +		case I3C_LVR_I2C_INDEX(2):
> +			if (i3cbus->mode < I3C_BUS_MODE_MIXED_SLOW)
> +				i3cbus->mode = I3C_BUS_MODE_MIXED_SLOW;
> +			break;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (!i3cbus->scl_rate.i3c)
> +		i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
> +
> +	if (!i3cbus->scl_rate.i2c) {
> +		if (i3cbus->mode == I3C_BUS_MODE_MIXED_SLOW)
> +			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_SCL_RATE;
> +		else
> +			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_PLUS_SCL_RATE;
> +	}
> +
> +	/*
> +	 * I3C/I2C frequency may have been overridden, check that user-provided
> +	 * values are not exceeding max possible frequency.
> +	 */
> +	if (i3cbus->scl_rate.i3c > I3C_BUS_MAX_I3C_SCL_RATE ||
> +	    i3cbus->scl_rate.i2c > I3C_BUS_I2C_FM_PLUS_SCL_RATE) {
> +		return -EINVAL;
> +	}
> +
> +	dev_set_name(&i3cbus->dev, "i3c-%d", i3cbus->id);
> +
> +	return device_add(&i3cbus->dev);
> +}
During the tests of the bus with i2c devices I found the i2c_dev_desc 
objects aren't allocated before this function. This cause i3cbus->mode = 
I3C_BUS_MODE_PURE.

I want to do something for the slave and secondary master, do you 
already have infrastructure that you can share?


Best regards,
Vitor Soares
