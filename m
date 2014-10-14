From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] misc: eeprom: add driver for Cypress FRAM
Date: Tue, 14 Oct 2014 15:12:30 +0530
Message-ID: <543CF006.6030600@gmail.com>
References: <8bfffe403f558ff93b50ae4088848c1c489c485b.1413278480.git.jiri.prchal@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8bfffe403f558ff93b50ae4088848c1c489c485b.1413278480.git.jiri.prchal-cKCO0sOKHLPtwjQa/ONI9g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Prchal <jiri.prchal-cKCO0sOKHLPtwjQa/ONI9g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 10/14/2014 02:53 PM, Jiri Prchal wrote:
> This patch adds driver for Cypress FRAMs on SPI bus, such as FM25V05, FM25V10
> etc.
> Reworked from at25 driver:
> - simplified writing since data are written without erasing and waiting to
> finish write cycle
> - add reading device ID and choose size and addr len from it
> - add serial number reading and exporting it to sysfs
>
(...)

> +static int fm25_probe(struct spi_device *spi)
> +{
> +	struct fm25_data	*fm25 = NULL;
> +	struct spi_eeprom	chip;
> +	struct device_node	*np = spi->dev.of_node;
> +	int			err;
> +	char			id[FM25_ID_LEN];
> +
> +	/* Chip description */
> +	if (!spi->dev.platform_data) {
> +		if (np) {
> +			err = fm25_np_to_chip(&spi->dev, np, &chip);
> +			if (err)
> +				return err;
> +		} else {
> +			dev_err(&spi->dev, "Error: no chip description\n");
> +			return -ENODEV;
> +		}
> +	} else
> +		chip = *(struct spi_eeprom *)spi->dev.platform_data;
> +
> +	fm25 = devm_kzalloc(&spi->dev, sizeof(struct fm25_data), GFP_KERNEL);
> +	if (!fm25)
> +		return -ENOMEM;

sizeof(*fm25)..?

> +
> +	mutex_init(&fm25->lock);
> +	fm25->chip = chip;
> +	fm25->spi = spi_dev_get(spi);
> +	spi_set_drvdata(spi, fm25);
> +
> +	/* Get ID of chip */
> +	fm25_id_read(fm25, id);
> +	if (id[6] != 0xc2) {
> +		dev_err(&spi->dev, "Error: no Cypress FRAM (id %02x)\n", id[6]);
> +		return -ENODEV;
> +	}
> +	/* set size found in ID */
> +	switch (id[7]) {
> +		case 0x21:
> +			fm25->chip.byte_len = 16 * 1024;
> +			break;
> +		case 0x22:
> +			fm25->chip.byte_len = 32 * 1024;
> +			break;
> +		case 0x23:
> +			fm25->chip.byte_len = 64 * 1024;
> +			break;
> +		case 0x24:
> +			fm25->chip.byte_len = 128 * 1024;
> +			break;
> +		case 0x25:
> +			fm25->chip.byte_len = 256 * 1024;
> +			break;
> +		default:
> +			dev_err(&spi->dev,
> +				"Error: unsupported size (id %02x)\n", id[7]);
> +			return -ENODEV;
> +			break;
> +	}

The preferred way of using switchhttp://lxr.free-electrons.com/source/Documentation/CodingStyle#L38

> +
> +	if (fm25->chip.byte_len > 64 * 1024) {
> +		fm25->addrlen = 3;
> +		fm25->chip.flags |= EE_ADDR3;
> +	}
> +	else {
> +		fm25->addrlen = 2;
> +		fm25->chip.flags |= EE_ADDR2;
> +	}
> +
> +	if (id[8])
> +		fm25->has_sernum = 1;
> +	else
> +		fm25->has_sernum = 0;
> +
> +	/* Export the EEPROM bytes through sysfs, since that's convenient.
> +	 * And maybe to other kernel code; it might hold a board's Ethernet
> +	 * address, or board-specific calibration data generated on the
> +	 * manufacturing floor.
> +	 *
> +	 * Default to root-only access to the data; EEPROMs often hold data
> +	 * that's sensitive for read and/or write, like ethernet addresses,
> +	 * security codes, board-specific manufacturing calibrations, etc.
> +	 */
> +	sysfs_bin_attr_init(&fm25->bin);
> +	fm25->bin.attr.name = "fram";
> +	fm25->bin.attr.mode = S_IRUGO;
> +	fm25->bin.read = fm25_bin_read;
> +	fm25->mem.read = fm25_mem_read;
> +
> +	fm25->bin.size = fm25->chip.byte_len;
> +	if (!(chip.flags & EE_READONLY)) {
> +		fm25->bin.write = fm25_bin_write;
> +		fm25->bin.attr.mode |= S_IWUSR | S_IWGRP;
> +		fm25->mem.write = fm25_mem_write;
> +	}
> +
> +	err = sysfs_create_bin_file(&spi->dev.kobj, &fm25->bin);
> +	if (err)
> +		return err;
> +
> +	/* Export the FM25 serial number */
> +	if (fm25->has_sernum) {
> +		err = device_create_file(&spi->dev, &dev_attr_sernum);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (chip.setup)
> +		chip.setup(&fm25->mem, chip.context);
> +
> +	dev_info(&spi->dev, "%Zd %s %s fram%s\n",
> +		(fm25->bin.size < 1024)
> +			? fm25->bin.size
> +			: (fm25->bin.size / 1024),
> +		(fm25->bin.size < 1024) ? "Byte" : "KByte",
> +		fm25->chip.name,
> +		(chip.flags & EE_READONLY) ? " (readonly)" : "");
> +	return 0;
> +}
> +
> +static int fm25_remove(struct spi_device *spi)
> +{
> +	struct fm25_data	*fm25;
> +
> +	fm25 = spi_get_drvdata(spi);

Both statements can be combine.

struct fm25_datd *fm25 = spi_get_drvdata(spi);

> +	sysfs_remove_bin_file(&spi->dev.kobj, &fm25->bin);
> +	if (fm25->has_sernum)
> +		device_remove_file(&spi->dev, &dev_attr_sernum);
> +	return 0;
> +}
> +
> +/*-------------------------------------------------------------------------*/
> +
> +static const struct of_device_id fm25_of_match[] = {
> +	{ .compatible = "cypress,fm25", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, fm25_of_match);
> +
> +static struct spi_driver fm25_driver = {
> +	.driver = {
> +		.name		= "fm25",
> +		.owner		= THIS_MODULE,

Can remove this filed. It will populate by module_spi_driver().

> +		.of_match_table = fm25_of_match,
> +	},
> +	.probe		= fm25_probe,
> +	.remove		= fm25_remove,
> +};
> +
> +module_spi_driver(fm25_driver);
> +
> +MODULE_DESCRIPTION("Driver for Cypress SPI FRAMs");
> +MODULE_AUTHOR("Jiri Prchal");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("spi:fram");

-- 
Regards,
Varka Bhadram.
