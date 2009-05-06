From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2.6.29.2] PXA I2C: Define log level for i2c PXA error
 report
Date: Wed, 6 May 2009 10:22:02 +0200
Message-ID: <20090506102202.73d6045d@hyperion.delvare>
References: <Pine.LNX.4.64.0905060829580.24668@venus.araneidae.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0905060829580.24668-EMtNTEpPrk39UE2ag0LVtCp2UmYkHbXO@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Abbott <michael-W/Bzo8D1sxa8qtKVGud/9w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 6 May 2009 08:32:09 +0100 (BST), Michael Abbott wrote:
> All the i2c pxa error messages should probably be KERN_DEBUG
> 
> At least, all the printk messages should have a log level specfied,
> and KERN_DEBUG seems appropriate.
> 
> Signed-off-by: Michael Abbott <michael.abbott-l+PWtdWbHAs2EctHIo1CcQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-pxa.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index bdb1f75..8cb9160 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -210,11 +210,11 @@ static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id);
>  static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
>  {
>  	unsigned int i;
> -	printk("i2c: error: %s\n", why);
> -	printk("i2c: msg_num: %d msg_idx: %d msg_ptr: %d\n",
> +	printk(KERN_DEBUG "i2c: error: %s\n", why);
> +	printk(KERN_DEBUG "i2c: msg_num: %d msg_idx: %d msg_ptr: %d\n",
>  		i2c->msg_num, i2c->msg_idx, i2c->msg_ptr);
> -	printk("i2c: ICR: %08x ISR: %08x\n"
> -	       "i2c: log: ", readl(_ICR(i2c)), readl(_ISR(i2c)));
> +	printk(KERN_DEBUG "i2c: ICR: %08x ISR: %08x\n"
> +	       KERN_DEBUG "i2c: log: ", readl(_ICR(i2c)), readl(_ISR(i2c)));
>  	for (i = 0; i < i2c->irqlogidx; i++)
>  		printk("[%08x:%08x] ", i2c->isrlog[i], i2c->icrlog[i]);
>  	printk("\n");

Already fixed in Linus' tree:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=154d22b04ae1741c5fcfd5d747b813a9a279abff#patch4

-- 
Jean Delvare
