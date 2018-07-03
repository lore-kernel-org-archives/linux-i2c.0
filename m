From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware-pcidrv: Mark expected switch
 fall-through
Date: Tue, 03 Jul 2018 22:16:43 +0300
Message-ID: <6f9e75b62b5e93b28694e6dac2abf0a398ee3dc1.camel@linux.intel.com>
References: <20180703191055.GA30768@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180703191055.GA30768@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-07-03 at 14:10 -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> 
> where we are expecting to fall through.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c
> b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index 86e1bd0..b4997be 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -105,6 +105,7 @@ static int mfld_setup(struct pci_dev *pdev, struct
> dw_pci_controller *c)
>  	case 0x0817:
>  		c->bus_cfg &= ~DW_IC_CON_SPEED_MASK;
>  		c->bus_cfg |= DW_IC_CON_SPEED_STD;
> +		/* fall through */
>  	case 0x0818:
>  	case 0x0819:
>  		c->bus_num = pdev->device - 0x817 + 3;

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
