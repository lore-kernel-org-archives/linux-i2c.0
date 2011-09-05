From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] i2c-ali1535: enable SPARC support
Date: Mon, 5 Sep 2011 10:15:00 +0200
Message-ID: <20110905101500.77849e49@endymion.delvare>
References: <4E144CC0.90502@geomatys.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E144CC0.90502-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "corentin.labbe" <corentin.labbe-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Corentin,

On Wed, 06 Jul 2011 13:53:36 +0200, corentin.labbe wrote:
> hello
> 
> I have a sun blade 100 and I want to get the sensors working with
> lm_sensors, but in current state, it doesn't work.
> 
> After some research, I have found that all SMBUS driver and the i2c_ali1535 particularly can't work.
> It assumes that ioport address are 16bits wide (address stored with an unsigned short).
> But on SPARC arch, ioports are mapped in memory and so are stored with an unsigned long.
> 
> So I write this patch for i2c_ali1535 for supporting SPARC architecture.
> With this patch, the driver i2c_ali1535 loads and works successfully.
> # sensors
> adm1023-i2c-0-18
> Adapter: SMBus ALI1535 adapter at 0x1fe02000620
> temp1:       +31.0 C  (low  = -55.0 C, high = +127.0 C)
> temp2:       +61.6 C  (low  = -55.0 C, high = +127.0 C)
> 
> I sent this patch for review at sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org and one person confirm me that it works on his sun-blade 100.
> 
> Bests regards,
> 
> Signed-off-by: LABBE Corentin <corentin.labbe-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>

Overall I like the patch. Minor comments below:

> ---
> --- linux/drivers/i2c/busses/i2c-ali1535.c.orig	2011-06-15 18:02:56.000000000 +0200
> +++ linux/drivers/i2c/busses/i2c-ali1535.c	2011-06-15 18:05:26.000000000 +0200
> @@ -132,7 +132,7 @@
>  #define	ALI1535_SMBIO_EN	0x04	/* SMB I/O Space enable		*/
> 
>  static struct pci_driver ali1535_driver;
> -static unsigned short ali1535_smba;
> +static unsigned long ali1535_smba;
> 
>  /* Detect whether a ALI1535 can be found, and initialize it, where necessary.
>     Note the differences between kernels with the old PCI BIOS interface and
> @@ -142,6 +142,7 @@ static int __devinit ali1535_setup(struc
>  {
>  	int retval = -ENODEV;
>  	unsigned char temp;
> +	unsigned short offset;
> 
>  	/* Check the following things:
>  		- SMB I/O address is initialized
> @@ -149,15 +150,27 @@ static int __devinit ali1535_setup(struc
>  		- We can use the addresses
>  	*/
> 
> +	if (pci_enable_device(dev)) {
> +		dev_err(&dev->dev, "ALI1535_smb cant enable device");

cant -> can't, and missing trailing \n.

> +		goto exit;
> +	}

Please return the error code from pci_enable_device() instead of
crafting your own.

> +
>  	/* Determine the address of the SMBus area */
> -	pci_read_config_word(dev, SMBBA, &ali1535_smba);
> -	ali1535_smba &= (0xffff & ~(ALI1535_SMB_IOSIZE - 1));
> -	if (ali1535_smba == 0) {
> +	pci_read_config_word(dev, SMBBA, &offset);
> +	dev_dbg(&dev->dev, "ALI1535_smb is at offset 0x%04x", offset);

Missing trailing \n.

> +	offset &= (0xffff & ~(ALI1535_SMB_IOSIZE - 1));
> +	if (offset == 0) {
>  		dev_warn(&dev->dev,
>  			"ALI1535_smb region uninitialized - upgrade BIOS?\n");
>  		goto exit;
>  	}
> 
> +	ali1535_smba = pci_resource_start(dev, 0) + offset;
> +	if ((pci_resource_flags(dev, 0) & IORESOURCE_IO) == 0) {
> +		dev_err(&dev->dev, "ALI1535_smb bar 0 is not IORESOURCE_IO");

Missing trailing \n.

> +		goto exit;
> +	}

You should swap these: first check the resource type, and if it is
correct, call pci_resource_start(). I agree it makes no difference in
practice, but it is cleaner.

> +
>  	retval = acpi_check_region(ali1535_smba, ALI1535_SMB_IOSIZE,
>  				   ali1535_driver.name);
>  	if (retval)
> @@ -165,7 +178,7 @@ static int __devinit ali1535_setup(struc
> 
>  	if (!request_region(ali1535_smba, ALI1535_SMB_IOSIZE,
>  			    ali1535_driver.name)) {
> -		dev_err(&dev->dev, "ALI1535_smb region 0x%x already in use!\n",
> +		dev_err(&dev->dev, "ALI1535_smb region 0x%lx already in use!\n",
>  			ali1535_smba);
>  		goto exit;
>  	}
> @@ -196,7 +209,7 @@ static int __devinit ali1535_setup(struc
>  	*/
>  	pci_read_config_byte(dev, SMBREV, &temp);
>  	dev_dbg(&dev->dev, "SMBREV = 0x%X\n", temp);
> -	dev_dbg(&dev->dev, "ALI1535_smba = 0x%X\n", ali1535_smba);
> +	dev_dbg(&dev->dev, "ALI1535_smba = 0x%0lx\n", ali1535_smba);

Prefix "0" alone is meaningless.

> 
>  	retval = 0;
>  exit:
> @@ -499,7 +512,7 @@ static int __devinit ali1535_probe(struc
>  	ali1535_adapter.dev.parent = &dev->dev;
> 
>  	snprintf(ali1535_adapter.name, sizeof(ali1535_adapter.name),
> -		"SMBus ALI1535 adapter at %04x", ali1535_smba);
> +		"SMBus ALI1535 adapter at %0lx", ali1535_smba);

This would potentially change the string on other systems. The adapter
name can be used as a unique identifier in sensors.conf or i2c tools
command line, so changing it is bad. Please keep the "04" as is, it
won't change anything for large ali1535_smba values.

>  	return i2c_add_adapter(&ali1535_adapter);
>  }

Please adjust these small mistakes, resend, and I'll be happy to take
your patch in kernel 3.2.

-- 
Jean Delvare
