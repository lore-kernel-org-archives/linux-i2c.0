From: "Chew, Chiau Ee" <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCHv2 RESEND] i2c: designware-pci: set ideal HCNT, LCNT and
 SDA hold time value
Date: Tue, 11 Mar 2014 03:39:22 +0000
Message-ID: <604BF5F4C5D71041942BC7E84ED659EA0155D80D@PGSMSX103.gar.corp.intel.com>
References: <1394537625-27205-1-git-send-email-chiau.ee.chew@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394537625-27205-1-git-send-email-chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Lim, Lee Booi" <lee.booi.lim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


> Subject: [PATCHv2 RESEND] i2c: designware-pci: set ideal HCNT, LCNT and SDA
> hold time value
> 
> From: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> On Intel BayTrail, there was case whereby the resulting fast mode bus speed
> becomes slower (~20% slower compared to expected speed) if using the
> HCNT/LCNT calculated in the core layer. Thus, this patch is added to allow pci
> glue layer to pass in optimal HCNT/LCNT/SDA hold time values to core layer
> since the core layer supports cofigurable HCNT/LCNT/SDA hold time values
> now.
> 
> Signed-off-by: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
> v2 changelog:
> * Add 'dw_' prefix to struct scl_sda_cfg
> * Add Baytrail HCNT/LCNT/SDA hold time values directly in the
>   struct instead of using macro definition
> * Replace tab before "=" with space in struct
> 
>  drivers/i2c/busses/i2c-designware-pcidrv.c |   28
> ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
> 

I have misplaced the changelog in the previous v2 patch which would cause the removal of signed-off-by line. I'm resending this to fix that problem. Sorry for any confusion and inconvenience caused.
