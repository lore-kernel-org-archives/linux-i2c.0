From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2.6.27-rc4] i2c-i801: SMBus patch for Intel Ibex Peak
 DeviceIDs
Date: Thu, 28 Aug 2008 09:53:23 +0200
Message-ID: <20080828095323.58f2a60e@hyperion.delvare>
References: <200808271652.37597.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <200808271652.37597.seth.heasley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: linux-kernel@vger.kernel.org, i2c@lm-sensors.org, linux-pci@vger.kernel.org, jbarnes@virtuousgeek.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 27 Aug 2008 16:52:37 -0700, Seth Heasley wrote:
> This patch adds the Intel Ibex Peak (PCH) SMBus Controller DeviceIDs.
> 
> Signed-off-by: Seth Heasley <seth.heasley@intel.com>
> 
> --- linux-2.6/drivers/i2c/busses/Kconfig.orig	2008-08-27 12:11:03.000000000 -0700
> +++ linux-2.6/drivers/i2c/busses/Kconfig	2008-08-27 12:11:24.000000000 -0700
> @@ -97,6 +97,7 @@
>  	    ICH9
>  	    Tolapai
>  	    ICH10
> +	    PCH
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-i801.
> --- linux-2.6/drivers/i2c/busses/i2c-i801.c.orig	2008-08-27 11:52:45.000000000 -0700
> +++ linux-2.6/drivers/i2c/busses/i2c-i801.c	2008-08-27 12:10:50.000000000 -0700
> @@ -577,6 +577,7 @@
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TOLAPAI_1) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_5) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PCH_32) },
>  	{ 0, }
>  };
>  
> @@ -600,6 +601,7 @@
>  	case PCI_DEVICE_ID_INTEL_TOLAPAI_1:
>  	case PCI_DEVICE_ID_INTEL_ICH10_4:
>  	case PCI_DEVICE_ID_INTEL_ICH10_5:
> +	case PCI_DEVICE_ID_INTEL_PCH_32:
>  		i801_features |= FEATURE_I2C_BLOCK_READ;
>  		/* fall through */
>  	case PCI_DEVICE_ID_INTEL_82801DB_3:

This is messy. I'm discarding this patch from my i2c tree for the time
being. When things have settled on the pci_ids.h front, I'll look into
applying it again.

Note that your patch is still missing a chunk to
Documentation/i2c/busses/i2c-i801. Originally I added it myself but if
you are going to resend the same patch with different IDs every now and
then, please add it on your side too, so that I don't have to fix it
manually every time.

-- 
Jean Delvare
