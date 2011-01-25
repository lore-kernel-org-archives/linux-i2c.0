From: Andy Walls <awalls-Xoej9cPu4Z+RGvkDC/A1pg@public.gmane.org>
Subject: Re: [PATCH 4/4] drivers/staging/lirc: Remove obsolete cleanup for
 clientdata
Date: Mon, 24 Jan 2011 19:09:02 -0500
Message-ID: <1295914142.2420.29.camel@localhost>
References: <1295865880-27672-1-git-send-email-w.sang@pengutronix.de>
	 <1295865880-27672-4-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1295865880-27672-4-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jarod Wilson <jarod-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2011-01-24 at 11:44 +0100, Wolfram Sang wrote:
> A few new i2c-drivers came into the kernel which clear the clientdata-pointer
> on exit or error. This is obsolete meanwhile, the core will do it. Simplify the
> kfree() calls after that, the pointers don't need to be checked.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
> Cc: Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Andy Walls <awalls-Xoej9cPu4Z+RGvkDC/A1pg@public.gmane.org>

Nak.

In a module where I plan to do more cleanup and add reference counting
to struct IR, IR_tx, and IR_rx objects, I'd like the explicit "NULL"s in
pointer checks to stay in for now.

Removing the explicit constant "NULL" makes searching for checks against
NULL pointers more difficult when auditing the code (No red syntax
highlighting and a /NULL search misses).

Regards,
Andy


> Cc: Jarod Wilson <jarod-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
> ---
> 
> Compile tested only.
> 
>  drivers/staging/lirc/lirc_zilog.c |   28 +++++++++-------------------
>  1 files changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/lirc/lirc_zilog.c b/drivers/staging/lirc/lirc_zilog.c
> index 3fe5f41..df1055f 100644
> --- a/drivers/staging/lirc/lirc_zilog.c
> +++ b/drivers/staging/lirc/lirc_zilog.c
> @@ -1214,15 +1214,12 @@ static int ir_remove(struct i2c_client *client)
>  
>  	/* Good-bye Rx */
>  	destroy_rx_kthread(ir->rx);
> -	if (ir->rx != NULL) {
> -		if (ir->rx->buf.fifo_initialized)
> -			lirc_buffer_free(&ir->rx->buf);
> -		i2c_set_clientdata(ir->rx->c, NULL);
> -		kfree(ir->rx);
> -	}
> +	if (ir->rx && ir->rx->buf.fifo_initialized)
> +		lirc_buffer_free(&ir->rx->buf);
> +
> +	kfree(ir->rx);
>  
>  	/* Good-bye Tx */
> -	i2c_set_clientdata(ir->tx->c, NULL);
>  	kfree(ir->tx);
>  
>  	/* Good-bye IR */
> @@ -1388,18 +1385,11 @@ out_unregister:
>  out_free_thread:
>  	destroy_rx_kthread(ir->rx);
>  out_free_xx:
> -	if (ir->rx != NULL) {
> -		if (ir->rx->buf.fifo_initialized)
> -			lirc_buffer_free(&ir->rx->buf);
> -		if (ir->rx->c != NULL)
> -			i2c_set_clientdata(ir->rx->c, NULL);
> -		kfree(ir->rx);
> -	}
> -	if (ir->tx != NULL) {
> -		if (ir->tx->c != NULL)
> -			i2c_set_clientdata(ir->tx->c, NULL);
> -		kfree(ir->tx);
> -	}
> +	if (ir->rx && ir->rx->buf.fifo_initialized)
> +		lirc_buffer_free(&ir->rx->buf);
> +
> +	kfree(ir->rx);
> +	kfree(ir->tx);
>  out_free_ir:
>  	del_ir_device(ir);
>  	kfree(ir);
