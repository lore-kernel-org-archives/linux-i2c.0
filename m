From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5] i2c: Adding support for Intel iSMT SMBus 2.0 host
 controller
Date: Tue, 29 Jan 2013 15:05:51 +0100
Message-ID: <20130129150551.498b2a9b@endymion.delvare>
References: <20121218150337.5b861ae3@endymion.delvare>
	<1359402232-21369-1-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359402232-21369-1-git-send-email-nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Neil,

On Mon, 28 Jan 2013 14:43:52 -0500, Neil Horman wrote:
> The iSMT (Intel SMBus Message Transport) supports multi-master I2C/SM=
Bus,
> as well as IPMI.  It's operation is DMA-based and utilizes descriptor=
s to
> initiate transactions on the bus.
>=20
> The iSMT hardware can act as both a master and a target, although thi=
s
> driver only supports being a master.
>=20
> Signed-off-by: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
> Signed-off-by: Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Tested-by: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> CC: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> CC: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>=20
> ---
> Forgive the latency in this reply, Jean, Bill has gone on sabbatical,=
 so I
> finished this up on behalf of Intel.

No problem, thanks for stepping in and sending this updated version.
I'm afraid we'll need one more round though (partly my fault, sorry
about that), see my comments in-line.

BTW, when I asked Bill several month ago for a datasheet for this part,
he told me it wasn't available publicly yet. Has the situation changed
meanwhile? There is an issue with SMBus block reads, as you'll see
below. Without a datasheet I can't verify how it can be solved, so
you'll have to do it.

> Change notes for V5)
> * Remove __devexit, __devinit macros
>=20
> * Convert module parameter to use units of khz
>=20
> * Update Description to reflect current pci db
>=20
> * Improve KConfig dependencies
>=20
> * Improve PCI device id names
>=20
> * Reduce dma buffer size to appropriate value and check mapping resul=
t
>=20
> * Fix build failure resulting from missing readq definition
>=20
> * Limit use of memcpy and copy length in ismt_process_desc
>=20
> * Fix off by one error in dma_size
>=20
> * Convert driver to uninterruptible wait on dma transfers
>=20
> * Add spped sync with bus_speed module option
>=20
> * Misc cleanups and fixes
>=20
> * Fix FTBFS when CONFIG_DYNAMIC_DEBUG is off
> ---
>  Documentation/i2c/busses/i2c-ismt |  36 ++
>  drivers/i2c/busses/Kconfig        |  10 +
>  drivers/i2c/busses/Makefile       |   1 +
>  drivers/i2c/busses/i2c-ismt.c     | 932 ++++++++++++++++++++++++++++=
++++++++++
>  4 files changed, 979 insertions(+)
>  create mode 100644 Documentation/i2c/busses/i2c-ismt
>  create mode 100644 drivers/i2c/busses/i2c-ismt.c
>=20
> diff --git a/Documentation/i2c/busses/i2c-ismt b/Documentation/i2c/bu=
sses/i2c-ismt
> new file mode 100644
> index 0000000..aa3b60f
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
> +Allows changing of the bus speed.  Normally, the bus speed is set by=
 the BIOS
> +and never needs to be changed.  However, some SMBus analyzers are to=
o slow for
> +monitoring the bus during debug, thus the need for this module param=
eter.
> +Specify the bus speed in units of KHz.

"in kHz" should do.

> +Available bus frequency settings:
> +  0  no change
> +  80 kHz
> +  100 kHz
> +  400 kHz
> +  1000 KHz

Should still be a lowercase "k" even if it's a big number ;)

> +
> +
> +Description
> +-----------
> +
> +The S12xx series of SOCs have a pair of integrated SMBus 2.0 control=
lers
> +targeted primarily at the microserver and storage markets.
> +
> +The S12xx series contain a pair of PCI functions.  An output of lspc=
i will show
> +something similar to the following:
> +
> +  00:13.0 System peripheral: Intel Corporation Centerton SMBus 2.0 C=
ontroller 0
> +  00:13.1 System peripheral: Intel Corporation Centerton SMBus 2.0 C=
ontroller 1
> (...)
> diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-i=
smt.c
> new file mode 100644
> index 0000000..5ad4680
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-ismt.c
> @@ -0,0 +1,932 @@
> (...)
> +/*
> + *  Supports the SMBus Message Transport (SMT) in the Intel Atom Pro=
cessor
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
> +#include <asm-generic/io-64-nonatomic-lo-hi.h>

This should fix the build issue on X86_32. This also means that you
should now be able to write register value ISMT_MSTR_MDBA in
ismt_hw_init() using writeq(), as was done originally, instead of two
writel(). This would be both more efficient and more consistent.

There are two build warnings left on 32-bit, see below.

> (...)
> +/* Bus speed control bits for slow debuggers - refer to the docs for=
 usage */
> +static unsigned int bus_speed;
> +module_param(bus_speed, uint, S_IRUGO);
> +MODULE_PARM_DESC(bus_speed, "Bus Speed in KHz (0 =3D BIOS default)")=
;

Proper casing is "kHz".

> (...)
> +/**
> + * ismt_gen_reg_dump() - dump the iSMT General Registers
> + * @priv: iSMT private data
> + */
> +static void ismt_gen_reg_dump(struct ismt_priv *priv)
> +{
> +	struct device *dev =3D &priv->pci_dev->dev;
> +
> +	dev_dbg(dev, "Dump of the iSMT General Registers\n");
> +	dev_dbg(dev, "  GCTRL.... : (0x%p)=3D0x%X\n",
> +		priv->smba + ISMT_GR_GCTRL,
> +		readl(priv->smba + ISMT_GR_GCTRL));
> +	dev_dbg(dev, "  SMTICL... : (0x%p)=3D0x%016lX\n",
> +		priv->smba + ISMT_GR_SMTICL,
> +		readq(priv->smba + ISMT_GR_SMTICL));

drivers/i2c/busses/i2c-ismt.c: In function =E2=80=98ismt_gen_reg_dump=E2=
=80=99:
drivers/i2c/busses/i2c-ismt.c:232: warning: format =E2=80=98%016lX=E2=80=
=99 expects type =E2=80=98long unsigned int=E2=80=99, but argument 5 ha=
s type =E2=80=98__u64=E2=80=99

> +	dev_dbg(dev, "  ERRINTMSK : (0x%p)=3D0x%X\n",
> +		priv->smba + ISMT_GR_ERRINTMSK,
> +		readl(priv->smba + ISMT_GR_ERRINTMSK));
> +	dev_dbg(dev, "  ERRAERMSK : (0x%p)=3D0x%X\n",
> +		priv->smba + ISMT_GR_ERRAERMSK,
> +		readl(priv->smba + ISMT_GR_ERRAERMSK));
> +	dev_dbg(dev, "  ERRSTS... : (0x%p)=3D0x%X\n",
> +		priv->smba + ISMT_GR_ERRSTS,
> +		readl(priv->smba + ISMT_GR_ERRSTS));
> +	dev_dbg(dev, "  ERRINFO.. : (0x%p)=3D0x%X\n",
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
> +	struct device *dev =3D &priv->pci_dev->dev;
> +
> +	dev_dbg(dev, "Dump of the iSMT Master Registers\n");
> +	dev_dbg(dev, "  MDBA..... : (0x%p)=3D0x%016lX\n",
> +		priv->smba + ISMT_MSTR_MDBA,
> +		readq(priv->smba + ISMT_MSTR_MDBA));

drivers/i2c/busses/i2c-ismt.c: In function =E2=80=98ismt_mstr_reg_dump=E2=
=80=99:
drivers/i2c/busses/i2c-ismt.c:258: warning: format =E2=80=98%016lX=E2=80=
=99 expects type =E2=80=98long unsigned int=E2=80=99, but argument 5 ha=
s type =E2=80=98__u64=E2=80=99

> +	dev_dbg(dev, "  MCTRL.... : (0x%p)=3D0x%X\n",
> +		priv->smba + ISMT_MSTR_MCTRL,
> +		readl(priv->smba + ISMT_MSTR_MCTRL));
> +	dev_dbg(dev, "  MSTS..... : (0x%p)=3D0x%X\n",
> +		priv->smba + ISMT_MSTR_MSTS,
> +		readl(priv->smba + ISMT_MSTR_MSTS));
> +	dev_dbg(dev, "  MDS...... : (0x%p)=3D0x%X\n",
> +		priv->smba + ISMT_MSTR_MDS,
> +		readl(priv->smba + ISMT_MSTR_MDS));
> +	dev_dbg(dev, "  RPOLICY.. : (0x%p)=3D0x%X\n",
> +		priv->smba + ISMT_MSTR_RPOLICY,
> +		readl(priv->smba + ISMT_MSTR_RPOLICY));
> +	dev_dbg(dev, "  SPGT..... : (0x%p)=3D0x%X\n",
> +		priv->smba + ISMT_SPGT,
> +		readl(priv->smba + ISMT_SPGT));
> +}
> +
> (...)
> +/**
> + * ismt_process_desc() - handle the completion of the descriptor
> + * @desc: the iSMT hardware descriptor
> + * @data: data buffer from the upper layer
> + * @dma_buffer: temporary buffer for the DMA engine
> + * @size: SMBus transaction type
> + */
> +static int ismt_process_desc(const struct ismt_desc *desc,
> +			     union i2c_smbus_data *data,
> +			     u8 *dma_buffer, int size,
> +			     char read_write)
> +{
> +	if ((read_write =3D=3D I2C_SMBUS_READ) &&
> +	    (desc->status & ISMT_DESC_SCS)) {

You added the "read_write =3D=3D I2C_SMBUS_READ" test in the wrong plac=
e.
You should add it below, to limit the memcpy to read transactions.
Putting it here instead will cause all write transactions to be
reported as having failed. Which brings a question... you did not test
the updated driver, did you?

> +		if (size !=3D I2C_SMBUS_QUICK)
> +			memcpy(data, dma_buffer,
> +			       min(sizeof(*data), (size_t)I2C_SMBUS_BLOCK_MAX));

This computation looks wrong. We already know that sizeof(*data) =3D=3D
sizeof(union i2c_smbus_data) > I2C_SMBUS_BLOCK_MAX, so the min() above
will always return I2C_SMBUS_BLOCK_MAX. Which may be insufficient as
the first byte holds the length, and at the same time it will be more
than needed in most cases.

My original suggestion to limit the size of the copy was meant as a
run-time optimization, i.e. copying exactly the number of bytes that
were received from the slave. That would be 1 or 2 for non-block reads,
and the block length for block reads. Unfortunately I'm not sure is the
block length is available. See my comment about this below in
ismt_access().

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
> +	dma_addr_t dma_addr =3D 0; /* address of the data buffer */
> +	u8 dma_size =3D 0;
> +	enum dma_data_direction dma_direction =3D 0;
> +	struct ismt_desc *desc;
> +	struct ismt_priv *priv =3D i2c_get_adapdata(adap);
> +	struct device *dev =3D &priv->pci_dev->dev;
> +
> +	desc =3D &priv->hw[priv->head];
> +
> +	/* Initialize the descriptor */
> +	memset(desc, 0, sizeof(struct ismt_desc));
> +	desc->tgtaddr_rw =3D ISMT_DESC_ADDR_RW(addr, read_write);
> +
> +	/* Create a temporary buffer for the DMA transaction */
> +	/* and insert the command at the beginning of the buffer */
> +	if ((read_write =3D=3D I2C_SMBUS_WRITE) &&
> +	    (size !=3D I2C_SMBUS_QUICK)) {

If I read the code below properly, this can be skipped for size =3D=3D
I2C_SMBUS_BYTE too, right?

> +		memcpy(priv->dma_buffer + 1, data,
> +		       min(sizeof(*data), (size_t)I2C_SMBUS_BLOCK_MAX));

Thinking about it some more, this is wrong for block transactions.
Sorry for not spotting it before. For block transactions,
data->block[0] is used for the length, so you can't just copy the union
i2c_smbus_data blindly to dma_buffer. You have to start copying from
data->block[1], and data->block[0] could be used to limit the length of
the memcpy. For non-block writes, length can only be 1 or 2 so you
could limit it to 2.

> +		priv->dma_buffer[0] =3D command;
> +	}
> +
> +	/* Initialize common control bits */
> +	if (likely(priv->using_msi))
> +		desc->control =3D ISMT_DESC_INT | ISMT_DESC_FAIR;
> +	else
> +		desc->control =3D ISMT_DESC_FAIR;
> +
> +	if ((flags & I2C_CLIENT_PEC) && (size !=3D I2C_SMBUS_QUICK)
> +	    && (size !=3D I2C_SMBUS_I2C_BLOCK_DATA))
> +		desc->control |=3D ISMT_DESC_PEC;
> +
> +	switch (size) {
> +	case I2C_SMBUS_QUICK:
> +		dev_dbg(dev, "I2C_SMBUS_QUICK\n");
> +		break;
> +
> +	case I2C_SMBUS_BYTE:
> +		if (read_write =3D=3D I2C_SMBUS_WRITE) {
> +			/*
> +			 * Send Byte
> +			 * The command field contains the write data
> +			 */
> +			dev_dbg(dev, "I2C_SMBUS_BYTE:  WRITE\n");
> +			desc->control |=3D ISMT_DESC_CWRL;
> +			desc->wr_len_cmd =3D command;
> +		} else {
> +			/* Receive Byte */
> +			dev_dbg(dev, "I2C_SMBUS_BYTE:  READ\n");
> +			dma_size =3D 1;
> +			dma_direction =3D DMA_FROM_DEVICE;
> +			desc->rd_len =3D 1;
> +		}
> +

This blank line could go away. There are more occurrences of this in
this function.

> +		break;
> +
> +	case I2C_SMBUS_BYTE_DATA:
> +		if (read_write =3D=3D I2C_SMBUS_WRITE) {
> +			/*
> +			 * Write Byte
> +			 * Command plus 1 data byte
> +			 */
> +			dev_dbg(dev, "I2C_SMBUS_BYTE_DATA:  WRITE\n");
> +			desc->wr_len_cmd =3D 2;
> +			dma_size =3D 2;
> +			dma_direction =3D DMA_TO_DEVICE;
> +		} else {
> +			/* Read Byte */
> +			dev_dbg(dev, "I2C_SMBUS_BYTE_DATA:  READ\n");
> +			desc->control |=3D ISMT_DESC_CWRL;
> +			desc->wr_len_cmd =3D command;
> +			desc->rd_len =3D 1;
> +			dma_size =3D 1;
> +			dma_direction =3D DMA_FROM_DEVICE;
> +		}
> +
> +		break;
> +
> +	case I2C_SMBUS_WORD_DATA:
> +		if (read_write =3D=3D I2C_SMBUS_WRITE) {
> +			/* Write Word */
> +			dev_dbg(dev, "I2C_SMBUS_WORD_DATA:  WRITE\n");
> +			desc->wr_len_cmd =3D 3;
> +			dma_size =3D 3;
> +			dma_direction =3D DMA_TO_DEVICE;
> +		} else {
> +			/* Read Word */
> +			dev_dbg(dev, "I2C_SMBUS_WORD_DATA:  READ\n");
> +			desc->wr_len_cmd =3D command;
> +			desc->control |=3D ISMT_DESC_CWRL;
> +			desc->rd_len =3D 2;
> +			dma_size =3D 2;
> +			dma_direction =3D DMA_FROM_DEVICE;
> +		}
> +
> +		break;
> +
> +	case I2C_SMBUS_PROC_CALL:
> +		dev_dbg(dev, "I2C_SMBUS_PROC_CALL\n");
> +		desc->wr_len_cmd =3D 3;
> +		desc->rd_len =3D 2;
> +		dma_size =3D 3;
> +		dma_direction =3D DMA_BIDIRECTIONAL;
> +		break;
> +
> +	case I2C_SMBUS_BLOCK_DATA:
> +		if (read_write =3D=3D I2C_SMBUS_WRITE) {
> +			/* Block Write */
> +			dev_dbg(dev, "I2C_SMBUS_BLOCK_DATA:  WRITE\n");
> +			dma_size =3D data->block[0] + 1;
> +			dma_direction =3D DMA_TO_DEVICE;
> +			desc->wr_len_cmd =3D dma_size;
> +			desc->control |=3D ISMT_DESC_BLK;
> +		} else {
> +			/* Block Read */
> +			dev_dbg(dev, "I2C_SMBUS_BLOCK_DATA:  READ\n");
> +			dma_size =3D I2C_SMBUS_BLOCK_MAX + 1;

I am the one who asked for the + 1 here, now I realize it might not be
correct. It really depends on what the hardware is returning on SMBus
block reads.

What you are supposed to return to the caller, per Linux' i2c API, is
the block length in data->block[0] and that many bytes in
data->block[1..n]. Question is, what do you get from the hardware in
dma_buffer? If you get the block length followed by the data then
"dma_size =3D I2C_SMBUS_BLOCK_MAX + 1" is correct and the code in
ismt_process_desc() is almost correct as well (you only have to get the
memcpy size right.)

OTOH if the hardware gives your only the data bytes in dma_buffer, then
the "+ 1" above is wrong, and we also face an issue with retrieving the
block length. Where is the hardware making it available to us? I
certainly hope it does.=20

> +			dma_direction =3D DMA_FROM_DEVICE;
> +			desc->rd_len =3D dma_size;
> +			desc->wr_len_cmd =3D command;
> +			desc->control |=3D (ISMT_DESC_BLK | ISMT_DESC_CWRL);
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
> +	if (dma_size !=3D 0) {
> +		dev_dbg(dev, " dev=3D%p\n", dev);
> +		dev_dbg(dev, " data=3D%p\n", data);
> +		dev_dbg(dev, " dma_buffer=3D%p\n", priv->dma_buffer);
> +		dev_dbg(dev, " dma_size=3D%d\n", dma_size);
> +		dev_dbg(dev, " dma_direction=3D%d\n", dma_direction);
> +
> +		dma_addr =3D dma_map_single(dev,
> +				      priv->dma_buffer,
> +				      dma_size,
> +				      dma_direction);
> +
> +		if (dma_mapping_error(dev, dma_addr)) {
> +			dev_err(dev, "Error in mapping dma buffer %p\n", priv->dma_buffer=
);
> +			return -EIO;
> +		}
> +
> +		dev_dbg(dev, " dma_addr =3D 0x%016llX\n",
> +			dma_addr);
> +
> +		desc->dptr_low =3D lower_32_bits(dma_addr);
> +		desc->dptr_high =3D upper_32_bits(dma_addr);
> +	}
> +
> +	INIT_COMPLETION(priv->cmp);
> +
> +	/* Add the descriptor */
> +	ismt_submit_desc(priv);
> +
> +	/* Now we wait for interrupt completion, 1s */
> +	ret =3D wait_for_completion_timeout(&priv->cmp, HZ*1);
> +
> +	/* unmap the data buffer */
> +	if (dma_size !=3D 0)
> +		dma_unmap_single(&adap->dev, dma_addr, dma_size, dma_direction);
> +
> +	if (unlikely(!ret)) {
> +		dev_err(dev, "completion wait timed out\n");
> +		ret =3D -ETIMEDOUT;
> +	}=20
> +
> +	/* do any post processing of the descriptor here */
> +	ret =3D ismt_process_desc(desc, data, priv->dma_buffer, size, read_=
write);

There's something wrong here, the "ret =3D -ETIMEDOUT" above is
overwritten by this call so the error code is lost. Bill's code did not
have the problem, not sure why you changed it.

> +
> +	/* Update the ring pointer */
> +	priv->head++;
> +	priv->head %=3D ISMT_DESC_ENTRIES;
> +
> +	return ret;
> +}
> +
> (...)
> +/**
> + * ismt_hw_init() - initialize the iSMT hardware
> + * @priv: iSMT private data
> + */
> +static void ismt_hw_init(struct ismt_priv *priv)
> +{
> +	u32 val;
> +	struct device *dev =3D &priv->pci_dev->dev;
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
> +	val =3D readl(priv->smba + ISMT_MSTR_MDS);
> +	writel((val & ~ISMT_MDS_MASK) | (ISMT_DESC_ENTRIES - 1),
> +		priv->smba + ISMT_MSTR_MDS);
> +
> +	/*
> +	 * Set the SMBus speed (could use this for slow HW debuggers)
> +	 */
> +
> +	val =3D readl(priv->smba + ISMT_SPGT);
> +
> +	switch (bus_speed) {
> +	case 0:
> +		break;
> +
> +	case 80:
> +		dev_dbg(dev, "Setting SMBus clock to 80 kHz\n");

You did add a space here between "80" and "kHz" as I asked, but...

> +		writel(((val & ~ISMT_SPGT_SPD_MASK) | ISMT_SPGT_SPD_80K),
> +			priv->smba + ISMT_SPGT);
> +		break;
> +
> +	case 100:
> +		dev_dbg(dev, "Setting SMBus clock to 100kHz\n");

=2E.. not here...

> +		writel(((val & ~ISMT_SPGT_SPD_MASK) | ISMT_SPGT_SPD_100K),
> +			priv->smba + ISMT_SPGT);
> +		break;
> +
> +	case 400:
> +		dev_dbg(dev, "Setting SMBus clock to 400kHz\n");

=2E.. nor here...

> +		writel(((val & ~ISMT_SPGT_SPD_MASK) | ISMT_SPGT_SPD_400K),
> +			priv->smba + ISMT_SPGT);
> +		break;
> +
> +	case 1000:
> +		dev_dbg(dev, "Setting SMBus clock to 1MHz\n");

=2E.. nor here.

> +		writel(((val & ~ISMT_SPGT_SPD_MASK) | ISMT_SPGT_SPD_1M),
> +			priv->smba + ISMT_SPGT);
> +		break;
> +
> +	default:
> +		dev_dbg(dev, "Invalid SMBus clock speed, only 1-4 are valid\n");

Valid values are now 80, 100, 400 and 1000. This is more than a debug
message BTW, this should be a warning IMHO.

> +		break;
> +	}
> +
> +	switch (val & ISMT_SPGT_SPD_MASK) {
> +	case ISMT_SPGT_SPD_80K:
> +		bus_speed =3D 80;
> +		break;
> +	case ISMT_SPGT_SPD_100K:
> +		bus_speed =3D 100;
> +		break;
> +	case ISMT_SPGT_SPD_400K:
> +		bus_speed =3D 400;
> +		break;
> +	case ISMT_SPGT_SPD_1M:
> +		bus_speed =3D 1000;
> +		break;
> +	}
> +	dev_dbg(dev, "SMBus clock is running at %d KHz\n", bus_speed);

This is incorrect. You changed the value of register ISMT_SPGT based on
the value of bus_speed, however you did not update "val" accordingly.
So if the user forced a specific speed, the value you are printing is
the speed at which the bus _was_ running before.

So you must update val prior to writing the new value to the register.

Also note that the proper casing is "kHz".

> +}
> +
> (...)
> +/**
> + * ismt_probe() - probe for iSMT devices
> + * @pdev: PCI-Express device
> + * @id: PCI-Express device ID
> + */
> +static int
> +ismt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	int err;
> +	struct ismt_priv *priv;
> +	unsigned long start, len;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	pci_set_drvdata(pdev, priv);
> +	i2c_set_adapdata(&priv->adapter, priv);
> +	priv->adapter.owner =3D THIS_MODULE;
> +
> +	priv->adapter.class =3D I2C_CLASS_HWMON;
> +
> +	priv->adapter.algo =3D &smbus_algorithm;
> +
> +	/* set up the sysfs linkage to our parent device */
> +	priv->adapter.dev.parent =3D &pdev->dev;
> +
> +	/* number of retries on lost arbitration */
> +	priv->adapter.retries =3D ISMT_MAX_RETRIES;
> +
> +	priv->pci_dev =3D pdev;
> +
> +	err =3D pcim_enable_device(pdev);
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
> +	start =3D pci_resource_start(pdev, SMBBAR);
> +	len =3D pci_resource_len(pdev, SMBBAR);
> +	if (!start || !len) {
> +		dev_err(&pdev->dev,
> +			"SMBus base address uninitialized, upgrade BIOS\n");
> +		return -ENODEV;
> +	}
> +
> +	snprintf(priv->adapter.name, sizeof(priv->adapter.name),
> +		 "SMBus iSMT adapter at %lx", start);
> +
> +	dev_dbg(&priv->pci_dev->dev, " start=3D0x%lX\n", start);
> +	dev_dbg(&priv->pci_dev->dev, " len=3D0x%lX\n", len);
> +
> +	err =3D acpi_check_resource_conflict(&pdev->resource[SMBBAR]);
> +	if (err) {
> +		dev_err(&pdev->dev, "ACPI resource conflict!\n");
> +		return err;
> +	}
> +
> +	err =3D pci_request_region(pdev, SMBBAR, ismt_driver.name);
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"Failed to request SMBus region 0x%lx-0x%lx\n",
> +			start, start + len);
> +		return err;
> +	}
> +
> +	priv->smba =3D pcim_iomap(pdev, SMBBAR, len);
> +	if (!priv->smba) {
> +		dev_err(&pdev->dev, "Unable to ioremap SMBus BAR\n");
> +		err =3D -ENODEV;
> +		goto fail;
> +	}
> +
> +	if ((pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) !=3D 0) ||
> +	    (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64)) !=3D 0)) {
> +		if ((pci_set_dma_mask(pdev, DMA_BIT_MASK(32)) !=3D 0) ||
> +		    (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32)) !=3D 0)) =
{
> +			dev_err(&pdev->dev, "pci_set_dma_mask fail %p\n",
> +				 pdev);

One less space before "pdev" for perfect alignment.

> +			goto fail;
> +		}
> +	}
> +
> +	err =3D ismt_dev_init(priv);
> +	if (err)
> +		goto fail;
> +
> +	ismt_hw_init(priv);
> +
> +	err =3D ismt_int_init(priv);
> +	if (err)
> +		goto fail;
> +
> +	err =3D i2c_add_adapter(&priv->adapter);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to add SMBus iSMT adapter\n");
> +		err =3D -ENODEV;
> +		goto fail;
> +	}
> +	return 0;
> +
> +fail:
> +	pci_release_region(pdev, SMBBAR);
> +	return err;
> +}

--=20
Jean Delvare
