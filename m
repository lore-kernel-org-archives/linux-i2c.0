From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-ali1535: fix styles issues
Date: Thu, 23 Jun 2011 18:08:42 +0200
Message-ID: <20110623180842.20241d38@endymion.delvare>
References: <4DF8D48B.80701@geomatys.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4DF8D48B.80701-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "corentin.labbe" <corentin.labbe-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Corentin,

On Wed, 15 Jun 2011 17:49:31 +0200, corentin.labbe wrote:
> Hello
> 
> This is a fix-style patch for i2c-ali1535. (issue reported by checkpatch.pl)
> 
> Signed-off-by: LABBE Corentin <corentin.labbe-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>
> 
> --- linux/drivers/i2c/busses/i2c-ali1535.c.orig	2011-06-15 16:31:33.000000000 +0200
> +++ linux/drivers/i2c/busses/i2c-ali1535.c	2011-06-15 17:03:12.000000000 +0200
> @@ -1,9 +1,9 @@
>  /*
> -    Copyright (c) 2000  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>,
> -                        Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>,
> -                        Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>,
> -                        Dan Eaton <dan.eaton-RtyX3GHucphnQYSypqKXDg@public.gmane.org> and
> -                        Stephen Rousset<stephen.rousset-RtyX3GHucphnQYSypqKXDg@public.gmane.org>
> +    Copyright (c) 2000  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>,
> +			Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>,
> +			Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>,
> +			Dan Eaton <dan.eaton-RtyX3GHucphnQYSypqKXDg@public.gmane.org> and
> +			Stephen Rousset<stephen.rousset-RtyX3GHucphnQYSypqKXDg@public.gmane.org>
> 
>      This program is free software; you can redistribute it and/or modify
>      it under the terms of the GNU General Public License as published by

Your mailer stripped the trailing white-space from the original code,
causing the patch to not apply.

While you're fixing this comment, please convert it to the standard
multi-line style:

/*
 * blah
 * blah
 */

In fact the wrong format is what causes checkpatch.pl to complain: it
doesn't realize it is dealing with comments and not code.

Please also restore the missing space after "Rousset".

> @@ -254,8 +254,8 @@ static int ali1535_transaction(struct i2
>  	if (temp & (ALI1535_STS_ERR | ALI1535_STS_BUSY)) {
>  		/* do a clear-on-write */
>  		outb_p(0xFF, SMBHSTSTS);
> -		if ((temp = inb_p(SMBHSTSTS)) &
> -		    (ALI1535_STS_ERR | ALI1535_STS_BUSY)) {
> +		temp = inb_p(SMBHSTSTS);
> +		if (temp & (ALI1535_STS_ERR | ALI1535_STS_BUSY)) {
>  			/* This is probably going to be correctable only by a
>  			 * power reset as one of the bits now appears to be
>  			 * stuck */
> @@ -267,9 +267,8 @@ static int ali1535_transaction(struct i2
>  		}
>  	} else {
>  		/* check and clear done bit */
> -		if (temp & ALI1535_STS_DONE) {
> +		if (temp & ALI1535_STS_DONE)
>  			outb_p(temp, SMBHSTSTS);
> -		}
>  	}
> 
>  	/* start the transaction by writing anything to the start register */
> @@ -278,7 +277,7 @@ static int ali1535_transaction(struct i2
>  	/* We will always wait for a fraction of a second! */
>  	timeout = 0;
>  	do {
> -		msleep(1);
> +		usleep_range(800, 1200);

Very nice, I didn't know about usleep_range().

>  		temp = inb_p(SMBHSTSTS);
>  	} while (((temp & ALI1535_STS_BUSY) && !(temp & ALI1535_STS_IDLE))
>  		 && (timeout++ < MAX_TIMEOUT));
> @@ -325,12 +324,12 @@ static int ali1535_transaction(struct i2
>  	/* take consequent actions for error conditions */
>  	if (!(temp & ALI1535_STS_DONE)) {
>  		/* issue "kill" to reset host controller */
> -		outb_p(ALI1535_KILL,SMBHSTTYP);
> -		outb_p(0xFF,SMBHSTSTS);
> +		outb_p(ALI1535_KILL, SMBHSTTYP);
> +		outb_p(0xFF, SMBHSTSTS);
>  	} else if (temp & ALI1535_STS_ERR) {
>  		/* issue "timeout" to reset all devices on bus */
> -		outb_p(ALI1535_T_OUT,SMBHSTTYP);
> -		outb_p(0xFF,SMBHSTSTS);
> +		outb_p(ALI1535_T_OUT, SMBHSTTYP);
> +		outb_p(0xFF, SMBHSTSTS);
>  	}
> 
>  	return result;
> @@ -351,7 +350,7 @@ static s32 ali1535_access(struct i2c_ada
>  	for (timeout = 0;
>  	     (timeout < MAX_TIMEOUT) && !(temp & ALI1535_STS_IDLE);
>  	     timeout++) {
> -		msleep(1);
> +		usleep_range(800, 1200);
>  		temp = inb_p(SMBHSTSTS);
>  	}
>  	if (timeout >= MAX_TIMEOUT)
> @@ -480,12 +479,12 @@ static struct i2c_adapter ali1535_adapte
>  	.algo		= &smbus_algorithm,
>  };
> 
> -static const struct pci_device_id ali1535_ids[] = {
> +static DEFINE_PCI_DEVICE_TABLE(ali1535_ids) = {

I'm not particularly fond of that one, but it even checkpatch.pl says
so...

>  	{ PCI_DEVICE(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101) },
>  	{ },
>  };
> 
> -MODULE_DEVICE_TABLE (pci, ali1535_ids);
> +MODULE_DEVICE_TABLE(pci, ali1535_ids);
> 
>  static int __devinit ali1535_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {

All other changes look good. Please resend with the first part updated.

-- 
Jean Delvare
