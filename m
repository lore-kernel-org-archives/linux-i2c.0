Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5608D402453;
	Thu,  9 Jul 2026 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589293; cv=none; b=S/7VH3kmqrAyjXcLXFZO9uAzrVMe4UsuqZEAf5LgSmeg3YhO+Dl0marHXJ0YogmyntqwEKfIsf9rvEYdfotWqNL1ynlmbBR6qqdQs+Pi/AwsEO8jKAYEj9tzaCsI93xQ8Bx+Mv4eQLEI+S4RzMLOAT6WlRKwghztRDAGPIiHfxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589293; c=relaxed/simple;
	bh=jfyQkpCZII0uVZuoC+54Lo1KjzhJe2lDVP2SuW1Fqx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucUu4zbCeoybwKpI+tD8I74ygnIHwnpjxOJZ39OAuexzEOnK2wljh8sA8WGPR7srnmGCDrJxSw3vZ6MzaZirhxvB2xM6rBQEbz6B3amP52NCZ0/hfMz7oHf6WVoxKD9+3JzsM0k2NFaqTJr3QY0pMkSlS7OWJUSFVtyvwlx1c+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsMzQ/8B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsMzQ/8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4FF1F00A3A;
	Thu,  9 Jul 2026 09:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783589282;
	bh=W9NS7Eko8kG3Pck7dcJ0KI9c7pQ79EorRXWLqm5A2XY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WsMzQ/8B85nCagxJLIbh8erD498bXiCWjSMQ6JTUOXZ2ficZqp6qeVTVzzRXtnNOB
	 SJnvyzDGgZgGD4ziJbe/bF5xSZGLZMXhI7IMsgGRUDv/+8cGIaKeNbNfCzUpI2nWQ2
	 GUh60x7h4cC4cfCKRr7LWIc79X57evWbZHUELxEXlwZBlq7JT/0AL85LUV+oDh5HPR
	 gjv+XL4WAb5Htp3/ruRbZZYp/7trwjFj7OpDyXJJ/vkFi5RB7DaUPVKB6IcqRjFlAM
	 h9966xDrMFguMiQ4l4rDYZM0zQQ8B2ciYBUFjkL/BmrbY0Cp6zDXN0141meqwsUUv9
	 NidQvOOr4y9DQ==
Date: Thu, 9 Jul 2026 10:27:59 +0100
From: Lee Jones <lee@kernel.org>
To: a0282524688@gmail.com
Cc: Ming Yu <tmyu0@nuvoton.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v6 6/7] mfd: nct6694: Introduce regmap-based transport
 abstraction
Message-ID: <20260709092759.GC2045740@google.com>
References: <20260701035025.3082927-1-a0282524688@gmail.com>
 <20260701035025.3082927-7-a0282524688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701035025.3082927-7-a0282524688@gmail.com>

/* Sashiko Automation: Issues Found (4 Findings) */

Some relevant ones I'd like you to look at please.

On Wed, 01 Jul 2026, a0282524688@gmail.com wrote:

> From: Ming Yu <a0282524688@gmail.com>
> 
> Wrap the USB transport behind a regmap_bus so that sub-device drivers
> talk to the firmware exclusively through nct6694_{read,write}_msg(),
> without referencing the underlying transport. This unblocks adding the
> upcoming HIF (eSPI) backend without touching any sub-device driver.
> 
> Encode the firmware addressing scheme (host control, module id and
> 16-bit offset) into a single 32-bit regmap register so that struct
> nct6694_cmd_header maps cleanly onto regmap_bulk_{read,write}():
> 
>     bits [31:24]  host control
>     bits [23:16]  module id
>     bits [15:0]   offset (low byte = command, high byte = selector)
> 
> Add nct6694_write_read_msg() for the few commands (e.g. the I2C
> "deliver" command) that send a request and read the reply back in a
> single transaction, and convert the I2C transfer path to use it.
> 
> The USB backend gains a scratch xfer_buf because nct6694_usb_write_msg()
> writes the firmware response back into its payload buffer, which is
> incompatible with the const buffer handed to regmap_bus->write. The
> per-transport access_lock is removed: regmap already serialises bus
> accesses on its own.
> 
> Signed-off-by: Ming Yu <a0282524688@gmail.com>
> ---
> Changes in v6:
> - New patch. Replaces the v5 function-pointer abstraction with a
>   regmap_bus based transport: the firmware command header is packed into
>   a single 32-bit regmap register and sub-device drivers use the regmap
>   bulk accessors. Adds nct6694_write_read_msg() for request/response
>   commands and drops the per-transport access_lock (regmap already
>   serialises bus accesses).
> 
>  drivers/i2c/busses/i2c-nct6694.c |   2 +-
>  drivers/mfd/Kconfig              |   1 +
>  drivers/mfd/nct6694-usb.c        | 118 +++++++++++++++++++++----------
>  include/linux/mfd/nct6694.h      |  63 ++++++++++++++---
>  4 files changed, 134 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-nct6694.c b/drivers/i2c/busses/i2c-nct6694.c
> index ef3329f34246..7e32dab6e759 100644
> --- a/drivers/i2c/busses/i2c-nct6694.c
> +++ b/drivers/i2c/busses/i2c-nct6694.c
> @@ -77,7 +77,7 @@ static int nct6694_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int
>  		deliver->addr = i2c_8bit_addr_from_msg(msg_temp);
>  		if (msg_temp->flags & I2C_M_RD) {
>  			deliver->r_cnt = msg_temp->len;
> -			ret = nct6694_write_msg(data->nct6694, &cmd_hd, deliver);
> +			ret = nct6694_write_read_msg(data->nct6694, &cmd_hd, deliver);

[Severity: High]
This is a pre-existing issue, but does passing the embedded deliver struct
(from struct nct6694_i2c_data) as the data buffer for I2C read/write
transactions risk memory corruption on non-cache-coherent architectures?

The USB transport calls usb_bulk_msg() in nct6694_usb_read_msg(), which maps
this unaligned buffer for DMA. Because deliver is embedded adjacent to other
fields like the i2c_adapter, it shares cachelines with them.

DMA invalidations during the I2C read phase could silently overwrite concurrent
CPU writes to adjacent fields, such as sysfs statistics in the i2c_adapter.



>  			if (ret < 0)
>  				return ret;
>  
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 5506a0adf3ec..742fc26e6ff7 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1166,6 +1166,7 @@ config MFD_MENF21BMC
>  config MFD_NCT6694
>  	tristate
>  	select MFD_CORE
> +	select REGMAP
>  	help
>  	  Core MFD support for the Nuvoton NCT6694 peripheral expander.
>  	  This provides the common APIs and shared structures used by all
> diff --git a/drivers/mfd/nct6694-usb.c b/drivers/mfd/nct6694-usb.c
> index 2289ebfde7fa..8e7f3b07de53 100644
> --- a/drivers/mfd/nct6694-usb.c
> +++ b/drivers/mfd/nct6694-usb.c
> @@ -9,6 +9,7 @@
>   * CAN, WDT, HWMON and RTC management.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -17,7 +18,9 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/nct6694.h>
>  #include <linux/module.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/unaligned.h>
>  #include <linux/usb.h>
>  
>  #define NCT6694_VENDOR_ID	0x0416
> @@ -34,10 +37,10 @@ union __packed nct6694_usb_msg {
>  };
>  
>  struct nct6694_usb_data {
> -	struct mutex access_lock;
>  	struct urb *int_in_urb;
>  	struct usb_device *udev;
>  	union nct6694_usb_msg *usb_msg;
> +	void *xfer_buf;
>  	__le32 *int_buffer;
>  };
>  
> @@ -101,29 +104,15 @@ static int nct6694_usb_err_handling(struct nct6694 *nct6694, unsigned char err_s
>  	return -EIO;
>  }
>  
> -/**
> - * nct6694_usb_read_msg() - Read message from NCT6694 device
> - * @nct6694: NCT6694 device pointer
> - * @cmd_hd: command header structure
> - * @buf: buffer to store the response data
> - *
> - * Sends a command to the NCT6694 device and reads the response.
> - * The command header is specified in @cmd_hd, and the response
> - * data is stored in @buf.
> - *
> - * Return: Negative value on error or 0 on success.
> - */
> -int nct6694_usb_read_msg(struct nct6694 *nct6694,
> -			 const struct nct6694_cmd_header *cmd_hd,
> -			 void *buf)
> +static int nct6694_usb_read_msg(struct nct6694 *nct6694,
> +				const struct nct6694_cmd_header *cmd_hd,
> +				void *buf)
>  {
>  	struct nct6694_usb_data *udata = nct6694->priv;
>  	union nct6694_usb_msg *msg = udata->usb_msg;
>  	struct usb_device *udev = udata->udev;
>  	int tx_len, rx_len, ret;
>  
> -	guard(mutex)(&udata->access_lock);
> -
>  	memcpy(&msg->cmd_header, cmd_hd, sizeof(*cmd_hd));
>  	msg->cmd_header.hctrl = NCT6694_HCTRL_GET;
>  
> @@ -153,30 +142,16 @@ int nct6694_usb_read_msg(struct nct6694 *nct6694,
>  
>  	return nct6694_usb_err_handling(nct6694, msg->response_header.sts);
>  }
> -EXPORT_SYMBOL_GPL(nct6694_usb_read_msg);
>  
> -/**
> - * nct6694_usb_write_msg() - Write message to NCT6694 device
> - * @nct6694: NCT6694 device pointer
> - * @cmd_hd: command header structure
> - * @buf: buffer containing the data to be sent
> - *
> - * Sends a command to the NCT6694 device and writes the data
> - * from @buf. The command header is specified in @cmd_hd.
> - *
> - * Return: Negative value on error or 0 on success.
> - */
> -int nct6694_usb_write_msg(struct nct6694 *nct6694,
> -			  const struct nct6694_cmd_header *cmd_hd,
> -			  void *buf)
> +static int nct6694_usb_write_msg(struct nct6694 *nct6694,
> +				 const struct nct6694_cmd_header *cmd_hd,
> +				 void *buf)
>  {
>  	struct nct6694_usb_data *udata = nct6694->priv;
>  	union nct6694_usb_msg *msg = udata->usb_msg;
>  	struct usb_device *udev = udata->udev;
>  	int tx_len, rx_len, ret;
>  
> -	guard(mutex)(&udata->access_lock);
> -
>  	memcpy(&msg->cmd_header, cmd_hd, sizeof(*cmd_hd));
>  	msg->cmd_header.hctrl = NCT6694_HCTRL_SET;
>  
> @@ -212,7 +187,67 @@ int nct6694_usb_write_msg(struct nct6694 *nct6694,
>  
>  	return nct6694_usb_err_handling(nct6694, msg->response_header.sts);
>  }
> -EXPORT_SYMBOL_GPL(nct6694_usb_write_msg);
> +
> +static int nct6694_usb_regmap_read(void *context, const void *reg_buf,
> +				   size_t reg_size, void *val_buf,
> +				   size_t val_size)
> +{
> +	struct nct6694 *nct6694 = context;
> +	u32 reg = get_unaligned_be32(reg_buf);
> +	const struct nct6694_cmd_header cmd_hd = {
> +		.mod = FIELD_GET(NCT6694_REG_MOD, reg),
> +		.offset = cpu_to_le16(FIELD_GET(NCT6694_REG_OFFSET, reg)),
> +		.len = cpu_to_le16(val_size),
> +	};
> +
> +	/*
> +	 * A SET transaction is a request/response exchange: send the payload
> +	 * already present in @val_buf and read the response back into it.
> +	 */
> +	if (FIELD_GET(NCT6694_REG_HCTRL, reg) == NCT6694_HCTRL_SET)
> +		return nct6694_usb_write_msg(nct6694, &cmd_hd, val_buf);
> +
> +	return nct6694_usb_read_msg(nct6694, &cmd_hd, val_buf);
> +}
> +
> +static int nct6694_usb_regmap_write(void *context, const void *data,
> +				    size_t count)
> +{
> +	struct nct6694 *nct6694 = context;
> +	struct nct6694_usb_data *udata = nct6694->priv;
> +	u32 reg = get_unaligned_be32(data);
> +	size_t len = count - sizeof(reg);
> +	const struct nct6694_cmd_header cmd_hd = {
> +		.mod = FIELD_GET(NCT6694_REG_MOD, reg),
> +		.offset = cpu_to_le16(FIELD_GET(NCT6694_REG_OFFSET, reg)),
> +		.len = cpu_to_le16(len),
> +	};
> +
> +	if (len > NCT6694_MAX_PACKET_SIZE)
> +		return -EINVAL;
> +
> +	/*
> +	 * nct6694_usb_write_msg() reads the firmware response back into the
> +	 * payload buffer, so copy the const regmap data into a scratch buffer
> +	 * it can write to.
> +	 */
> +	memcpy(udata->xfer_buf, data + sizeof(reg), len);
> +
> +	return nct6694_usb_write_msg(nct6694, &cmd_hd, udata->xfer_buf);
> +}
> +
> +static const struct regmap_bus nct6694_usb_regmap_bus = {
> +	.read = nct6694_usb_regmap_read,
> +	.write = nct6694_usb_regmap_write,
> +};
> +
> +static const struct regmap_config nct6694_usb_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 8,
> +	.reg_stride = 1,
> +	.max_raw_read = NCT6694_MAX_PACKET_SIZE,
> +	.max_raw_write = NCT6694_MAX_PACKET_SIZE,
> +};
>  
>  static void nct6694_usb_int_callback(struct urb *urb)
>  {
> @@ -270,6 +305,10 @@ static int nct6694_usb_probe(struct usb_interface *iface,
>  	if (!udata->usb_msg)
>  		return -ENOMEM;
>  
> +	udata->xfer_buf = devm_kzalloc(dev, NCT6694_MAX_PACKET_SIZE, GFP_KERNEL);
> +	if (!udata->xfer_buf)
> +		return -ENOMEM;
> +
>  	udata->int_buffer = devm_kzalloc(dev, sizeof(*udata->int_buffer), GFP_KERNEL);
>  	if (!udata->int_buffer)
>  		return -ENOMEM;
> @@ -283,9 +322,12 @@ static int nct6694_usb_probe(struct usb_interface *iface,
>  	nct6694->dev = dev;
>  	nct6694->priv = udata;
>  
> -	ret = devm_mutex_init(dev, &udata->access_lock);
> -	if (ret)
> +	nct6694->regmap = devm_regmap_init(dev, &nct6694_usb_regmap_bus, nct6694,
> +					   &nct6694_usb_regmap_config);
> +	if (IS_ERR(nct6694->regmap)) {
> +		ret = PTR_ERR(nct6694->regmap);
>  		goto err_urb;
> +	}
>  
>  	interface = iface->cur_altsetting;
>  

[Severity: High]
This isn't a bug introduced by this patch, but could an out-of-bounds read
occur if a malicious USB device presents an interface with zero endpoints?

In nct6694_usb_probe() just below this diff, the code unconditionally accesses
the first endpoint:

    int_endpoint = &interface->endpoint[0].desc;
    if (!usb_endpoint_is_int_in(int_endpoint)) {

If the device provides 0 endpoints, the endpoint array is empty, leading to an
out-of-bounds read of kernel memory.



[Severity: High]
Could an early URB completion allow privilege escalation?

In nct6694_usb_probe(), just below this diff, the interrupt URB is submitted
before nct6694_core_probe() is called:

    ret = usb_submit_urb(udata->int_in_urb, GFP_KERNEL);
    ...
    ret = nct6694_core_probe(dev, nct6694, nct6694_usb_devs, ...);

A malicious or fast USB device can complete the URB immediately, triggering
nct6694_usb_int_callback() while nct6694->domain (created in the core probe)
is still NULL.

If the callback runs with a NULL domain:

    generic_handle_irq_safe(irq_find_mapping(nct6694->domain, irq));

It calls irq_find_mapping(NULL, irq), which causes the kernel to fall back to
the irq_default_domain. This allows an attacker to supply crafted hardware IRQ
numbers in the payload, spoofing arbitrary system interrupts (like timers or
keyboards).



> diff --git a/include/linux/mfd/nct6694.h b/include/linux/mfd/nct6694.h
> index 853b1530755d..d655d726d4de 100644
> --- a/include/linux/mfd/nct6694.h
> +++ b/include/linux/mfd/nct6694.h
> @@ -9,7 +9,9 @@
>  #ifndef __MFD_NCT6694_H
>  #define __MFD_NCT6694_H
>  
> +#include <linux/bitfield.h>
>  #include <linux/idr.h>
> +#include <linux/regmap.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
>  
> @@ -29,6 +31,9 @@ struct mfd_cell;
>  #define NCT6694_HCTRL_SET	0x40
>  #define NCT6694_HCTRL_GET	0x80
>  
> +/* Maximum message payload length exchanged with the firmware in one command */
> +#define NCT6694_MAX_PACKET_SIZE	0x3F0
> +
>  enum nct6694_irq_id {
>  	NCT6694_IRQ_GPIO0 = 0,
>  	NCT6694_IRQ_GPIO1,
> @@ -87,6 +92,7 @@ struct __packed nct6694_response_header {
>  
>  struct nct6694 {
>  	struct device *dev;
> +	struct regmap *regmap;
>  	struct ida gpio_ida;
>  	struct ida i2c_ida;
>  	struct ida canfd_ida;
> @@ -97,29 +103,64 @@ struct nct6694 {
>  	void *priv;
>  };
>  
> -int nct6694_core_probe(struct device *dev, struct nct6694 *nct6694,
> -		       const struct mfd_cell *cells, int n_cells);
> -void nct6694_core_remove(struct nct6694 *nct6694);
> +/*
> + * The NCT6694 firmware is reached through messages that carry a module id
> + * together with an offset (or command/selector pair). These fields are packed
> + * into a single 32-bit regmap register so that the sub-device drivers can use
> + * the standard regmap bulk accessors, while each transport driver implements
> + * the actual I/O through its own regmap bus.
> + *
> + *   bits [31:24]  host control (NCT6694_HCTRL_GET / NCT6694_HCTRL_SET)
> + *   bits [23:16]  module id
> + *   bits [15:0]   offset (low byte = command, high byte = selector)
> + */
> +#define NCT6694_REG_HCTRL	GENMASK(31, 24)
> +#define NCT6694_REG_MOD		GENMASK(23, 16)
> +#define NCT6694_REG_OFFSET	GENMASK(15, 0)
>  
> -int nct6694_usb_read_msg(struct nct6694 *nct6694,
> -			 const struct nct6694_cmd_header *cmd_hd,
> -			 void *buf);
> -int nct6694_usb_write_msg(struct nct6694 *nct6694,
> -			  const struct nct6694_cmd_header *cmd_hd,
> -			  void *buf);
> +static inline u32 nct6694_cmd_to_reg(const struct nct6694_cmd_header *cmd_hd,
> +				     u8 hctrl)
> +{
> +	return FIELD_PREP(NCT6694_REG_HCTRL, hctrl) |
> +	       FIELD_PREP(NCT6694_REG_MOD, cmd_hd->mod) |
> +	       FIELD_PREP(NCT6694_REG_OFFSET, le16_to_cpu(cmd_hd->offset));
> +}
>  
>  static inline int nct6694_read_msg(struct nct6694 *nct6694,
>  				   const struct nct6694_cmd_header *cmd_hd,
>  				   void *buf)
>  {
> -	return nct6694_usb_read_msg(nct6694, cmd_hd, buf);
> +	return regmap_bulk_read(nct6694->regmap,
> +				nct6694_cmd_to_reg(cmd_hd, NCT6694_HCTRL_GET),
> +				buf, le16_to_cpu(cmd_hd->len));
>  }

[Severity: Medium]
Are we misusing the regmap API by passing an input payload through
regmap_bulk_read() in nct6694_write_read_msg()?

The driver handles command exchanges by modeling them as a regmap_bulk_read()
of a SET register, passing the request payload inside the buf parameter.
However, the regmap API strictly defines this as an output buffer.

This currently works because regmap bypasses bounce buffers and cache for this
specific configuration. Any future changes in the regmap subsystem, such as
initializing output buffers, enabling a regmap cache, or adding bounce buffers
for DMA alignment, will silently discard the outgoing request payload.

>  
>  static inline int nct6694_write_msg(struct nct6694 *nct6694,
>  				    const struct nct6694_cmd_header *cmd_hd,
>  				    void *buf)
>  {
> -	return nct6694_usb_write_msg(nct6694, cmd_hd, buf);
> +	return regmap_bulk_write(nct6694->regmap,
> +				 nct6694_cmd_to_reg(cmd_hd, NCT6694_HCTRL_SET),
> +				 buf, le16_to_cpu(cmd_hd->len));
>  }

[Severity: Medium]
Are we misusing the regmap API by passing an input payload through
regmap_bulk_read() in nct6694_write_read_msg()?

The driver handles command exchanges by modeling them as a regmap_bulk_read()
of a SET register, passing the request payload inside the buf parameter.
However, the regmap API strictly defines this as an output buffer.

This currently works because regmap bypasses bounce buffers and cache for this
specific configuration. Any future changes in the regmap subsystem, such as
initializing output buffers, enabling a regmap cache, or adding bounce buffers
for DMA alignment, will silently discard the outgoing request payload.

>  
> +/*
> + * A few firmware commands (e.g. the I2C "deliver") transmit a request and
> + * read the reply back in a single transaction. Model this as a regmap read of
> + * a SET register: @buf carries the request on entry and holds the reply on
> + * return, so the firmware exchange stays a single message as before.
> + */
> +static inline int nct6694_write_read_msg(struct nct6694 *nct6694,
> +					 const struct nct6694_cmd_header *cmd_hd,
> +					 void *buf)
> +{
> +	return regmap_bulk_read(nct6694->regmap,
> +				nct6694_cmd_to_reg(cmd_hd, NCT6694_HCTRL_SET),
> +				buf, le16_to_cpu(cmd_hd->len));
> +}

[Severity: Medium]
Are we misusing the regmap API by passing an input payload through
regmap_bulk_read() in nct6694_write_read_msg()?

The driver handles command exchanges by modeling them as a regmap_bulk_read()
of a SET register, passing the request payload inside the buf parameter.
However, the regmap API strictly defines this as an output buffer.

This currently works because regmap bypasses bounce buffers and cache for this
specific configuration. Any future changes in the regmap subsystem, such as
initializing output buffers, enabling a regmap cache, or adding bounce buffers
for DMA alignment, will silently discard the outgoing request payload.

> +
> +int nct6694_core_probe(struct device *dev, struct nct6694 *nct6694,
> +		       const struct mfd_cell *cells, int n_cells);
> +void nct6694_core_remove(struct nct6694 *nct6694);
> +
>  #endif
> -- 
> 2.34.1
> 

-- 
Lee Jones
