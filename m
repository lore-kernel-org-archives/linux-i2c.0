From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Clear only status bits in HST_STS after
 waiting for INTR
Date: Thu, 28 Jun 2012 14:51:59 +0200
Message-ID: <20120628145159.3725395b@endymion.delvare>
References: <1340873970-19226-1-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340873970-19226-1-git-send-email-djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 28 Jun 2012 16:59:30 +0800, Daniel Kurtz wrote:
> Writing back the whole status register could clear unwanted bits.
> In particular, it could clear the "INUSE_STS" bit, which is a
> 'hardware semaphore', that might be useful to use some day.
> To prepare for this, let's ban writing back the whole status to register
> HST_STS, of which this is the only instance.
> 
> Signed-off-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Reported-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-i801.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index ae2945a..7443990 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -301,7 +301,7 @@ static void i801_wait_hwpec(struct i801_priv *priv)
>  	if (timeout > MAX_RETRIES)
>  		dev_dbg(&priv->pci_dev->dev, "PEC Timeout!\n");
>  
> -	outb_p(status, SMBHSTSTS(priv));
> +	outb_p(status & STATUS_FLAGS, SMBHSTSTS(priv));
>  }
>  
>  static int i801_block_transaction_by_block(struct i801_priv *priv,

Applied, thanks.

-- 
Jean Delvare
