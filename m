From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH 2/2] i2c: New bus driver for the QUP I2C controller
Date: Tue, 10 Sep 2013 18:10:56 +0300
Message-ID: <1378825856.960.47.camel@iivanov-dev.int.mm-sol.com>
References: <1377782873-31931-1-git-send-email-iivanov@mm-sol.com>
	 <1377782873-31931-2-git-send-email-iivanov@mm-sol.com>
	 <20130910134650.GO808@joshc.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20130910134650.GO808@joshc.qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Josh Cartwright <joshc@codeaurora.org>
Cc: wsa@the-dreams.de, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, grant.likely@linaro.org, gavidov@codeaurora.org, sdharia@codeaurora.org, alokc@codeaurora.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel, linux-arm-msm@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


Hi, 

On Tue, 2013-09-10 at 08:46 -0500, Josh Cartwright wrote: 
> Hey Ivan-
> 
> Some nits below.
> 
> On Thu, Aug 29, 2013 at 04:27:53PM +0300, Ivan T. Ivanov wrote:
> > From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> > 
> > This bus driver supports the QUP i2c hardware controller in the Qualcomm
> > MSM SOCs.  The Qualcomm Universal Peripheral Engine (QUP) is a general
> > purpose data path engine with input/output FIFOs and an embedded i2c
> > mini-core. The driver supports FIFO mode (for low bandwidth	applications)
> 
> Rogue tab in your commit message.

Will fix.

> 
> > and block mode (interrupt generated for each block-size data transfer).
> > The driver currently does not support DMA transfers.
> > 
> > Shamelessly based on codeaurora version of the driver.
> > 
> > This controller could be found in the following chip-sets:
> > msm9625, msm8974, msm8610, msm8226, mpq8092.
> 
> This may be good to include in the Kconfig help text.

Will do.

> 
> > Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> > ---
> >  drivers/i2c/busses/Kconfig   |   10 +
> >  drivers/i2c/busses/Makefile  |    1 +
> >  drivers/i2c/busses/i2c-qup.c |  909 ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 920 insertions(+)
> >  create mode 100644 drivers/i2c/busses/i2c-qup.c
> > 
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index fcdd321..c76ddd4 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -777,6 +777,16 @@ config I2C_RCAR
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called i2c-rcar.
> >  
> > +config I2C_QUP
> > +	tristate "Qualcomm QUP based I2C controller"
> > +	depends on ARCH_MSM
> > +	help
> > +	  If you say yes to this option, support will be included for the
> > +	  built-in I2C interface on the MSM family processors.
> > +
> > +	  This driver can also be built as a module.  If so, the module
> > +	  will be called i2c-qup.
> > +
> >  comment "External I2C/SMBus adapter drivers"
> >  
> >  config I2C_DIOLAN_U2C
> > diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> > index d00997f..77127df 100644
> > --- a/drivers/i2c/busses/Makefile
> > +++ b/drivers/i2c/busses/Makefile
> > @@ -76,6 +76,7 @@ obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
> >  obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
> >  obj-$(CONFIG_I2C_XLR)		+= i2c-xlr.o
> >  obj-$(CONFIG_I2C_RCAR)		+= i2c-rcar.o
> > +obj-$(CONFIG_I2C_QUP)		+= i2c-qup.o
> >  
> >  # External I2C/SMBus adapter drivers
> >  obj-$(CONFIG_I2C_DIOLAN_U2C)	+= i2c-diolan-u2c.o
> > diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> > new file mode 100644
> > index 0000000..3b5ef91
> > --- /dev/null
> > +++ b/drivers/i2c/busses/i2c-qup.c
> [..]
> > +
> > +static int qup_i2c_change_state(struct qup_i2c_dev *qup, u32 state)
> > +{
> > +	if (qup_i2c_poll_state(qup, 0, true) != 0)
> > +		return -EIO;
> > +
> > +	writel(state, qup->base + QUP_STATE);
> > +
> > +	if (qup_i2c_poll_state(qup, state, false) != 0)
> > +		return -EIO;
> > +	return 0;
> > +}
> > +
> > +static void qup_i2c_enable(struct qup_i2c_dev *qup, bool state)
> 
> Bit of a confusing name, especially when qup_i2c_enable(qup, false) is
> used. I'd suggest qup_i2c_set_state or qup_i2c_set_enabled.

Indeed. I prefer qup_i2c_set_enabled.

> 
> > +{
> > +	u32 config;
> > +
> > +	if (state) {
> > +		clk_prepare_enable(qup->clk);
> > +		clk_prepare_enable(qup->pclk);
> > +	} else {
> > +		qup_i2c_change_state(qup, QUP_RESET_STATE);
> > +		clk_disable_unprepare(qup->clk);
> > +		config = readl(qup->base + QUP_CONFIG);
> > +		config |= QUP_CLOCK_AUTO_GATE;
> > +		writel(config, qup->base + QUP_CONFIG);
> > +		clk_disable_unprepare(qup->pclk);
> > +	}
> > +}
> [..]
> > +static int qup_i2c_probe(struct platform_device *pdev)
> > +{
> [..]
> > +
> > +	ret = devm_request_irq(qup->dev, qup->irq, qup_i2c_interrupt,
> > +			       IRQF_TRIGGER_HIGH, "i2c_qup", qup);
> > +	if (ret) {
> > +		dev_err(qup->dev, "Request %d IRQ failed\n", qup->irq);
> > +		return ret;
> > +	}
> > +
> > +	disable_irq(qup->irq);
> 
> How is this not racy, in the case where a pending interrupt is left from
> the bootloader (which seems to be possible based on the comments below)?

Yes it looks weird. Interrupt handler will check and exit if there
is no message for transfer. I am looking for better way to handle this.

Thanks, 
Ivan

> 
> > +
> > +	init_completion(&qup->xfer);
> > +
> > +	ret = clk_set_rate(qup->clk, qup->src_clk_freq);
> > +	if (ret)
> > +		dev_info(qup->dev, "Fail to set core clk, %dHz:%d\n",
> > +			 qup->src_clk_freq, ret);
> > +
> > +	qup_i2c_enable(qup, true);
> > +
> > +	/*
> > +	 * If bootloaders leave a pending interrupt on certain QUP's,
> > +	 * then we reset the core before registering for interrupts.
> > +	 */
> [..]
> 
