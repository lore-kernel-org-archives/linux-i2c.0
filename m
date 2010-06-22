From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] i2c/mips: Fix error return codes from Sibyte i2c bus
 driver
Date: Tue, 22 Jun 2010 20:10:03 +0200
Message-ID: <20100622201003.23318b09@hyperion.delvare>
References: <1277215748-31510-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1277215748-31510-1-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Guenter,

On Tue, 22 Jun 2010 07:09:08 -0700, Guenter Roeck wrote:
> Sibyte i2c bus driver returns non-descriptive error values.
> Update to return error values as defined in Documentation/i2c/fault-codes.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
> ---
> v2: Return -ENXIO for missing ACK and -EIO for other errors
> ---
>  drivers/i2c/busses/i2c-sibyte.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-sibyte.c b/drivers/i2c/busses/i2c-sibyte.c
> index 3d76a18..0fe505d 100644
> --- a/drivers/i2c/busses/i2c-sibyte.c
> +++ b/drivers/i2c/busses/i2c-sibyte.c
> @@ -94,7 +94,7 @@ static int smbus_xfer(struct i2c_adapter *i2c_adap, u16 addr,
>  		}
>  		break;
>  	default:
> -		return -1;      /* XXXKW better error code? */
> +		return -EOPNOTSUPP;
>  	}
>  
>  	while (csr_in32(SMB_CSR(adap, R_SMB_STATUS)) & M_SMB_BUSY)
> @@ -104,7 +104,7 @@ static int smbus_xfer(struct i2c_adapter *i2c_adap, u16 addr,
>  	if (error & M_SMB_ERROR) {
>  		/* Clear error bit by writing a 1 */
>  		csr_out32(M_SMB_ERROR, SMB_CSR(adap, R_SMB_STATUS));
> -		return -1;      /* XXXKW better error code? */
> +		return (error & M_SMB_ERROR_TYPE) ? -EIO : -ENXIO;
>  	}
>  
>  	if (data_bytes == 1)

Very nice, patch applied, thanks.

-- 
Jean Delvare
