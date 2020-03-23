From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v9 3/3] i2c: npcm7xx: Add support for slave mode for
 Nuvoton
Date: Mon, 23 Mar 2020 18:01:58 +0200
Message-ID: <20200323160158.GR1922688@smile.fi.intel.com>
References: <20200323134437.259210-1-tali.perry1@gmail.com>
 <20200323134437.259210-4-tali.perry1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200323134437.259210-4-tali.perry1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tali Perry <tali.perry1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, avifishman70-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kfting-KrzQf0k3Iz9BDgjK7y7TUQ@public.gmane.org, venture-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, yuenn-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, benjaminfair-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 23, 2020 at 03:44:37PM +0200, Tali Perry wrote:
> Add support for slave mode for Nuvoton
> NPCM BMC I2C controller driver.

Same comments apply as per previous patch.

...

> +#if IS_ENABLED(CONFIG_I2C_SLAVE)

Perhaps create a separate module and compile it when user selects?
See I²C DesignWare split.

...

> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +	if (bus->slave) {
> +		npcm_i2c_slave_enable_l(bus, I2C_SLAVE_ADDR1, bus->slave->addr,
> +					true);
> +	}

Put it on one line and drop {} -- it will be much better to read.

> +#endif

...

> +static void npcm_i2c_write_to_fifo_slave(struct npcm_i2c *bus,
> +					 u16 max_bytes_to_send)
> +{
> +	// Fill the FIFO, while the FIFO is not full and there are more bytes to
> +	// write
> +	npcm_i2c_clear_fifo_int(bus);
> +	npcm_i2c_clear_tx_fifo(bus);
> +	iowrite8(0, bus->reg + NPCM_I2CTXF_CTL);
> +
> +	while ((max_bytes_to_send--) && (I2C_HW_FIFO_SIZE -
> +					 npcm_i2c_get_fifo_fullness(bus))) {
> +		if (bus->slv_wr_size > 0) {
> +			npcm_i2c_wr_byte(bus,
> +					 bus->slv_wr_buf[bus->slv_wr_ind %
> +					 I2C_HW_FIFO_SIZE]);
> +			bus->slv_wr_ind = (bus->slv_wr_ind + 1) %
> +					   I2C_HW_FIFO_SIZE;
> +			bus->slv_wr_size--; // size indicates the # of bytes in
> +					    // the SW FIFO, not HW.
> +		} else {
> +			break;
> +		}

This looks ugly. Can you redo the style.

> +	}
> +}

...

> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +			if (bus->slave) {
> +				bus->slv_rd_buf[bus->slv_rd_ind %
> +						I2C_HW_FIFO_SIZE] = data;
> +				bus->slv_rd_ind++;
> +				if (bus->slv_rd_ind == 1 && bus->read_block_use)
> +					// 1st byte is length in block protocol
> +					bus->slv_rd_size = data +
> +							   (u8)bus->PEC_use +
> +							(u8)bus->read_block_use;
> +			}
> +#endif

Ditto.

...

>  		   I2C_FUNC_SMBUS_EMUL |
>  		   I2C_FUNC_SMBUS_BLOCK_DATA |
>  		   I2C_FUNC_SMBUS_PEC
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +		   | I2C_FUNC_SLAVE
> +#endif

Completely inconsistent style.

>  		   ;

-- 
With Best Regards,
Andy Shevchenko
