From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 3/4] i2c: designware-pcidrv: enable RuntimePM before
 registering to the core
Date: Wed, 20 Apr 2016 16:03:01 +0300
Message-ID: <57177E05.80107@linux.intel.com>
References: <1460638414-5987-1-git-send-email-jszhang@marvell.com>
 <1460638414-5987-4-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:36450 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255AbcDTNDG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 20 Apr 2016 09:03:06 -0400
In-Reply-To: <1460638414-5987-4-git-send-email-jszhang@marvell.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 04/14/2016 03:53 PM, Jisheng Zhang wrote:
> As pointed out by commit 36d48fb5766a ("i2c: designware-platdrv: enable
> RuntimePM before registering to the core"), "The core may register
> clients attached to this master which may use funtionality from the
> master", so enable RuntimePM before registering to the core.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>   drivers/i2c/busses/i2c-designware-pcidrv.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index 7368be0..41a01a7 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -248,14 +248,17 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
>   	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
>   	adap->nr = controller->bus_num;
>
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_allow(&pdev->dev);
> +
>   	r = i2c_dw_probe(dev);
> -	if (r)
> +	if (r) {
> +		pm_runtime_forbid(&pdev->dev);
>   		return r;
> +	}
>
> -	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
> -	pm_runtime_use_autosuspend(&pdev->dev);
>   	pm_runtime_put_autosuspend(&pdev->dev);
> -	pm_runtime_allow(&pdev->dev);
>
Last time I checked this I didn't see urgent reason for the move because 
runtime PM is enabled for PCI devices by default via pci_device_add() -> 
pci_init_capabilities() -> pci_pm_init() -> pm_runtime_enable().

-- 
Jarkko
