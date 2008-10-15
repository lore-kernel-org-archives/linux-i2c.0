From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 5/6]: i2c: Add bus addressing support.
Date: Wed, 15 Oct 2008 14:52:28 +0200
Message-ID: <20081015145228.14b1ae77@hyperion.delvare>
References: <20080821.024330.51639001.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080821.024330.51639001.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Thu, 21 Aug 2008 02:43:30 -0700 (PDT), David Miller wrote:
> 
> i2c: Add bus addressing support.
> 
> Some I2C bus controllers support the driving of multiple I2C bus
> segments (think PCI domains).
> 
> For example, the pcf8584 variants on some sparc64 boxes can do this.
> They have an auxiliary 8-bit register that specifies the I2C bus each
> I2C operation acts upon.  In the openfirmware device tree, the I2C
> client devices are described using an 8-bit bus address and a 10-bit
> I2C device address.

Can you please point me to the part of the PCF8454 datasheet which
explains this? I can't find it. As I read the datasheet, the PCF8454
supports a single I2C bus.

> 
> In practice only really small numbers are used for the I2C bus
> numbers, such as "0" and "1".  So we don't need to really represent
> the full 8-bits.
> 
> Adding this support is a little bit tricky, because we can't just add
> a "bus" member to struct i2c_client, struct i2c_msg, etc. because
> some of these structures are exported to userspace for the sake of the
> i2c-dev driver interface.
> 
> Since we encode the I2C addresses in a 16-bit quantity, we steal the
> top 6 bits for the bus number.
> 
> This works out because all current code will generate addresses with
> those top 6-bits clear.

Oh my, holy crap! I can't believe you dared to propose this.

(Note that we may actually need one of these 6 unused bits someday, to
properly support 10-bit addressing. Currently it isn't possible to have
a 7-bit address chip and a 10-bit address chip using the same address
number on a given bus, while this is physically allowed.)

> 
> We add a new functionality bit, I2C_FUNC_BUS_ADDRESSING, that the
> algorithm provider uses to indicate that it can support bus addressing.
> 
> If we see a non-zero bus address, we make sure the adapter can support
> it.

I don't like this at all. This really looks like a custom hack to solve
the problem at hand without paying too much attention to compatibility
issues which I am certain will arise. Just to mention the first one
that comes to mind: access from user-space through i2c-dev, and
specifically i2c-tools.

What makes your setup fundamentally different from a motherboard with
more than one I2C bus (which is a rather common case)? Why don't you
simply register one i2c_adapter for each i2c bus segment?

> 
> Signed-off-by: David S. Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 550853f..3c0b5af 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -807,6 +807,10 @@ static int __i2c_check_addr(struct device *dev, void *addrp)
>  
>  static int i2c_check_addr(struct i2c_adapter *adapter, int addr)
>  {
> +	if (I2C_ADDR_GET_BUS(addr) != 0 &&
> +	    !i2c_check_functionality(adapter, I2C_FUNC_BUS_ADDRESSING))
> +		return -EOPNOTSUPP;
> +
>  	return device_for_each_child(&adapter->dev, &addr, __i2c_check_addr);
>  }
>  
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 08be0d2..c93561e 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -169,6 +169,31 @@ struct i2c_driver {
>  };
>  #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
>  
> +/* In order to add bus addressing to the I2C layer without changing
> + * the layout of structures such as i2c_msg (for the sake of
> + * userspace), we encode the bus number into the top 6 bits of the
> + * address value.
> + *
> + * This allows existing userspace and drivers to keep working (the bus
> + * will be zero), and bus addressing support can be gradually added.
> + *
> + * Algorithm providers must indicate they support bus addressing via
> + * i2c_algorithm->functionality().  If they don't, the I2C layer will
> + * reject any attempt to attach, probe, or detect a device with a bus
> + * number other than zero.
> + */
> +#define I2C_ADDR_ADDR_MASK	0x03ff
> +#define I2C_ADDR_ADDR_SHIFT	0
> +#define I2C_ADDR_BUS_MASK	0xfc00
> +#define I2C_ADDR_BUS_SHIFT	10
> +#define I2C_ADDR_GET_ADDR(addr) \
> +	(((addr) & I2C_ADDR_ADDR_MASK) >> I2C_ADDR_ADDR_SHIFT)
> +#define I2C_ADDR_GET_BUS(addr) \
> +	(((addr) & I2C_ADDR_BUS_MASK) >> I2C_ADDR_BUS_SHIFT)
> +#define I2C_ADDR_ENCODE(bus, addr) \
> +	(((bus) << I2C_ADDR_BUS_SHIFT) | \
> +	 ((addr) << I2C_ADDR_ADDR_SHIFT))
> +
>  /**
>   * struct i2c_client - represent an I2C slave device
>   * @flags: I2C_CLIENT_TEN indicates the device uses a ten bit chip address;
> @@ -531,6 +556,7 @@ struct i2c_msg {
>  #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* w/ 1-byte reg. addr. */
>  #define I2C_FUNC_SMBUS_READ_I2C_BLOCK_2	 0x10000000 /* I2C-like block xfer  */
>  #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2 0x20000000 /* w/ 2-byte reg. addr. */
> +#define I2C_FUNC_BUS_ADDRESSING		0x40000000
>  
>  #define I2C_FUNC_SMBUS_BYTE (I2C_FUNC_SMBUS_READ_BYTE | \
>                               I2C_FUNC_SMBUS_WRITE_BYTE)


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
