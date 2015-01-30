From: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c/mpc: Fix ISR return value
Date: Fri, 30 Jan 2015 03:17:37 -0800
Message-ID: <CAAVjN7fQ4RLgsk1R_DPrFm21OBWpsBdxMuDyQauiz3pxCgK+Lw@mail.gmail.com>
References: <BL2PR03MB449C87445D2FD1F15E9D33483310@BL2PR03MB449.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BL2PR03MB449C87445D2FD1F15E9D33483310-AZ66ij2kwaaRkNCTDI+ukOO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I have been using the driver with this modification for the past 6
months and it has been stable in an industrial environment.I had made
a few other changes that also improve reliability (using ppc in_8 and
out_8 and eieio barriers to ensure in-order execution. This lets you
remove the unneeded double read of the status register. I also added a
more robust recovery function to handle force of bus master-ship, and
clearing the arb lost interrupt that is generated. currently this can
cause the isr to trigger and cause superfluous interrupts. I have not
posted this patch because of the extensive changes,

I will ack this patch.

On Fri, Jan 30, 2015 at 2:24 AM, Amit Tomar <Amit.Tomar-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> ISR should not return IRQ_HANDLED for not handling anything.
> This patch fixes the return value of ISR for the same case.
>
>
> Signed-off-by: Amit Singh Tomar <amit.tomar-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> drivers/i2c/busses/i2c-mpc.c |    3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c index 0edf630..7a3136f 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -95,8 +95,9 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
>         i2c->interrupt = readb(i2c->base + MPC_I2C_SR);
>         writeb(0, i2c->base + MPC_I2C_SR);
>         wake_up(&i2c->queue);
> +       return IRQ_HANDLED;
>     }
> -  return IRQ_HANDLED;
> +  return IRQ_NONE;
> }
>
> /* Sometimes 9th clock pulse isn't generated, and slave doesn't release
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
- Danielle Costantino
