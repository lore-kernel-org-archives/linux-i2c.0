From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] i2c-rcar: fix MNR interrupt handling
Date: Tue, 02 Sep 2014 22:29:06 +0400
Message-ID: <54060C72.3010309@cogentembedded.com>
References: <1843756.qQiZLxsyqD@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1843756.qQiZLxsyqD-gHKXc3Y1Z8zGSmamagVegGFoWSdPRAKMAL8bYrjMMd8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 09/02/2014 01:15 AM, Sergei Shtylyov wrote:

> Sometimes the MNR and MST interrupts happen simultaneously  (stop  automatically
> follows NACK, according to the manuals) and in such case the ID_NACK flag  isn't
> set since the MST interrupt handling precedes MNR and all interrupts are cleared
> and disabled then, so that MNR interrupt is never noticed -- this causes NACK'ed
> transfers to be falsely reported as successful. Exchanging MNR and  MST handlers
> fixes this issue, however the MNR bit  somehow  gets set again even after  being
> explicitly cleared, so I decided to completely suppress handling of all disabled
> interrupts (which is a good thing anyway)...

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

> ---
> The patch is against Wolfram Sang's 'linux.git' repo.

>   drivers/i2c/busses/i2c-rcar.c |   15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
>
> Index: linux/drivers/i2c/busses/i2c-rcar.c
> ===================================================================
> --- linux.orig/drivers/i2c/busses/i2c-rcar.c
> +++ linux/drivers/i2c/busses/i2c-rcar.c
> @@ -367,18 +367,15 @@ static irqreturn_t rcar_i2c_irq(int irq,
>
>   	msr = rcar_i2c_read(priv, ICMSR);
>
> +	/* Only handle interrupts that are currently enabled */
> +	msr &= rcar_i2c_read(priv, ICMIER);
> +

    I think it makes sense to check 'msr' for 0 and return IRQ_NONE in this 
case. Would you apply such patch (probably to the -next branch)?

WBR, Sergei
