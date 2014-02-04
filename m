From: 'Mika Westerberg' <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: designware-pci: Add CONFIG_PM_RUNTIME to
 i2c_dw_pci_runtime_idle()
Date: Tue, 4 Feb 2014 12:05:26 +0200
Message-ID: <20140204100526.GZ18029@intel.com>
References: <000301cf216d$0d08b4e0$271a1ea0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000301cf216d$0d08b4e0$271a1ea0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Andy Shevchenko' <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 04, 2014 at 02:50:46PM +0900, Jingoo Han wrote:
> Add CONFIG_PM_RUNTIME to i2c_dw_pci_runtime_idle() to fix the
> build warning when CONFIG_PM_RUNTIME is not selected. This is
> because runtime PM callbacks defined by SET_RUNTIME_PM_OPS are
> only used when the CONFIG_PM_RUNTIME is enabled.
> 
> drivers/i2c/busses/i2c-designware-pcidrv.c:188:12: warning: 'i2c_dw_pci_runtime_idle' defined but not used [-Wunused-function]
> 
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index f6ed06c..2b5d3a6 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -185,6 +185,7 @@ static int i2c_dw_pci_resume(struct device *dev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_RUNTIME
>  static int i2c_dw_pci_runtime_idle(struct device *dev)
>  {
>  	int err = pm_schedule_suspend(dev, 500);
> @@ -194,6 +195,7 @@ static int i2c_dw_pci_runtime_idle(struct device *dev)
>  		return 0;
>  	return -EBUSY;
>  }
> +#endif

While this fixes the compilation warning, I would like to get rid of the
whole runtime idle hook along with the PCI D-state management in the
driver.

I have a patch for this but I haven't been able to test it yet (hopefully I
can get it tested today).
