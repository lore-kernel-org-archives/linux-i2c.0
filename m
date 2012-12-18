From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v4] i2c: Adding support for Intel iSMT SMBus 2.0 host
 controller
Date: Tue, 18 Dec 2012 15:03:37 +0100
Message-ID: <20121218150337.5b861ae3@endymion.delvare>
References: <1354840604-8160-1-git-send-email-bill.e.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354840604-8160-1-git-send-email-bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill E Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Bill,

On Thu,  6 Dec 2012 17:36:44 -0700, Bill E Brown wrote:
> From: Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> The iSMT (Intel SMBus Message Transport) supports multi-master I2C/SMBus,
> as well as IPMI.  It's operation is DMA-based and utilizes descriptors to
> initiate transactions on the bus.
> 
> The iSMT hardware can act as both a master and a target, although this
> driver only supports being a master.
> 
> Signed-off-by: Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/i2c/busses/i2c-ismt |   36 ++
>  drivers/i2c/busses/Kconfig        |   10 +
>  drivers/i2c/busses/Makefile       |    1 +
>  drivers/i2c/busses/i2c-ismt.c     |  911 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 958 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/i2c/busses/i2c-ismt
>  create mode 100644 drivers/i2c/busses/i2c-ismt.c

Looks much better and nearly ready for upstream inclusion. I have a few
minor concerns remaining, see my comments in-line:

> diff --git a/Documentation/i2c/busses/i2c-ismt b/Documentation/i2c/busses/i2c-ismt
> new file mode 100644
> index 0000000..ed6375c
> --- /dev/null
> +++ b/Documentation/i2c/busses/i2c-ismt
> @@ -0,0 +1,36 @@
> +Kernel driver i2c-ismt
> +
> +Supported adapters:
> +  * Intel S12xx series SOCs
> +
> +Authors:
> +	Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> +
> +
> +Module Parameters
> +-----------------
> +
> +* bus_speed (unsigned int)
> +Allows changing of the bus speed.  Normally, the bus speed is set by the BIOS
> +and never needs to be changed.  However, some SMBus analyzers are too slow for
> +monitoring the bus during debug, thus the need for this module parameter.
> +Available bus frequency settings:
> +  0  no change
> +  1  80 kHz
> +  2  100 kHz
> +  3  400 kHz
> +  4  1 MHz

I'm fine with having a module parameter for this, but not so with using
arbitrary values to represent the different speeds. While we don't
(yet) have a standard module parameter for this, several drivers
implementing this feature use actual frequency numbers and I'd prefer
that you do the same. See for example drivers i2c-eg20t, i2c-stu300 and
i2c-viperboard. Or i2c-diolan-u2c, although that one uses Hz instead of
kHz as the unit.

> +
> +
> +Description
> +-----------
> +
> +The S12xx series of SOCs have a pair of integrated SMBus 2.0 controllers
> +targeted primarily at the microserver and storage markets.
> +
> +The S12xx series contain a pair of PCI functions.  An output of lspci will show
> +something similar to the following:
> +
> +  00:13.0 System peripheral: Intel Corporation Device 0xc59
> +  00:13.1 System peripheral: Intel Corporation Device 0xc5a

Actually, as these PCI device IDs have been added to the pci.ids
database meanwhile, you'd rather see:

  00:13.0 System peripheral: Intel Corporation Centerton SMBus 2.0 Controller 0
  00:13.1 System peripheral: Intel Corporation Centerton SMBus 2.0 Controller 1

> +

No blank line at end of file please, git would complain.

> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 7244c8b..64d5756 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -119,6 +119,16 @@ config I2C_ISCH
>  	  This driver can also be built as a module. If so, the module
>  	  will be called i2c-isch.
>  
> +config I2C_ISMT
> +	tristate "Intel iSMT SMBus Controller"
> +	depends on PCI

As the controller is integrated into x86 CPUs, I think you should make
the driver depend on X86.

> +	help
> +	  If you say yes to this option, support will be included for the Intel
> +	  iSMT SMBus host controller interface.
> +
> +	  This driver can also be built as a module.  If so, the module will be
> +	  called i2c-ismt.
> +
>  config I2C_PIIX4
>  	tristate "Intel PIIX4 and compatible (ATI/AMD/Serverworks/Broadcom/SMSC)"
>  	depends on PCI
> (...)
> diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
> new file mode 100644
> index 0000000..17b1bdd
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-ismt.c
> @@ -0,0 +1,911 @@
> (...)
> +/*
> + *  Supports the SMBus Message Transport (SMT) in the Intel Atom Processor
> + *  S12xx Product Family.
> + *
> + *  Features supported by this driver:
> + *  Hardware PEC                     yes
> + *  Block buffer                     yes
> + *  Block process call transaction   no
> + *  Slave mode                       no
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include <linux/kernel.h>
> +#include <linux/stddef.h>
> +#include <linux/completion.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/i2c.h>
> +#include <linux/acpi.h>
> +#include <linux/interrupt.h>
> +
> +/* PCI Address Constants */
> +#define SMBBAR		0
> +
> +/* PCI DIDs for the Intel SMBus Message Transport (SMT) Devices */
> +#define PCI_DEVICE_ID_INTEL_S1200_SMB_SMT0	0x0c59
> +#define PCI_DEVICE_ID_INTEL_S1200_SMB_SMT1	0x0c5a

I don't like "SMB" being used for SMBus as it is ambiguous. Plus,
SMBus and "SMT" are somewhat redundant. So I would suggest the
following names:
PCI_DEVICE_ID_INTEL_S1200_SMT0
PCI_DEVICE_ID_INTEL_S1200_SMT1

> (...)
> +struct ismt_priv {
> +	struct i2c_adapter adapter;
> +	void *smba;				/* PCI BAR */
> +	struct pci_dev *pci_dev;
> +	struct ismt_desc *hw;			/* descriptor virt base addr */
> +	dma_addr_t io_rng_dma;			/* descriptor HW base addr */
> +	u8 head;				/* ring buffer head pointer */
> +	struct completion cmp;			/* interrupt completion */
> +	u8 dma_buffer[I2C_SMBUS_BLOCK_MAX + 3];	/* temp R/W data buffer */

Why + 3? Also, are there no alignment constraints for DMA buffers?

> +	bool using_msi;				/* type of interrupt flag */
> +};
> +
> +/**
> + * ismt_ids - PCI device IDs supported by this driver
> + */
> +static const DEFINE_PCI_DEVICE_TABLE(ismt_ids) = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_S1200_SMB_SMT0) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_S1200_SMB_SMT1) },
> +	{ 0, }
> +};
> +
> +MODULE_DEVICE_TABLE(pci, ismt_ids);
> +
> +/* Bus speed control bits for slow debuggers - refer to the docs for usage */
> +static unsigned int bus_speed;
> +module_param(bus_speed, uint, S_IRUGO);
> +MODULE_PARM_DESC(bus_speed, "Bus Speed");

"Bus speed in kHz (0 = BIOS default)"

> +
> +#if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
> +/**
> + * ismt_desc_dump() - dump the contents of a descriptor for debug purposes
> + * @priv: iSMT private data
> + */
> +static void ismt_desc_dump(struct ismt_priv *priv)
> +{
> +	struct device *dev = &priv->pci_dev->dev;
> +	struct ismt_desc *desc = &priv->hw[priv->head];
> +
> +	dev_dbg(dev, "Dump of the descriptor struct:  0x%X\n", priv->head);
> +	dev_dbg(dev, "\ttgtaddr_rw=0x%02X\n", desc->tgtaddr_rw);
> +	dev_dbg(dev, "\twr_len_cmd=0x%02X\n", desc->wr_len_cmd);
> +	dev_dbg(dev, "\trd_len=    0x%02X\n", desc->rd_len);
> +	dev_dbg(dev, "\tcontrol=   0x%02X\n", desc->control);
> +	dev_dbg(dev, "\tstatus=    0x%02X\n", desc->status);
> +	dev_dbg(dev, "\tretry=     0x%02X\n", desc->retry);
> +	dev_dbg(dev, "\trxbytes=   0x%02X\n", desc->rxbytes);
> +	dev_dbg(dev, "\ttxbytes=   0x%02X\n", desc->txbytes);
> +	dev_dbg(dev, "\tdptr_low=  0x%08X\n", desc->dptr_low);
> +	dev_dbg(dev, "\tdptr_high= 0x%08X\n", desc->dptr_high);
> +}
> +
> +/**
> + * ismt_gen_reg_dump() - dump the iSMT General Registers
> + * @priv: iSMT private data
> + */
> +static void ismt_gen_reg_dump(struct ismt_priv *priv)
> +{
> +	struct device *dev = &priv->pci_dev->dev;
> +
> +	dev_dbg(dev, "Dump of the iSMT General Registers\n");
> +	dev_dbg(dev, "  GCTRL.... : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_GR_GCTRL,
> +		readl(priv->smba + ISMT_GR_GCTRL));
> +	dev_dbg(dev, "  SMTICL... : (0x%p)=0x%016lX\n",
> +		priv->smba + ISMT_GR_SMTICL,
> +		readq(priv->smba + ISMT_GR_SMTICL));

Function readq() doesn't exist on 32-bit x86, causing a build failure.

> +	dev_dbg(dev, "  ERRINTMSK : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_GR_ERRINTMSK,
> +		readl(priv->smba + ISMT_GR_ERRINTMSK));
> +	dev_dbg(dev, "  ERRAERMSK : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_GR_ERRAERMSK,
> +		readl(priv->smba + ISMT_GR_ERRAERMSK));
> +	dev_dbg(dev, "  ERRSTS... : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_GR_ERRSTS,
> +		readl(priv->smba + ISMT_GR_ERRSTS));
> +	dev_dbg(dev, "  ERRINFO.. : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_GR_ERRINFO,
> +		readl(priv->smba + ISMT_GR_ERRINFO));
> +}
> +
> +/**
> + * ismt_mstr_reg_dump() - dump the iSMT Master Registers
> + * @priv: iSMT private data
> + */
> +static void ismt_mstr_reg_dump(struct ismt_priv *priv)
> +{
> +	struct device *dev = &priv->pci_dev->dev;
> +
> +	dev_dbg(dev, "Dump of the iSMT Master Registers\n");
> +	dev_dbg(dev, "  MDBA..... : (0x%p)=0x%016lX\n",
> +		priv->smba + ISMT_MSTR_MDBA,
> +		readq(priv->smba + ISMT_MSTR_MDBA));

Same problem here.

> +	dev_dbg(dev, "  MCTRL.... : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_MSTR_MCTRL,
> +		readl(priv->smba + ISMT_MSTR_MCTRL));
> +	dev_dbg(dev, "  MSTS..... : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_MSTR_MSTS,
> +		readl(priv->smba + ISMT_MSTR_MSTS));
> +	dev_dbg(dev, "  MDS...... : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_MSTR_MDS,
> +		readl(priv->smba + ISMT_MSTR_MDS));
> +	dev_dbg(dev, "  RPOLICY.. : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_MSTR_RPOLICY,
> +		readl(priv->smba + ISMT_MSTR_RPOLICY));
> +	dev_dbg(dev, "  SPGT..... : (0x%p)=0x%X\n",
> +		priv->smba + ISMT_SPGT,
> +		readl(priv->smba + ISMT_SPGT));
> +}

Originally you had an #else here with stubs for when debugging was
disabled. I don't understand why you removed them, as this will cause a
build failure if neither CONFIG_DYNAMIC_DEBUG nor CONFIG_I2C_DEBUG_BUS
is set.

> +#endif
> +
> +/**
> + * ismt_submit_desc() - add a descriptor to the ring
> + * @priv: iSMT private data
> + */
> +static void ismt_submit_desc(struct ismt_priv *priv)
> +{
> +	uint fmhp;
> +	uint val;
> +
> +	ismt_desc_dump(priv);
> +	ismt_gen_reg_dump(priv);
> +	ismt_mstr_reg_dump(priv);
> +
> +	/* Set the FMHP (Firmware Master Head Pointer)*/
> +	fmhp = ((priv->head + 1) % ISMT_DESC_ENTRIES) << 16;
> +	val = readl(priv->smba + ISMT_MSTR_MCTRL);
> +	writel((val & ~ISMT_MCTRL_FMHP) | fmhp,
> +	       priv->smba + ISMT_MSTR_MCTRL);
> +
> +	/* Set the start bit */
> +	val = readl(priv->smba + ISMT_MSTR_MCTRL);
> +	writel(val | ISMT_MCTRL_SS,
> +	       priv->smba + ISMT_MSTR_MCTRL);
> +}
> +
> +/**
> + * ismt_process_desc() - handle the completion of the descriptor
> + * @desc: the iSMT hardware descriptor
> + * @data: data buffer from the upper layer
> + * @dma_buffer: temporary buffer for the DMA engine
> + * @size: SMBus transaction type
> + */
> +static int ismt_process_desc(const struct ismt_desc *desc,
> +			     union i2c_smbus_data *data,
> +			     u8 *dma_buffer, int size)
> +{
> +	if (likely(desc->status & ISMT_DESC_SCS)) {
> +		if (size != I2C_SMBUS_QUICK)

This condition seems incomplete, as far as I can see the memcpy is only
needed for read transactions, not write transactions.

> +			memcpy(data, dma_buffer, sizeof(*data));

Why not limit the size of the copy?

> +		return 0;
> +	}
> +
> +	if (likely(desc->status & ISMT_DESC_NAK))
> +		return -ENXIO;
> +
> +	if (desc->status & ISMT_DESC_CRC)
> +		return -EBADMSG;
> +
> +	if (desc->status & ISMT_DESC_COL)
> +		return -EAGAIN;
> +
> +	if (desc->status & ISMT_DESC_LPR)
> +		return -EPROTO;
> +
> +	if (desc->status & (ISMT_DESC_DLTO | ISMT_DESC_CLTO))
> +		return -ETIMEDOUT;
> +
> +	return -EIO;
> +}
> +
> +/**
> + * ismt_access() - process an SMBus command
> + * @adap: the i2c host adapter
> + * @addr: address of the i2c/SMBus target
> + * @flags: command options
> + * @read_write: read from or write to device
> + * @command: the i2c/SMBus command to issue
> + * @size: SMBus transaction type
> + * @data: read/write data buffer
> + */
> +static int ismt_access(struct i2c_adapter *adap, u16 addr,
> +		       unsigned short flags, char read_write, u8 command,
> +		       int size, union i2c_smbus_data *data)
> +{
> +	int ret;
> +	dma_addr_t dma_addr = 0; /* address of the data buffer */
> +	u8 dma_size = 0;
> +	enum dma_data_direction dma_direction = 0;
> +	struct ismt_desc *desc;
> +	struct ismt_priv *priv = i2c_get_adapdata(adap);
> +	struct device *dev = &priv->pci_dev->dev;
> +
> +	desc = &priv->hw[priv->head];
> +
> +	/* Initialize the descriptor */
> +	memset(desc, 0, sizeof(struct ismt_desc));
> +	desc->tgtaddr_rw = ISMT_DESC_ADDR_RW(addr, read_write);
> +
> +	/* Create a temporary buffer for the DMA transaction */
> +	/* and insert the command at the beginning of the buffer */
> +	if (size != I2C_SMBUS_QUICK) {
> +		memcpy(priv->dma_buffer + 1, data, sizeof(*data));

Here too, this memcpy seems unneeded for read transactions, and for
writes, you could limit the size.

> +		priv->dma_buffer[0] = command;
> +	}
> +
> +	/* Initialize common control bits */
> +	if (likely(priv->using_msi))
> +		desc->control = ISMT_DESC_INT | ISMT_DESC_FAIR;
> +	else
> +		desc->control = ISMT_DESC_FAIR;
> +
> +	if ((flags & I2C_CLIENT_PEC) && (size != I2C_SMBUS_QUICK)
> +	    && (size != I2C_SMBUS_I2C_BLOCK_DATA))
> +		desc->control |= ISMT_DESC_PEC;
> +
> +	switch (size) {
> +	case I2C_SMBUS_QUICK:
> +		dev_dbg(dev, "I2C_SMBUS_QUICK\n");
> +		break;
> +
> +	case I2C_SMBUS_BYTE:
> +		if (read_write == I2C_SMBUS_WRITE) {
> +			/*
> +			 * Send Byte
> +			 * The command field contains the write data
> +			 */
> +			dev_dbg(dev, "I2C_SMBUS_BYTE:  WRITE\n");
> +			desc->control |= ISMT_DESC_CWRL;
> +			desc->wr_len_cmd = command;
> +		} else {
> +			/* Receive Byte */
> +			dev_dbg(dev, "I2C_SMBUS_BYTE:  READ\n");
> +			dma_size = 1;
> +			dma_direction = DMA_FROM_DEVICE;
> +			desc->rd_len = 1;
> +		}
> +
> +		break;
> +
> +	case I2C_SMBUS_BYTE_DATA:
> +		if (read_write == I2C_SMBUS_WRITE) {
> +			/*
> +			 * Write Byte
> +			 * Command plus 1 data byte
> +			 */
> +			dev_dbg(dev, "I2C_SMBUS_BYTE_DATA:  WRITE\n");
> +			desc->wr_len_cmd = 2;
> +			dma_size = 2;
> +			dma_direction = DMA_TO_DEVICE;
> +		} else {
> +			/* Read Byte */
> +			dev_dbg(dev, "I2C_SMBUS_BYTE_DATA:  READ\n");
> +			desc->control |= ISMT_DESC_CWRL;
> +			desc->wr_len_cmd = command;
> +			desc->rd_len = 1;
> +			dma_size = 1;
> +			dma_direction = DMA_FROM_DEVICE;
> +		}
> +
> +		break;
> +
> +	case I2C_SMBUS_WORD_DATA:
> +		if (read_write == I2C_SMBUS_WRITE) {
> +			/* Write Word */
> +			dev_dbg(dev, "I2C_SMBUS_WORD_DATA:  WRITE\n");
> +			desc->wr_len_cmd = 3;
> +			dma_size = 3;
> +			dma_direction = DMA_TO_DEVICE;
> +		} else {
> +			/* Read Word */
> +			dev_dbg(dev, "I2C_SMBUS_WORD_DATA:  READ\n");
> +			desc->wr_len_cmd = command;
> +			desc->control |= ISMT_DESC_CWRL;
> +			desc->rd_len = 2;
> +			dma_size = 2;
> +			dma_direction = DMA_FROM_DEVICE;
> +		}
> +
> +		break;
> +
> +	case I2C_SMBUS_PROC_CALL:
> +		dev_dbg(dev, "I2C_SMBUS_PROC_CALL\n");
> +		desc->wr_len_cmd = 3;
> +		desc->rd_len = 2;
> +		dma_size = 3;
> +		dma_direction = DMA_BIDIRECTIONAL;
> +		break;
> +
> +	case I2C_SMBUS_BLOCK_DATA:
> +		if (read_write == I2C_SMBUS_WRITE) {
> +			/* Block Write */
> +			dev_dbg(dev, "I2C_SMBUS_BLOCK_DATA:  WRITE\n");
> +			dma_size = data->block[0] + 1;
> +			dma_direction = DMA_TO_DEVICE;
> +			desc->wr_len_cmd = dma_size;
> +			desc->control |= ISMT_DESC_BLK;
> +		} else {
> +			/* Block Read */
> +			dev_dbg(dev, "I2C_SMBUS_BLOCK_DATA:  READ\n");
> +			dma_size = I2C_SMBUS_BLOCK_MAX;

If I'm not mistaken, you're missing a + 1 here. I2C_SMBUS_BLOCK_MAX is
the maximum block length value returned by the slave, but there's one
leading byte needed for the command too.

> +			dma_direction = DMA_FROM_DEVICE;
> +			desc->rd_len = dma_size;
> +			desc->wr_len_cmd = command;
> +			desc->control |= (ISMT_DESC_BLK | ISMT_DESC_CWRL);
> +		}
> +
> +		break;
> +
> +	default:
> +		dev_err(dev, "Unsupported transaction %d\n",
> +			size);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* map the data buffer */
> +	if (dma_size != 0) {
> +		dev_dbg(dev, " dev=%p\n", dev);
> +		dev_dbg(dev, " data=%p\n", data);
> +		dev_dbg(dev, " dma_buffer=%p\n", priv->dma_buffer);
> +		dev_dbg(dev, " dma_size=%d\n", dma_size);
> +		dev_dbg(dev, " dma_direction=%d\n", dma_direction);
> +
> +		dma_addr = dma_map_single(&priv->pci_dev->dev,

Just "dev" will do.

> +				      priv->dma_buffer,
> +				      dma_size,
> +				      dma_direction);
> +
> +		dev_dbg(dev, " dma_addr = 0x%016llX\n",
> +			dma_addr);
> +
> +		desc->dptr_low = lower_32_bits(dma_addr);
> +		desc->dptr_high = upper_32_bits(dma_addr);
> +	}
> +
> +	INIT_COMPLETION(priv->cmp);
> +
> +	/* Add the descriptor */
> +	ismt_submit_desc(priv);
> +
> +	/* Now we wait for interrupt completion, 1s */
> +	ret = wait_for_completion_interruptible_timeout(&priv->cmp, HZ*1);
> +
> +	/* unmap the data buffer */
> +	if (dma_size != 0)
> +		dma_unmap_single(&adap->dev, dma_addr, dma_size, dma_direction);
> +
> +	if (likely(ret > 0))
> +		/* do any post processing of the descriptor here */
> +		ret = ismt_process_desc(desc, data, priv->dma_buffer, size);
> +	else if (ret == 0) {
> +		dev_err(dev, "completion wait timed out\n");
> +		ret = -ETIMEDOUT;
> +	} else {
> +		dev_err(dev, "completion wait interrupted\n");

I did not notice during my initial review... Why did you make it
interruptible in the first place? At least 2 i2c bus drivers have moved to
the non-interruptible flavor in the past. See for example commits
4b723a471050a8b80f7fa86e76f01f4c711b3443 and
b7af349b175af45f9d87b3bf3f0a221e1831ed39. Given how short SMBus
transactions are typically, letting them be interrupted seems more
trouble than is worth.

> +		ret = -EIO;
> +	}
> +
> +	/* Update the ring pointer */
> +	priv->head++;
> +	priv->head %= ISMT_DESC_ENTRIES;
> +
> +	return ret;
> +}
> +
> +/**
> + * ismt_func() - report which i2c commands are supported by this adapter
> + * @adap: the i2c host adapter
> + */
> +static u32 ismt_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_SMBUS_QUICK		|
> +		I2C_FUNC_SMBUS_BYTE		|
> +		I2C_FUNC_SMBUS_BYTE_DATA	|
> +		I2C_FUNC_SMBUS_WORD_DATA	|
> +		I2C_FUNC_SMBUS_PROC_CALL	|
> +		I2C_FUNC_SMBUS_BLOCK_DATA	|
> +		I2C_FUNC_SMBUS_PEC;

Nitpicking: can you please align the I2C_... by using seven spaces
instead of one tab?

> +}
> +
> +(...)
> +/**
> + * ismt_do_msi_interrupt() - MSI interrupt handler
> + * @vec: interrupt vector
> + * @data: iSMT private data
> + */
> +static irqreturn_t ismt_do_msi_interrupt(int vec, void *data)
> +{
> +	return ismt_handle_isr(data);
> +}
> +
> +/**
> + * ismt_hw_init() - initialize the iSMT hardware
> + * @priv: iSMT private data
> + */
> +static void __devinit ismt_hw_init(struct ismt_priv *priv)

All __dev* markers are going away meanwhile, so you should remove them
from your code to prevent build failures in future kernels.

> +{
> +	u32 val;
> +	struct device *dev = &priv->pci_dev->dev;
> +
> +	/* initialize the Master Descriptor Base Address (MDBA) */
> +	writel(priv->io_rng_dma, priv->smba + ISMT_MSTR_MDBA);
> +	writel(priv->io_rng_dma >> 32, priv->smba + ISMT_MSTR_MDBA + 4);
> +
> +	/* initialize the Master Control Register (MCTRL) */
> +	writel(ISMT_MCTRL_MEIE, priv->smba + ISMT_MSTR_MCTRL);
> +
> +	/* initialize the Master Status Register (MSTS) */
> +	writel(0, priv->smba + ISMT_MSTR_MSTS);
> +
> +	/* initialize the Master Descriptor Size (MDS) */
> +	val = readl(priv->smba + ISMT_MSTR_MDS);
> +	writel((val & ~ISMT_MDS_MASK) | (ISMT_DESC_ENTRIES - 1),
> +		priv->smba + ISMT_MSTR_MDS);
> +
> +	/*
> +	 * Set the SMBus speed (could use this for slow HW debuggers)
> +	 */
> +
> +	val = readl(priv->smba + ISMT_SPGT);
> +
> +	switch (bus_speed) {
> +	case 0:

Maybe you could set bus_speed here based on the register value you
read. And log the value as well. Rationale: it might be useful for the
user (or for support / debugging) to know the actual clock speed.

> +		break;
> +
> +	case 1:
> +		dev_dbg(dev, "Setting SMBus clock to 80kHz\n");

A space between the number and "kHz" would improve readability.

> +		writel(((val & ~ISMT_SPGT_SPD_MASK) | ISMT_SPGT_SPD_80K),
> +			priv->smba + ISMT_SPGT);
> +		break;
> +
> +	case 2:
> +		dev_dbg(dev, "Setting SMBus clock to 100kHz\n");
> +		writel(((val & ~ISMT_SPGT_SPD_MASK) | ISMT_SPGT_SPD_100K),
> +			priv->smba + ISMT_SPGT);
> +		break;
> +
> +	case 3:
> +		dev_dbg(dev, "Setting SMBus clock to 400kHz\n");
> +		writel(((val & ~ISMT_SPGT_SPD_MASK) | ISMT_SPGT_SPD_400K),
> +			priv->smba + ISMT_SPGT);
> +		break;
> +
> +	case 4:
> +		dev_dbg(dev, "Setting SMBus clock to 1MHz\n");
> +		writel(((val & ~ISMT_SPGT_SPD_MASK) | ISMT_SPGT_SPD_1M),
> +			priv->smba + ISMT_SPGT);
> +		break;
> +
> +	default:
> +		dev_dbg(dev, "Invalid SMBus clock speed, only 1-4 are valid\n");
> +		break;
> +	}
> +}
> +
> + (...)
> +/**
> + * ismt_int_init() - initialize interrupts
> + * @priv: iSMT private data
> + */
> +static int __devinit ismt_int_init(struct ismt_priv *priv)
> +{
> +	int err;
> +
> +	/* Try using MSI interrupts */
> +	err = pci_enable_msi(priv->pci_dev);
> +

No blank line between command and error testing, please.

> +	if (err) {
> +		dev_warn(&priv->pci_dev->dev,
> +			 "Unable to use MSI interrupts, falling back to legacy");

Missing trailing "\n".

> +		goto intx;
> +	}
> +
> +	err = devm_request_irq(&priv->pci_dev->dev,
> +			       priv->pci_dev->irq,
> +			       ismt_do_msi_interrupt,
> +			       0,
> +			       "ismt-msi",
> +			       priv);
> +

No blank line here either.

> +	if (err) {
> +		pci_disable_msi(priv->pci_dev);
> +		goto intx;
> +	}
> +
> +	priv->using_msi = true;
> +	goto done;
> +
> +	/* Try using legacy interrupts */
> +intx:
> +	err = devm_request_irq(&priv->pci_dev->dev,
> +			       priv->pci_dev->irq,
> +			       ismt_do_interrupt,
> +			       IRQF_SHARED,
> +			       "ismt-intx",
> +			       priv);
> +	if (err) {
> +		dev_err(&priv->pci_dev->dev, "no usable interrupts\n");
> +		return -ENODEV;
> +	}
> +
> +	priv->using_msi = false;
> +
> +done:
> +	return 0;
> +}
> +
> +static struct pci_driver ismt_driver;
> +
> +/**
> + * ismt_probe() - probe for iSMT devices
> + * @pdev: PCI-Express device
> + * @id: PCI-Express device ID
> + */
> +static int __devinit
> +ismt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	int err;
> +	struct ismt_priv *priv;
> +	unsigned long start, len;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	pci_set_drvdata(pdev, priv);
> +	i2c_set_adapdata(&priv->adapter, priv);
> +	priv->adapter.owner = THIS_MODULE;
> +
> +	priv->adapter.class = I2C_CLASS_HWMON;
> +
> +	priv->adapter.algo = &smbus_algorithm;
> +
> +	/* set up the sysfs linkage to our parent device */
> +	priv->adapter.dev.parent = &pdev->dev;
> +
> +	/* number of retries on lost arbitration */
> +	priv->adapter.retries = ISMT_MAX_RETRIES;
> +
> +	priv->pci_dev = pdev;
> +
> +	err = pcim_enable_device(pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to enable SMBus PCI device (%d)\n",
> +			err);
> +		return err;
> +	}
> +
> +	/* enable bus mastering */
> +	pci_set_master(pdev);
> +
> +	/* Determine the address of the SMBus area */
> +	start = pci_resource_start(pdev, SMBBAR);
> +	len = pci_resource_len(pdev, SMBBAR);
> +	if (!start || !len) {
> +		dev_err(&pdev->dev,
> +			"SMBus base address uninitialized, upgrade BIOS\n");
> +		return -ENODEV;
> +	}
> +
> +	snprintf(priv->adapter.name, sizeof(priv->adapter.name),
> +		 "SMBus iSMT adapter at %lx", start);
> +
> +	dev_dbg(&priv->pci_dev->dev, " start=0x%lX\n", start);
> +	dev_dbg(&priv->pci_dev->dev, " len=0x%lX\n", len);
> +
> +	err = acpi_check_resource_conflict(&pdev->resource[SMBBAR]);
> +	if (err) {
> +		dev_err(&pdev->dev, "ACPI resource conflict!\n");
> +		return err;
> +	}
> +
> +	err = pci_request_region(pdev, SMBBAR, ismt_driver.name);
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"Failed to request SMBus region 0x%lx-0x%lx\n",
> +			start, start + len);
> +		return err;
> +	}
> +
> +	priv->smba = pcim_iomap(pdev, SMBBAR, len);
> +	if (!priv->smba) {
> +		dev_err(&pdev->dev, "Unable to ioremap SMBus BAR\n");
> +		err = -ENODEV;
> +		goto fail;
> +	}
> +
> +	if ((pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) != 0) ||
> +	    (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64)) != 0)) {
> +		if ((pci_set_dma_mask(pdev, DMA_BIT_MASK(32)) != 0) ||
> +		   (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32)) != 0)) {

One more space for perfect alignment.

> +			dev_warn(&pdev->dev, "pci_set_dma_mask fail %p\n",

With a "goto fail" that's more than a dev_warn, that's a dev_err.

> +				 pdev);
> +			goto fail;
> +		}
> +	}
> +
> +	err = ismt_dev_init(priv);
> +	if (err)
> +		goto fail;
> +
> +	ismt_hw_init(priv);
> +
> +	err = ismt_int_init(priv);
> +	if (err)
> +		goto fail;
> +
> +	err = i2c_add_adapter(&priv->adapter);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to add SMBus iSMT adapter\n");
> +		err = -ENODEV;
> +		goto fail;
> +	}
> +	return 0;
> +
> +fail:
> +	pci_release_region(pdev, SMBBAR);
> +	return err;
> +}
> +
> (...)

Please resubmit with these last issues fixed and I'll be happy to
approve this new driver for upstream inclusion.

-- 
Jean Delvare
