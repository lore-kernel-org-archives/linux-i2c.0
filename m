From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v3] i2c: piix4: Avoid race conditions with IMC
Date: Tue, 31 Jan 2017 14:55:56 +0100
Message-ID: <20170131145556.71202452@endymion>
References: <20170112194946.13925-1-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33499 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752072AbdAaN4u (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Jan 2017 08:56:50 -0500
In-Reply-To: <20170112194946.13925-1-ricardo.ribalda@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel

Hi all,

On Thu, 12 Jan 2017 20:49:46 +0100, Ricardo Ribalda Delgado wrote:
> From: Ricardo Ribalda <ricardo.ribalda@gmail.com>
> 
> On AMD's SB800 and upwards, the SMBus is shared with the Integrated
> Micro Controller (IMC).
> 
> The platform provides a hardware semaphore to avoid race conditions
> among them. (Check page 288 of the SB800-Series Southbridges Register
> Reference Guide http://support.amd.com/TechDocs/45482.pdf)
> 
> Without this patch, many access to the SMBus end with an invalid
> transaction or even with the bus stalled.
> 
> Reported-by: Alexandre Desnoyers <alex@qtec.com>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> v3: Suggestions by Andy Shevchenko <andy.shevchenko@gmail.com> and
> Wolfram Sang <wsa@the-dreams.de>:
>  -Use Reported-by instead of Credit-to
> 
> v2: Suggestions by Andy Shevchenko <andy.shevchenko@gmail.com>:
>  -Rename timeout to retries
>  -Use do {} while(--retries) pattern
>  -Group new variables
> 
>  drivers/i2c/busses/i2c-piix4.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index c2268cdf38e8..e34d82e79b98 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -585,10 +585,29 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
>  		 u8 command, int size, union i2c_smbus_data *data)
>  {
>  	struct i2c_piix4_adapdata *adapdata = i2c_get_adapdata(adap);
> +	unsigned short piix4_smba = adapdata->smba;
> +	int retries = MAX_TIMEOUT;
> +	int smbslvcnt;
>  	u8 smba_en_lo;
>  	u8 port;
>  	int retval;
>  
> +	/* Request the SMBUS semaphore, avoid conflicts with the IMC */
> +	smbslvcnt  = inb_p(SMBSLVCNT);
> +	do {
> +		outb_p(smbslvcnt | 0x10, SMBSLVCNT);
> +
> +		/* Check the semaphore status */
> +		smbslvcnt  = inb_p(SMBSLVCNT);
> +		if (smbslvcnt & 0x10)
> +			break;
> +
> +		usleep_range(1000, 2000);
> +	} while (--retries);
> +	/* SMBus is still owned by the IMC, we give up */
> +	if (!retries)
> +		return -EBUSY;
> +
>  	mutex_lock(&piix4_mutex_sb800);

Sorry for being late to the party but... Shouldn't the IMC semaphore
check be done with piix4_mutex_sb800 held? If we do it before taking
piix4_mutex_sb800, as done above, several SMBus users could try to
write to and read from SMBSLVCNT at the same time. That doesn't look
safe to me. I can imagine that one (starting) SMBus transaction would
try to gain the IMC semaphore above...

>  
>  	outb_p(piix4_port_sel_sb800, SB800_PIIX4_SMB_IDX);
> @@ -606,6 +625,9 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
>  
>  	mutex_unlock(&piix4_mutex_sb800);
>  
> +	/* Release the semaphore */
> +	outb_p(smbslvcnt | 0x20, SMBSLVCNT);
> +

... while another (finishing) SMBus transaction is releasing it. At
which point we may end up using the SMBus while we do not own the IMC
semaphore.

And things could get even worse if SMBSLVCNT is ever used somewhere
else in the driver.

>  	return retval;
>  }
>  


-- 
Jean Delvare
SUSE L3 Support
