From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: nvidia-gpu: mark resume function as __maybe_unused
Date: Tue, 11 Dec 2018 12:50:27 +0200
Message-ID: <20181211105027.GB10650@smile.fi.intel.com>
References: <20181210205356.2846843-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181210205356.2846843-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ajay Gupta <ajayg@nvidia.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 10, 2018 at 09:53:45PM +0100, Arnd Bergmann wrote:
> When CONFIG_PM is disabled, this is needed to avoid a harmless
> unused-function warning:
> 
> drivers/i2c/busses/i2c-nvidia-gpu.c:345:12: error: 'gpu_i2c_resume' defined but not used [-Werror=unused-function]
> 

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: c71bcdcb42a7 ("i2c: add i2c bus driver for NVIDIA GPU")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/i2c/busses/i2c-nvidia-gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-nvidia-gpu.c b/drivers/i2c/busses/i2c-nvidia-gpu.c
> index e99c3bb58351..4e67d5ed480e 100644
> --- a/drivers/i2c/busses/i2c-nvidia-gpu.c
> +++ b/drivers/i2c/busses/i2c-nvidia-gpu.c
> @@ -342,7 +342,7 @@ static void gpu_i2c_remove(struct pci_dev *pdev)
>  	pci_free_irq_vectors(pdev);
>  }
>  
> -static int gpu_i2c_resume(struct device *dev)
> +static __maybe_unused int gpu_i2c_resume(struct device *dev)
>  {
>  	struct gpu_i2c_dev *i2cd = dev_get_drvdata(dev);
>  
> -- 
> 2.20.0
> 

-- 
With Best Regards,
Andy Shevchenko
