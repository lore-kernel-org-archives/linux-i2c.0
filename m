From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-piix4: Add support for the Broadcom HT1100 chipset
Date: Tue, 24 Mar 2009 17:57:51 +0100
Message-ID: <20090324175751.24c8b267@hyperion.delvare>
References: <20090324024326.GA22272@sysclose.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090324024326.GA22272-ljGZA5MgXf9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Flavio Leitner <fbl-ljGZA5MgXf9g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Flavio,

On Mon, 23 Mar 2009 23:43:26 -0300, Flavio Leitner wrote:
> Add support for the Broadcom HT1100 LD chipset
> 
> Signed-off-by: Flavio Leitner <fbl-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-piix4.c |    4 +++-
>  include/linux/pci_ids.h        |    1 +
>  2 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 761f9dd..64145b3 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -20,7 +20,7 @@
>  /*
>     Supports:
>  	Intel PIIX4, 440MX
> -	Serverworks OSB4, CSB5, CSB6, HT-1000
> +	Serverworks OSB4, CSB5, CSB6, HT-1000, HT-1100
>  	ATI IXP200, IXP300, IXP400, SB600, SB700, SB800
>  	SMSC Victory66
>  
> @@ -423,6 +423,8 @@ static struct pci_device_id piix4_ids[] = {
>  		     PCI_DEVICE_ID_SERVERWORKS_CSB6) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
>  		     PCI_DEVICE_ID_SERVERWORKS_HT1000SB) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
> +		     PCI_DEVICE_ID_SERVERWORKS_HT1100LD) },
>  	{ 0, }
>  };
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index aca8c45..531e628 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1467,6 +1467,7 @@
>  #define PCI_DEVICE_ID_SERVERWORKS_CSB5	  0x0201
>  #define PCI_DEVICE_ID_SERVERWORKS_CSB6    0x0203
>  #define PCI_DEVICE_ID_SERVERWORKS_HT1000SB 0x0205
> +#define PCI_DEVICE_ID_SERVERWORKS_HT1100LD 0x0408
>  #define PCI_DEVICE_ID_SERVERWORKS_OSB4IDE 0x0211
>  #define PCI_DEVICE_ID_SERVERWORKS_CSB5IDE 0x0212
>  #define PCI_DEVICE_ID_SERVERWORKS_CSB6IDE 0x0213

Applied, with minor improvements:
* Keep the PCI IDs sorted numerically.
* Update Kconfig and driver documentation file.

Resulting patch is at:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/i2c-piix4-add-support-for-broadcom-ht1100.patch
and will be merged in 2.6.30.

-- 
Jean Delvare
