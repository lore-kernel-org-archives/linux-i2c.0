From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/8 v3] i2c: i801: check INTR after every transaction
Date: Wed, 27 Jun 2012 18:07:24 +0200
Message-ID: <20120627180724.762f854a@endymion.delvare>
References: <1340805255-8041-1-git-send-email-djkurtz@chromium.org>
	<1340805255-8041-4-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340805255-8041-4-git-send-email-djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 27 Jun 2012 21:54:10 +0800, Daniel Kurtz wrote:
> Per ICH10 datasheet [1] pg. 711, after completing a block transaction,
> INTR should be checked & cleared separately, only after BYTE_DONE is
> first cleared:
> 
>   When the last byte of a block message is received, the host controller
> sets DS. However, it does not set the INTR bit (and generate another
> interrupt) until DS is cleared. Thus, for a block message of n bytes,
> the ICH10 will generate n+1 interrupts.
> 
> [1] http://www.intel.com/content/dam/doc/datasheet/io-controller-hub-10-family-datasheet.pdf
> 
> Currently, the INTR bit was only checked & cleared separately if the PEC
> was used.
> This patch checks and clears INTR at the very end of every successful
> transaction, regardless of whether the PEC is used.
> 
> Signed-off-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-i801.c |   46 ++++++++++++++++++++--------------------
>  1 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 8b74e1e..6a53338 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -257,6 +257,24 @@ static int i801_check_post(struct i801_priv *priv, int status, int timeout)
>  	return result;
>  }
>  
> +/* wait for INTR bit as advised by Intel */
> +static void i801_wait_intr(struct i801_priv *priv)
> +{
> +	int timeout = 0;
> +	int status;
> +
> +	status = inb_p(SMBHSTSTS(priv));
> +	while ((!(status & SMBHSTSTS_INTR)) && (timeout++ < MAX_RETRIES)) {
> +		usleep_range(250, 500);
> +		status = inb_p(SMBHSTSTS(priv));
> +	}

Per my comment on previous patch, I've swapped the logic here to be in
line with what we had before. I have no objection to trying this change
again, but later, and only if you have actual numbers to back it up.

> +
> +	if (timeout > MAX_RETRIES)
> +		dev_dbg(&priv->pci_dev->dev, "INTR Timeout!\n");
> +
> +	outb_p(status, SMBHSTSTS(priv));

Wouldn't it be more correct to only write the INTR bit? Writing back
the whole 8 bits frightens me a little especially because of bit
INUSE_STS. If we ever want to support this feature, I think we have to
first ban writing back the whole status to register HST_STS. And this
is the only place where we still do AFAICS.

(This isn't a regression from your patch, the old code was already
doing that, but it might be the opportunity to fix it.)

-- 
Jean Delvare
