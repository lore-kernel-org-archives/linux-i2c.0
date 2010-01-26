From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH RESEND 1/1] i2c: Add support for Xilinx XPS IIC Bus
 Interface
Date: Tue, 26 Jan 2010 14:44:02 +0000
Message-ID: <20100126144402.GE12774@fluff.org.uk>
References: <4B55D74C.2010806@pelagicore.com>
 <20100124154930.GE28675@fluff.org.uk>
 <4B5C8460.2040309@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4B5C8460.2040309-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard R?jfors <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Jan 24, 2010 at 06:33:20PM +0100, Richard R?jfors wrote:
> Hi Ben,
> 
> Thanks for the feedback! Comments below...
> 
> On 1/24/10 4:49 PM, Ben Dooks wrote:
> > On Tue, Jan 19, 2010 at 05:01:16PM +0100, Richard R?jfors wrote:
> >> This patch adds support for the Xilinx XPS IIC Bus Interface.
> >>
> >> The driver uses the dynamic mode, supporting to put several
> >> I2C messages in the FIFO to reduce the number of interrupts.
> >>
> >> It has the same feature as ocores, it can be passed a list
> >> of devices that will be added when the bus is probed.
> >>
> >> Signed-off-by: Richard R?jfors <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
> >> ---
> >> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> >> index 5f318ce..44ff5c8 100644
> >> --- a/drivers/i2c/busses/Kconfig
> >> +++ b/drivers/i2c/busses/Kconfig
> >> @@ -564,6 +564,16 @@ config I2C_VERSATILE
> >>  	  This driver can also be built as a module.  If so, the module
> >>  	  will be called i2c-versatile.
> >>
> >> +config I2C_XILINX
> >> +	tristate "Xilinx I2C Controller"
> >> +	depends on EXPERIMENTAL && HAS_IOMEM
> >> +	help
> >> +	  If you say yes to this option, support will be included for the
> >> +	  Xilinx I2C controller.
> >> +
> >> +	  This driver can also be built as a module.  If so, the module
> >> +	  will be called xilinx_i2c.
> >> +
> >>  comment "External I2C/SMBus adapter drivers"
> >>
> >>  config I2C_PARPORT
> >> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> >> index 302c551..168f302 100644
> >> --- a/drivers/i2c/busses/Makefile
> >> +++ b/drivers/i2c/busses/Makefile
> >> @@ -54,6 +54,7 @@ obj-$(CONFIG_I2C_SH_MOBILE)	+= i2c-sh_mobile.o
> >>  obj-$(CONFIG_I2C_SIMTEC)	+= i2c-simtec.o
> >>  obj-$(CONFIG_I2C_STU300)	+= i2c-stu300.o
> >>  obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
> >> +obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
> >>
> >>  # External I2C/SMBus adapter drivers
> >>  obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
> >> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> >> new file mode 100644
> >> index 0000000..561c4cf
> >> --- /dev/null
> >> +++ b/drivers/i2c/busses/i2c-xiic.c
> >> @@ -0,0 +1,802 @@
> >> +/*
> >> + * i2c-xiic.c
> > 
> > the directory path to the file would have been nice.
> 
> Will update
> 
> > 
> >> + * Copyright (c) 2009 Intel Corporation
> > 
> > is this right, you've not got an @intel.com address?
> 
> It's correct.

ok, a comment either in the file or the documentation about
what relation to intel you are and why you belive you can
submit this. Section (12) of Documentation/SubmittingPatches should
be read on this subject.
 
> > 
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program; if not, write to the Free Software
> >> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> >> + */
> >> +
> >> +/* Supports:
> >> + * Xilinx IIC
> >> + */
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/init.h>
> >> +#include <linux/errno.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/i2c.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/wait.h>
> >> +#include <linux/i2c-xiic.h>
> >> +#include <linux/io.h>
> >> +
> >> +#define DRIVER_NAME "xiic-i2c"
> >> +
> >> +enum xilinx_i2c_state {
> >> +	STATE_DONE,
> >> +	STATE_ERROR,
> >> +	STATE_START
> >> +};
> >> +
> >> +struct xiic_i2c {
> >> +	void __iomem		*base;	/* Memory base of the HW registers */
> >> +	wait_queue_head_t	wait;	/* wait queue for callers */
> >> +	struct i2c_adapter	adap;	/* kernel adapter representation */
> >> +	struct i2c_msg		*tx_msg;/* Messages from above to send */
> >> +	spinlock_t		lock;	/* mutual exclusion */
> >> +	unsigned int 		tx_pos;	/* Current pos in TX message */
> >> +	unsigned int		nmsgs;	/* number of messages in tx_msg */
> >> +	enum xilinx_i2c_state	state;	/* see STATE_ */
> >> +	struct i2c_msg		*rx_msg;/* current RX message */
> >> +	int			rx_pos;	/* position within current RX message */
> >> +};
> > 
> > I'd much rather see this kernel-doced.
> 
> Good idea, will update.
> 
> > 
> >> +
> >> +#define XIIC_MSB_OFFSET 0
> >> +#define XIIC_REG_OFFSET (0x100+XIIC_MSB_OFFSET)
> > 
> > givevn you're running everything through indirect read/write calls,
> > how about doing it in there?
> 
> Could do, bad thing is that it would add in an addition during runtime
> rather than having the C preprocessor doing it.
> 
> I think I would like to leave it as is.
> 
> What do you think?

Compilers aren't that stupid nowadays, they can generally sort this
thing out at compile time, esepcially with inline code. Try it and
see what happens...
 
> > 
> >> +/*
> >> + * Register offsets in bytes from RegisterBase. Three is added to the
> >> + * base offset to access LSB (IBM style) of the word
> >> + */
> >> +#define XIIC_CR_REG_OFFSET   (0x00+XIIC_REG_OFFSET)	/* Control Register   */
> >> +#define XIIC_SR_REG_OFFSET   (0x04+XIIC_REG_OFFSET)	/* Status Register    */
> >> +#define XIIC_DTR_REG_OFFSET  (0x08+XIIC_REG_OFFSET)	/* Data Tx Register   */
> >> +#define XIIC_DRR_REG_OFFSET  (0x0C+XIIC_REG_OFFSET)	/* Data Rx Register   */
> >> +#define XIIC_ADR_REG_OFFSET  (0x10+XIIC_REG_OFFSET)	/* Address Register   */
> >> +#define XIIC_TFO_REG_OFFSET  (0x14+XIIC_REG_OFFSET)	/* Tx FIFO Occupancy  */
> >> +#define XIIC_RFO_REG_OFFSET  (0x18+XIIC_REG_OFFSET)	/* Rx FIFO Occupancy  */
> >> +#define XIIC_TBA_REG_OFFSET  (0x1C+XIIC_REG_OFFSET)	/* 10 Bit Address reg */
> >> +#define XIIC_RFD_REG_OFFSET  (0x20+XIIC_REG_OFFSET)	/* Rx FIFO Depth reg  */
> >> +#define XIIC_GPO_REG_OFFSET  (0x24+XIIC_REG_OFFSET)	/* Output Register    */
> >> +
> >> +/* Control Register masks */
> >> +#define XIIC_CR_ENABLE_DEVICE_MASK        0x01	/* Device enable = 1      */
> >> +#define XIIC_CR_TX_FIFO_RESET_MASK        0x02	/* Transmit FIFO reset=1  */
> >> +#define XIIC_CR_MSMS_MASK                 0x04	/* Master starts Txing=1  */
> >> +#define XIIC_CR_DIR_IS_TX_MASK            0x08	/* Dir of tx. Txing=1     */
> >> +#define XIIC_CR_NO_ACK_MASK               0x10	/* Tx Ack. NO ack = 1     */
> >> +#define XIIC_CR_REPEATED_START_MASK       0x20	/* Repeated start = 1     */
> >> +#define XIIC_CR_GENERAL_CALL_MASK         0x40	/* Gen Call enabled = 1   */
> >> +
> >> +/* Status Register masks */
> >> +#define XIIC_SR_GEN_CALL_MASK             0x01	/* 1=a mstr issued a GC   */
> >> +#define XIIC_SR_ADDR_AS_SLAVE_MASK        0x02	/* 1=when addr as slave   */
> >> +#define XIIC_SR_BUS_BUSY_MASK             0x04	/* 1 = bus is busy        */
> >> +#define XIIC_SR_MSTR_RDING_SLAVE_MASK     0x08	/* 1=Dir: mstr <-- slave  */
> >> +#define XIIC_SR_TX_FIFO_FULL_MASK         0x10	/* 1 = Tx FIFO full       */
> >> +#define XIIC_SR_RX_FIFO_FULL_MASK         0x20	/* 1 = Rx FIFO full       */
> >> +#define XIIC_SR_RX_FIFO_EMPTY_MASK        0x40	/* 1 = Rx FIFO empty      */
> >> +#define XIIC_SR_TX_FIFO_EMPTY_MASK        0x80	/* 1 = Tx FIFO empty      */
> >> +
> >> +/* Interrupt Status Register masks    Interrupt occurs when...       */
> >> +#define XIIC_INTR_ARB_LOST_MASK           0x01	/* 1 = arbitration lost   */
> >> +#define XIIC_INTR_TX_ERROR_MASK           0x02	/* 1=Tx error/msg complete */
> >> +#define XIIC_INTR_TX_EMPTY_MASK           0x04	/* 1 = Tx FIFO/reg empty  */
> >> +#define XIIC_INTR_RX_FULL_MASK            0x08	/* 1=Rx FIFO/reg=OCY level */
> >> +#define XIIC_INTR_BNB_MASK                0x10	/* 1 = Bus not busy       */
> >> +#define XIIC_INTR_AAS_MASK                0x20	/* 1 = when addr as slave */
> >> +#define XIIC_INTR_NAAS_MASK               0x40	/* 1 = not addr as slave  */
> >> +#define XIIC_INTR_TX_HALF_MASK            0x80	/* 1 = TX FIFO half empty */
> >> +
> >> +/* The following constants specify the depth of the FIFOs */
> >> +#define IIC_RX_FIFO_DEPTH         16	/* Rx fifo capacity               */
> >> +#define IIC_TX_FIFO_DEPTH         16	/* Tx fifo capacity               */
> >> +
> >> +/* The following constants specify groups of interrupts that are typically
> >> + * enabled or disables at the same time
> >> + */
> >> +#define XIIC_TX_INTERRUPTS                           \
> >> +(XIIC_INTR_TX_ERROR_MASK | XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_HALF_MASK)
> >> +
> >> +#define XIIC_TX_RX_INTERRUPTS (XIIC_INTR_RX_FULL_MASK | XIIC_TX_INTERRUPTS)
> >> +
> >> +/* The following constants are used with the following macros to specify the
> >> + * operation, a read or write operation.
> >> + */
> >> +#define XIIC_READ_OPERATION  1
> >> +#define XIIC_WRITE_OPERATION 0
> >> +
> >> +/*
> >> + * Tx Fifo upper bit masks.
> >> + */
> >> +#define XIIC_TX_DYN_START_MASK            0x0100 /* 1 = Set dynamic start */
> >> +#define XIIC_TX_DYN_STOP_MASK             0x0200 /* 1 = Set dynamic stop */
> >> +
> >> +/*
> >> + * The following constants define the register offsets for the Interrupt
> >> + * registers. There are some holes in the memory map for reserved addresses
> >> + * to allow other registers to be added and still match the memory map of the
> >> + * interrupt controller registers
> >> + */
> >> +#define XIIC_DGIER_OFFSET    0x1C /* Device Global Interrupt Enable Register */
> >> +#define XIIC_IISR_OFFSET     0x20 /* Interrupt Status Register */
> >> +#define XIIC_IIER_OFFSET     0x28 /* Interrupt Enable Register */
> >> +#define XIIC_RESETR_OFFSET   0x40 /* Reset Register */
> >> +
> >> +#define XIIC_RESET_MASK             0xAUL
> >> +
> >> +/*
> >> + * The following constant is used for the device global interrupt enable
> >> + * register, to enable all interrupts for the device, this is the only bit
> >> + * in the register
> >> + */
> >> +#define XIIC_GINTR_ENABLE_MASK      0x80000000UL
> >> +
> >> +#define xiic_tx_space(i2c) ((i2c)->tx_msg->len - (i2c)->tx_pos)
> >> +#define xiic_rx_space(i2c) ((i2c)->rx_msg->len - (i2c)->rx_pos)
> >> +
> >> +static void xiic_start_xfer(struct xiic_i2c *i2c);
> >> +static void __xiic_start_xfer(struct xiic_i2c *i2c);
> >> +
> >> +static inline void xiic_setreg8(struct xiic_i2c *i2c, int reg, u8 value)
> >> +{
> >> +	iowrite8(value, i2c->base + reg);
> >> +}
> >> +
> >> +static inline u8 xiic_getreg8(struct xiic_i2c *i2c, int reg)
> >> +{
> >> +	return ioread8(i2c->base + reg);
> >> +}
> >> +
> >> +static inline void xiic_setreg16(struct xiic_i2c *i2c, int reg, u16 value)
> >> +{
> >> +	iowrite16(value, i2c->base + reg);
> >> +}
> >> +
> >> +static inline void xiic_setreg32(struct xiic_i2c *i2c, int reg, int value)
> >> +{
> >> +	iowrite32(value, i2c->base + reg);
> >> +}
> >> +
> >> +static inline int xiic_getreg32(struct xiic_i2c *i2c, int reg)
> >> +{
> >> +	return ioread32(i2c->base + reg);
> >> +}
> >> +
> >> +static inline void xiic_irq_dis(struct xiic_i2c *i2c, u32 mask)
> >> +{
> >> +	u32 ier = xiic_getreg32(i2c, XIIC_IIER_OFFSET);
> >> +	xiic_setreg32(i2c, XIIC_IIER_OFFSET, ier & ~mask);
> >> +}
> >> +
> >> +static inline void xiic_irq_en(struct xiic_i2c *i2c, u32 mask)
> >> +{
> >> +	u32 ier = xiic_getreg32(i2c, XIIC_IIER_OFFSET);
> >> +	xiic_setreg32(i2c, XIIC_IIER_OFFSET, ier | mask);
> >> +}
> >> +
> >> +static inline void xiic_irq_clr(struct xiic_i2c *i2c, u32 mask)
> >> +{
> >> +	u32 isr = xiic_getreg32(i2c, XIIC_IISR_OFFSET);
> >> +	xiic_setreg32(i2c, XIIC_IISR_OFFSET, isr & mask);
> >> +}
> >> +
> >> +static inline void xiic_irq_clr_en(struct xiic_i2c *i2c, u32 mask)
> >> +{
> >> +	xiic_irq_clr(i2c, mask);
> >> +	xiic_irq_en(i2c, mask);
> >> +}
> >> +
> >> +static void xiic_clear_rx_fifo(struct xiic_i2c *i2c)
> >> +{
> >> +	u8 sr;
> >> +	for (sr = xiic_getreg8(i2c, XIIC_SR_REG_OFFSET);
> >> +		!(sr & XIIC_SR_RX_FIFO_EMPTY_MASK);
> >> +		sr = xiic_getreg8(i2c, XIIC_SR_REG_OFFSET))
> >> +		xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
> >> +}
> >> +
> >> +static void xiic_reinit(struct xiic_i2c *i2c)
> >> +{
> >> +	xiic_setreg32(i2c, XIIC_RESETR_OFFSET, XIIC_RESET_MASK);
> >> +
> >> +	/* Set receive Fifo depth to maximum (zero based). */
> >> +	xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, IIC_RX_FIFO_DEPTH - 1);
> >> +
> >> +	/* Reset Tx Fifo. */
> >> +	xiic_setreg8(i2c, XIIC_CR_REG_OFFSET, XIIC_CR_TX_FIFO_RESET_MASK);
> >> +
> >> +	/* Enable IIC Device, remove Tx Fifo reset & disable general call. */
> >> +	xiic_setreg8(i2c, XIIC_CR_REG_OFFSET, XIIC_CR_ENABLE_DEVICE_MASK);
> >> +
> >> +	/* make sure RX fifo is empty */
> >> +	xiic_clear_rx_fifo(i2c);
> >> +
> >> +	/* Enable interrupts */
> >> +	xiic_setreg32(i2c, XIIC_DGIER_OFFSET, XIIC_GINTR_ENABLE_MASK);
> >> +
> >> +	xiic_irq_clr_en(i2c, XIIC_INTR_AAS_MASK | XIIC_INTR_ARB_LOST_MASK);
> >> +}
> >> +
> >> +static void xiic_deinit(struct xiic_i2c *i2c)
> >> +{
> >> +	u8 cr;
> >> +
> >> +	xiic_setreg32(i2c, XIIC_RESETR_OFFSET, XIIC_RESET_MASK);
> >> +
> >> +	/* Disable IIC Device. */
> >> +	cr = xiic_getreg8(i2c, XIIC_CR_REG_OFFSET);
> >> +	xiic_setreg8(i2c, XIIC_CR_REG_OFFSET, cr & ~XIIC_CR_ENABLE_DEVICE_MASK);
> >> +}
> >> +
> >> +static void xiic_read_rx(struct xiic_i2c *i2c)
> >> +{
> >> +	u8 bytes_in_fifo;
> >> +	int i;
> >> +
> >> +	bytes_in_fifo = xiic_getreg8(i2c, XIIC_RFO_REG_OFFSET) + 1;
> >> +
> >> +	dev_dbg(i2c->adap.dev.parent, "%s entry, bytes in fifo: %d, msg: %d"
> >> +		", SR: 0x%x, CR: 0x%x\n",
> >> +		__func__, bytes_in_fifo, xiic_rx_space(i2c),
> >> +		xiic_getreg8(i2c, XIIC_SR_REG_OFFSET),
> >> +		xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
> >> +
> >> +	if (bytes_in_fifo > xiic_rx_space(i2c))
> >> +		bytes_in_fifo = xiic_rx_space(i2c);
> >> +
> >> +	for (i = 0; i < bytes_in_fifo; i++)
> >> +		i2c->rx_msg->buf[i2c->rx_pos++] =
> >> +			xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
> >> +
> >> +	xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET,
> >> +		(xiic_rx_space(i2c) > IIC_RX_FIFO_DEPTH) ?
> >> +		IIC_RX_FIFO_DEPTH - 1 :  xiic_rx_space(i2c) - 1);
> >> +}
> >> +
> >> +static int xiic_tx_fifo_space(struct xiic_i2c *i2c)
> >> +{
> >> +	/* return the actual space left in the FIFO */
> >> +	return IIC_TX_FIFO_DEPTH - xiic_getreg8(i2c, XIIC_TFO_REG_OFFSET) - 1;
> >> +}
> >> +
> >> +static void xiic_fill_tx_fifo(struct xiic_i2c *i2c)
> >> +{
> >> +	u8 fifo_space = xiic_tx_fifo_space(i2c);
> >> +	int len = xiic_tx_space(i2c);
> >> +
> >> +	len = (len > fifo_space) ? fifo_space : len;
> >> +
> >> +	dev_dbg(i2c->adap.dev.parent, "%s entry, len: %d, fifo space: %d\n",
> >> +		__func__, len, fifo_space);
> >> +
> >> +	while (len--) {
> >> +		u16 data = i2c->tx_msg->buf[i2c->tx_pos++];
> >> +		if ((xiic_tx_space(i2c) == 0) && (i2c->nmsgs == 1)) {
> >> +			/* last message in transfer -> STOP */
> >> +			data |= XIIC_TX_DYN_STOP_MASK;
> >> +			dev_dbg(i2c->adap.dev.parent, "%s TX STOP\n", __func__);
> >> +
> >> +			xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET, data);
> >> +		} else
> >> +			xiic_setreg8(i2c, XIIC_DTR_REG_OFFSET, data);
> >> +	}
> >> +}
> >> +
> >> +static void xiic_wakeup(struct xiic_i2c *i2c, int code)
> >> +{

> >> +	/* add i2c adapter to i2c tree */
> >> +	ret = i2c_add_adapter(&i2c->adap);
> >> +	if (ret) {
> >> +		dev_err(&pdev->dev, "Failed to add adapter\n");
> >> +		goto add_adapter_failed;
> >> +	}
> >> +
> >> +	/* add in known devices to the bus */
> >> +	for (i = 0; i < pdata->num_devices; i++)
> >> +		i2c_new_device(&i2c->adap, pdata->devices + i);
> > 
> > wouldn't i2c_register_board_info() do the job for you too?
> 
> No actually not, we had a discussion about this like 6-9 months ago,
> when I posted the similar solution as a patch to ocores. Problem is that
> we don't know the bus number in advance and in theory several boards
> containing the I2C bus could in theory show up.
> I would like to see the same solution here.

Sorry, you've just registered the bus so should now know the number?

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
