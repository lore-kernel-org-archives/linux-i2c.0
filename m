From: Jean-Jacques Hiblot <jjhiblot-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/4] i2c: i2c-ibm-iic: perform the transfer in the
 interrupt handler
Date: Mon, 25 Nov 2013 09:24:58 +0100
Message-ID: <5293095A.70605@gmail.com>
References: <1385110686-4226-1-git-send-email-jean-jacques.hiblot@jdsu.com> <1385110686-4226-3-git-send-email-jean-jacques.hiblot@jdsu.com> <528F7547.2070308@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <528F7547.2070308-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jean-jacques hiblot <jean-jacques.hiblot-qU79poH1Kb0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Gregory,

Thank you for the review.


Le 22/11/2013 16:16, Gregory CLEMENT a =C3=A9crit :
> Hi Jean-Jacques,
>
>
> On 22/11/2013 09:58, jean-jacques hiblot wrote:
>> The current implementation uses the interrupt only to wakeup the pro=
cess doing
>> the data transfer. While this is working, it introduces indesirable =
latencies.
>> This patch implements the data transfer in the interrupt handler. It=
 keeps the
>> latency between individual bytes low and the jitter on the total tra=
nsfer time
>> is reduced.
>>
>> Note: transfer abortion and polling mode are not working and will be=
 supported
>> in further patches
>>
>> This was tested on a custom board built around a PPC460EX with sever=
al
>> different I2C devices (including EEPROMs and smart batteries)
>>
>> Signed-off-by: jean-jacques hiblot <jjhiblot-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>
> I didn't see anything scary on this patch but my last interaction wit=
h this i2c
> controller was a long time ago, so I can't really comment the heart o=
f this patch.
>
> However if it worked on your board at least it is not too buggy ;)
>
> I still made a few trivial comments
>
I'll take those comments in account for a 3rd version of the patches.
>
>> ---
>>   drivers/i2c/busses/i2c-ibm_iic.c | 233 +++++++++++++++++++++++++++=
+-----------
>>   drivers/i2c/busses/i2c-ibm_iic.h |   8 ++
>>   2 files changed, 177 insertions(+), 64 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i=
2c-ibm_iic.c
>> index 9cdef65..2bb55b3 100644
>> --- a/drivers/i2c/busses/i2c-ibm_iic.c
>> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
>> @@ -68,6 +68,8 @@ MODULE_PARM_DESC(iic_force_fast, "Force fast mode =
(400 kHz)");
>>   #undef DBG2
>>   #endif
>>
>> +#  define ERR(dev, f, x...)	dev_err(dev->adap.dev.parent, f, ##x)
>> +
> This chunk should be part of the previous patch
>
>>   #if DBG_LEVEL > 0
>>   #  define DBG(dev, f, x...)	dev_dbg(dev->adap.dev.parent, f, ##x)
>>   #else
>> @@ -123,6 +125,7 @@ static struct i2c_timings {
>>   	.high 	=3D 600,
>>   	.buf	=3D 1300,
>>   }};
>> +static int iic_xfer_bytes(struct ibm_iic_private *dev);
>>
>>   /* Enable/disable interrupt generation */
>>   static inline void iic_interrupt_mode(struct ibm_iic_private* dev,=
 int enable)
>> @@ -165,8 +168,8 @@ static void iic_dev_init(struct ibm_iic_private*=
 dev)
>>   	/* Clear control register */
>>   	out_8(&iic->cntl, 0);
>>
>> -	/* Enable interrupts if possible */
>> -	iic_interrupt_mode(dev, dev->irq >=3D 0);
>> +	/* Start with each individual interrupt masked*/
>> +	iic_interrupt_mode(dev, 0);
>>
>>   	/* Set mode control */
>>   	out_8(&iic->mdcntl, MDCNTL_FMDB | MDCNTL_EINT | MDCNTL_EUBS
>> @@ -325,16 +328,8 @@ err:
>>    */
>>   static irqreturn_t iic_handler(int irq, void *dev_id)
>>   {
>> -	struct ibm_iic_private* dev =3D (struct ibm_iic_private*)dev_id;
>> -	struct iic_regs __iomem *iic =3D dev->vaddr;
>> -
>> -	DBG2(dev, "irq handler, STS =3D 0x%02x, EXTSTS =3D 0x%02x\n",
>> -	     in_8(&iic->sts), in_8(&iic->extsts));
>> -
>> -	/* Acknowledge IRQ and wakeup iic_wait_for_tc */
>> -	out_8(&iic->sts, STS_IRQA | STS_SCMP);
>> -	wake_up_interruptible(&dev->wq);
>> -
>> +	struct ibm_iic_private *dev =3D (struct ibm_iic_private *) dev_id;
>> +	iic_xfer_bytes(dev);
>>   	return IRQ_HANDLED;
>>   }
>>
>> @@ -457,60 +452,126 @@ static int iic_wait_for_tc(struct ibm_iic_pri=
vate* dev){
>>   /*
>>    * Low level master transfer routine
>>    */
>> -static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_m=
sg* pm,
>> -			  int combined_xfer)
>> +static int iic_xfer_bytes(struct ibm_iic_private *dev)
>>   {
>> -	struct iic_regs __iomem *iic =3D dev->vaddr;
>> -	char* buf =3D pm->buf;
>> -	int i, j, loops, ret =3D 0;
>> -	int len =3D pm->len;
>> -
>> -	u8 cntl =3D (in_8(&iic->cntl) & CNTL_AMD) | CNTL_PT;
>> -	if (pm->flags & I2C_M_RD)
>> -		cntl |=3D CNTL_RW;
>> +	struct i2c_msg *pm =3D &(dev->msgs[dev->current_msg]);
>> +	struct iic_regs *iic =3D dev->vaddr;
>> +	u8 cntl =3D in_8(&iic->cntl) & CNTL_AMD;
>> +	int count;
>> +	u32 status;
>> +	u32 ext_status;
>> +
>> +	/* First check the status register */
>> +	status =3D in_8(&iic->sts);
>> +	ext_status =3D in_8(&iic->extsts);
>> +
>> +	/* and acknowledge the interrupt */
>> +	out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD | EXTSTS_LA |
>> +			    EXTSTS_ICT | EXTSTS_XFRA);
>> +	out_8(&iic->sts, STS_IRQA | STS_SCMP);
>>
>> -	loops =3D (len + 3) / 4;
>> -	for (i =3D 0; i < loops; ++i, len -=3D 4){
>> -		int count =3D len > 4 ? 4 : len;
>> -		u8 cmd =3D cntl | ((count - 1) << CNTL_TCT_SHIFT);
>> +	if ((status & STS_ERR) ||
>> +	    (ext_status & (EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA))) {
>> +		DBG(dev, "status 0x%x\n", status);
>> +		DBG(dev, "extended status 0x%x\n", ext_status);
>> +		if (status & STS_ERR)
>> +			ERR(dev, "Error detected\n");
>> +		if (ext_status & EXTSTS_LA)
>> +			DBG(dev, "Lost arbitration\n");
>> +		if (ext_status & EXTSTS_ICT)
>> +			ERR(dev, "Incomplete transfer\n");
>> +		if (ext_status & EXTSTS_XFRA)
>> +			ERR(dev, "Transfer aborted\n");
>> +
>> +		dev->status =3D -EIO;
>> +		dev->transfer_complete =3D 1;
>> +		complete(&dev->iic_compl);
>> +		return dev->status;
>> +	}
>>
>> -		if (!(cntl & CNTL_RW))
>> -			for (j =3D 0; j < count; ++j)
>> -				out_8(&iic->mdbuf, *buf++);
>> +	if (dev->msgs =3D=3D NULL) {
>> +		DBG(dev, "spurious !!!!!\n");
>> +		dev->status =3D -EINVAL;
>> +		return dev->status;
>> +	}
>>
>> -		if (i < loops - 1)
>> -			cmd |=3D CNTL_CHT;
>> -		else if (combined_xfer)
>> -			cmd |=3D CNTL_RPST;
>> +	/* check if there's any data to read from the fifo */
>> +	if (pm->flags & I2C_M_RD) {
>> +		while (dev->current_byte_rx < dev->current_byte) {
>> +			u8 *buf =3D pm->buf + dev->current_byte_rx;
>> +			*buf =3D in_8(&iic->mdbuf);
>> +			dev->current_byte_rx++;
>> +			DBG2(dev, "read 0x%x\n", *buf);
>> +		}
>> +	}
>> +	/* check if we must go with the next tranfer */
>> +	if (pm->len  =3D=3D dev->current_byte) {
>> +		DBG2(dev, "going to next transfer\n");
>> +		dev->current_byte =3D 0;
>> +		dev->current_byte_rx =3D 0;
>> +		dev->current_msg++;
>> +		if (dev->current_msg =3D=3D dev->num_msgs) {
>> +			DBG2(dev, "end of transfer\n");
>> +			dev->transfer_complete =3D 1;
>> +			complete(&dev->iic_compl);
>> +			return dev->status;
>> +		}
>> +		pm++;
>> +	}
>>
>> -		DBG2(dev, "xfer_bytes, %d, CNTL =3D 0x%02x\n", count, cmd);
>> +	/* take care of the direction */
>> +	if (pm->flags & I2C_M_RD)
>> +		cntl |=3D CNTL_RW;
>>
>> -		/* Start transfer */
>> -		out_8(&iic->cntl, cmd);
>> +	/*  how much data are we going to transfer this time ?
>> +	 *  (up to 4 bytes at once)
>> +	 */
>> +	count =3D pm->len  - dev->current_byte;
>> +	count =3D (count > 4) ? 4 : count;
>> +	cntl |=3D (count - 1) << CNTL_TCT_SHIFT;
>> +
>> +	if ((pm->flags & I2C_M_RD) =3D=3D 0) {
>> +		/* This is a write. we must fill the fifo with the data */
>> +		int i;
>> +		u8 *buf =3D pm->buf + dev->current_byte;
>> +
>> +		for (i =3D 0; i < count; i++) {
>> +			out_8(&iic->mdbuf, buf[i]);
>> +			DBG2(dev, "write : 0x%x\n", buf[i]);
>> +		}
>> +	}
>>
>> -		/* Wait for completion */
>> -		ret =3D iic_wait_for_tc(dev);
>> +	/* will the current transfer complete with this chunk of data ? */
>> +	if (pm->len  > dev->current_byte + 4) {
>> +		/* we're not done with the current transfer.
>> +		 * Don't send a repeated start
>> +		 */
>> +		cntl |=3D CNTL_CHT;
>> +	}
>> +	/* This transfer will be complete with this chunk of data
>> +	 * BUT is this the last transfer of the list ?
>> +	 */
>
> It's really a nitpick but the style for long (multi-line) comments
> this should be:
> 	/*
> 	 * This transfer will be complete with this chunk of data
> 	 * BUT is this the last transfer of the list ?
> 	 */
>
> The style you used was for files in net/ and drivers/net/,
> see "Chapter 8: Commenting" of the Documentation/CodingStyle file
>
>
>
>> +	else if (dev->current_msg !=3D (dev->num_msgs-1)) {
>> +		/* not the last tranfer */
>> +		cntl |=3D CNTL_RPST; /* Do not send a STOP condition */
>> +		/* check if the NEXT transfer needs a repeated start */
>> +		if (pm[1].flags & I2C_M_NOSTART)
>> +			cntl |=3D CNTL_CHT;
>> +	}
>>
>> -		if (unlikely(ret < 0))
>> -			break;
>> -		else if (unlikely(ret !=3D count)){
>> -			DBG(dev, "xfer_bytes, requested %d, transferred %d\n",
>> -				count, ret);
>> +	if ((cntl & CNTL_RPST) =3D=3D 0)
>> +		DBG2(dev, "STOP required\n");
>>
>> -			/* If it's not a last part of xfer, abort it */
>> -			if (combined_xfer || (i < loops - 1))
>> -    				iic_abort_xfer(dev);
>> +	if ((cntl & CNTL_CHT) =3D=3D 0)
>> +		DBG2(dev, "next transfer will begin with START\n");
>>
>> -			ret =3D -EREMOTEIO;
>> -			break;
>> -		}
>> +	/* keep track of the amount of data transfered (RX and TX) */
>> +	dev->current_byte +=3D count;
>>
>> -		if (cntl & CNTL_RW)
>> -			for (j =3D 0; j < count; ++j)
>> -				*buf++ =3D in_8(&iic->mdbuf);
>> -	}
>> +	/* actually start the transfer of the current data chunk */
>> +	out_8(&iic->cntl, cntl | CNTL_PT);
>>
>> -	return ret > 0 ? 0 : ret;
>> +	return 0;
>>   }
>>
>>   /*
>> @@ -608,19 +669,63 @@ static int iic_xfer(struct i2c_adapter *adap, =
struct i2c_msg *msgs, int num)
>>   			return -EREMOTEIO;
>>   		}
>>   	}
>> -	else {
>> -		/* Flush master data buffer (just in case) */
>> -		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
>> +
>> +	dev->current_byte =3D dev->current_msg =3D dev->current_byte_rx =3D=
 0;
>> +	dev->transfer_complete =3D 0;
>> +	dev->status =3D 0;
>> +	dev->msgs =3D msgs;
>> +	dev->num_msgs =3D num;
>> +
>> +	/* clear the buffers */
>> +	out_8(&iic->mdcntl, MDCNTL_FMDB);
>> +	i =3D 100;
> please use a define for it
> something like
> #define FLUSH_TIMEOUT 100
>
>> +	while (in_8(&iic->mdcntl) & MDCNTL_FMDB) {
>> +		if (i-- < 0) {
>> +			DBG(dev, "iic_xfer, unable to flush\n");
>> +			return -EREMOTEIO;
>> +		}
>>   	}
>>
>> +	/* clear all interrupts masks */
>> +	out_8(&iic->intmsk, 0x0);
>> +	/* clear any status */
>> +	out_8(&iic->sts, STS_IRQA | STS_SCMP);
>> +	out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD | EXTSTS_LA |
>> +			    EXTSTS_ICT | EXTSTS_XFRA);
>> +
>>   	/* Load slave address */
>>   	iic_address(dev, &msgs[0]);
>>
>> -	/* Do real transfer */
>> -    	for (i =3D 0; i < num && !ret; ++i)
>> -		ret =3D iic_xfer_bytes(dev, &msgs[i], i < num - 1);
>> +	init_completion(&dev->iic_compl);
>> +
>> +	/* start the transfer */
>> +	ret =3D iic_xfer_bytes(dev);
>> +
>> +	if (ret =3D=3D 0) {
>> +		/* enable the interrupts */
>> +		out_8(&iic->mdcntl, MDCNTL_EINT);
>> +		/*  unmask the interrupts */
>> +		out_8(&iic->intmsk,	INTRMSK_EIMTC | INTRMSK_EITA  |
>> +					INTRMSK_EIIC | INTRMSK_EIHE);
>> +		/*  wait for the transfer to complete */
>> +		ret =3D wait_for_completion_interruptible_timeout(
>> +			&dev->iic_compl, num * HZ);
>> +		/* mask the interrupts */
>> +		out_8(&iic->intmsk, 0);
>> +	}
>>
>> -	return ret < 0 ? ret : num;
>> +	if (ret =3D=3D 0) {
>> +		ERR(dev, "transfer timed out\n");
>> +		ret =3D -ETIMEDOUT;
>> +	} else if (ret < 0) {
>> +		if (ret =3D=3D -ERESTARTSYS)
>> +			ERR(dev, "transfer interrupted\n");
>> +	} else {
>> +		/* Transfer is complete */
>> +		ret =3D (dev->status) ? dev->status : num;
>> +	}
>> +
>> +	return ret;
>>   }
>>
>>   static u32 iic_func(struct i2c_adapter *adap)
>> @@ -673,7 +778,7 @@ static int iic_request_irq(struct platform_devic=
e *ofdev,
>>
>>   	irq =3D irq_of_parse_and_map(np, 0);
>>   	if (!irq) {
>> -		dev_err(&ofdev->dev, "irq_of_parse_and_map failed\n");
>> +		ERR(dev, "irq_of_parse_and_map failed\n");
> This chunk should be part of the previous patch
>
>>   		return 0;
>>   	}
>>
>> @@ -682,7 +787,7 @@ static int iic_request_irq(struct platform_devic=
e *ofdev,
>>   	 */
>>   	iic_interrupt_mode(dev, 0);
>>   	if (request_irq(irq, iic_handler, 0, "IBM IIC", dev)) {
>> -		dev_err(&ofdev->dev, "request_irq %d failed\n", irq);
>> +		ERR(dev, "request_irq %d failed\n", irq);
> This chunk should be part of the previous patch
>
>>   		/* Fallback to the polling mode */
>>   		return 0;
>>   	}
>> @@ -720,7 +825,7 @@ static int iic_probe(struct platform_device *ofd=
ev)
>>
>>   	dev->irq =3D iic_request_irq(ofdev, dev);
>>   	if (!dev->irq)
>> -		dev_warn(&ofdev->dev, "using polling mode\n");
>> +		dev_info(&ofdev->dev, "using polling mode\n");
> This chunk should be part of the previous patch
>
>>
>>   	/* Board specific settings */
>>   	if (iic_force_fast || of_get_property(np, "fast-mode", NULL))
>> diff --git a/drivers/i2c/busses/i2c-ibm_iic.h b/drivers/i2c/busses/i=
2c-ibm_iic.h
>> index 1efce5d..76c476a 100644
>> --- a/drivers/i2c/busses/i2c-ibm_iic.h
>> +++ b/drivers/i2c/busses/i2c-ibm_iic.h
>> @@ -51,6 +51,14 @@ struct ibm_iic_private {
>>   	int irq;
>>   	int fast_mode;
>>   	u8  clckdiv;
>> +	struct i2c_msg *msgs;
>> +	int num_msgs;
>> +	int current_msg;
>> +	int current_byte;
>> +	int current_byte_rx;
>> +	int transfer_complete;
>> +	int status;
>> +	struct completion iic_compl;
>>   };
>>
>>   /* IICx_CNTL register */
>>
>
>
> Thanks,
>
> Gregory
>
