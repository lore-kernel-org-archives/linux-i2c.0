From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/1] drivers/i2c/busses/scx200_acb.c: Fix section
 mismatch warning in scx200_pci_drv
Date: Thu, 1 Sep 2011 14:19:44 +0200
Message-ID: <20110901141944.4f7ce096@endymion.delvare>
References: <1314870029-28541-1-git-send-email-harvey.huawei.yang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1314870029-28541-1-git-send-email-harvey.huawei.yang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Harvey Yang <harvey.huawei.yang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Harvey,

Please send i2c-related patches to the i2c list rather than LKML.

On Thu,  1 Sep 2011 17:40:29 +0800, Harvey Yang wrote:
> WARNING: drivers/i2c/busses/built-in.o(.data+0x47c8): Section mismatch in reference from the variable scx200_pci_drv to the function .devinit.text:scx200_probe()
> The variable scx200_pci_drv references
> the function __devinit scx200_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> Signed-off-by: Harvey Yang <harvey.huawei.yang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/scx200_acb.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
> index 986e5f6..91e349c 100644
> --- a/drivers/i2c/busses/scx200_acb.c
> +++ b/drivers/i2c/busses/scx200_acb.c
> @@ -550,7 +550,7 @@ static int __devexit scx200_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static struct platform_driver scx200_pci_drv = {
> +static struct platform_driver scx200_pci_driver = {
>  	.driver = {
>  		.name = "cs5535-smb",
>  		.owner = THIS_MODULE,
> @@ -593,14 +593,14 @@ static int __init scx200_acb_init(void)
>  		return 0;
>  
>  	/* No ISA devices; register the platform driver for PCI-based devices */
> -	return platform_driver_register(&scx200_pci_drv);
> +	return platform_driver_register(&scx200_pci_driver);
>  }
>  
>  static void __exit scx200_acb_cleanup(void)
>  {
>  	struct scx200_acb_iface *iface;
>  
> -	platform_driver_unregister(&scx200_pci_drv);
> +	platform_driver_unregister(&scx200_pci_driver);
>  
>  	mutex_lock(&scx200_acb_list_mutex);
>  	while ((iface = scx200_acb_list) != NULL) {

Applied, thanks.

-- 
Jean Delvare
