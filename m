From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: core: ACPI: Properly set status byte to 0 for
 multi-byte writes
Date: Sat, 11 Aug 2018 15:11:03 +0200
Message-ID: <20180811070321.GA2180@kunai>
References: <20180810122714.690-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180810122714.690-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Hans,

thanks for fixing this!

On Fri, Aug 10, 2018 at 02:27:14PM +0200, Hans de Goede wrote:
> acpi_gsb_i2c_write_bytes() returns i2c_transfer()'s return value, which
> is the number of transfers executed on success, so 1.
> 
> The ACPI code expects us to store 0 in gsb->status for success, not 1.
> 
> Specifically this breaks the following code in the Thinkpad 8 DSDT:
> 
>             ECWR = I2CW = ECWR /* \_SB_.I2C1.BAT0.ECWR */
>             If ((ECST == Zero))
>             {
>                 ECRD = I2CR /* \_SB_.I2C1.I2CR */
>             }
> 
> Before this commit we set ECST to 1, causing the read to never happen
> breaking battery monitoring on the Thinkpad 8. Note the Thinkpad 8 also
> has some unrelated issues where i2c transfers are unreliable.
> 
> This commit sets status to 0 if it was bigger then 0 (so success),
> mirroring the multi-byte read path, fixing this.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/i2c/i2c-core-acpi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 7c3b4740b94b..10ad851bd277 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -595,6 +595,8 @@ i2c_acpi_space_handler(u32 function, acpi_physical_address command,
>  		} else {
>  			status = acpi_gsb_i2c_write_bytes(client, command,
>  					gsb->data, info->access_length);
> +			if (status > 0)
> +				status = 0;

I think we should fix the function we are calling (and the read
function, too). It doesn't make much sense to return the number of
successful messages when the paramters of the function deal with bytes,
not messages. Otherwise we probably will have the bug somewhere else
again.

We should also return 0 only iff all messages were sent, otherwise -EIO
or something.

Makes sense?

Regards,

   Wolfram
