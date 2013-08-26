From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH V2 2/3] i2c: mxs: Rework the PIO mode operation
Date: Mon, 26 Aug 2013 20:51:42 +0200
Message-ID: <201308262051.43123.marex@denx.de>
References: <1375219237-9594-1-git-send-email-marex@denx.de> <201308251819.57351.marex@denx.de> <11990305.k2WdFfCnhA@linux-1fbo.site>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <11990305.k2WdFfCnhA-BVXpyJtzy6LO1Ldfs0Uenw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Torsten Fleischer,

> Hi Marek,
> 
> > > > +
> > > > +			/* Check NAK here ? */
> > > 
> > > checking for the NAK at this point is really necessary.
> > > 
> > > I've tested the patches by writing to the EEPROM using the at24 driver.
> > > If the data to write cross the EEPROM's page boundary then the at24
> > > driver splits the I2C write commands.
> > > 
> > > After the first I2C write command is done the at24 driver immediately
> > > tries
> > > to send the next I2C write command. Normally the EEPROM signals a NAK,
> > > because the previous write operation is internally still in progress.
> > > The NAK will be handled by the at24 driver. It later retries the I2C
> > > write command.
> > > 
> > > But if the the EEPROM signals a NAK and the I2C write command has more
> > > than
> > > 3 and less than 7 bytes then the error "PIO: Failed to finish WRITE
> > > cmd!" appears, because the loop is not exited due to the NAK.
> > 
> > Ok, so we check
> > 
> > HW_I2C_STAT :: GOT_A_NAK bit at the end of the loop and if it's set, we
> > "goto cleanup" with ret = -ENXIO . How does it sound to you?
> 
> this sounds good to me.

Does it fix your EEPROM issue then ?

Best regards,
Marek Vasut
