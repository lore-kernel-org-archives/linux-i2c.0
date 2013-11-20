From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] i2c : i2c-ibm-iic : use interrupts to perform the data
 transfer
Date: Wed, 20 Nov 2013 16:53:16 +0100
Message-ID: <528CDAEC.3040307@free-electrons.com>
References: <1384960134-24039-1-git-send-email-jean-jacques.hiblot@jdsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384960134-24039-1-git-send-email-jean-jacques.hiblot-qU79poH1Kb0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jean-jacques hiblot <jjhiblot-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jean-jacques hiblot <jean-jacques.hiblot-qU79poH1Kb0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean-Jacques,

On 20/11/2013 16:08, jean-jacques hiblot wrote:
> The current implementation uses the interrupt only to wakeup the process doing the data transfer.
> While this is working, it introduces a sometimes indesirable blanks during the transfer.
> 
> This patch implements the data transfer in the interrupt handler. It keeps the latency between individual bytes low and the jitter on the total transfer time is reduced.
> Polling mode is still supported.

I saw that you added a flag named use_polling, but I didn't see
how a user can set it (nothing was added in the device tree). Could you
explain what do you meant by "Polling mode is still supported" ?

> 
> This was tested on a custom board built around a PPC460EX with several different I2C devices (including EEPROMs and smart batteries)

Could you wrap the commit log at ~80 columns?

I made only a few comments because your patch is hard to review.
Could you split your patch in smaller and incremental part?

However I made few comments inline

> 
> Signed-off-by: jean-jacques hiblot <jjhiblot-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-ibm_iic.c | 411 +++++++++++++++++++++++----------------
>  drivers/i2c/busses/i2c-ibm_iic.h |  21 +-
>  2 files changed, 263 insertions(+), 169 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
> index ff3caa0..77df857 100644
> --- a/drivers/i2c/busses/i2c-ibm_iic.c
> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
> @@ -163,8 +163,8 @@ static void iic_dev_init(struct ibm_iic_private* dev)
>  	/* Clear control register */
>  	out_8(&iic->cntl, 0);
>  
> -	/* Enable interrupts if possible */
> -	iic_interrupt_mode(dev, dev->irq >= 0);
> +	/* disable interrupts*/
> +	iic_interrupt_mode(dev, 0);
>  
>  	/* Set mode control */
>  	out_8(&iic->mdcntl, MDCNTL_FMDB | MDCNTL_EINT | MDCNTL_EUBS
> @@ -319,197 +319,218 @@ err:
>  	goto out;
>  }
>  
> -/*
> - * IIC interrupt handler
> - */
> -static irqreturn_t iic_handler(int irq, void *dev_id)
> +static int iic_xfer_bytes(struct ibm_iic_private *dev)
>  {
> -	struct ibm_iic_private* dev = (struct ibm_iic_private*)dev_id;
> -	volatile struct iic_regs __iomem *iic = dev->vaddr;
> -
> -	DBG2("%d: irq handler, STS = 0x%02x, EXTSTS = 0x%02x\n",
> -	     dev->idx, in_8(&iic->sts), in_8(&iic->extsts));
> -
> -	/* Acknowledge IRQ and wakeup iic_wait_for_tc */
> +	struct i2c_msg *pm = &(dev->msgs[dev->current_msg]);
> +	struct iic_regs *iic = dev->vaddr;
> +	u8 cntl = in_8(&iic->cntl) & CNTL_AMD;
> +	int count;
> +	u32 status;
> +	u32 ext_status;
> +
> +	/* First check the status register */
> +	status = in_8(&iic->sts);
> +	ext_status = in_8(&iic->extsts);
> +
> +	/* and acknowledge the interrupt */
> +	out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD | EXTSTS_LA |
> +			    EXTSTS_ICT | EXTSTS_XFRA);
>  	out_8(&iic->sts, STS_IRQA | STS_SCMP);
> -	wake_up_interruptible(&dev->wq);
>  
> -	return IRQ_HANDLED;
> -}
> +	if (dev->status == -ECANCELED) {
> +		dev_dbg(dev->dev, "abort completed\n");
> +		dev->transfer_complete = 1;
> +		if (!dev->use_polling)
> +			complete(&dev->iic_compl);
> +		return dev->status;
> +	}
>  
> -/*
> - * Get master transfer result and clear errors if any.
> - * Returns the number of actually transferred bytes or error (<0)
> - */
> -static int iic_xfer_result(struct ibm_iic_private* dev)
> -{
> -	volatile struct iic_regs __iomem *iic = dev->vaddr;
> +	if ((status & STS_ERR) ||
> +	    (ext_status & (EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA))) {
> +		dev_dbg(dev->dev, "status 0x%x\n", status);
> +		dev_dbg(dev->dev, "extended status 0x%x\n", ext_status);
> +		if (status & STS_ERR)
> +			dev_dbg(dev->dev, "Error detected\n");
Is it really a debug message?  shouldn't it be an error message?

> +		if (ext_status & EXTSTS_LA)
> +			dev_dbg(dev->dev, "Lost arbitration\n");

Ditto

> +		if (ext_status & EXTSTS_ICT)
> +			dev_dbg(dev->dev, "Incomplete transfer\n");

Ditto

> +		if (ext_status & EXTSTS_XFRA)
> +			dev_dbg(dev->dev, "Transfer aborted\n");

Ditto

> +
> +		dev->status = -EIO;
> +		dev->transfer_complete = 1;
> +		if (!dev->use_polling)
> +			complete(&dev->iic_compl);
> +	}
>  
> -	if (unlikely(in_8(&iic->sts) & STS_ERR)){
> -		DBG("%d: xfer error, EXTSTS = 0x%02x\n", dev->idx,
> -			in_8(&iic->extsts));
> +	if (dev->msgs == NULL) {
> +		dev_dbg(dev->dev, "spurious !!!!!\n");
> +		dev->status = -EINVAL;
> +		return dev->status;
> +	}
>  
> -		/* Clear errors and possible pending IRQs */
> -		out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD |
> -			EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA);
> +	/* check if there's any data to read from the fifo */
> +	if (pm->flags & I2C_M_RD) {
> +		while (dev->current_byte_rx < dev->current_byte) {
> +			u8 *buf = pm->buf + dev->current_byte_rx;
> +			*buf = in_8(&iic->mdbuf);
> +			dev->current_byte_rx++;
> +			dev_dbg(dev->dev, "read 0x%x\n", *buf);
> +		}
> +	}
> +	/* check if we must go with the next tranfer */
> +	if (pm->len  == dev->current_byte) {
> +		dev_dbg(dev->dev, "going to next transfer\n");
> +		dev->current_byte = 0;
> +		dev->current_byte_rx = 0;
> +		dev->current_msg++;
> +		if (dev->current_msg == dev->num_msgs) {
> +			dev_dbg(dev->dev, "end of transfer\n");
> +			dev->transfer_complete = 1;
> +			if (!dev->use_polling)
> +				complete(&dev->iic_compl);
> +			return dev->status;
> +		}
> +		pm++;
> +	}
>  
> -		/* Flush master data buffer */
> -		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
> +	/* take care of the direction */
> +	if (pm->flags & I2C_M_RD)
> +		cntl |= CNTL_RW;
>  
> -		/* Is bus free?
> -		 * If error happened during combined xfer
> -		 * IIC interface is usually stuck in some strange
> -		 * state, the only way out - soft reset.
> -		 */
> -		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
> -			DBG("%d: bus is stuck, resetting\n", dev->idx);
> -			iic_dev_reset(dev);
> +	/*  how much data are we going to transfer this time ?
> +	 *  (up to 4 bytes at once)
> +	 */
> +	count = pm->len  - dev->current_byte;
> +	count = (count > 4) ? 4 : count;
> +	cntl |= (count - 1) << CNTL_TCT_SHIFT;
> +
> +	if ((pm->flags & I2C_M_RD) == 0) {
> +		/* This is a write. we must fill the fifo with the data */
> +		int i;
> +		u8 *buf = pm->buf + dev->current_byte;
> +
> +		for (i = 0; i < count; i++) {
> +			out_8(&iic->mdbuf, buf[i]);
> +			dev_dbg(dev->dev, "write : 0x%x\n", buf[i]);
>  		}
> -		return -EREMOTEIO;
>  	}
> -	else
> -		return in_8(&iic->xfrcnt) & XFRCNT_MTC_MASK;
> -}
>  
> -/*
> - * Try to abort active transfer.
> - */
> -static void iic_abort_xfer(struct ibm_iic_private* dev)
> -{
> -	volatile struct iic_regs __iomem *iic = dev->vaddr;
> -	unsigned long x;
> +	/* will the current transfer complete with this chunk of data ? */
> +	if (pm->len  > dev->current_byte + 4) {
> +		/* we're not done with the current transfer.
> +		 * Don't send a repeated start
> +		 */
> +		cntl |= CNTL_CHT;
> +	}
> +	/* This transfer will be complete with this chunk of data
> +	 * BUT is this the last transfer of the list ?
> +	 */
> +	else if (dev->current_msg != (dev->num_msgs-1)) {
> +		/* not the last tranfer */
> +		cntl |= CNTL_BCL; /* Do not send a STOP condition */
> +		/* check if the NEXT transfer needs a repeated start */
> +		if (pm[1].flags & I2C_M_NOSTART)
> +			cntl |= CNTL_CHT;
> +	}
>  
> -	DBG("%d: iic_abort_xfer\n", dev->idx);
> +	if ((cntl & CNTL_BCL) == 0)
> +		dev_dbg(dev->dev, "STOP required\n");
>  
> -	out_8(&iic->cntl, CNTL_HMT);
> +	if ((cntl & CNTL_CHT) == 0)
> +		dev_dbg(dev->dev, "next transfer will begin with START\n");
>  
> -	/*
> -	 * Wait for the abort command to complete.
> -	 * It's not worth to be optimized, just poll (timeout >= 1 tick)
> -	 */
> -	x = jiffies + 2;
> -	while ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
> -		if (time_after(jiffies, x)){
> -			DBG("%d: abort timeout, resetting...\n", dev->idx);
> -			iic_dev_reset(dev);
> -			return;
> -		}
> -		schedule();
> +	/* keep track of the amount of data transfered (RX and TX) */
> +	dev->current_byte += count;
> +
> +	/* actually start the transfer of the current data chunk */
> +	out_8(&iic->cntl, cntl | CNTL_PT);
> +
> +	/* The transfer must be aborted. */
> +	if (dev->abort) {
> +		dev_dbg(dev->dev, "aborting\n");
> +		out_8(&iic->cntl, CNTL_HMT);
> +		dev->status = -ECANCELED;
>  	}
>  
> -	/* Just to clear errors */
> -	iic_xfer_result(dev);
> +	return dev->status;
>  }
>  
>  /*
> - * Wait for master transfer to complete.
> - * It puts current process to sleep until we get interrupt or timeout expires.
> - * Returns the number of transferred bytes or error (<0)
> + * IIC interrupt handler
>   */
> -static int iic_wait_for_tc(struct ibm_iic_private* dev){
> +static irqreturn_t iic_handler(int irq, void *dev_id)
> +{
> +	struct ibm_iic_private *dev = (struct ibm_iic_private *) dev_id;
> +	iic_xfer_bytes(dev);

Shouldn't you do something with the return value of this function?

> +	return IRQ_HANDLED;
> +}
>  
> +/*
> + * Polling used when interrupt can't be used
> + */
> +static int poll_for_end_of_transfer(struct ibm_iic_private *dev, u32 timeout)
> +{
>  	volatile struct iic_regs __iomem *iic = dev->vaddr;
> -	int ret = 0;
> -
> -	if (dev->irq >= 0){
> -		/* Interrupt mode */
> -		ret = wait_event_interruptible_timeout(dev->wq,
> -			!(in_8(&iic->sts) & STS_PT), dev->adap.timeout);
> -
> -		if (unlikely(ret < 0))
> -			DBG("%d: wait interrupted\n", dev->idx);
> -		else if (unlikely(in_8(&iic->sts) & STS_PT)){
> -			DBG("%d: wait timeout\n", dev->idx);
> -			ret = -ETIMEDOUT;
> -		}
> -	}
> -	else {
> -		/* Polling mode */
> -		unsigned long x = jiffies + dev->adap.timeout;
> -
> -		while (in_8(&iic->sts) & STS_PT){
> -			if (unlikely(time_after(jiffies, x))){
> -				DBG("%d: poll timeout\n", dev->idx);
> -				ret = -ETIMEDOUT;
> -				break;
> -			}
> -
> -			if (unlikely(signal_pending(current))){
> -				DBG("%d: poll interrupted\n", dev->idx);
> -				ret = -ERESTARTSYS;
> -				break;
> -			}
> +	u32 status;
> +	unsigned long end = jiffies + timeout;
> +
> +	while ((dev->transfer_complete == 0) &&
> +	   time_after(end, jiffies) &&
> +	   !signal_pending(current)) {
> +		status = in_8(&iic->sts);
> +		/* check if the transfer is done or an error occured */
> +		if ((status & (STS_ERR | STS_SCMP)) || !(status & STS_PT))
> +			iic_xfer_bytes(dev);
> +		/* The transfer is not complete,
> +		 * let's wait a bit to give time to the controller to update
> +		 * its registers.
> +		 * calling schedule relaxes the CPU load and allows to know
> +		 * if the process is being signaled (for abortion)
> +		 */
> +		if (dev->transfer_complete == 0)
>  			schedule();
> -		}
>  	}
>  
> -	if (unlikely(ret < 0))
> -		iic_abort_xfer(dev);
> -	else
> -		ret = iic_xfer_result(dev);
> +	if (signal_pending(current))
> +		return -ERESTARTSYS;
>  
> -	DBG2("%d: iic_wait_for_tc -> %d\n", dev->idx, ret);
> +	if (dev->transfer_complete == 0)
> +		return 0;
>  
> -	return ret;
> +	return 1;
>  }
>  
>  /*
> - * Low level master transfer routine
> + * Try to abort active transfer.
>   */
> -static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm,
> -			  int combined_xfer)
> +static void iic_abort_xfer(struct ibm_iic_private *dev)
>  {
> -	volatile struct iic_regs __iomem *iic = dev->vaddr;
> -	char* buf = pm->buf;
> -	int i, j, loops, ret = 0;
> -	int len = pm->len;
> -
> -	u8 cntl = (in_8(&iic->cntl) & CNTL_AMD) | CNTL_PT;
> -	if (pm->flags & I2C_M_RD)
> -		cntl |= CNTL_RW;
> -
> -	loops = (len + 3) / 4;
> -	for (i = 0; i < loops; ++i, len -= 4){
> -		int count = len > 4 ? 4 : len;
> -		u8 cmd = cntl | ((count - 1) << CNTL_TCT_SHIFT);
> -
> -		if (!(cntl & CNTL_RW))
> -			for (j = 0; j < count; ++j)
> -				out_8((void __iomem *)&iic->mdbuf, *buf++);
> -
> -		if (i < loops - 1)
> -			cmd |= CNTL_CHT;
> -		else if (combined_xfer)
> -			cmd |= CNTL_RPST;
> -
> -		DBG2("%d: xfer_bytes, %d, CNTL = 0x%02x\n", dev->idx, count, cmd);
> -
> -		/* Start transfer */
> -		out_8(&iic->cntl, cmd);
> -
> -		/* Wait for completion */
> -		ret = iic_wait_for_tc(dev);
> -
> -		if (unlikely(ret < 0))
> -			break;
> -		else if (unlikely(ret != count)){
> -			DBG("%d: xfer_bytes, requested %d, transferred %d\n",
> -				dev->idx, count, ret);
> -
> -			/* If it's not a last part of xfer, abort it */
> -			if (combined_xfer || (i < loops - 1))
> -    				iic_abort_xfer(dev);
> -
> -			ret = -EREMOTEIO;
> -			break;
> +	struct iic_regs *iic = dev->vaddr;
> +	unsigned long end;
> +
> +	dev_dbg(dev->dev, "aborting transfer\n");
> +	/* transfer should be aborted within 10ms */
> +	end = jiffies + 10;
> +	dev->abort = 1;
> +
> +	while (time_after(end, jiffies) && !dev->transfer_complete) {
> +		u32 sts;
> +		if (dev->use_polling) {
> +			sts = in_8(&iic->sts);
> +			/* check if the transfer is done or an error occured */
> +			if ((sts & (STS_ERR | STS_SCMP)) || !(sts & STS_PT))
> +				iic_xfer_bytes(dev);
>  		}
> -
> -		if (cntl & CNTL_RW)
> -			for (j = 0; j < count; ++j)
> -				*buf++ = in_8((void __iomem *)&iic->mdbuf);
> +		if (dev->transfer_complete == 0)
> +			schedule();
>  	}
>  
> -	return ret > 0 ? 0 : ret;
> +	if (!dev->transfer_complete) {
> +		dev_err(dev->dev, "abort operation failed\n");
> +		iic_dev_reset(dev);
> +	}
>  }
>  
>  /*
> @@ -607,19 +628,74 @@ static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>  			return -EREMOTEIO;
>  		}
>  	}
> -	else {
> -		/* Flush master data buffer (just in case) */
> -		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
> +
> +	dev->current_byte = dev->current_msg = dev->current_byte_rx = 0;
> +	dev->msgs = msgs;
> +	dev->num_msgs = num;
> +	dev->transfer_complete = 0;
> +	dev->status = 0;
> +	dev->abort = 0;
> +
> +	/* clear the buffers */
> +	out_8(&iic->mdcntl, MDCNTL_FMDB);
> +	i = 100;
> +	while (in_8(&iic->mdcntl) & MDCNTL_FMDB) {
> +		if (i-- < 0) {
> +			DBG("%d: iic_xfer, unable to flush\n", dev->idx);
> +			return -EREMOTEIO;
> +		}
>  	}
>  
> +	/* clear all interrupts masks */
> +	out_8(&iic->intmsk, 0x0);
> +	/* clear any status */
> +	out_8(&iic->sts, STS_IRQA | STS_SCMP);
> +	out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD | EXTSTS_LA |
> +			    EXTSTS_ICT | EXTSTS_XFRA);
> +
>  	/* Load slave address */
>  	iic_address(dev, &msgs[0]);
>  
> -	/* Do real transfer */
> -    	for (i = 0; i < num && !ret; ++i)
> -		ret = iic_xfer_bytes(dev, &msgs[i], i < num - 1);
> +	if (!dev->use_polling)
> +		init_completion(&dev->iic_compl);
> +
> +	/* start the transfer */
> +	ret = iic_xfer_bytes(dev);
> +
> +	if (ret == 0) {
> +		if (dev->use_polling) {
> +			ret = poll_for_end_of_transfer(dev, num * HZ);
> +		} else {
> +			/* enable the interrupts */
> +			out_8(&iic->mdcntl, MDCNTL_EINT);
> +			/*  unmask the interrupts */
> +			out_8(&iic->intmsk,	INTRMSK_EIMTC | INTRMSK_EITA  |
> +						INTRMSK_EIIC | INTRMSK_EIHE);
> +			/*  wait for the transfer to complete */
> +			ret = wait_for_completion_interruptible_timeout(
> +				&dev->iic_compl, num * HZ);
> +			/* we don't mask the interrupts here because we may
> +			 * need them to abort the transfer gracefully
> +			 */
> +		}
> +	}
>  
> -	return ret < 0 ? ret : num;
> +	if (ret == 0) {
> +		dev_err(dev->dev, "transfer timed out\n");
> +		ret = -ETIMEDOUT;
> +	} else if (ret < 0) {
> +		if (ret == -ERESTARTSYS)
> +			dev_err(dev->dev, "transfer interrupted\n");
> +		iic_abort_xfer(dev);
> +	} else {
> +		/* Transfer is complete */
> +		ret = (dev->status) ? dev->status : num;
> +	}
> +
> +	/* mask the interrupts */
> +	out_8(&iic->intmsk, 0);
> +
> +	return ret;
>  }
>  
>  static u32 iic_func(struct i2c_adapter *adap)
> @@ -668,6 +744,7 @@ static int iic_request_irq(struct platform_device *ofdev,
>  	if (iic_force_poll)
>  		return 0;
>  
> +	dev->use_polling = 1;
>  	irq = irq_of_parse_and_map(np, 0);
>  	if (!irq) {
>  		dev_err(&ofdev->dev, "irq_of_parse_and_map failed\n");
> @@ -677,13 +754,14 @@ static int iic_request_irq(struct platform_device *ofdev,
>  	/* Disable interrupts until we finish initialization, assumes
>  	 *  level-sensitive IRQ setup...
>  	 */
> +	init_completion(&dev->iic_compl);
>  	iic_interrupt_mode(dev, 0);
>  	if (request_irq(irq, iic_handler, 0, "IBM IIC", dev)) {
>  		dev_err(&ofdev->dev, "request_irq %d failed\n", irq);
>  		/* Fallback to the polling mode */
>  		return 0;
>  	}
> -
> +	dev->use_polling = 0;
>  	return irq;
>  }
>  
> @@ -705,6 +783,7 @@ static int iic_probe(struct platform_device *ofdev)
>  	}
>  
>  	platform_set_drvdata(ofdev, dev);
> +	dev->dev = &ofdev->dev;

Is it related to the topic of this patch?

>  
>  	dev->vaddr = of_iomap(np, 0);
>  	if (dev->vaddr == NULL) {
> diff --git a/drivers/i2c/busses/i2c-ibm_iic.h b/drivers/i2c/busses/i2c-ibm_iic.h
> index fdaa482..8fa2b6b 100644
> --- a/drivers/i2c/busses/i2c-ibm_iic.h
> +++ b/drivers/i2c/busses/i2c-ibm_iic.h
> @@ -22,11 +22,14 @@
>  #ifndef __I2C_IBM_IIC_H_
>  #define __I2C_IBM_IIC_H_
>  
> +#include <linux/device.h>
>  #include <linux/i2c.h>
>  
>  struct iic_regs {
> -	u16 mdbuf;
> -	u16 sbbuf;
> +	u8 mdbuf;
> +	u8 reserved1;
> +	u8 sbbuf;
> +	u8 reserved2;
>  	u8 lmadr;
>  	u8 hmadr;
>  	u8 cntl;
> @@ -44,12 +47,23 @@ struct iic_regs {
>  
>  struct ibm_iic_private {
>  	struct i2c_adapter adap;
> -	volatile struct iic_regs __iomem *vaddr;
> +	struct iic_regs *vaddr;
>  	wait_queue_head_t wq;
>  	int idx;
>  	int irq;
>  	int fast_mode;
>  	u8  clckdiv;
> +	struct i2c_msg *msgs;
> +	int num_msgs;
> +	int current_msg;
> +	int current_byte;
> +	int current_byte_rx;
> +	int transfer_complete;
> +	int use_polling;
> +	int status;
> +	int abort;
> +	struct completion iic_compl;
> +	struct device *dev;
>  };
>  
>  /* IICx_CNTL register */
> @@ -58,6 +72,7 @@ struct ibm_iic_private {
>  #define CNTL_TCT_MASK	0x30
>  #define CNTL_TCT_SHIFT	4
>  #define CNTL_RPST	0x08
> +#define CNTL_BCL	CNTL_RPST
>  #define CNTL_CHT	0x04
>  #define CNTL_RW		0x02
>  #define CNTL_PT		0x01
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
