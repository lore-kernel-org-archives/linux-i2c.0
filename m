From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2.6.26.2] i2c-i801: SMBus patch for Intel Ibex Peak
 DeviceIDs
Date: Sat, 9 Aug 2008 16:48:29 +0200
Message-ID: <20080809164829.231c1d6f@hyperion.delvare>
References: <200808081602.28479.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754520AbYHIOsq@vger.kernel.org>
In-Reply-To: <200808081602.28479.seth.heasley@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: linux-kernel@vger.kernel.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

Hi Seth,

On Fri, 8 Aug 2008 16:02:28 -0700, Seth Heasley wrote:
> This patch adds the Intel Ibex Peak (PCH) SMBus Controller DeviceIDs.
> 
> Signed-off by: Seth Heasley <seth.heasley@intel.com>
> 
> --- linux-2.6.26.2/drivers/i2c/busses/i2c-i801.c.orig   2008-08-08 11:28:08.000000000 -0700
> +++ linux-2.6.26.2/drivers/i2c/busses/i2c-i801.c        2008-08-08 11:32:18.000000000 -0700
> @@ -43,6 +43,7 @@
>    Tolapai               0x5032     32     hard     yes     yes     yes
>    ICH10                 0x3a30     32     hard     yes     yes     yes
>    ICH10                 0x3a60     32     hard     yes     yes     yes
> +  PCH                   0x3b30     32     hard     yes     yes     yes
> 
>    Features supported by this driver:
>    Software PEC                     no
> @@ -592,6 +593,7 @@
>         { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TOLAPAI_1) },
>         { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_4) },
>         { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_5) },
> +       { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PCH_2) },
>         { 0, }
>  };
> (...)

Your e-mail client converted all tabs to spaces, so your patch doesn't
apply. Please resend in a way which leaves the patch unmodified, so that I can apply it.

Thanks,
-- 
Jean Delvare
