From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-sh_mobile irq rollback fix
Date: Tue, 10 Aug 2010 15:18:28 +0200
Message-ID: <20100810151828.36a77cc3@hyperion.delvare>
References: <20100802071637.18054.76993.sendpatchset@t400s>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100802071637.18054.76993.sendpatchset@t400s>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 02 Aug 2010 16:16:37 +0900, Magnus Damm wrote:
> From: Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> 
> Update the i2c-sh_mobile driver to properly free
> interrupts. The function sh_mobile_i2c_hook_irqs()
> is fixed so module both unload and load are working
> as expected.
> 
> Signed-off-by: Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> ---
> 
>  drivers/i2c/busses/i2c-sh_mobile.c |   23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> --- 0001/drivers/i2c/busses/i2c-sh_mobile.c
> +++ work/drivers/i2c/busses/i2c-sh_mobile.c	2010-08-02 15:14:48.000000000 +0900
> @@ -538,15 +538,17 @@ static int sh_mobile_i2c_hook_irqs(struc
>  {
>  	struct resource *res;
>  	int ret = -ENXIO;
> -	int q, m;
> -	int k = 0;
> -	int n = 0;
> +	int n, k = 0;

You can't really hope to get the code right with such variable names.

-- 
Jean Delvare
