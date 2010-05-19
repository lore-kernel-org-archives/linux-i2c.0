From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-nforce2: Remove redundant error messages on ACPI
 conflict
Date: Wed, 19 May 2010 22:31:00 +0200
Message-ID: <20100519223100.1634e789@hyperion.delvare>
References: <1274127379-5433-1-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1274127379-5433-1-git-send-email-chase.douglas-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chase Douglas <chase.douglas-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Chase,

On Mon, 17 May 2010 16:16:19 -0400, Chase Douglas wrote:
> The ACPI subsystem strictly checks for resource conflicts. When there's
> a conflict, it outputs a warning message with all the details needed to
> properly diagnose the underlying issue. However, the i2c-nforce2 driver
> also prints its own message. Not only is the message redundant, it is at
> the KERN_ERR level, which overrides some bootsplash screens for no good
> reason. This change removes the two lines that print out the error
> messages.
> 
> Signed-off-by: Chase Douglas <chase.douglas-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-nforce2.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
> index 4a48dd4..2da9a23 100644
> --- a/drivers/i2c/busses/i2c-nforce2.c
> +++ b/drivers/i2c/busses/i2c-nforce2.c
> @@ -405,7 +405,6 @@ static int __devinit nforce2_probe(struct pci_dev *dev, const struct pci_device_
>  	/* SMBus adapter 1 */
>  	res1 = nforce2_probe_smb(dev, 4, NFORCE_PCI_SMB1, &smbuses[0], "SMB1");
>  	if (res1 < 0) {
> -		dev_err(&dev->dev, "Error probing SMB1.\n");
>  		smbuses[0].base = 0;	/* to have a check value */
>  	}
>  	/* SMBus adapter 2 */
> @@ -417,7 +416,6 @@ static int __devinit nforce2_probe(struct pci_dev *dev, const struct pci_device_
>  		res2 = nforce2_probe_smb(dev, 5, NFORCE_PCI_SMB2, &smbuses[1],
>  					 "SMB2");
>  		if (res2 < 0) {
> -			dev_err(&dev->dev, "Error probing SMB2.\n");
>  			smbuses[1].base = 0;	/* to have a check value */
>  		}
>  	}

I agree that these messages are essentially redundant, as
nforce2_probe_smb() never fails without printing an message. Patch
applied, thanks.

-- 
Jean Delvare
