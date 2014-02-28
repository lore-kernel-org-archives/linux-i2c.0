From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/3] i2c: add DMA support for freescale i2c driver
Date: Fri, 28 Feb 2014 10:13:02 +0800
Message-ID: <20140228021300.GJ13537@S2101-09.ap.freescale.net>
References: <1393481115-22136-1-git-send-email-yao.yuan@freescale.com>
 <1393481115-22136-2-git-send-email-yao.yuan@freescale.com>
 <201402272139.36076.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201402272139.36076.marex@denx.de>
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
Cc: mark.rutland@arm.com, wsa@the-dreams.de, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Yuan Yao <yao.yuan@freescale.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 27, 2014 at 09:39:35PM +0100, Marek Vasut wrote:
> > @@ -193,6 +216,7 @@ static const struct imx_i2c_hwdata imx1_i2c_hwdata  = {
> >  	.ndivs			= ARRAY_SIZE(imx_i2c_clk_div),
> >  	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W0C,
> >  	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_1,
> > +	.has_dma_support	= false,
> > 
> >  };
> > 
> > @@ -203,6 +227,7 @@ static const struct imx_i2c_hwdata imx21_i2c_hwdata  =
> > { .ndivs			= ARRAY_SIZE(imx_i2c_clk_div),
> >  	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W0C,
> >  	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_1,
> > +	.has_dma_support	= false,
> > 
> >  };
> > 
> > @@ -213,6 +238,7 @@ static struct imx_i2c_hwdata vf610_i2c_hwdata = {
> >  	.ndivs			= ARRAY_SIZE(vf610_i2c_clk_div),
> >  	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W1C,
> >  	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_0,
> > +	.has_dma_support	= true,
> 
> So why exactly don't we have a DT prop for determining whether the controller 
> has DMA support ?

Using DMA or PIO is a decision that should be made by driver on its own,
not device tree.

Shawn
