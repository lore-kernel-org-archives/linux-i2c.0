From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] [I2C] i2c-viapro: Add new PCI device ID For VX855
Date: Sun, 17 May 2009 10:19:52 +0200
Message-ID: <20090517101952.533373c1@hyperion.delvare>
References: <20090517060439.GE4909@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090517060439.GE4909-jI4mzJ+yNOMOwssVsN95jSCwEArCW2h5@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Harald Welte <HaraldWelte-yS34VQbMlVtBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Harald,

On Sun, 17 May 2009 14:04:39 +0800, Harald Welte wrote:
> The south bridge of the VIA VX855 chipset has a different PCI Device ID
> so i2c-viapro.c needs to be updated with this.
> 
> Signed-off-by: Harald Welte <HaraldWelte-yS34VQbMlVtBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-viapro.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
> index 02e6f72..7a0b15a 100644
> --- a/drivers/i2c/busses/i2c-viapro.c
> +++ b/drivers/i2c/busses/i2c-viapro.c
> @@ -37,6 +37,7 @@
>     VT8251             0x3287             yes
>     CX700              0x8324             yes
>     VX800/VX820        0x8353             yes
> +   VX855/VX875        0x8409             yes
>  
>     Note: we assume there can only be one device, with one SMBus interface.
>  */
> @@ -469,6 +470,8 @@ static struct pci_device_id vt596_ids[] = {
>  	  .driver_data = SMBBA3 },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX800),
>  	  .driver_data = SMBBA3 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX855),
> +	  .driver_data = SMBBA3 },
>  	{ 0, }
>  };
>  

Thanks for your contribution. You did not include
PCI_DEVICE_ID_VIA_VX855 to the list of devices which support I2C block
transactions (in function vt596_probe), is this on purpose or an
overlook?

-- 
Jean Delvare
