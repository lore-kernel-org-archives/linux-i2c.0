From: Yao Yuan <yao.yuan@freescale.com>
Subject: RE: [PATCH v7 1/2] i2c: imx: add DMA support for freescale i2c driver
Date: Wed, 10 Sep 2014 14:48:01 +0000
Message-ID: <1410360473732.53953@freescale.com>
References: <1407923215-3749-1-git-send-email-yao.yuan@freescale.com>
 <201409041638.45537.marex@denx.de>
 <c10c1960255e4dbca2a281b995290c6d@BL2PR03MB338.namprd03.prod.outlook.com>
 <201409051240.44469.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201409051240.44469.marex@denx.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marek Vasut <marex@denx.de>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "fugang.duan@freescale.com" <fugang.duan@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "LW@karo-electronics.de" <LW@karo-electronics.de>
List-Id: linux-i2c@vger.kernel.org

On Friday, September 05, 2014 6:41 PM, Marek Vasut wrote:
> On Friday, September 05, 2014 at 12:32:40 PM, Yao Yuan wrote:
> [...]
> > > > +static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
> > > > +					struct i2c_msg *msgs)
> > > > +{
> > > > +	int result;
> > > > +	unsigned int temp = 0;
> > > > +	unsigned long orig_jiffies = jiffies;
> > > > +	struct imx_i2c_dma *dma = i2c_imx->dma;
> > > > +	struct device *dev = &i2c_imx->adapter.dev;
> > > > +
> > > > +	dev_dbg(dev, "<%s> write slave address: addr=0x%x\n",
> > > > +		__func__, msgs->addr << 1);
> > > > +
> > > > +	reinit_completion(&i2c_imx->dma->cmd_complete);
> > > > +	dma->chan_using = dma->chan_tx;
> > > > +	dma->dma_transfer_dir = DMA_MEM_TO_DEV;
> > > > +	dma->dma_data_dir = DMA_TO_DEVICE;
> > > > +	dma->dma_len = msgs->len - 1;
> > > > +	result = i2c_imx_dma_xfer(i2c_imx, msgs);
> > > > +	if (result)
> > > > +		return result;
> > > > +
> > > > +	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> > > > +	temp |= I2CR_DMAEN;
> > > > +	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> > > > +
> > > > +	/*
> > > > +	 * Write slave address.
> > > > +	 * The first byte muse be transmitted by the CPU.
> > > > +	 */
> > > > +	imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
> > > > +	result = wait_for_completion_interruptible_timeout(
> > > > +				&i2c_imx->dma->cmd_complete,
> > > > +				msecs_to_jiffies(IMX_I2C_DMA_TIMEOUT));
> > > > +	if (result <= 0) {
> > > > +		dmaengine_terminate_all(dma->chan_using);
> > > > +		if (result)
> > > > +			return result;
> > > > +		else
> > > > +			return -ETIMEDOUT;
> > >
> > > Shouldn't you force-disable the DMA here somehow (like unsetting
> > > I2CR_DMAEN bit), if it failed or timed out?
> >
> > [Yuan Yao] Yes, I put the code for force-disable DMA in i2c_imx_start().
> > In order to make sure any DMA error will not effect the I2C.
> > It seems almost the same as put the code here, how about your think?
> 
> Would that mean that the "crashed" DMA would be running until the next
> transmission is scheduled ?
> 
[Yuan Yao] No, In fact any DMA timeout will result the failure of I2C transmission
and then it will turn to report the exception and wait for next transmission.
The only thing I worried about is I2C may still receive some feedbacks after DMA timeout.
In this case the feedbacks may lead to abnormal state in PIO mode.But it will be ignored
in DMA model.
That's why I tend to delay force-disable DMA until the next transmission begin.
Could you please give me some suggestion?

Thanks & Best regards,
Yuan Yao
