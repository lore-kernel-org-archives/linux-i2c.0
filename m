From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/5] i2c-i801: Add Device IDs for Intel Wellsburg PCH
Date: Sat, 9 Feb 2013 20:00:10 +0100
Message-ID: <20130209200010.1b18fdb3@endymion.delvare>
References: <1360373535-2055-1-git-send-email-james.d.ralston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1360373535-2055-1-git-send-email-james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi James,

On Fri,  8 Feb 2013 17:32:15 -0800, James Ralston wrote:
> This patch adds the SMBus Device IDs for the Intel Wellsburg PCH
> 
> Signed-off-by: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/i2c/busses/i2c-i801 |    1 +
>  drivers/i2c/busses/Kconfig        |    1 +
>  drivers/i2c/busses/i2c-i801.c     |    3 +++
>  3 files changed, 5 insertions(+), 0 deletions(-)
> (...)

Seth recently sent a patch adding IDs for the Avoton:
http://marc.info/?l=linux-kernel&m=135959209218860&w=2

Your patch conflicts with his. Please rebase on top of Seth's patch, so
that both patches can be applied in sequence.

> (...)
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> (...)
> @@ -165,6 +166,7 @@
>  #define PCI_DEVICE_ID_INTEL_DH89XXCC_SMBUS	0x2330
>  #define PCI_DEVICE_ID_INTEL_5_3400_SERIES_SMBUS	0x3b30
>  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_SMBUS	0x8c22
> +#define PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS	0x8d22
>  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_SMBUS	0x9c22

Please keep sorted by ID.

-- 
Jean Delvare
