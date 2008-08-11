From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 2.6.26.2] pci_ids: patch for Intel Ibex Peak DeviceIDs
Date: Mon, 11 Aug 2008 10:18:43 -0700
Message-ID: <200808111018.44024.jbarnes@virtuousgeek.org>
References: <200808081616.08158.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <200808081616.08158.seth.heasley@intel.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: i2c@lm-sensors.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, khali@linux-fr.org
List-Id: linux-i2c@vger.kernel.org

On Friday, August 8, 2008 4:16 pm Seth Heasley wrote:
> This patch adds the Intel Ibex Peak (PCH) LPC and SMBus Controller
> DeviceIDs.
>
> Signed-off-by: Seth Heasley <seth.heasley@intel.com>
>
> --- linux-2.6.26.2/include/linux/pci_ids.h.orig 2008-08-08
> 11:07:41.000000000 -0700 +++ linux-2.6.26.2/include/linux/pci_ids.h     
> 2008-08-08 11:22:31.000000000 -0700 @@ -2385,6 +2385,9 @@
>  #define PCI_DEVICE_ID_INTEL_ICH10_3    0x3a1a
>  #define PCI_DEVICE_ID_INTEL_ICH10_4    0x3a30
>  #define PCI_DEVICE_ID_INTEL_ICH10_5    0x3a60
> +#define PCI_DEVICE_ID_INTEL_PCH_0      0x3b10
> +#define PCI_DEVICE_ID_INTEL_PCH_1      0x3b11
> +#define PCI_DEVICE_ID_INTEL_PCH_2      0x3b30
>  #define PCI_DEVICE_ID_INTEL_IOAT_SNB   0x402f
>  #define PCI_DEVICE_ID_INTEL_5400_ERR   0x4030
>  #define PCI_DEVICE_ID_INTEL_5400_FBD0  0x4035

Should PCH_2 also be added to arch/x86/pci/irq.c?  You may as well combine the 
irq.c and pci_ids.h patches into one patch too.  Care to respin against my 
for-linus branch and resubmit?

Thanks.
-- 
Jesse Barnes, Intel Open Source Technology Center
