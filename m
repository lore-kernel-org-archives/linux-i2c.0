From: Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH V2 2/3] i2c: mxs: Rework the PIO mode operation
Date: Thu, 15 Aug 2013 19:08:49 +0200
Message-ID: <8771910.JgfUXiMKri@linux-1fbo.site>
References: <1375219237-9594-1-git-send-email-marex@denx.de> <1375219237-9594-2-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1375219237-9594-2-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Marek,
> +
> +			mxs_i2c_pio_trigger_write_cmd(i2c,
> +				start | MXS_I2C_CTRL0_MASTER_MODE |
> +				MXS_I2C_CTRL0_DIRECTION |
> +				MXS_I2C_CTRL0_XFER_COUNT(xlen), data);
> +
> +			/* The START condition is sent only once. */
> +			start &= ~MXS_I2C_CTRL0_PRE_SEND_START;
> +
> +			/* Wait for the end of the transfer. */
> +			ret = mxs_i2c_pio_wait_xfer_end(i2c);
> +			if (ret) {
> +				dev_err(i2c->dev,
> +					"PIO: Failed to finish WRITE cmd!\n");
> +				break;
> +			}
> +
> +			/* Check NAK here ? */

checking for the NAK at this point is really necessary.

I've tested the patches by writing to the EEPROM using the at24 driver.
If the data to write cross the EEPROM's page boundary then the at24 driver 
splits the I2C write commands.

After the first I2C write command is done the at24 driver immediately tries to 
send the next I2C write command. Normally the EEPROM signals a NAK, because 
the previous write operation is internally still in progress. The NAK will be 
handled by the at24 driver. It later retries the I2C write command.

But if the the EEPROM signals a NAK and the I2C write command has more than 3 
and less than 7 bytes then the error "PIO: Failed to finish WRITE cmd!" 
appears, because the loop is not exited due to the NAK.

Best regards,
Torsten Fleischer
