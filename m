From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 4/8 v3] i2c: i801: check and return errors during
 byte-by-byte transfers
Date: Wed, 27 Jun 2012 18:51:36 +0200
Message-ID: <20120627185136.315e6625@endymion.delvare>
References: <1340805255-8041-1-git-send-email-djkurtz@chromium.org>
	<1340805255-8041-5-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340805255-8041-5-git-send-email-djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 27 Jun 2012 21:54:11 +0800, Daniel Kurtz wrote:
> If an error is detected in the polling loop, abort the transaction and
> return an error code.
> 
>  * DEV_ERR is set if the device does not respond with an acknowledge, and
> the SMBus controller times out (minimum 25ms).
>  * BUS_ERR is set if a bus arbitration collision is detected.  In other
> words, when the SMBus controller tries to generate a START condition, but
> detects that the SMBDATA is being held low, usually by another SMBus/I2C
> master.
>  * FAILED is only set if a the transaction is set by software (using the
> SMBHSTCNT KILL bit).

Not quite sure what you mean with "set by software". Other than this,
patch looks good, applied, thanks.

> 
> Signed-off-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-i801.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 6a53338..ba56b74 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -131,9 +131,11 @@
>  #define SMBHSTSTS_INTR		0x02
>  #define SMBHSTSTS_HOST_BUSY	0x01
>  
> -#define STATUS_FLAGS		(SMBHSTSTS_BYTE_DONE | SMBHSTSTS_FAILED | \
> -				 SMBHSTSTS_BUS_ERR | SMBHSTSTS_DEV_ERR | \
> -				 SMBHSTSTS_INTR)
> +#define STATUS_ERROR_FLAGS	(SMBHSTSTS_FAILED | SMBHSTSTS_BUS_ERR | \
> +				 SMBHSTSTS_DEV_ERR)
> +
> +#define STATUS_FLAGS		(SMBHSTSTS_BYTE_DONE | SMBHSTSTS_INTR | \
> +				 STATUS_ERROR_FLAGS)
>  
>  /* Older devices have their ID defined in <linux/pci_ids.h> */
>  #define PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS	0x1c22
> @@ -385,7 +387,7 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
>  		do {
>  			usleep_range(250, 500);
>  			status = inb_p(SMBHSTSTS(priv));
> -		} while ((!(status & SMBHSTSTS_BYTE_DONE))
> +		} while (!(status & (SMBHSTSTS_BYTE_DONE | STATUS_ERROR_FLAGS))
>  			 && (timeout++ < MAX_RETRIES));
>  
>  		result = i801_check_post(priv, status, timeout > MAX_RETRIES);


-- 
Jean Delvare
