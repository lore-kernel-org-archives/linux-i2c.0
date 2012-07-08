From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 8/8 v3] i2c: i801: enable irq for byte_by_byte
 transactions
Date: Sun, 8 Jul 2012 13:53:37 +0200
Message-ID: <20120708135337.4fb879b2@endymion.delvare>
References: <1340805255-8041-1-git-send-email-djkurtz@chromium.org>
	<1340805255-8041-9-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340805255-8041-9-git-send-email-djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

One more note...

On Wed, 27 Jun 2012 21:54:15 +0800, Daniel Kurtz wrote:
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> (...)
> +static void i801_isr_byte_done(struct i801_priv *priv)
> +{
> +	/* For SMBus block reads, length is first byte read */
> +	if (priv->is_read && ((priv->cmd & 0x1c) == I801_BLOCK_DATA) &&
> +	    (priv->count == 0)) {
> +		priv->len = inb_p(SMBHSTDAT0(priv));
> +		if (priv->len < 1 || priv->len > I2C_SMBUS_BLOCK_MAX) {
> +			dev_err(&priv->pci_dev->dev,
> +				"Illegal SMBus block read size %d\n",
> +				priv->len);
> +			/* FIXME: Recover */
> +			priv->len = I2C_SMBUS_BLOCK_MAX;
> +		} else {
> +			dev_dbg(&priv->pci_dev->dev,
> +				"SMBus block read size is %d\n",
> +				priv->len);
> +		}
> +		priv->data[-1] = priv->len;
> +	} else if (priv->is_read) {
> +		priv->data[priv->count++] = inb(SMBBLKDAT(priv));
> +		/* Set LAST_BYTE for last byte of read transaction */
> +		if (priv->count == priv->len - 1)
> +			priv->cmd |= SMBHSTCNT_LAST_BYTE;
> +		outb_p(priv->cmd, SMBHSTCNT(priv));

This register write doesn't seem to be needed, except when
SMBHSTCNT_LAST_BYTE must be added.

> +	} else if (priv->count < priv->len - 1) {
> +		/* Write next byte, except for IRQ after last byte */
> +		outb_p(priv->data[++priv->count], SMBBLKDAT(priv));
> +		outb_p(priv->cmd, SMBHSTCNT(priv));

Same here. I know we do write to SMBHSTCNT after for every byte in
i801_block_transaction_byte_by_byte(), that must be the reason why you
did it in the interrupt path too, but I don't know why we did that and
I don't think we actually had to.

-- 
Jean Delvare
