From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
Date: Thu, 22 Aug 2013 09:40:45 +0200
Message-ID: <5215C07D.7040000@free-electrons.com>
References: <1376039158-1896-1-git-send-email-gregory.clement@free-electrons.com> <1376039158-1896-2-git-send-email-gregory.clement@free-electrons.com> <20130821210116.GA3130@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130821210116.GA3130@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 21/08/2013 23:01, Wolfram Sang wrote:
> Hi,
> 
> here is the review. BTW have you tested with and without the offload
> engine?

yes with eeprog.

> 
>> +static int mv64xxx_i2c_offload_msg(struct mv64xxx_i2c_data *drv_data)
>> +{
>> +	unsigned long data_reg_hi = 0;
>> +	unsigned long data_reg_lo = 0;
>> +	unsigned long ctrl_reg;
>> +	unsigned int i;
>> +	struct i2c_msg *msg = drv_data->msgs;
>> +
>> +	drv_data->msg = msg;
>> +	drv_data->byte_posn = 0;
>> +	drv_data->bytes_left = msg->len;
>> +	drv_data->aborting = 0;
>> +	drv_data->rc = 0;
>> +	/* Only regular transactions can be offloaded */
>> +	if ((msg->flags & ~(I2C_M_TEN | I2C_M_RD)) != 0)
>> +		return 1;
> 
> -EINVAL?
> 

OK

>> +
>> +	/* Only 1-8 byte transfers can be offloaded */
>> +	if (msg->len < 1 || msg->len > 8)
>> +		return 1;
> 
> ditto
> 

OK

>> +
>> +	/* Build transaction */
>> +	ctrl_reg = MV64XXX_I2C_BRIDGE_CONTROL_ENABLE |
>> +		   (msg->addr << MV64XXX_I2C_BRIDGE_CONTROL_ADDR_SHIFT);
>> +
>> +	if ((msg->flags & I2C_M_TEN) != 0)
>> +		ctrl_reg |=  MV64XXX_I2C_BRIDGE_CONTROL_ADDR_EXT;
>> +
>> +	if ((msg->flags & I2C_M_RD) == 0) {
>> +		for (i = 0; i < 4 && i < msg->len; i++)
>> +			data_reg_lo = data_reg_lo |
>> +					(msg->buf[i] << ((i & 0x3) * 8));
>> +
>> +		for (i = 4; i < 8 && i < msg->len; i++)
>> +			data_reg_hi = data_reg_hi |
>> +					(msg->buf[i] << ((i & 0x3) * 8));
> 
> What about:
> 
> 	local_buf[8] = { 0 };
> 
> 	memcpy(local_buf, msg->buf, msg->len);
> 	cpu_to_be32(...)
> 
> ? A lot less lines and be32 macros are likely more efficient. Copy loop
> probably, too.
> 

OK


>> +
>> +		ctrl_reg |= MV64XXX_I2C_BRIDGE_CONTROL_WR |
>> +		    (msg->len - 1) << MV64XXX_I2C_BRIDGE_CONTROL_TX_SIZE_SHIFT;
>> +	} else {
>> +		ctrl_reg |= MV64XXX_I2C_BRIDGE_CONTROL_RD |
>> +		    (msg->len - 1) << MV64XXX_I2C_BRIDGE_CONTROL_RX_SIZE_SHIFT;
>> +	}
>> +
>> +	/* Execute transaction */
>> +	writel_relaxed(data_reg_lo,
>> +		drv_data->reg_base + MV64XXX_I2C_REG_TX_DATA_LO);
>> +	writel_relaxed(data_reg_hi,
>> +		drv_data->reg_base + MV64XXX_I2C_REG_TX_DATA_HI);
> 
> Do you need to write the 0 in case of I2C_M_RD?
> 

Not sure I will check it

>> +	writel(ctrl_reg, drv_data->reg_base + MV64XXX_I2C_REG_BRIDGE_CONTROL);
>> +
>> +	return 0;
>> +}
>> +
>> +static void
>> +mv64xxx_i2c_update_offload_data(struct i2c_msg *msg, unsigned long data_reg_hi,
>> +	unsigned long data_reg_lo)
>> +{
>> +	int i;
>> +
>> +	if ((msg->flags & I2C_M_RD) != 0) {
> 
> != 0 is superfluous
> 

OK

>> +		for (i = 0; i < 4 && i < msg->len; i++) {
>> +			msg->buf[i] = data_reg_lo & 0xFF;
>> +			data_reg_lo >>= 8;
>> +		}
>> +
>> +		for (i = 4; i < 8 && i < msg->len; i++) {
>> +			msg->buf[i] = data_reg_hi & 0xFF;
>> +			data_reg_hi >>= 8;
>> +		}
>> +	}
> 
> Same idea as above?
> 

OK I will do it here also as in both cases the number of lines will be
shorter, but for small amount of data I am not sure it will be faster.

>> @@ -298,21 +420,36 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)
>>  static void
>>  mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
>>  {
>> +	unsigned long data_reg_hi = 0;
>> +	unsigned long data_reg_lo = 0;
>> +
>>  	switch(drv_data->action) {
>> +	case MV64XXX_I2C_ACTION_OFFLOAD_RESTART:
>> +		data_reg_lo = readl(drv_data->reg_base +
>> +				MV64XXX_I2C_REG_RX_DATA_LO);
>> +		data_reg_hi = readl(drv_data->reg_base +
>> +				MV64XXX_I2C_REG_RX_DATA_HI);
> 
> Initializing data_reg_* is the same for both calls to
> update_offload_data, so it could be moved into the function.
> Probably not needed when using the local_buf idea.
> 

I will move this part in the update_offload_data function.

>> @@ -326,6 +463,12 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
>>  			drv_data->reg_base + drv_data->reg_offsets.control);
>>  		break;
>>  
>> +	case MV64XXX_I2C_ACTION_OFFLOAD_SEND_START:
>> +		if (mv64xxx_i2c_offload_msg(drv_data) <= 0)
> 
> needs to be adjusted when using -EINVAL above. I'd prefer the error case
> in the else branch, though. Easier to read.
> 

OK, but in this case ...

>> +			break;
>> +		else
>> +			drv_data->action = MV64XXX_I2C_ACTION_SEND_START;
>> +		/* FALLTHRU */

... the fall through here is less readable. But it is a matter of
taste, I will change this.

>>  	case MV64XXX_I2C_ACTION_SEND_START:
>>  		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_START,
>>  			drv_data->reg_base + drv_data->reg_offsets.control);
> 
>> @@ -601,6 +779,13 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
>>  
>>  	memcpy(&drv_data->reg_offsets, device->data, sizeof(drv_data->reg_offsets));
>>  
>> +	/*
>> +	 * For controllers embedded in new SoCs activate the
>> +	 * Transaction Generator support.
>> +	 */
>> +	if (of_device_is_compatible(np, "marvell,mv78230-i2c"))
>> +		drv_data->offload_enabled = true;
> 
> For now OK, if there are more users, someone will need to convert it to
> be included in match_data.
> 
>> @@ -654,6 +839,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>>  		drv_data->freq_n = pdata->freq_n;
>>  		drv_data->irq = platform_get_irq(pd, 0);
>>  		drv_data->adapter.timeout = msecs_to_jiffies(pdata->timeout);
>> +		drv_data->offload_enabled = 0;
> 
> 'false' instead of 0.
> 

OK

Thanks for your review.

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
