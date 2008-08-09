From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2.6.26.2] pci_ids: patch for Intel Ibex Peak DeviceIDs
Date: Sat, 9 Aug 2008 16:00:40 +0200
Message-ID: <20080809160040.6c8618a0@hyperion.delvare>
References: <200808081616.08158.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <200808081616.08158.seth.heasley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: i2c@lm-sensors.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 8 Aug 2008 16:16:07 -0700, Seth Heasley wrote:
> This patch adds the Intel Ibex Peak (PCH) LPC and SMBus Controller DeviceIDs.
> 
> Signed-off-by: Seth Heasley <seth.heasley@intel.com>
> 
> --- linux-2.6.26.2/include/linux/pci_ids.h.orig 2008-08-08 11:07:41.000000000 -0700
> +++ linux-2.6.26.2/include/linux/pci_ids.h      2008-08-08 11:22:31.000000000 -0700
> @@ -2385,6 +2385,9 @@
>  #define PCI_DEVICE_ID_INTEL_ICH10_3    0x3a1a
>  #define PCI_DEVICE_ID_INTEL_ICH10_4    0x3a30
>  #define PCI_DEVICE_ID_INTEL_ICH10_5    0x3a60
> +#define PCI_DEVICE_ID_INTEL_PCH_0      0x3b10
> +#define PCI_DEVICE_ID_INTEL_PCH_1      0x3b11
> +#define PCI_DEVICE_ID_INTEL_PCH_2      0x3b30
>  #define PCI_DEVICE_ID_INTEL_IOAT_SNB   0x402f
>  #define PCI_DEVICE_ID_INTEL_5400_ERR   0x4030
>  #define PCI_DEVICE_ID_INTEL_5400_FBD0  0x4035

Acked-by: Jean Delvare <khali@linux-fr.org>

Would be a good idea to send such a patch to the maintainer of the PCI
subsystem (Cc added.)

Note that the other patch you just sent for i2c-i801 depends on this
one, so I will have to wait for Jesse to pick it first.

-- 
Jean Delvare
