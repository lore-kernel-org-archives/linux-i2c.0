From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/5] I2C driver for MXC
Date: Mon, 30 Mar 2009 10:46:55 +0200
Message-ID: <20090330084655.GO7861@pengutronix.de>
References: <49C89E13.7040801@gmail.com> <20090324094215.GA3471@pengutronix.de> <49C8ABE5.40408@gmail.com> <20090325092625.GA3029@pengutronix.de> <49CA017D.20005@gmail.com> <20090325104357.GB3029@pengutronix.de> <Pine.LNX.4.64.0903282207480.9903@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0903282207480.9903-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Guennadi,

On Sat, Mar 28, 2009 at 10:36:50PM +0100, Guennadi Liakhovetski wrote:
> On Wed, 25 Mar 2009, Wolfram Sang wrote:
> 
> > > Because I hurry to submit this, because merge window is open.
> 
> Ok, I waited for this driver, I really did, and I really prefer having one 
> driver for as many hardware (SoC) variants as possible instead of having 
> different drivers, and I really hoped its new version will work 
> out-of-the-box in my setup (pcm037 with a mt9t031 camera). Unfortunately, 
> it didn't. I've spent more than a full working day trying to get it to 
> work, but I didn't succeed so far. It works with the on-board rtc, but it 
> doesn't work with the camera, connected over a flex cable.
> 
> Attached to this email is a version of the i2c driver for i.mx31 that I've 
> been using with my setup for about half a year now.

Then why didn't you send this driver half a year ago??

> I adjusted it slightly 
> to accept the same platform data, so, it is really a drop-in replacement 
> for i2c-imx.c. Of course, you have to adjust or extend the Makefile. I 
> actually added a new Kconfig entry for this driver, so I could easily 
> compare them during the tests.
> 
> The source of "my" version does look more logical and more clean to me on 
> quite a few occasions. So, maybe someone could give it a quick spin on 
> other *mx* SoCs and see if we can use this one instead? You might have to 
> replace {read,write}w with readb and writeb, so, it might be a good idea 
> to abstract them into inlines or macros. Otherwise, I think, it might work 
> for other CPUs straight away.
> 
> I just would like to avoid committing a driver and having to spend hours 
> or days fixing it afterwards when a possibly more mature version exists.

I just had a quick look over this driver, some comments inline. I think
your driver has some pros, but given the fact that we are in the middle
of the merge window and this driver is not ready for direct inclusion
I'd say that you are simply too late.

Sascha

> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> /*
>  * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
>  *
>  * The code contained herein is licensed under the GNU General Public
>  * License. You may obtain a copy of the GNU General Public License
>  * Version 2 or later at the following locations:
>  *
>  * http://www.opensource.org/licenses/gpl-license.html
>  * http://www.gnu.org/copyleft/gpl.html
>  */
> 
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/delay.h>
> #include <linux/interrupt.h>
> #include <linux/platform_device.h>
> #include <linux/i2c.h>
> #include <linux/clk.h>
> #include <linux/err.h>
> 
> #include <asm/irq.h>
> #include <asm/io.h>
> 
> #include <mach/i2c.h>
> #include <mach/iomux-mx3.h>
> 
> /* Address offsets of the I2C registers */
> #define MXC_IADR                0x00	/* Address Register */
> #define MXC_IFDR                0x04	/* Freq div register */
> #define MXC_I2CR                0x08	/* Control regsiter */
> #define MXC_I2SR                0x0C	/* Status register */
> #define MXC_I2DR                0x10	/* Data I/O register */
> 
> /* Bit definitions of I2CR */
> #define MXC_I2CR_IEN            0x0080
> #define MXC_I2CR_IIEN           0x0040
> #define MXC_I2CR_MSTA           0x0020
> #define MXC_I2CR_MTX            0x0010
> #define MXC_I2CR_TXAK           0x0008
> #define MXC_I2CR_RSTA           0x0004
> 
> /* Bit definitions of I2SR */
> #define MXC_I2SR_ICF            0x0080
> #define MXC_I2SR_IAAS           0x0040
> #define MXC_I2SR_IBB            0x0020
> #define MXC_I2SR_IAL            0x0010
> #define MXC_I2SR_SRW            0x0004
> #define MXC_I2SR_IIF            0x0002
> #define MXC_I2SR_RXAK           0x0001
> 
> #define MXC_ADAPTER_NAME        "MXC I2C Adapter"
> 
> /*
>  * In case the MXC device has multiple I2C modules, this structure is used to
>  * store information specific to each I2C module.
>  */
> struct mxc_i2c_device {
> 	struct i2c_adapter adap;
> 	wait_queue_head_t wq;		/* Transfer completion wait queue */
> 	void __iomem *membase;
> 	int irq;
> 	unsigned int clkdiv;		/* Default clock divider */
> 	struct clk *clk;
> 	bool low_power;			/* Current power state */
> 	bool transfer_done;
> 	bool tx_success;		/* ACK received */
> 	struct resource *res;
> };
> 
> struct clk_div_table {
> 	int reg_value;
> 	int div;
> };
> 
> static const struct clk_div_table i2c_clk_table[] = {
> 	{0x20, 22}, {0x21, 24}, {0x22, 26}, {0x23, 28},
> 	{0, 30}, {1, 32}, {0x24, 32}, {2, 36},
> 	{0x25, 36}, {0x26, 40}, {3, 42}, {0x27, 44},
> 	{4, 48}, {0x28, 48}, {5, 52}, {0x29, 56},
> 	{6, 60}, {0x2A, 64}, {7, 72}, {0x2B, 72},
> 	{8, 80}, {0x2C, 80}, {9, 88}, {0x2D, 96},
> 	{0xA, 104}, {0x2E, 112}, {0xB, 128}, {0x2F, 128},
> 	{0xC, 144}, {0xD, 160}, {0x30, 160}, {0xE, 192},
> 	{0x31, 192}, {0x32, 224}, {0xF, 240}, {0x33, 256},
> 	{0x10, 288}, {0x11, 320}, {0x34, 320}, {0x12, 384},
> 	{0x35, 384}, {0x36, 448}, {0x13, 480}, {0x37, 512},
> 	{0x14, 576}, {0x15, 640}, {0x38, 640}, {0x16, 768},
> 	{0x39, 768}, {0x3A, 896}, {0x17, 960}, {0x3B, 1024},
> 	{0x18, 1152}, {0x19, 1280}, {0x3C, 1280}, {0x1A, 1536},
> 	{0x3D, 1536}, {0x3E, 1792}, {0x1B, 1920}, {0x3F, 2048},
> 	{0x1C, 2304}, {0x1D, 2560}, {0x1E, 3072}, {0x1F, 3840},
> 	{0, 0}
> };

Use of struct instead of a two dimensional array, 1:0 for your driver.

> 
> /**
>  * Transmit a \b STOP signal to the slave device.
>  *
>  * @param   dev   the mxc i2c structure used to get to the right i2c device
>  */
> static void mxc_i2c_stop(struct mxc_i2c_device * dev)
> {
> 	unsigned int cr;
> 	int retry = 200;
> 
> 	cr = readw(dev->membase + MXC_I2CR);
> 	cr &= ~(MXC_I2CR_MSTA | MXC_I2CR_MTX);
> 	writew(cr, dev->membase + MXC_I2CR);
> 
> 	/*
> 	 * Make sure STOP meets setup requirement.
> 	 */
> 	for (;;) {
> 		unsigned int sr = readw(dev->membase + MXC_I2SR);
> 		if ((sr & MXC_I2SR_IBB) == 0)
> 			break;
> 		if (retry-- <= 0) {
> 			printk(KERN_DEBUG "Bus busy\n");
> 			break;
> 		}
> 		udelay(3);
> 	}
> }
> 
> /**
>  * Wait for the transmission of the data byte to complete. This function waits
>  * till we get a signal from the interrupt service routine indicating completion
>  * of the address cycle or we time out.
>  *
>  * @param   dev         the mxc i2c structure used to get to the right i2c device
>  * @param   trans_flag  transfer flag
>  *
>  *
>  * @return  The function returns 0 on success or -1 if an ack was not received
>  */
> 
> static int mxc_i2c_wait_for_tc(struct mxc_i2c_device *dev, int trans_flag)
> {
> 	int retry = 16;
> 
> 	while (retry-- && !dev->transfer_done)
> 		wait_event_interruptible_timeout(dev->wq,
> 						 dev->transfer_done,
> 						 dev->adap.timeout);
> 
> 	dev->transfer_done = false;
> 
> 	if (retry <= 0) {
> 		/* Unable to send data */
> 		dev_warn(&dev->adap.dev, "Data not transmitted\n");
> 		return -ETIMEDOUT;
> 	}
> 
> 	if (!dev->tx_success) {
> 		/* An ACK was not received for transmitted byte */
> 		dev_dbg(&dev->adap.dev, "ACK not received \n");
> 		return -EREMOTEIO;
> 	}
> 
> 	return 0;
> }
> 
> /**
>  * Transmit a \b START signal to the slave device.
>  *
>  * @param   dev   the mxc i2c structure used to get to the right i2c device
>  * @param   *msg  pointer to a message structure that contains the slave
>  *                address
>  */
> static void mxc_i2c_start(struct mxc_i2c_device *dev, struct i2c_msg *msg)
> {
> 	unsigned int cr, sr;
> 	unsigned int addr_trans;
> 	int retry = 16;
> 
> 	/*
> 	 * Set the slave address and the requested transfer mode
> 	 * in the data register
> 	 */
> 	addr_trans = msg->addr << 1;
> 	if (msg->flags & I2C_M_RD)
> 		addr_trans |= 0x01;
> 
> 	dev_dbg(&dev->adap.dev, "%s: start %x\n", __func__, msg->addr);
> 
> 	/* Set the Master bit */
> 	cr = readw(dev->membase + MXC_I2CR);
> 	cr |= MXC_I2CR_MSTA;
> 	writew(cr, dev->membase + MXC_I2CR);
> 
> 	/* Wait till the Bus Busy bit is set */
> 	sr = readw(dev->membase + MXC_I2SR);
> 	while (retry-- && (!(sr & MXC_I2SR_IBB))) {
> 		udelay(3);
> 		sr = readw(dev->membase + MXC_I2SR);
> 	}
> 	if (retry <= 0)
> 		dev_warn(&dev->adap.dev, "Could not grab Bus ownership\n");
> 
> 	/* Set the Transmit bit */
> 	cr = readw(dev->membase + MXC_I2CR);
> 	cr |= MXC_I2CR_MTX;
> 	writew(cr, dev->membase + MXC_I2CR);
> 
> 	writew(addr_trans, dev->membase + MXC_I2DR);
> }
> 
> /**
>  * Transmit a \b REPEAT START to the slave device
>  *
>  * @param   dev   the mxc i2c structure used to get to the right i2c device
>  * @param   *msg  pointer to a message structure that contains the slave
>  *                address
>  */
> static void mxc_i2c_repstart(struct mxc_i2c_device *dev, struct i2c_msg *msg)
> {
> 	unsigned int cr;
> 	unsigned int addr_trans;
> 
> 	/*
> 	 * Set the slave address and the requested transfer mode
> 	 * in the data register
> 	 */
> 	addr_trans = msg->addr << 1;
> 	if (msg->flags & I2C_M_RD)
> 		addr_trans |= 0x01;
> 
> 	dev_dbg(&dev->adap.dev, "%s: repeat start %x\n", __func__, msg->addr);
> 
> 	cr = readw(dev->membase + MXC_I2CR);
> 	cr |= MXC_I2CR_RSTA;
> 	writew(cr, dev->membase + MXC_I2CR);
> 	udelay(3);
> 	writew(addr_trans, dev->membase + MXC_I2DR);
> }
> 
> /**
>  * Read the received data. The function waits till data is available or times
>  * out. Generates a stop signal if this is the last message to be received.
>  * Sends an ack for all the bytes received except the last byte.
>  *
>  * @param  dev       the mxc i2c structure used to get to the right i2c device
>  * @param  *msg      pointer to a message structure that contains the slave
>  *                   address and a pointer to the receive buffer
>  * @param  last      indicates that this is the last message to be received
>  * @param  addr_comp flag indicates that we just finished the address cycle
>  *
>  * @return  The function returns the number of bytes read or -1 on time out.
>  */
> static int mxc_i2c_readbytes(struct mxc_i2c_device *dev, struct i2c_msg *msg,
> 			     int last, int addr_comp)
> {
> 	int i;
> 	char *buf = msg->buf;
> 	int len = msg->len;
> 	unsigned int cr;
> 
> 	dev_dbg(&dev->adap.dev, "%s: last %d, addr_comp %d\n",
> 		__func__, last, addr_comp);
> 
> 	cr = readw(dev->membase + MXC_I2CR);
> 	/*
> 	 * Clear MTX to switch to receive mode.
> 	 */
> 	cr &= ~MXC_I2CR_MTX;
> 	/*
> 	 * Clear the TXAK bit to gen an ack when receiving only one byte.
> 	 */
> 	if (len == 1)
> 		cr |= MXC_I2CR_TXAK;
> 	else
> 		cr &= ~MXC_I2CR_TXAK;
> 
> 	writew(cr, dev->membase + MXC_I2CR);
> 	/*
> 	 * Dummy read only at the end of an address cycle
> 	 */
> 	if (addr_comp > 0)
> 		readw(dev->membase + MXC_I2DR);
> 
> 	for (i = 0; i < len; i++) {
> 		int ret;
> 		/*
> 		 * Wait for data transmission to complete
> 		 */
> 		ret = mxc_i2c_wait_for_tc(dev, msg->flags);
> 		if (ret < 0) {
> 			dev_err(&dev->adap.dev, "%s: rx #%d of %d failed!\n",
> 				__func__, i, len);
> 			mxc_i2c_stop(dev);
> 			return ret;
> 		}
> 		/*
> 		 * Do not generate an ACK for the last byte
> 		 */
> 		if (i == len - 2) {
> 			cr = readw(dev->membase + MXC_I2CR);
> 			cr |= MXC_I2CR_TXAK;
> 			writew(cr, dev->membase + MXC_I2CR);
> 		} else if (i == len - 1) {
> 			if (last)
> 				mxc_i2c_stop(dev);
> 		}
> 		/* Read the data */
> 		*buf++ = readw(dev->membase + MXC_I2DR);
> 	}
> 
> 	return i;
> }
> 
> /**
>  * Write the data to the data register. Generates a stop signal if this is
>  * the last message to be sent or if no ack was received for the data sent.
>  *
>  * @param   dev   the mxc i2c structure used to get to the right i2c device
>  * @param   *msg  pointer to a message structure that contains the slave
>  *                address and data to be sent
>  * @param   last  indicates that this is the last message to be received
>  *
>  * @return  The function returns the number of bytes written or -1 on time out
>  *          or if no ack was received for the data that was sent.
>  */
> static int mxc_i2c_writebytes(struct mxc_i2c_device *dev, struct i2c_msg *msg,
> 			      int last)
> {
> 	int i;
> 	char *buf = msg->buf;
> 	int len = msg->len;
> 	unsigned int cr;
> 
> 	dev_dbg(&dev->adap.dev, "%s: last %d\n", __func__, last);
> 
> 	cr = readw(dev->membase + MXC_I2CR);
> 	/* Set MTX to switch to transmit mode */
> 	writew(cr | MXC_I2CR_MTX, dev->membase + MXC_I2CR);
> 
> 	for (i = 0; i < len; i++) {
> 		int ret;
> 		/*
> 		 * Write the data
> 		 */
> 		writew(*buf++, dev->membase + MXC_I2DR);
> 		ret = mxc_i2c_wait_for_tc(dev, msg->flags);
> 		if (ret < 0) {
> 			dev_err(&dev->adap.dev, "%s: tx #%d of %d timed out!\n",
> 				__func__, i, len);
> 			mxc_i2c_stop(dev);
> 			return ret;
> 		}
> 	}
> 	if (last > 0)
> 		mxc_i2c_stop(dev);
> 
> 	return i;
> }
> 
> /**
>  * Function enables the I2C module and initializes the registers.
>  *
>  * @param   dev   the mxc i2c structure used to get to the right i2c device
>  * @param   trans_flag  transfer flag
>  */
> static void mxc_i2c_module_en(struct mxc_i2c_device *dev, int trans_flag)
> {
> 	clk_enable(dev->clk);
> 	/* Set the frequency divider */
> 	writew(dev->clkdiv, dev->membase + MXC_IFDR);
> 	/* Clear the status register */
> 	writew(0x0, dev->membase + MXC_I2SR);
> 	/* Enable I2C and its interrupts */
> 	writew(MXC_I2CR_IEN, dev->membase + MXC_I2CR);
> 	writew(MXC_I2CR_IEN | MXC_I2CR_IIEN, dev->membase + MXC_I2CR);
> }
> 
> /**
>  * Disables the I2C module.
>  *
>  * @param   dev   the mxc i2c structure used to get to the right i2c device
>  */
> static void mxc_i2c_module_dis(struct mxc_i2c_device * dev)
> {
> 	writew(0x0, dev->membase + MXC_I2CR);
> 	clk_disable(dev->clk);
> }
> 
> /**
>  * The function is registered in the adapter structure. It is called when an MXC
>  * driver wishes to transfer data to a device connected to the I2C device.
>  *
>  * @param   adap   adapter structure for the MXC i2c device
>  * @param   msgs[] array of messages to be transferred to the device
>  * @param   num    number of messages to be transferred to the device
>  *
>  * @return  The function returns the number of messages transferred,
>  *          \b -EREMOTEIO on I2C failure and a 0 if the num argument is
>  *          less than 0.
>  */
> static int mxc_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> {
> 	struct mxc_i2c_device *dev = i2c_get_adapdata(adap);
> 	int i, ret = 0, addr_comp = 0;
> 	unsigned int sr;
> 
> 	if (dev->low_power) {
> 		dev_warn(&dev->adap.dev, "I2C Device in low power mode\n");
> 		return -EREMOTEIO;
> 	}
> 
> 	if (num < 1)
> 		return 0;
> 
> 	dev_dbg(&dev->adap.dev, "%s: xfer %d msgs\n", __func__, num);
> 
> 	mxc_i2c_module_en(dev, msgs[0].flags);
> 	sr = readw(dev->membase + MXC_I2SR);
> 	/*
> 	 * Check bus state
> 	 */
> 	if (sr & MXC_I2SR_IBB) {
> 		mxc_i2c_module_dis(dev);
> 		printk(KERN_DEBUG "Bus busy\n");
> 		return -EREMOTEIO;
> 	}
> 
> 	dev->transfer_done = false;
> 	dev->tx_success = false;
> 	for (i = 0; i < num && ret >= 0; i++) {
> 		addr_comp = 0;
> 		/*
> 		 * Send the slave address and transfer direction in the
> 		 * address cycle
> 		 */
> 		if (i == 0) {
> 			/*
> 			 * Send a start or repeat start signal
> 			 */
> 			mxc_i2c_start(dev, &msgs[0]);
> 			/* Wait for the address cycle to complete */
> 			if (mxc_i2c_wait_for_tc(dev, msgs[0].flags)) {
> 				mxc_i2c_stop(dev);
> 				mxc_i2c_module_dis(dev);
> 				dev_err(&dev->adap.dev,
> 					"%s: Address failed!\n", __func__);
> 				return -EREMOTEIO;
> 			}
> 			addr_comp = 1;

This looks strange. Why is this block inside the loop?

> 		} else {
> 			/*
> 			 * Generate repeat start only if required i.e. the
> 			 * address changed or the transfer direction changed
> 			 */
> 			if ((msgs[i].addr != msgs[i - 1].addr) ||
> 			    ((msgs[i].flags & I2C_M_RD) !=
> 			     (msgs[i - 1].flags & I2C_M_RD))) {
> 				mxc_i2c_repstart(dev, &msgs[i]);
> 				/* Wait for the address cycle to complete */
> 				if (mxc_i2c_wait_for_tc(dev, msgs[i].flags)) {
> 					mxc_i2c_stop(dev);
> 					mxc_i2c_module_dis(dev);
> 					dev_err(&dev->adap.dev,
> 						"%s: Address repeat failed!\n",
> 						__func__);
> 					return -EREMOTEIO;
> 				}
> 				addr_comp = 1;
> 			}
> 		}
> 
> 		/* Transfer the data */
> 		if (msgs[i].flags & I2C_M_RD) {
> 			/* Read the data */
> 			ret = mxc_i2c_readbytes(dev, &msgs[i], i + 1 == num,
> 						addr_comp);
> 			if (ret < 0) {
> 				dev_err(&dev->adap.dev, "mxc_i2c_readbytes: fail.\n");
> 				break;
> 			}
> 		} else {
> 			/* Write the data */
> 			ret = mxc_i2c_writebytes(dev, &msgs[i], i + 1 == num);
> 			if (ret < 0) {
> 				dev_err(&dev->adap.dev, "mxc_i2c_writebytes: fail.\n");
> 				break;
> 			}
> 		}
> 	}
> 
> 	mxc_i2c_module_dis(dev);
> 
> 	dev_dbg(&dev->adap.dev, "%s: %d msgs success\n", __func__, i);
> 
> 	/*
> 	 * Decrease by 1 as we do not want Start message to be included in
> 	 * the count
> 	 */
> 	return i;

Original Freescale code returned  i - 1 here which was wrong. The code
is correct, but you should remove the comment.

> }
> 
> /**
>  * Returns the i2c functionality supported by this driver.
>  *
>  * @param   adap adapter structure for this i2c device
>  *
>  * @return Returns the functionality that is supported.
>  */
> static u32 mxc_i2c_func(struct i2c_adapter *adap)
> {
> 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> }
> 
> static struct i2c_algorithm mxc_i2c_algorithm = {
> 	.master_xfer = mxc_i2c_xfer,
> 	.functionality = mxc_i2c_func
> };
> 
> /*
>  * Interrupt Service Routine. It signals to the process about the data transfer
>  * completion. Also sets a flag if bus arbitration is lost.

This comment is not true. All it does is a printk. The other driver does
not handle this situation, too.

>  */
> static irqreturn_t mxc_i2c_handler(int irq, void *dev_id)
> {
> 	struct mxc_i2c_device *dev = dev_id;
> 	unsigned int sr, cr;
> 
> 	sr = readw(dev->membase + MXC_I2SR);
> 	cr = readw(dev->membase + MXC_I2CR);
> 
> 	/*
> 	 * Clear the interrupt bit
> 	 */
> 	writew(0x0, dev->membase + MXC_I2SR);
> 
> 	if (sr & MXC_I2SR_IAL) {
> 		printk(KERN_DEBUG "Bus Arbitration lost\n");
> 	} else {
> 		/* Interrupt due byte transfer completion */
> 		dev->tx_success = true;
> 		/* Check if RXAK is received in Transmit mode */
> 		if ((cr & MXC_I2CR_MTX) && (sr & MXC_I2SR_RXAK))
> 			dev->tx_success = false;
> 
> 		dev->transfer_done = true;
> 		wake_up_interruptible(&dev->wq);
> 	}
> 
> 	return IRQ_HANDLED;
> }
> 
> static int mxci2c_suspend(struct platform_device *pdev, pm_message_t state)
> {
> 	struct mxc_i2c_device *mxcdev = platform_get_drvdata(pdev);
> 	struct imxi2c_platform_data *i2c_plat_data = pdev->dev.platform_data;
> 	unsigned int sr;
> 
> 	if (mxcdev == NULL)
> 		return -ENODEV;
> 
> 	/* Prevent further calls to be processed */
> 	mxcdev->low_power = true;
> 	/* Wait till we finish the current transfer */
> 	sr = readw(mxcdev->membase + MXC_I2SR);
> 	while (sr & MXC_I2SR_IBB) {
> 		msleep(10);
> 		sr = readw(mxcdev->membase + MXC_I2SR);
> 	}
> 
> 	if (i2c_plat_data->exit)
> 		i2c_plat_data->exit(&pdev->dev);
> 
> 	return 0;
> }
> 
> static int mxci2c_resume(struct platform_device *pdev)
> {
> 	struct mxc_i2c_device *mxcdev = platform_get_drvdata(pdev);
> 	struct imxi2c_platform_data *i2c_plat_data = pdev->dev.platform_data;
> 
> 	if (mxcdev == NULL)
> 		return -ENODEV;
> 
> 	mxcdev->low_power = false;
> 	if (i2c_plat_data->init)
> 		i2c_plat_data->init(&pdev->dev);
> 
> 	return 0;
> }
> 
> static int __init mxci2c_probe(struct platform_device *pdev)
> {
> 	struct mxc_i2c_device *mxc_i2c;
> 	struct imxi2c_platform_data *i2c_plat_data = pdev->dev.platform_data;
> 	struct resource *res;
> 	int id = pdev->id;
> 	u32 clk_freq;
> 	int ret;
> 	int i;
> 
> 	mxc_i2c = kzalloc(sizeof(struct mxc_i2c_device), GFP_KERNEL);
> 	if (!mxc_i2c)
> 		return -ENOMEM;
> 
> 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 	if (res == NULL) {
> 		ret = -ENODEV;
> 		goto egetres;
> 	}
> 
> 	if (!request_mem_region(res->start, resource_size(res), res->name)) {
> 		ret = -ENOMEM;
> 		goto ereqmemr;
> 	}
> 
> 	mxc_i2c->membase = ioremap(res->start, resource_size(res));
> 	if (!mxc_i2c->membase) {
> 		ret = -ENOMEM;
> 		goto eiomap;
> 	}
> 
> 	mxc_i2c->res = res;
> 
> 	/*
> 	 * Request the I2C interrupt
> 	 */
> 	mxc_i2c->irq = platform_get_irq(pdev, 0);
> 	if (mxc_i2c->irq < 0) {
> 		ret = mxc_i2c->irq;
> 		goto epgirq;
> 	}
> 
> 	ret = request_irq(mxc_i2c->irq, mxc_i2c_handler,
> 			  0, pdev->name, mxc_i2c);
> 	if (ret < 0)
> 		goto ereqirq;
> 
> 	init_waitqueue_head(&mxc_i2c->wq);
> 
> 	mxc_i2c->low_power	= false;
> 	mxc_i2c->transfer_done	= false;
> 	mxc_i2c->tx_success	= false;
> 
> 	if (i2c_plat_data->init)
> 		i2c_plat_data->init(&pdev->dev);
> 
> 	mxc_i2c->clk = clk_get(&pdev->dev, "i2c_clk");
> 	if (IS_ERR(mxc_i2c->clk)) {
> 		ret = PTR_ERR(mxc_i2c->clk);
> 		dev_err(&pdev->dev, "can't get I2C clock\n");
> 		goto eclkget;
> 	}
> 	clk_freq = clk_get_rate(mxc_i2c->clk);
> 
> 	mxc_i2c->clkdiv = -1;
> 	if (i2c_plat_data->bitrate) {
> 		/* Calculate divider and round up any fractional part */
> 		int div = (clk_freq + i2c_plat_data->bitrate - 1) /
> 			i2c_plat_data->bitrate;
> 		for (i = 0; i2c_clk_table[i].div != 0; i++) {

You could use ARRAY_SIZE here and remove the last {0, 0} entry from
i2c_clk_table.

> 			if (i2c_clk_table[i].div >= div) {
> 				mxc_i2c->clkdiv = i2c_clk_table[i].reg_value;
> 				break;
> 			}
> 		}
> 	}
> 	if (mxc_i2c->clkdiv == -1) {
> 		i = ARRAY_SIZE(i2c_clk_table) - 2;

Then we would not have this strange -2 here.

> 		/* Use max divider */
> 		mxc_i2c->clkdiv = i2c_clk_table[i].reg_value;
> 	}
> 	dev_dbg(&pdev->dev, "i2c speed is %d/%d = %d bps, reg val = 0x%02X\n",
> 		clk_freq, i2c_clk_table[i].div, clk_freq / i2c_clk_table[i].div,
> 		mxc_i2c->clkdiv);
> 
> 	/*
> 	 * Set the adapter information
> 	 */
> 	strcpy(mxc_i2c->adap.name, MXC_ADAPTER_NAME);
> 	mxc_i2c->adap.nr	= id;

id is used only here. pdev->id instead?

> 	mxc_i2c->adap.algo	= &mxc_i2c_algorithm;
> 	mxc_i2c->adap.timeout	= 1;
> 	mxc_i2c->adap.dev.parent= &pdev->dev;
> 	mxc_i2c->adap.class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
> 	platform_set_drvdata(pdev, mxc_i2c);
> 	i2c_set_adapdata(&mxc_i2c->adap, mxc_i2c);
> 	if ((ret = i2c_add_numbered_adapter(&mxc_i2c->adap)) < 0)
> 		goto eaddadap;
> 
> 	return 0;
> 
> eaddadap:
> 	platform_set_drvdata(pdev, NULL);
> 	clk_put(mxc_i2c->clk);
> eclkget:
> 	if (i2c_plat_data->exit)
> 		i2c_plat_data->exit(&pdev->dev);
> 	free_irq(mxc_i2c->irq, mxc_i2c);
> ereqirq:
> epgirq:
> 	iounmap(mxc_i2c->membase);
> eiomap:
> 	release_mem_region(res->start, resource_size(res));
> ereqmemr:
> egetres:
> 	kfree(mxc_i2c);
> 	dev_err(&pdev->dev, "failed to probe i2c adapter\n");
> 	return ret;
> }
> 
> static int __exit mxci2c_remove(struct platform_device *pdev)
> {
> 	struct mxc_i2c_device *mxc_i2c = platform_get_drvdata(pdev);
> 	struct imxi2c_platform_data *i2c_plat_data = pdev->dev.platform_data;
> 
> 	free_irq(mxc_i2c->irq, mxc_i2c);
> 	i2c_del_adapter(&mxc_i2c->adap);
> 	if (i2c_plat_data->exit)
> 		i2c_plat_data->exit(&pdev->dev);
> 	clk_put(mxc_i2c->clk);
> 	platform_set_drvdata(pdev, NULL);
> 	iounmap(mxc_i2c->membase);
> 	release_mem_region(mxc_i2c->res->start, resource_size(mxc_i2c->res));
> 	kfree(mxc_i2c);
> 	return 0;
> }
> 
> static struct platform_driver mxci2c_driver = {
> 	.driver = {
> 		   .name = "imx-i2c",
> 		   .owner = THIS_MODULE,
> 	},
> 	.remove = __exit_p(mxci2c_remove),
> 	.suspend = mxci2c_suspend,
> 	.resume = mxci2c_resume,
> };
> 
> static int __init mxc_i2c_init(void)
> {
> 	return platform_driver_probe(&mxci2c_driver, mxci2c_probe);
> }
> 
> static void __exit mxc_i2c_exit(void)
> {
> 	platform_driver_unregister(&mxci2c_driver);
> }
> 
> subsys_initcall(mxc_i2c_init);
> module_exit(mxc_i2c_exit);
> 
> MODULE_AUTHOR("Freescale Semiconductor, Inc.");
> MODULE_DESCRIPTION("MXC I2C driver");
> MODULE_LICENSE("GPL");


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
