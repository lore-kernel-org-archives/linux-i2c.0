From: "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [RESEND][PATCH v4 3/3] i2c: piix4: add ACPI support
Date: Mon, 26 Feb 2018 19:59:24 +1100
Message-ID: <20180226085924.GB15131@eros>
References: <cover.1519601860.git.andrew.cooks@opengear.com>
 <d197d95d77afa2054ff1b2c593dae7939030e24b.1519601860.git.andrew.cooks@opengear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d197d95d77afa2054ff1b2c593dae7939030e24b.1519601860.git.andrew.cooks@opengear.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Cooks <andrew.cooks@opengear.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, "open list:I2C/SMBUS CONTROLLER DRIVERS FOR PC" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Andrew Cooks <acooks@rationali.st>, linux-acpi@vger.kernel.org, platypus-sw@opengear.com
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 26, 2018 at 10:28:45AM +1000, Andrew Cooks wrote:
> Enable the i2c-piix4 SMBus controller driver to enumerate I2C slave
> devices using ACPI. It builds on the related I2C mux device work
> in commit 8eb5c87a92c0 ("i2c: add ACPI support for I2C mux ports")
> 
> In the i2c-piix4 driver the adapters are enumerated as:
>  Main SMBus adapter Port 0, Port 2, ..., aux port (i.e., ASF adapter)
> 
> However, in the AMD BKDG documentation[1], the implied order of ports is:
>  Main SMBus adapter Port 0, ASF adapter, Port 2, Port 3, ...
> 
> This ordering difference is unfortunate. We assume that ACPI
> developers will use the Linux ordering.
> 
> [1] 52740 BIOS and Kernel Developer's Guide (BKDG) for AMD Family 16h
> Models 30h-3Fh Processors
> 
> Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
> ---
>  drivers/i2c/busses/i2c-piix4.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 01f1610..9a6cdc8 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -837,6 +837,12 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
>  	/* set up the sysfs linkage to our parent device */
>  	adap->dev.parent = &dev->dev;
>  
> +	if (has_acpi_companion(&dev->dev)) {
> +		acpi_preset_companion(&adap->dev,
> +				ACPI_COMPANION(&dev->dev),
> +				piix4_adapter_count);

nit:
		acpi_preset_companion(&adap->dev,
				      ACPI_COMPANION(&dev->dev),
				      piix4_adapter_count);

> +	}
> +
>  	snprintf(adap->name, sizeof(adap->name),
>  		"SMBus PIIX4 adapter%s at %04x", name, smba);


Hope this helps,
Tobin
