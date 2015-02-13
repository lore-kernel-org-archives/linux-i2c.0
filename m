From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCHv2 1/5] i2c: i801: Don't break user-visible strings
Date: Fri, 13 Feb 2015 11:00:02 +0100
Message-ID: <20150213110002.0823131c@endymion.delvare>
References: <1423657928-25534-1-git-send-email-jarkko.nikula@linux.intel.com>
	<1423657928-25534-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423657928-25534-2-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 11 Feb 2015 14:32:04 +0200, Jarkko Nikula wrote:
> It makes more difficult to grep these error prints from sources if they are
> split to multiple source lines.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-i801.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 8fafb254e42a..7d1f4a478c54 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -1192,8 +1192,8 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	/* Determine the address of the SMBus area */
>  	priv->smba = pci_resource_start(dev, SMBBAR);
>  	if (!priv->smba) {
> -		dev_err(&dev->dev, "SMBus base address uninitialized, "
> -			"upgrade BIOS\n");
> +		dev_err(&dev->dev,
> +			"SMBus base address uninitialized, upgrade BIOS\n");
>  		err = -ENODEV;
>  		goto exit;
>  	}
> @@ -1206,8 +1206,9 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  
>  	err = pci_request_region(dev, SMBBAR, i801_driver.name);
>  	if (err) {
> -		dev_err(&dev->dev, "Failed to request SMBus region "
> -			"0x%lx-0x%Lx\n", priv->smba,
> +		dev_err(&dev->dev,
> +			"Failed to request SMBus region 0x%lx-0x%Lx\n",
> +			priv->smba,
>  			(unsigned long long)pci_resource_end(dev, SMBBAR));
>  		goto exit;
>  	}

Looks good.

Reviewed-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>

-- 
Jean Delvare
SUSE L3 Support
