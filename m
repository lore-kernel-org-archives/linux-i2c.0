From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i801: fix DNV's SMBCTRL register offset
Date: Mon, 3 Sep 2018 09:09:53 +0200
Message-ID: <20180903090953.7d3e677f@endymion>
References: <20180903053705.9844-1-felipe.balbi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180903053705.9844-1-felipe.balbi@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, stable@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Hi Felipe,

On Mon,  3 Sep 2018 08:37:05 +0300, Felipe Balbi wrote:
> DNV's iTCO is slightly different with SMBCTRL sitting at a differnt
> offset when compared to all other devices. Let's fix so that we can
> properly use iTCO watchdog.
> 
> Fixes: 84d7f2ebd70d ("i2c: i801: Add support for Intel DNV")
> Cc: <stable@vger.kernel.org> # v4.4+
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-i801.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 941c223f6491..390bf253b6ea 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -1400,6 +1400,11 @@ static void i801_add_tco(struct i801_priv *priv)
>  
>  	res = &tco_res[ICH_RES_MEM_OFF];
>  	res->start = (resource_size_t)base64_addr + SBREG_SMBCTRL;
> +
> +	/* DNV device has SMBCTRL at 0xcf000c */
> +	if (pci_dev->device == PCI_DEVICE_ID_INTEL_DNV_SMBUS)
> +		res->start += 0x90000;
> +
>  	res->end = res->start + 3;
>  	res->flags = IORESOURCE_MEM;
>  

Thanks for catching this but this is not the way I want it to be fixed.
Applying an arbitrary offset like that is pretty obscure and fragile
too. The value of SMBCTRL for DNV should instead appear explicitly in
the code. Something like that:

#define SBREG_SMBCTRL		0xc6000c
#define SBREG_SMBCTRL_DNV	0xcf000c

	if (pci_dev->device == PCI_DEVICE_ID_INTEL_DNV_SMBUS)
		res->start = (resource_size_t)base64_addr + SBREG_SMBCTRL_DNV;
	else
		res->start = (resource_size_t)base64_addr + SBREG_SMBCTRL;

Alternatively you can add a member to struct i801_priv to store the
register address in i801_probe(), and use that in i801_add_tco(). The
above defines could even go away then. Both approaches are fine with me.

-- 
Jean Delvare
SUSE L3 Support
