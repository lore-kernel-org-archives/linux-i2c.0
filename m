From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2] i2c: piix4: Disable completely the IMC during
 SMBUS_BLOCK_DATA
Date: Tue, 10 Oct 2017 16:34:22 +0200
Message-ID: <20171010163422.119102c1@endymion>
References: <20171010124858.2247-1-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171010124858.2247-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ricardo,

On Tue, 10 Oct 2017 14:48:58 +0200, Ricardo Ribalda Delgado wrote:
> SMBUS_BLOCK_DATA transactions might fail due to a race condition with
> the IMC (Integrated Micro Controller), even when the IMC semaphore
> is used.
> 
> This bug has been reported and confirmed by AMD, who suggested as a
> solution an IMC firmware upgrade (obtained via BIOS update) and
> disabling the IMC during SMBUS_BLOCK_DATA transactions.
> 
> Even without the IMC upgrade, the SMBUS is much more stable with this
> patch.
> 
> Tested on a Bettong-alike board.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
> v2: Suggestions by Jean Delvare <jdelvare@suse.de>
> 
> -Fix function definitions (static)
> -Add register definition
> -Use muxed_io interface
> -Improve comments
> -Keep old timeout
> -Rebase
> 
> 
>  drivers/i2c/busses/i2c-piix4.c | 132 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 126 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 01f767ee4546..04ade552d426 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -85,6 +85,9 @@
>  /* SB800 constants */
>  #define SB800_PIIX4_SMB_IDX		0xcd6
>  
> +#define IMC_SMB_IDX			0x3e
> +#define IMC_SMB_DATA			0x3f

I'm a but confused by these names. These two ports are not
SMBus-specific, are they? I'd expect something like KERNCZ_IMC_IDX and
KERNCZ_IMC_DATA instead. No bug deal, just curious.

> +
>  /*
>   * SB800 port is selected by bits 2:1 of the smb_en register (0x2c)
>   * or the smb_sel register (0x2e), depending on bit 0 of register 0x2f.
> @@ -168,6 +171,7 @@ struct i2c_piix4_adapdata {
>  	/* SB800 */
>  	bool sb800_main;
>  	u8 port;		/* Port number, shifted */
> +	bool notify_imc;

I asked "Put right after sb800_main?" and you replied "ack", so why is
it not happening? Grouping the booleans together should save some space
on the stack. At least I think so. And it looks nicer, too.

>  };
> (...)
> +static int piix4_imc_sleep(void)
> +{
> +	int timeout = MAX_TIMEOUT;
> +
> +	if (!request_muxed_region(IMC_SMB_IDX, 2, "kerncz_imc_idx"))

I don't think this is a good region name. You request the whole 2
ports, not just the index port, so "kerncz_imc" would seem more
appropriate. For debugging purposes, it may also make sense to mention
the originator of the request, as by design another driver may request
the same ports. So I would settle with "smbus_kerncz_imc" or something
like that. What do you think?

> +		return -EBUSY;
> +
> +	/* clear response register */
> +	piix4_imc_write(0x82, 0x00);
> +	/* request ownership flag */
> +	piix4_imc_write(0x83, 0xB4);
> +	/* Kick off IMC Mailbox command 96 */
> +	piix4_imc_write(0x80, 0x96);

Please be consistent with the leading capital in comments.

> +
> +	while (timeout--) {
> +		if (piix4_imc_read(0x82) == 0xfa) {
> +			release_region(IMC_SMB_IDX, 2);
> +			return 0;
> +		}
> +		usleep_range(1000, 2000);
> +	}
> +
> +	release_region(IMC_SMB_IDX, 2);
> +	return -ETIMEDOUT;
> +}
> +
> +static void piix4_imc_wakeup(void)
> +{
> +	int timeout = MAX_TIMEOUT;
> +
> +	if (!request_muxed_region(IMC_SMB_IDX, 2, "kerncz_imc_idx"))
> +		return;

Same.

> +
> +	/* clear response register */
> +	piix4_imc_write(0x82, 0x00);
> +	/* release ownership flag */
> +	piix4_imc_write(0x83, 0xB5);
> +	/* Kick off IMC Mailbox command 96 */
> +	piix4_imc_write(0x80, 0x96);

Same.

> +
> +	while (timeout--) {
> +		if (piix4_imc_read(0x82) == 0xfa)
> +			break;
> +		usleep_range(1000, 2000);
> +	}
> +
> +	release_region(IMC_SMB_IDX, 2);
> +}
> +
>  /*
>   * Handles access to multiple SMBus ports on the SB800.
>   * The port is selected by bits 2:1 of the smb_en register (0x2c).
> @@ -634,6 +699,41 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
>  		return -EBUSY;
>  	}
>  
> +	/*
> +	 * Notify the IMC (Integrated Micro Controller) if required.
> +	 * Among other responsibilities, the IMC is in charge of monitoring
> +	 * the System fans and temperature sensors, and act accordingly.
> +	 * All this is done through SMBus and can/will collide
> +	 * with our transactions if they are long (BLOCK_DATA).
> +	 * Therefore we need to request the ownership flag during those
> +	 * transactions.
> +	 */

Thanks for the explanation, it helps.

> +	if ((size == I2C_SMBUS_BLOCK_DATA) && adapdata->notify_imc) {
> +		int ret;
> +
> +		ret = piix4_imc_sleep();
> +		switch (ret) {
> +		case -EBUSY:
> +			dev_warn(&adap->dev,
> +				 "IMC base address index region 0x%x already in use.\n",
> +				 IMC_SMB_IDX);
> +			break;
> +		case -ETIMEDOUT:
> +			dev_warn(&adap->dev,
> +				 "Failed to communicate with the IMC.\n");
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		/* If IMC communication fails do not retry*/

Missing space before end of comment.

> +		if (ret) {
> +			dev_warn(&adap->dev,
> +				 "Continuing without IMC notification.\n");
> +			adapdata->notify_imc = false;
> +		}
> +	}
> +
>  	outb_p(piix4_port_sel_sb800, SB800_PIIX4_SMB_IDX);
>  	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
>  
> (...)
> @@ -800,6 +906,20 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  			return -EBUSY;
>  		}
>  
> +		if (dev->vendor == PCI_VENDOR_ID_AMD &&
> +		    dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
> +			u8 imc;
> +
> +			/*
> +			 * Detect if IMC is active or not, this method is
> +			 * described on coreboot's AMD IMC notes
> +			 */
> +			pci_bus_read_config_byte(dev->bus, PCI_DEVFN(0x14, 3),
> +						 0x40, &imc);
> +			if (imc & 0x80)
> +				notify_imc = true;
> +		}

Sweet :-)

> +
>  		/* base address location etc changed in SB800 */
>  		retval = piix4_setup_sb800(dev, id, 0);
>  		if (retval < 0) {

Everything else looks fine, I'd say we are almost good to go, good job!

-- 
Jean Delvare
SUSE L3 Support
