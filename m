From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] (RESEND #2)  i2c: prevent spurious interrupt
Date: Fri, 27 Jan 2012 09:26:07 +0100
Message-ID: <20120127092607.09ed312a@endymion.delvare>
References: <20120126161319.22798.6071.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120126161319.22798.6071.stgit-Z/y2cZnRghHXmaaqVzeoHQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Alan,

On Thu, 26 Jan 2012 16:13:34 +0000, Alan Cox wrote:
> From: Kristen Carlson Accardi <kristen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> Don't call i2c_enable on resume because it causes a spurious
> interrupt.
> 
> Signed-off-by:  Kristen Carlson Accardi <kristen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
> 
>  drivers/i2c/busses/i2c-designware-pcidrv.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

Please come up with a decent subject line for this patch. Currently it
sounds very generic so Ben will never look at it, assuming I will take
care of it. But it is actually driver-specific, and that's a driver Ben
is responsible for, so I won't pick it.

> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index 37f4211..00e8f21 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -182,7 +182,6 @@ static int i2c_dw_pci_resume(struct device *dev)
>  	pci_restore_state(pdev);
>  
>  	i2c_dw_init(i2c);
> -	i2c_dw_enable(i2c);
>  	return 0;
>  }
>  


-- 
Jean Delvare
