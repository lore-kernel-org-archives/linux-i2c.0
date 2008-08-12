From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2.6.26.2][RESEND] i2c-i801: SMBus patch for Intel Ibex
 Peak DeviceIDs
Date: Tue, 12 Aug 2008 13:58:02 +0200
Message-ID: <20080812135802.53db9a8a@hyperion.delvare>
References: <200808111702.38396.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753243AbYHLL6V@vger.kernel.org>
In-Reply-To: <200808111702.38396.seth.heasley@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, i2c@lm-sensors.org, seth.heasley@intel.com
List-Id: linux-i2c@vger.kernel.org

On Mon, 11 Aug 2008 17:02:38 -0700, Seth Heasley wrote:
> Resend with proper whitespace.
> 
> This patch adds the Intel Ibex Peak (PCH) SMBus Controller DeviceIDs.
> 
> Signed-off-by: Seth Heasley <seth.heasley@intel.com>
> 
> --- linux-2.6.26.2/drivers/i2c/busses/i2c-i801.c.orig	2008-08-08 11:28:08.000000000 -0700
> +++ linux-2.6.26.2/drivers/i2c/busses/i2c-i801.c	2008-08-08 11:32:18.000000000 -0700
> @@ -43,6 +43,7 @@
>    Tolapai               0x5032     32     hard     yes     yes     yes
>    ICH10                 0x3a30     32     hard     yes     yes     yes
>    ICH10                 0x3a60     32     hard     yes     yes     yes
> +  PCH                   0x3b30     32     hard     yes     yes     yes
>  
>    Features supported by this driver:
>    Software PEC                     no
> @@ -592,6 +593,7 @@
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TOLAPAI_1) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_5) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PCH_2) },
>  	{ 0, }
>  };
>  
> @@ -615,6 +617,7 @@
>  	case PCI_DEVICE_ID_INTEL_TOLAPAI_1:
>  	case PCI_DEVICE_ID_INTEL_ICH10_4:
>  	case PCI_DEVICE_ID_INTEL_ICH10_5:
> +	case PCI_DEVICE_ID_INTEL_PCH_2:
>  		i801_features |= FEATURE_I2C_BLOCK_READ;
>  		/* fall through */
>  	case PCI_DEVICE_ID_INTEL_82801DB_3:
> --- linux-2.6.26.2/drivers/i2c/busses/Kconfig.orig	2008-08-08 11:27:52.000000000 -0700
> +++ linux-2.6.26.2/drivers/i2c/busses/Kconfig	2008-08-08 11:30:42.000000000 -0700
> @@ -182,6 +182,7 @@
>  	    ICH9
>  	    Tolapai
>  	    ICH10
> +	    PCH
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-i801.
> 

Looks good, I've added this to my tree. I will have to wait for the PCI
IDs patch to go upstream before I can push it though.


-- 
Jean Delvare
