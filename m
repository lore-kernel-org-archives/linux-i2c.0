From: David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 1/3] i2c: designware-pci: shrink dw_pci_controllers
 array
Date: Thu, 22 Jan 2015 11:03:02 -0800
Message-ID: <20150122190301.GA15297@psi-dev26.jf.intel.com>
References: <1421937869-28376-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421937869-28376-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Andy,

On Thu, Jan 22, 2015 at 04:44:27PM +0200, Andy Shevchenko wrote:
> There is no need to duplicate same data for each controller. If we need
> specific stuff for a certain controller in the future we may add it later. The
> patch leaves one controller per platform.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c | 96 ++++++------------------------
>  1 file changed, 19 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index acb40f9..9237abb 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -40,17 +40,8 @@
>  #define DRIVER_NAME "i2c-designware-pci"
>  
>  enum dw_pci_ctl_id_t {
> -	moorestown_0,
> -	moorestown_1,
> -	moorestown_2,
> -
> -	medfield_0,
> -	medfield_1,
> -	medfield_2,
> -	medfield_3,
> -	medfield_4,
> -	medfield_5,
> -
> +	moorestown,

Since you're doing this rework, could you remove moorestown for good?
It's no longer supported as one of intel mid's platform anyway.

Br, David
