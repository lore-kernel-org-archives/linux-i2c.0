From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v6] i2c: Adding support for Intel iSMT SMBus 2.0 host
 controller
Date: Mon, 4 Feb 2013 10:47:44 +0100
Message-ID: <20130204104744.5f83541e@endymion.delvare>
References: <1359402232-21369-1-git-send-email-nhorman@tuxdriver.com>
	<1359748083-24423-1-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359748083-24423-1-git-send-email-nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Neil,

On Fri,  1 Feb 2013 14:48:03 -0500, Neil Horman wrote:
> The iSMT (Intel SMBus Message Transport) supports multi-master I2C/SMBus,
> as well as IPMI.  It's operation is DMA-based and utilizes descriptors to
> initiate transactions on the bus.
> 
> The iSMT hardware can act as both a master and a target, although this
> driver only supports being a master.
> 
> Signed-off-by: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
> Signed-off-by: Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Tested-by: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> CC: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> CC: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> 
> ---
> General note - Seth had mentioned to me that he was unable to get writes to work
> on his system.  I'm not sure of the details, but I've done some rudimentary
> read/write testing here on my system, and it seems to work well (for the limited
> testing I can do).  Seth if you could please provide details of your testing, or
> give this patch a try, I would appreciate it.

I am still trying to get my hands on a test machine. I am told we have
a few, however they are currently either not setup or reserved.

Until then, a few remaining comments:

> +/**
> + * ismt_gen_reg_dump() - dump the iSMT General Registers
> + * @priv: iSMT private data
> + */
> +static void ismt_gen_reg_dump(struct ismt_priv *priv)
> +{
> +	struct device *dev = &priv->pci_dev->dev;
> +
> +	dev_dbg(dev, "Dump of the iSMT General Registers\n");
> +	dev_dbg(dev, "  GCTRL.... : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_GR_GCTRL,
> +		readl(priv->smba + ISMT_GR_GCTRL));
> +	dev_dbg(dev, "  SMTICL... : (0x%p)=0x%016lX\n",
> +		priv->smba + ISMT_GR_SMTICL,
> +		(long unsigned int)readq(priv->smba + ISMT_GR_SMTICL));

On 32-bit systems, a long unsigned int can only hold 4 bytes, not 8, so
the top 32 bits of the value returned by readq() will be lost. I think
you have to use format 0x%016llX and cast to long long unsigned int.

> +	dev_dbg(dev, "  ERRINTMSK : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_GR_ERRINTMSK,
> +		readl(priv->smba + ISMT_GR_ERRINTMSK));
> +	dev_dbg(dev, "  ERRAERMSK : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_GR_ERRAERMSK,
> +		readl(priv->smba + ISMT_GR_ERRAERMSK));
> +	dev_dbg(dev, "  ERRSTS... : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_GR_ERRSTS,
> +		readl(priv->smba + ISMT_GR_ERRSTS));
> +	dev_dbg(dev, "  ERRINFO.. : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_GR_ERRINFO,
> +		readl(priv->smba + ISMT_GR_ERRINFO));
> +}
> +
> +/**
> + * ismt_mstr_reg_dump() - dump the iSMT Master Registers
> + * @priv: iSMT private data
> + */
> +static void ismt_mstr_reg_dump(struct ismt_priv *priv)
> +{
> +	struct device *dev = &priv->pci_dev->dev;
> +
> +	dev_dbg(dev, "Dump of the iSMT Master Registers\n");
> +	dev_dbg(dev, "  MDBA..... : (0x%p)=0x%016lX\n",
> +		priv->smba + ISMT_MSTR_MDBA,
> +		(long unsigned int)readq(priv->smba + ISMT_MSTR_MDBA));

Same here.

> +	dev_dbg(dev, "  MCTRL.... : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_MSTR_MCTRL,
> +		readl(priv->smba + ISMT_MSTR_MCTRL));
> +	dev_dbg(dev, "  MSTS..... : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_MSTR_MSTS,
> +		readl(priv->smba + ISMT_MSTR_MSTS));
> +	dev_dbg(dev, "  MDS...... : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_MSTR_MDS,
> +		readl(priv->smba + ISMT_MSTR_MDS));
> +	dev_dbg(dev, "  RPOLICY.. : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_MSTR_RPOLICY,
> +		readl(priv->smba + ISMT_MSTR_RPOLICY));
> +	dev_dbg(dev, "  SPGT..... : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_SPGT,
> +		readl(priv->smba + ISMT_SPGT));
> +}

> (...)
> +/**
> + * ismt_process_desc() - handle the completion of the descriptor
> + * @desc: the iSMT hardware descriptor
> + * @data: data buffer from the upper layer
> + * @priv: ismt_priv struct holding our dma buffer
> + * @size: SMBus transaction type
> + * @read_write flag to indicate if this is a read or write

Missing colon after parameter name.

> + * @dma_size size of the dma transfer

This function has no parameter named dma_size.

> + */
> +static int ismt_process_desc(const struct ismt_desc *desc,
> +			     union i2c_smbus_data *data,
> +			     struct ismt_priv *priv, int size,
> +			     char read_write)
> +{
> +	u8 *dma_buffer = priv->dma_buffer;
> +
> +	dev_dbg(&priv->pci_dev->dev, "Processing completed descriptor\n");
> +	__ismt_desc_dump(&priv->pci_dev->dev, desc);
> +
> +	if (desc->status & ISMT_DESC_SCS) {
> +		if ((size != I2C_SMBUS_QUICK) &&
> +		    (read_write == I2C_SMBUS_READ)) {
> +			memcpy(&data->block[1], dma_buffer, desc->rxbytes);
> +			data->block[0] = desc->rxbytes;

This looks good for block reads. But for receive byte, read byte and
read word transactions, this can't be correct. You have to copy the
contents of dma_buffer to data->byte or data->word for these
transactions.

> +		}
> +		return 0;
> +	}
> +
> +	if (likely(desc->status & ISMT_DESC_NAK))
> +		return -ENXIO;
> +
> +	if (desc->status & ISMT_DESC_CRC)
> +		return -EBADMSG;
> +
> +	if (desc->status & ISMT_DESC_COL)
> +		return -EAGAIN;
> +
> +	if (desc->status & ISMT_DESC_LPR)
> +		return -EPROTO;
> +
> +	if (desc->status & (ISMT_DESC_DLTO | ISMT_DESC_CLTO))
> +		return -ETIMEDOUT;
> +
> +	return -EIO;
> +}

> (...)
> +	/* Create a temporary buffer for the DMA transaction */
> +	/* and insert the command at the beginning of the buffer */
> +	if ((read_write == I2C_SMBUS_WRITE) &&
> +	    (size > I2C_SMBUS_BYTE)) {
> +		memcpy(&priv->dma_buffer[1], &data->block[1], dma_size);
> +		priv->dma_buffer[0] = command;
> +	}

Again this looks good for block writes, but not for send byte, write
byte and write word transactions. data->block is only relevant for
block transactions, and &data->block[1] is off by one compared to
&data->byte and &data->word.

We did not discuss it yet but you should also pay attention to
I2C_SMBUS_PROC_CALL. It is the only bidirectional transaction, so the
value of read_write is irrelevant there. So I'm reasonably certain your
code doesn't implement it properly. Either fix it or drop support
altogether. I can't remember this transaction type ever being used by
any slave device in practice, and it can always be added back later if
really needed.

> +
> +	/* map the data buffer */
> +	if (dma_size != 0) {
> +		dev_dbg(dev, " dev=%p\n", dev);
> +		dev_dbg(dev, " data=%p\n", data);
> +		dev_dbg(dev, " dma_buffer=%p\n", priv->dma_buffer);
> +		dev_dbg(dev, " dma_size=%d\n", dma_size);
> +		dev_dbg(dev, " dma_direction=%d\n", dma_direction);
> +
> +		dma_addr = dma_map_single(dev,
> +				      priv->dma_buffer,
> +				      dma_size,
> +				      dma_direction);
> +
> +		if (dma_mapping_error(dev, dma_addr)) {
> +			dev_err(dev, "Error in mapping dma buffer %p\n",
> +				priv->dma_buffer);
> +			return -EIO;
> +		}
> +
> +		dev_dbg(dev, " dma_addr = 0x%016llX\n",
> +			dma_addr);
> +
> +		desc->dptr_low = lower_32_bits(dma_addr);
> +		desc->dptr_high = upper_32_bits(dma_addr);
> +	}
> +
> +	INIT_COMPLETION(priv->cmp);
> +
> +	/* Add the descriptor */
> +	ismt_submit_desc(priv);
> +
> +	/* Now we wait for interrupt completion, 1s */
> +	ret = wait_for_completion_timeout(&priv->cmp, HZ*1);
> +
> +	/* unmap the data buffer */
> +	if (dma_size != 0)
> +		dma_unmap_single(&adap->dev, dma_addr, dma_size, dma_direction);
> +
> +	if (unlikely(!ret)) {
> +		dev_err(dev, "completion wait timed out\n");
> +		ret = -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	/* do any post processing of the descriptor here */
> +	ret = ismt_process_desc(desc, data, priv, size, read_write);
> +
> +out:
> +	/* Update the ring pointer */
> +	priv->head++;
> +	priv->head %= ISMT_DESC_ENTRIES;
> +
> +	return ret;
> +}

I have backported your code to kernel 3.0 and I'll get back to you when
I finally get a chance to test it.

-- 
Jean Delvare
