From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: test off by one in {piix4,vt596}_transaction()
Date: Wed, 6 Jan 2010 12:14:34 +0100
Message-ID: <20100106121434.5553d1cc@hyperion.delvare>
References: <4B3773F2.3010703@gmail.com>
	<20100105175511.39dc6c42@hyperion.delvare>
	<4B43AD8F.2030809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B43AD8F.2030809-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 05 Jan 2010 22:22:23 +0100, Roel Kluin wrote:
> With `while (timeout++ < MAX_TIMEOUT)' timeout reaches MAX_TIMEOUT + 1 after the loop
> This is probably unlikely to produce a problem.
> 
> Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> > That's right... but I'd rather change the loops to use "++timeout" and
> > leave the conditions as is (or maybe change it to "=="). I think it's
> > easier to read that way. Would that be OK with you?
> 
> Ok,
> 
>  drivers/i2c/busses/i2c-piix4.c  |    4 ++--
>  drivers/i2c/busses/i2c-viapro.c |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 1e245e9..e56e4b6 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -324,12 +324,12 @@ static int piix4_transaction(void)
>  	else
>  		msleep(1);
>  
> -	while ((timeout++ < MAX_TIMEOUT) &&
> +	while ((++timeout < MAX_TIMEOUT) &&
>  	       ((temp = inb_p(SMBHSTSTS)) & 0x01))
>  		msleep(1);
>  
>  	/* If the SMBus is still busy, we give up */
> -	if (timeout >= MAX_TIMEOUT) {
> +	if (timeout == MAX_TIMEOUT) {
>  		dev_err(&piix4_adapter.dev, "SMBus Timeout!\n");
>  		result = -ETIMEDOUT;
>  	}
> diff --git a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
> index e4b1543..a84a909 100644
> --- a/drivers/i2c/busses/i2c-viapro.c
> +++ b/drivers/i2c/busses/i2c-viapro.c
> @@ -165,10 +165,10 @@ static int vt596_transaction(u8 size)
>  	do {
>  		msleep(1);
>  		temp = inb_p(SMBHSTSTS);
> -	} while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));
> +	} while ((temp & 0x01) && (++timeout < MAX_TIMEOUT));
>  
>  	/* If the SMBus is still busy, we give up */
> -	if (timeout >= MAX_TIMEOUT) {
> +	if (timeout == MAX_TIMEOUT) {
>  		result = -ETIMEDOUT;
>  		dev_err(&vt596_adapter.dev, "SMBus timeout!\n");
>  	}

Applied, thanks.

-- 
Jean Delvare
