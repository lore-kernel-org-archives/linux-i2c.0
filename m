From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [2.6 patch] i2c/busses/scx200_acb.c: don't use 0 as NULL
 pointer
Date: Mon, 31 Mar 2008 10:51:54 +0200
Message-ID: <20080331105154.0a38ebf7@hyperion.delvare>
References: <20080330232228.GR28445@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755637AbYCaIwe@vger.kernel.org>
In-Reply-To: <20080330232228.GR28445@cs181133002.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 31 Mar 2008 02:22:28 +0300, Adrian Bunk wrote:
> Don't use 0 as NULL pointer.
> 
> Spotted by sparse.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> 4a2495930cc9bc83f4302de3b73ebf3e8849dc1a diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
> index f5e7a70..61abe0f 100644
> --- a/drivers/i2c/busses/scx200_acb.c
> +++ b/drivers/i2c/busses/scx200_acb.c
> @@ -527,7 +527,7 @@ static int __init scx200_create_isa(const char *text, unsigned long base,
>  	if (iface == NULL)
>  		return -ENOMEM;
>  
> -	if (request_region(base, 8, iface->adapter.name) == 0) {
> +	if (!request_region(base, 8, iface->adapter.name)) {
>  		printk(KERN_ERR NAME ": can't allocate io 0x%lx-0x%lx\n",
>  		       base, base + 8 - 1);
>  		rc = -EBUSY;
> 

Applied, thanks.

-- 
Jean Delvare
