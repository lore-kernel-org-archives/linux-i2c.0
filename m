From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v1 2/3] i2c: designware-pci: Introduce Merrifield support
Date: Wed, 15 Jun 2016 16:48:27 +0300
Message-ID: <ffcdc682-1948-f048-b8df-4f3360fbe501@linux.intel.com>
References: <1465944960-25444-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1465944960-25444-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62351 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932121AbcFONsi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 15 Jun 2016 09:48:38 -0400
In-Reply-To: <1465944960-25444-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

On 06/15/2016 01:55 AM, Andy Shevchenko wrote:
> This patch enables I2C controllers found on Intel Edison board.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c | 33 ++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index 0f1fc48..a51f6e0 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -42,6 +42,7 @@
>
>  enum dw_pci_ctl_id_t {
>  	medfield,
> +	merrifield,
>  	baytrail,
>  	haswell,
>  };
> @@ -75,6 +76,14 @@ struct dw_pci_controller {
>  					I2C_FUNC_SMBUS_WORD_DATA |	\
>  					I2C_FUNC_SMBUS_I2C_BLOCK)
>
> +/* Merrifield HCNT/LCNT/SDA hold time */
> +static struct dw_scl_sda_cfg mrfld_config = {
> +	.ss_hcnt = 0x2f8,
> +	.fs_hcnt = 0x87,
> +	.ss_lcnt = 0x37b,
> +	.fs_lcnt = 0x10a,
> +};
> +
>  /* BayTrail HCNT/LCNT/SDA hold time */
>  static struct dw_scl_sda_cfg byt_config = {
>  	.ss_hcnt = 0x200,
> @@ -110,6 +119,19 @@ static int mfld_setup(struct pci_dev *pdev, struct dw_pci_controller *c)
>  	return -ENODEV;
>  }
>
> +static int mrfld_setup(struct pci_dev *pdev, struct dw_pci_controller *c)
> +{
> +	switch (PCI_SLOT(pdev->devfn)) {
> +	case 8:
> +		c->bus_num = PCI_FUNC(pdev->devfn) + 0 + 1;
> +		return 0;
> +	case 9:
> +		c->bus_num = PCI_FUNC(pdev->devfn) + 4 + 1;
> +		return 0;
> +	}
> +	return -ENODEV;
> +}
> +

What kind of bus numbers we are expected to see here and what offsets 
these magic numbers represent?

-- 
Jarkko
