From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/2] i2c: add ACPI support for i2c-piix4
Date: Thu, 7 Dec 2017 15:37:39 +0100
Message-ID: <20171207153739.472a93c7@endymion>
References: <cover.1511391626.git.andrew.cooks@opengear.com>
        <a5c728e338b6d0622ae055948fc191da20e86193.1511391626.git.andrew.cooks@opengear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753608AbdLGOhm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 7 Dec 2017 09:37:42 -0500
In-Reply-To: <a5c728e338b6d0622ae055948fc191da20e86193.1511391626.git.andrew.cooks@opengear.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andrew Cooks <andrew.cooks@opengear.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Andrew,

On Thu, 23 Nov 2017 13:09:37 +1000, Andrew Cooks wrote:
> This enables the i2c-piix4 SMBus controller driver to enumerate I2C
> slave devices using ACPI. It builds on the related I2C mux device work
> in commit 8eb5c87a92c0 ("i2c: add ACPI support for I2C mux ports")
> 
> Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
> ---
>  drivers/i2c/busses/i2c-piix4.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 174579d..9260cfa 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -837,6 +837,12 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
>  	/* set up the sysfs linkage to our parent device */
>  	adap->dev.parent = &dev->dev;
>  
> +	if (has_acpi_companion(&dev->dev)) {
> +		acpi_preset_companion(&adap->dev,
> +				      ACPI_COMPANION(&dev->dev),
> +				      port);
> +	}
> +
>  	snprintf(adap->name, sizeof(adap->name),
>  		"SMBus PIIX4 adapter%s at %04x", name, smba);
>  

Looks good to me but I think you have the patches in the wrong order.
First we must get the port number right, and then you can instantiate
the devices from the ACPI data. If you do it the other way around then
you have a transient situation where you instantiate a device where it
does not exist.

-- 
Jean Delvare
SUSE L3 Support
