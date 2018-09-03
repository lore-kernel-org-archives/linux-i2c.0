From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2] i2c: i801: fix DNV's SMBCTRL register offset
Date: Mon, 3 Sep 2018 11:02:51 +0200
Message-ID: <20180903110251.7aef3fd0@endymion>
References: <20180903090953.7d3e677f@endymion>
        <20180903082457.26143-1-felipe.balbi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180903082457.26143-1-felipe.balbi@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, stable@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Mon,  3 Sep 2018 11:24:57 +0300, Felipe Balbi wrote:
> DNV's iTCO is slightly different with SMBCTRL sitting at a differnt

Typo: different.

> offset when compared to all other devices. Let's fix so that we can
> properly use iTCO watchdog.
> 
> Fixes: 84d7f2ebd70d ("i2c: i801: Add support for Intel DNV")
> Cc: <stable@vger.kernel.org> # v4.4+
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> ---
> 
> Changes since v1:
> 	- explicitly define DNV's register instead of adding an offset
> 
>  drivers/i2c/busses/i2c-i801.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 941c223f6491..bdff45f99a56 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -140,6 +140,7 @@
>  
>  #define SBREG_BAR		0x10
>  #define SBREG_SMBCTRL		0xc6000c
> +#define SBREG_SMBCTRL_DNV	0xcf000c
>  
>  /* Host status bits for SMBPCISTS */
>  #define SMBPCISTS_INTS		BIT(3)
> @@ -1399,7 +1400,11 @@ static void i801_add_tco(struct i801_priv *priv)
>  	spin_unlock(&p2sb_spinlock);
>  
>  	res = &tco_res[ICH_RES_MEM_OFF];
> -	res->start = (resource_size_t)base64_addr + SBREG_SMBCTRL;
> +	if (pci_dev->device == PCI_DEVICE_ID_INTEL_DNV_SMBUS)
> +		res->start = (resource_size_t)base64_addr + SBREG_SMBCTRL_DNV;
> +	else
> +		res->start = (resource_size_t)base64_addr + SBREG_SMBCTRL;
> +
>  	res->end = res->start + 3;
>  	res->flags = IORESOURCE_MEM;
>  

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support
