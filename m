From: Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH] i2c: davinci: Add block read functionality for IPMI
Date: Mon, 2 Jun 2014 12:28:43 -0400
Message-ID: <538CA63B.6000703@ti.com>
References: <1398970186-12204-1-git-send-email-m-karicheri2@ti.com> <3E54258959B69E4282D79E01AB1F32B70472F6AC@DFLE11.ent.ti.com> <20140522090041.GA2573@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140522090041.GA2573@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Ding, Garrett" <g-ding@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
List-Id: linux-i2c@vger.kernel.org

On 5/22/2014 5:00 AM, Wolfram Sang wrote:
> Hi,
>
> thanks for the patch.
>
>>> +/* capabilities */
>>> +#define I2C_CAPABILITIES	(I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | \
>>> +				 I2C_FUNC_SMBUS_READ_BLOCK_DATA)
> I don't see the need for a seperate define.
>
>>> +
>>> struct davinci_i2c_dev {
>>> 	struct device           *dev;
>>> 	void __iomem		*base;
>>> @@ -318,7 +322,13 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg
>>> *msg, int stop)
>>> 	davinci_i2c_write_reg(dev, DAVINCI_I2C_SAR_REG, msg->addr);
>>>
>>> 	dev->buf = msg->buf;
>>> -	dev->buf_len = msg->len;
>>> +
>>> +	 /* if first received byte is length, set buf_len = 0xffff as flag */
>>> +	if (msg->flags & I2C_M_RECV_LEN)
>>> +		dev->buf_len = 0xffff;
> a) this magic value should be a define instead of a comment
> b) i2c messages easily have a 16 bit range, so 0xffff is a troublesome
> choice.
>
>>> +	else
>>> +		dev->buf_len = msg->len;
>>> +
>>> 	dev->stop = stop;
>>>
>>> 	davinci_i2c_write_reg(dev, DAVINCI_I2C_CNT_REG, dev->buf_len); @@ -456,7
>>> +466,7 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>>>
>>> static u32 i2c_davinci_func(struct i2c_adapter *adap)  {
>>> -	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>>> +	return I2C_CAPABILITIES;
>>> }
>>>
>>> static void terminate_read(struct davinci_i2c_dev *dev) @@ -528,10 +538,32 @@ static
>>> irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
>>>
>>> 		case DAVINCI_I2C_IVR_RDR:
>>> 			if (dev->buf_len) {
>>> -				*dev->buf++ =
>>> -				    davinci_i2c_read_reg(dev,
>>> -							 DAVINCI_I2C_DRR_REG);
>>> +				*dev->buf++ = davinci_i2c_read_reg(dev,
>>> +							DAVINCI_I2C_DRR_REG);
>>> +				/*
>>> +				 * check if the first received byte is message
>>> +				 * length, i.e, I2C_M_RECV_LEN
>>> +				 */
>>> +				if (dev->buf_len == 0xffff)
>>> +					dev->buf_len = *(dev->buf - 1) + 1;
> Please rework the code to get rid of the '- 1' and '+ 1'. They look
> hackish and make the code less readable.
>
>>> +
>>> 				dev->buf_len--;
>>> +				/*
>>> +				 * send NACK/STOP bits BEFORE last byte is
>>> +				 * received
>>> +				 */
>>> +				if (dev->buf_len == 1) {
>>> +					w = davinci_i2c_read_reg(dev,
>>> +							DAVINCI_I2C_MDR_REG);
>>> +					w |= DAVINCI_I2C_MDR_NACK;
>>> +					davinci_i2c_write_reg(dev,
>>> +							DAVINCI_I2C_MDR_REG, w);
>>> +
>>> +					w |= DAVINCI_I2C_MDR_STP;
>>> +					davinci_i2c_write_reg(dev,
>>> +							DAVINCI_I2C_MDR_REG, w);
>>> +				}
>>> +
> Looks like an unreleated change to me? Why is this I2C_M_RECV_LEN
> specific?
>
> Kind regards,
>
>     Wolfram
Wolfram,

Thanks for reviewing the patch. I will review your comments and get back 
to you. This patch
is tested on a customer board and thus it might be a while before I can 
incorporate these changes
and provide an updated patch to the list. Meanwhile I will be reviewing 
the comment in the
next few weeks and get back to you in case I have questions.

Thanks and regards,

Murali
