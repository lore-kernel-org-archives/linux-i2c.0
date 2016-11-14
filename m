From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH v4] i2c: designware: Implement support for SMBus block read and write
Date: Mon, 14 Nov 2016 11:59:37 +0100
Message-ID: <4917823.j8OxAtZYNT@ws-stein>
References: <1478746593-10905-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478746593-10905-1-git-send-email-tnhuynh@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: tnhuynh@apm.com, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com
List-Id: linux-i2c@vger.kernel.org

On Thursday 10 November 2016 09:56:33, tnhuynh@apm.com wrote:
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c
> b/drivers/i2c/busses/i2c-designware-pcidrv.c index 96f8230..8ffe2da 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -75,6 +75,7 @@ struct dw_pci_controller {
>  					I2C_FUNC_SMBUS_BYTE |		\
>  					I2C_FUNC_SMBUS_BYTE_DATA |	\
>  					I2C_FUNC_SMBUS_WORD_DATA |	\
> +					I2C_FUNC_SMBUS_BLOCK_DATA |	\
>  					I2C_FUNC_SMBUS_I2C_BLOCK)
> 
>  /* Merrifield HCNT/LCNT/SDA hold time */
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c index 0b42a12..886fb62 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -220,6 +220,7 @@ static int dw_i2c_plat_probe(struct platform_device
> *pdev) I2C_FUNC_SMBUS_BYTE |
>  		I2C_FUNC_SMBUS_BYTE_DATA |
>  		I2C_FUNC_SMBUS_WORD_DATA |
> +		I2C_FUNC_SMBUS_BLOCK_DATA |
>  		I2C_FUNC_SMBUS_I2C_BLOCK;
> 
>  	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |

Shouldn't those functionality bits moved to a common place, like i2c-
designware-core.h?

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein
SYS TEC electronic GmbH
alexander.stein@systec-electronic.com

Legal and Commercial Address:
Am Windrad 2
08468 Heinsdorfergrund
Germany

Office: +49 (0) 3765 38600-0
Fax:    +49 (0) 3765 38600-4100
 
Managing Directors:
	Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
	Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
Commercial Registry:
	Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010
