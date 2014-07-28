From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] i2c: piix4: Continue probing for auxiliary SMBus
 without main
Date: Mon, 28 Jul 2014 14:22:09 +0200
Message-ID: <20140728142209.69246fcc@endymion.delvare>
References: <20140712000607.GA25787@turkey.danweeks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140712000607.GA25787-gS7JvH28tD4DdhJ/W92+Z9HuzzzSOjJt@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Daniel M. Weeks" <dan-ZKupHW+dzKzk1uMJSBkQmQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Daniel,

On Fri, 11 Jul 2014 20:06:15 -0400, Daniel M. Weeks wrote:
> Some BIOS may only allow access to the AMD auxiliary SMBus - reserving
> the main SMBus for system functions only. Probing should continue even
> if the main bus is not available so at least the auxiliary can be added.
> 
> Signed-off-by: Daniel M. Weeks <dan-ZKupHW+dzKzk1uMJSBkQmQ@public.gmane.org>
> ---
> This patch may warrant some discussion. I ran across this problem on an
> AMD Hudson board where the main SMBus is hard-wired for debugging but
> the auxiliary bus is exposed for expansion. Either purposefully or
> because the BIOS is a little broken, loading this module used to result
> in an ACPI conflict for the main bus and neither was usable. With the
> patch I'm able to use the auxiliary bus regardless of the conflict on
> the main bus. I'm not 100% convinced it's the correct fix - someone with
> more ACPI experience than me is going to need to review this.

This is fine. The auxiliary bus setup code has its own ACPI resource
conflict check, so it is safe to let the driver bind to the auxiliary
bus even if the main bus is skipped.

> 
> drivers/i2c/busses/i2c-piix4.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index a6f54ba..d4bac64 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -628,14 +628,16 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	else
>  		retval = piix4_setup(dev, id);
>  
> -	/* If no main SMBus found, give up */
> -	if (retval < 0)
> -		return retval;
> -
> -	/* Try to register main SMBus adapter, give up if we can't */
> -	retval = piix4_add_adapter(dev, retval, &piix4_main_adapter);
> -	if (retval < 0)
> -		return retval;
> +	/* If no main SMBus found, do not give up
> +	 * some BIOS purposely only expose aux bus */
> +	if (retval < 0) {
> +		dev_info(&dev->dev, "No main SMBus; checking auxiliary\n");

Not sure if this message is really needed, as both parts already print
relevant message in both success and failure cases.

> +	} else {
> +		/* Try to register main SMBus adapter, give up if we can't */
> +		retval = piix4_add_adapter(dev, retval, &piix4_main_adapter);
> +		if (retval < 0)
> +			return retval;
> +	}
>  
>  	/* Check for auxiliary SMBus on some AMD chipsets */
>  	retval = -ENODEV;

I'm mostly fine with the change above, but it is insufficient in one
corner case: if both the main bus and the aux bus probing fails. The
code does currently not consider both buses equal, in that it never
returns an error if the aux bus probing fails. The return value only
stands for the status of the main bus. With your change, if both buses
fail to register, the piix4_probe function may still returns 0
(success.)

Your proposed change somehow makes the aux bus an equal of the main
bus. The probe function should return 0 if either bus was successfully
registered. It should still return an error if both fail to register.
Unfortunately we can't report both error codes to the caller. For
historical reasons I believe we should return the error code for the
main bus in that case, which means you have to store it in the middle
of the function for it to be available at the end of the function.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
