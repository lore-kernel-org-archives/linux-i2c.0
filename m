From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v6 5/6] i2c: Add Actions Semiconductor Owl family S900
 I2C driver
Date: Mon, 23 Jul 2018 12:54:52 +0530
Message-ID: <20180723072452.GA4353@mani>
References: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
 <20180723034025.5763-6-manivannan.sadhasivam@linaro.org>
 <911dc259-7b30-9c6e-2c82-2f4c032b9d73@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <911dc259-7b30-9c6e-2c82-2f4c032b9d73@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de, linus.walleij@linaro.org, linux-i2c@vger.kernel.org, liuwei@actions-semi.com, mp-cs@actions-semi.com, 96boards@ucrobotics.com, devicetree@vger.kernel.org, andy.shevchenko@gmail.com, daniel.thompson@linaro.org, amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com, thomas.liau@actions-semi.com, jeff.chen@actions-semi.com
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

On Mon, Jul 23, 2018 at 08:12:17AM +0200, Peter Rosin wrote:
> On 2018-07-23 05:40, Manivannan Sadhasivam wrote:
> > +		/* Handle the remaining bytes which were not sent */
> > +		while (!(readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
> > +		       OWL_I2C_FIFOSTAT_TFF) && i2c_dev->msg_ptr < msg->len) {
> 
> You moved the OWL_ line to the left instead of right, so this is still
> misaligned and thus not helping the reader.
> 

Yes. I'm not sure which side I should shift but since the recommendation
states that we should start from the first character after parenthesis, so I
went for left.

But yeah, this could be more readable by shifting right.

Anyway, thanks a lot for helping me to cleanup/structure the code.

Regards,
Mani

> Cheers,
> Peter
> 
> > +			writel(msg->buf[i2c_dev->msg_ptr++],
> > +			       i2c_dev->base + OWL_I2C_REG_TXDAT);
> > +		}
> 
