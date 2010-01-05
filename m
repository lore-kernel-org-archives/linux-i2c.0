From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: test off by one in {piix4,vt596}_transaction()
Date: Tue, 5 Jan 2010 17:55:11 +0100
Message-ID: <20100105175511.39dc6c42@hyperion.delvare>
References: <4B3773F2.3010703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B3773F2.3010703-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 27 Dec 2009 15:49:22 +0100, Roel Kluin wrote:
> With `while (timeout++ < MAX_TIMEOUT)' timeout reaches MAX_TIMEOUT + 1 after the loop
> This is probably unlikely to produce a problem.
> 
> Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-piix4.c  |    2 +-
>  drivers/i2c/busses/i2c-viapro.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 1e245e9..d8e0df0 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -329,7 +329,7 @@ static int piix4_transaction(void)
>  		msleep(1);
>  
>  	/* If the SMBus is still busy, we give up */
> -	if (timeout >= MAX_TIMEOUT) {
> +	if (timeout > MAX_TIMEOUT) {
>  		dev_err(&piix4_adapter.dev, "SMBus Timeout!\n");
>  		result = -ETIMEDOUT;
>  	}
> diff --git a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
> index e4b1543..8a2e0d5 100644
> --- a/drivers/i2c/busses/i2c-viapro.c
> +++ b/drivers/i2c/busses/i2c-viapro.c
> @@ -168,7 +168,7 @@ static int vt596_transaction(u8 size)
>  	} while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));
>  
>  	/* If the SMBus is still busy, we give up */
> -	if (timeout >= MAX_TIMEOUT) {
> +	if (timeout > MAX_TIMEOUT) {
>  		result = -ETIMEDOUT;
>  		dev_err(&vt596_adapter.dev, "SMBus timeout!\n");
>  	}

That's right... but I'd rather change the loops to use "++timeout" and
leave the conditions as is (or maybe change it to "=="). I think it's
easier to read that way. Would that be OK with you?

-- 
Jean Delvare
