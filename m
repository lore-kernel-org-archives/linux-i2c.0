From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: Rework the PIO mode operation
Date: Sun, 21 Jul 2013 23:21:22 +0200
Message-ID: <201307212321.22207.marex@denx.de>
References: <201307150405.53110.marex@denx.de> <201307171904.00784.marex@denx.de> <3767128.gOKkIqK4p5@linux-1fbo.site>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3767128.gOKkIqK4p5-BVXpyJtzy6LO1Ldfs0Uenw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Torsten,

> Hi Marek,
> 
> > Thinking about this, did you correctly configure the EEPROM write sector
> > size? I think it's 32 bytes for this device.
> 
> The EEPROM is correctly configured, i.e. page size is set to 32.
> 
> I made a test by writing one byte (0x01) to the address 0x0100 of the
> EEPROM. The EEPROM's I2C bus address is 0x54.
> The test has only one transfer with a message length of 3 bytes.
> 
> I figured out that the value written to the MXS_I2C_DATA register should be
> 0x010001a8. But instead of that a value of 0x00000000 is written to the
> register.
> 
> I think that the reason for that can be found in the following code
> section:
> 
> if (i + 1 == msg->len) {
> 	/* This is the last transfer. */
> 	start |= flags;
> 	start &= ~MXS_I2C_CTRL0_RETAIN_CLOCK;
> 	xlen = (i + 2) % 4;
> 	data >>= (4 - xlen) * 8;
> } else if ((i & 3) == 2) {
> 	/* Regular transfer. */
> 	xlen = 4;
> } else {
> 	/* Just stuff data. */
> 	continue;
> }
> 
> After the last byte is stuffed into the variable data (i = 2) xlen is
> calculated (with xlen = (i + 2) % 4) to zero. Thus the following shift
> operation (data >>= (4 - xlen) * 8) shifts all the bits out of data that
> already contains 0x010001a8.

You're right, thanks for finding this! Does the following fix look OK ? I added 
some more comments and "decompressed" the code some more.

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index fb6f110..ee17b6a 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -366,7 +366,7 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
        struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
        uint32_t addr_data = msg->addr << 1;
        uint32_t data = 0;
-       int i, ret, xlen = 0;
+       int i, ret, xlen = 0, xmit = 0;
        uint32_t start;
 
        /* Mute IRQs coming from this block. */
@@ -463,20 +463,42 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter 
*adap,
                        data >>= 8;
                        data |= (msg->buf[i] << 24);
 
+                       xmit = 0;
+
+                       /* This is the last transfer of the message. */
                        if (i + 1 == msg->len) {
-                               /* This is the last transfer. */
+                               /* Add optional STOP flag. */
                                start |= flags;
+                               /* Remove RETAIN_CLOCK bit. */
                                start &= ~MXS_I2C_CTRL0_RETAIN_CLOCK;
-                               xlen = (i + 2) % 4;
-                               data >>= (4 - xlen) * 8;
-                       } else if ((i & 3) == 2) {
-                               /* Regular transfer. */
-                               xlen = 4;
-                       } else {
-                               /* Just stuff data. */
-                               continue;
+                               xmit = 1;
                        }
 
+                       /* Four bytes are ready in the "data" variable. */
+                       if ((i & 3) == 2)
+                               xmit = 1;
+
+                       /* Nothing interesting happened, continue stuffing. */
+                       if (!xmit)
+                               continue;
+
+                       /*
+                        * Compute the size of the transfer and shift the
+                        * data accordingly.
+                        *
+                        * i = (4k + 0) .... xlen = 2
+                        * i = (4k + 1) .... xlen = 3
+                        * i = (4k + 2) .... xlen = 4
+                        * i = (4k + 3) .... xlen = 1
+                        */
+
+                       if ((i % 4) == 3)
+                               xlen = 1;
+                       else
+                               xlen = (i % 4) + 2;
+
+                       data >>= (4 - xlen) * 8;
+
                        dev_dbg(i2c->dev,
                                "PIO: len=%i pos=%i total=%i [W%s%s%s]\n",
                                xlen, i, msg->len,

Best regards,
Marek Vasut
