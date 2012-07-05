From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 8/8 v3] i2c: i801: enable irq for byte_by_byte
 transactions
Date: Thu, 5 Jul 2012 16:46:32 +0200
Message-ID: <20120705164632.04f53a73@endymion.delvare>
References: <1340805255-8041-1-git-send-email-djkurtz@chromium.org>
	<1340805255-8041-9-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340805255-8041-9-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Seth Heasley <seth.heasley@intel.com>, Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Daniel,

On Wed, 27 Jun 2012 21:54:15 +0800, Daniel Kurtz wrote:
> Byte-by-byte transactions are used primarily for accessing I2C devices
> with an SMBus controller.  For these transactions, for each byte that is
> read or written, the SMBus controller generates a BYTE_DONE irq.  The isr
> reads/writes the next byte, and clears the irq flag to start the next byte.
> On the penultimate irq, the isr also sets the LAST_BYTE flag.
> 
> There is no locking around the cmd/len/count/data variables, since the
> I2C adapter lock ensures there is never multiple simultaneous transactions
> for the same device, and the driver thread never accesses these variables
> while interrupts might be occurring.
> 
> The end result is faster I2C block read and write transactions.
> 
> Note: This patch has only been tested and verified by doing I2C read and
> write block transfers on Cougar Point 6 Series PCH.

Two issues remaining:

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

The "else" is wrong. When count == 0, you receive two bytes from the
controller: the block length in SMBHSTDAT0 and the first data byte in
SMBBLKDAT. So the code flow must fall through.

> +		priv->data[priv->count++] = inb(SMBBLKDAT(priv));

This is lacking a boundary check. As I reported in an earlier review,
you shouldn't assume that the hardware will only emit the number of
interrupts you are expecting. If for any reason (crazy hardware or
driver bug) you get more interrupts than expected, you don't want to
overflow priv->data[].

> +		/* Set LAST_BYTE for last byte of read transaction */
> +		if (priv->count == priv->len - 1)
> +			priv->cmd |= SMBHSTCNT_LAST_BYTE;
> +		outb_p(priv->cmd, SMBHSTCNT(priv));
> +	} else if (priv->count < priv->len - 1) {
> +		/* Write next byte, except for IRQ after last byte */
> +		outb_p(priv->data[++priv->count], SMBBLKDAT(priv));
> +		outb_p(priv->cmd, SMBHSTCNT(priv));
> +	}
> +
> +	/* Clear BYTE_DONE to start next transaction. */
> +	outb_p(SMBHSTSTS_BYTE_DONE, SMBHSTSTS(priv));
> +}

The rest looks OK.

-- 
Jean Delvare
