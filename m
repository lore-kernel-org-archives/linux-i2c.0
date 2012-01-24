From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 4/6] i2c-i801: SMBus patch for Intel Lynx Point
 DeviceIDs
Date: Tue, 24 Jan 2012 08:34:16 +0100
Message-ID: <20120124083416.00c582d0@endymion.delvare>
References: <201201231637.36362.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201201231637.36362.seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 23 Jan 2012 16:37:36 -0800, Seth Heasley wrote:
> This patch adds the SMBus controller DeviceIDs for the Intel Lynx Point PCH.
> 
> Signed-off-by: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/i2c/busses/i2c-i801 |    1 +
>  drivers/i2c/busses/Kconfig        |    1 +
>  drivers/i2c/busses/i2c-i801.c     |    3 +++
>  3 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i2c-i801
> index 2871fd5..71f55bb 100644
> --- a/Documentation/i2c/busses/i2c-i801
> +++ b/Documentation/i2c/busses/i2c-i801
> @@ -20,6 +20,7 @@ Supported adapters:
>    * Intel Patsburg (PCH)
>    * Intel DH89xxCC (PCH)
>    * Intel Panther Point (PCH)
> +  * Intel Lynx Point (PCH)
>     Datasheets: Publicly available at the Intel website
>  
>  On Intel Patsburg and later chipsets, both the normal host SMBus controller
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index a3afac4..ff64291 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -103,6 +103,7 @@ config I2C_I801
>  	    Patsburg (PCH)
>  	    DH89xxCC (PCH)
>  	    Panther Point (PCH)
> +	    Lynx Point (PCH)
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-i801.
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index ab26840d..f9c3ca0 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -51,6 +51,7 @@
>    Patsburg (PCH) IDF    0x1d72     32     hard     yes     yes     yes
>    DH89xxCC (PCH)        0x2330     32     hard     yes     yes     yes
>    Panther Point (PCH)   0x1e22     32     hard     yes     yes     yes
> +  Lynx Point (PCH)      0x8c22     32     hard     yes     yes     yes
>  
>    Features supported by this driver:
>    Software PEC                     no
> @@ -145,6 +146,7 @@
>  #define PCI_DEVICE_ID_INTEL_PANTHERPOINT_SMBUS	0x1e22
>  #define PCI_DEVICE_ID_INTEL_DH89XXCC_SMBUS	0x2330
>  #define PCI_DEVICE_ID_INTEL_5_3400_SERIES_SMBUS	0x3b30
> +#define PCI_DEVICE_ID_INTEL_LYNXPOINT_SMBUS	0x8c22
>  
>  struct i801_priv {
>  	struct i2c_adapter adapter;
> @@ -633,6 +635,7 @@ static const struct pci_device_id i801_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF2) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_DH89XXCC_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PANTHERPOINT_SMBUS) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LYNXPOINT_SMBUS) },
>  	{ 0, }
>  };
>  

Applied, thanks.

-- 
Jean Delvare
