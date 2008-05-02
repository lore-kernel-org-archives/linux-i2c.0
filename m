From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-piix4-inc-delay-after-starting-transaction
Date: Fri, 2 May 2008 22:05:28 +0200
Message-ID: <20080502220528.65c07727@hyperion.delvare>
References: <20080429170053.GA16863@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080429170053.GA16863-MyKPER+WmwNgWwbpmQC+TKfLeoKvNuZc@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Milburn <dmilburn-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Tue, 29 Apr 2008 12:00:53 -0500, David Milburn wrote:
> Per the PIIX4 errata, there maybe a delay between setting the
> start bit in the Smbus Host Controller Register and the transaction
> actually starting. If the driver doesn't delay long enough, it
> may appear that the transaction is complete when actually it
> hasn't started, this may lead to bus collisions.

The driver was already waiting at least 1 ms before checking the busy
bit. I don't see any value mentioned in the PIIX4 specification update,
so what makes you think that 2 ms is required? And what makes you think
it's sufficient?

I've never seen any problem with the i2c-piix4 driver on my PIIX4,
while I tested it hard at HZ=1000. On which chip did you hit the
problem? On what machine? Which transaction? How frequently? And how
did you notice? Details please.

> 
> Signed-off-by: David Milburn <dmilburn-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/ata/libata-core.c      |    0 
>  drivers/i2c/busses/i2c-piix4.c |    2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 9bbe96c..84a70ac 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -232,7 +232,7 @@ static int piix4_transaction(void)
>  
>  	/* We will always wait for a fraction of a second! (See PIIX4 docs errata) */
>  	do {
> -		msleep(1);
> +		msleep(2);
>  		temp = inb_p(SMBHSTSTS);
>  	} while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));
>  

This is not only increasing the delay before checking the busy bit
right after starting a transaction. This also slows down the polling
loop. And this also has the side effect of doubling the timeout - not
really your fault, count-based timeouts are broken by design.

I am additionally worried that you are changing this for all devices,
while presumably only the PIIX4 (and maybe the 82443MX? not sure) are
affected. If seems unfair to slow down the more recent devices.

I'd like you to update your patch to only change the initial wait time
and not the polling loop interval. It should be fairly easy. I also
would like you to make this change device-dependent, so that newer
devices aren't slowed down.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
