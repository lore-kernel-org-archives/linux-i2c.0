From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c-taos-evm: Use module_serio_driver()
Date: Fri, 13 Jun 2014 23:23:00 +0200
Message-ID: <20140613232300.45ebf96f@endymion.delvare>
References: <1402689144-20259-1-git-send-email-christophjaeger@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402689144-20259-1-git-send-email-christophjaeger@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Jaeger <christophjaeger@linux.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 13 Jun 2014 21:52:24 +0200, Christoph Jaeger wrote:
> Get rid of some boilerplate code by using module_serio_driver().
> 
> Signed-off-by: Christoph Jaeger <christophjaeger@linux.com>
> ---
>  drivers/i2c/busses/i2c-taos-evm.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-taos-evm.c b/drivers/i2c/busses/i2c-taos-evm.c
> index 0576026..10855a0 100644
> --- a/drivers/i2c/busses/i2c-taos-evm.c
> +++ b/drivers/i2c/busses/i2c-taos-evm.c
> @@ -311,19 +311,8 @@ static struct serio_driver taos_drv = {
>  	.interrupt	= taos_interrupt,
>  };
>  
> -static int __init taos_init(void)
> -{
> -	return serio_register_driver(&taos_drv);
> -}
> -
> -static void __exit taos_exit(void)
> -{
> -	serio_unregister_driver(&taos_drv);
> -}
> +module_serio_driver(taos_drv);
>  
>  MODULE_AUTHOR("Jean Delvare <jdelvare@suse.de>");
>  MODULE_DESCRIPTION("TAOS evaluation module driver");
>  MODULE_LICENSE("GPL");
> -
> -module_init(taos_init);
> -module_exit(taos_exit);

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support
