From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v6 5/6] i2c: Add Actions Semiconductor Owl family S900 I2C
 driver
Date: Mon, 23 Jul 2018 08:12:17 +0200
Message-ID: <911dc259-7b30-9c6e-2c82-2f4c032b9d73@axentia.se>
References: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
 <20180723034025.5763-6-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723034025.5763-6-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de
Cc: linus.walleij@linaro.org, linux-i2c@vger.kernel.org, liuwei@actions-semi.com, mp-cs@actions-semi.com, 96boards@ucrobotics.com, devicetree@vger.kernel.org, andy.shevchenko@gmail.com, daniel.thompson@linaro.org, amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com, thomas.liau@actions-semi.com, jeff.chen@actions-semi.com
List-Id: linux-i2c@vger.kernel.org

On 2018-07-23 05:40, Manivannan Sadhasivam wrote:
> +		/* Handle the remaining bytes which were not sent */
> +		while (!(readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
> +		       OWL_I2C_FIFOSTAT_TFF) && i2c_dev->msg_ptr < msg->len) {

You moved the OWL_ line to the left instead of right, so this is still
misaligned and thus not helping the reader.

Cheers,
Peter

> +			writel(msg->buf[i2c_dev->msg_ptr++],
> +			       i2c_dev->base + OWL_I2C_REG_TXDAT);
> +		}
