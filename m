From: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH v5] i2c: Adding support for Intel iSMT SMBus 2.0 host
 controller
Date: Tue, 29 Jan 2013 10:32:53 -0500
Message-ID: <20130129153253.GA14044@hmsreliant.think-freely.org>
References: <20121218150337.5b861ae3@endymion.delvare>
 <1359402232-21369-1-git-send-email-nhorman@tuxdriver.com>
 <20130129150551.498b2a9b@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130129150551.498b2a9b-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 29, 2013 at 03:05:51PM +0100, Jean Delvare wrote:
> Hi Neil,
>=20
> On Mon, 28 Jan 2013 14:43:52 -0500, Neil Horman wrote:
> > The iSMT (Intel SMBus Message Transport) supports multi-master I2C/=
SMBus,
> > as well as IPMI.  It's operation is DMA-based and utilizes descript=
ors to
> > initiate transactions on the bus.
> >=20
> > The iSMT hardware can act as both a master and a target, although t=
his
> > driver only supports being a master.
> >=20
> > Signed-off-by: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
> > Signed-off-by: Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Tested-by: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > CC: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > CC: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> >=20
> > ---
> > Forgive the latency in this reply, Jean, Bill has gone on sabbatica=
l, so I
> > finished this up on behalf of Intel.
>=20
> No problem, thanks for stepping in and sending this updated version.
> I'm afraid we'll need one more round though (partly my fault, sorry
> about that), see my comments in-line.
>=20
Understood, and no problem, I'll square it up.

> BTW, when I asked Bill several month ago for a datasheet for this par=
t,
> he told me it wasn't available publicly yet. Has the situation change=
d
> meanwhile? There is an issue with SMBus block reads, as you'll see
> below. Without a datasheet I can't verify how it can be solved, so
> you'll have to do it.
>=20
I'm afraid not (at least not that I know of), the only reason that I wa=
s able to
post this was because most of the changes were fairly trivial.  I'll se=
e if I
can't push to get a datasheet released however, either publically, or t=
o myself,
so that I can verify the issue.
> > +
> > +Module Parameters
> > +-----------------
> > +
> > +* bus_speed (unsigned int)
> > +Allows changing of the bus speed.  Normally, the bus speed is set =
by the BIOS
> > +and never needs to be changed.  However, some SMBus analyzers are =
too slow for
> > +monitoring the bus during debug, thus the need for this module par=
ameter.
> > +Specify the bus speed in units of KHz.
>=20
> "in kHz" should do.
>=20
No problem.

> > +Available bus frequency settings:
> > +  0  no change
> > +  80 kHz
> > +  100 kHz
> > +  400 kHz
> > +  1000 KHz
>=20
> Should still be a lowercase "k" even if it's a big number ;)
>=20
Check.

> > +
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/pci.h>
> > +#include <linux/kernel.h>
> > +#include <linux/stddef.h>
> > +#include <linux/completion.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/i2c.h>
> > +#include <linux/acpi.h>
> > +#include <linux/interrupt.h>
> > +
> > +#include <asm-generic/io-64-nonatomic-lo-hi.h>
>=20
> This should fix the build issue on X86_32. This also means that you
> should now be able to write register value ISMT_MSTR_MDBA in
> ismt_hw_init() using writeq(), as was done originally, instead of two
> writel(). This would be both more efficient and more consistent.
>=20
Understood, I'll put that back.

> There are two build warnings left on 32-bit, see below.
>=20
> > (...)
> > +/* Bus speed control bits for slow debuggers - refer to the docs f=
or usage */
> > +static unsigned int bus_speed;
> > +module_param(bus_speed, uint, S_IRUGO);
> > +MODULE_PARM_DESC(bus_speed, "Bus Speed in KHz (0 =3D BIOS default)=
");
>=20
> Proper casing is "kHz".
>=20
yup

> > (...)
> > +/**
> > + * ismt_gen_reg_dump() - dump the iSMT General Registers
> > + * @priv: iSMT private data
> > + */
> > +static void ismt_gen_reg_dump(struct ismt_priv *priv)
> > +{
> > +	struct device *dev =3D &priv->pci_dev->dev;
> > +
> > +	dev_dbg(dev, "Dump of the iSMT General Registers\n");
> > +	dev_dbg(dev, "  GCTRL.... : (0x%p)=3D0x%X\n",
> > +		priv->smba + ISMT_GR_GCTRL,
> > +		readl(priv->smba + ISMT_GR_GCTRL));
> > +	dev_dbg(dev, "  SMTICL... : (0x%p)=3D0x%016lX\n",
> > +		priv->smba + ISMT_GR_SMTICL,
> > +		readq(priv->smba + ISMT_GR_SMTICL));
>=20
> drivers/i2c/busses/i2c-ismt.c: In function =E2=80=98ismt_gen_reg_dump=
=E2=80=99:
> drivers/i2c/busses/i2c-ismt.c:232: warning: format =E2=80=98%016lX=E2=
=80=99 expects type =E2=80=98long unsigned int=E2=80=99, but argument 5=
 has type =E2=80=98__u64=E2=80=99
>=20
Doh!  My bad, I'll fix that up.

> > +	dev_dbg(dev, "  ERRINTMSK : (0x%p)=3D0x%X\n",
> > +		priv->smba + ISMT_GR_ERRINTMSK,
> > +		readl(priv->smba + ISMT_GR_ERRINTMSK));
> > +	dev_dbg(dev, "  ERRAERMSK : (0x%p)=3D0x%X\n",
> > +		priv->smba + ISMT_GR_ERRAERMSK,
> > +		readl(priv->smba + ISMT_GR_ERRAERMSK));
> > +	dev_dbg(dev, "  ERRSTS... : (0x%p)=3D0x%X\n",
> > +		priv->smba + ISMT_GR_ERRSTS,
> > +		readl(priv->smba + ISMT_GR_ERRSTS));
> > +	dev_dbg(dev, "  ERRINFO.. : (0x%p)=3D0x%X\n",
> > +		priv->smba + ISMT_GR_ERRINFO,
> > +		readl(priv->smba + ISMT_GR_ERRINFO));
> > +}
> > +
> > +/**
> > + * ismt_mstr_reg_dump() - dump the iSMT Master Registers
> > + * @priv: iSMT private data
> > + */
> > +static void ismt_mstr_reg_dump(struct ismt_priv *priv)
> > +{
> > +	struct device *dev =3D &priv->pci_dev->dev;
> > +
> > +	dev_dbg(dev, "Dump of the iSMT Master Registers\n");
> > +	dev_dbg(dev, "  MDBA..... : (0x%p)=3D0x%016lX\n",
> > +		priv->smba + ISMT_MSTR_MDBA,
> > +		readq(priv->smba + ISMT_MSTR_MDBA));
>=20
> drivers/i2c/busses/i2c-ismt.c: In function =E2=80=98ismt_mstr_reg_dum=
p=E2=80=99:
> drivers/i2c/busses/i2c-ismt.c:258: warning: format =E2=80=98%016lX=E2=
=80=99 expects type =E2=80=98long unsigned int=E2=80=99, but argument 5=
 has type =E2=80=98__u64=E2=80=99
>=20
Ditto.

> > +	dev_dbg(dev, "  MCTRL.... : (0x%p)=3D0x%X\n",
> > +		priv->smba + ISMT_MSTR_MCTRL,
> > +		readl(priv->smba + ISMT_MSTR_MCTRL));
> > +	dev_dbg(dev, "  MSTS..... : (0x%p)=3D0x%X\n",
> > +		priv->smba + ISMT_MSTR_MSTS,
> > +		readl(priv->smba + ISMT_MSTR_MSTS));
> > +	dev_dbg(dev, "  MDS...... : (0x%p)=3D0x%X\n",
> > +		priv->smba + ISMT_MSTR_MDS,
> > +		readl(priv->smba + ISMT_MSTR_MDS));
> > +	dev_dbg(dev, "  RPOLICY.. : (0x%p)=3D0x%X\n",
> > +		priv->smba + ISMT_MSTR_RPOLICY,
> > +		readl(priv->smba + ISMT_MSTR_RPOLICY));
> > +	dev_dbg(dev, "  SPGT..... : (0x%p)=3D0x%X\n",
> > +		priv->smba + ISMT_SPGT,
> > +		readl(priv->smba + ISMT_SPGT));
> > +}
> > +
> > (...)
> > +/**
> > + * ismt_process_desc() - handle the completion of the descriptor
> > + * @desc: the iSMT hardware descriptor
> > + * @data: data buffer from the upper layer
> > + * @dma_buffer: temporary buffer for the DMA engine
> > + * @size: SMBus transaction type
> > + */
> > +static int ismt_process_desc(const struct ismt_desc *desc,
> > +			     union i2c_smbus_data *data,
> > +			     u8 *dma_buffer, int size,
> > +			     char read_write)
> > +{
> > +	if ((read_write =3D=3D I2C_SMBUS_READ) &&
> > +	    (desc->status & ISMT_DESC_SCS)) {
>=20
> You added the "read_write =3D=3D I2C_SMBUS_READ" test in the wrong pl=
ace.
> You should add it below, to limit the memcpy to read transactions.
> Putting it here instead will cause all write transactions to be
> reported as having failed. Which brings a question... you did not tes=
t
> the updated driver, did you?
>=20
I passed it over to intel for testing, and Seth, who is copied, gave it=
 a thumbs
up.  Seth, can you elaborate?

> > +		if (size !=3D I2C_SMBUS_QUICK)
> > +			memcpy(data, dma_buffer,
> > +			       min(sizeof(*data), (size_t)I2C_SMBUS_BLOCK_MAX));
>=20
> This computation looks wrong. We already know that sizeof(*data) =3D=3D
> sizeof(union i2c_smbus_data) > I2C_SMBUS_BLOCK_MAX, so the min() abov=
e
> will always return I2C_SMBUS_BLOCK_MAX. Which may be insufficient as
> the first byte holds the length, and at the same time it will be more
> than needed in most cases.
>=20
Gah!  Sorry, you're right, I wasn't paying attention and though that da=
ta was
just an allocated buffer, I need to fix that.

> My original suggestion to limit the size of the copy was meant as a
> run-time optimization, i.e. copying exactly the number of bytes that
> were received from the slave. That would be 1 or 2 for non-block read=
s,
> and the block length for block reads. Unfortunately I'm not sure is t=
he
> block length is available. See my comment about this below in
> ismt_access().
>=20
We don't currently have the dma_size, no, but the only calling function=
 computes
it (either from the block header or sets it appropriately for non-block
transfers).  We can pass that into the process_desc function and fix th=
is.

> > +
> > +/**
> > + * ismt_access() - process an SMBus command
> > + * @adap: the i2c host adapter
> > + * @addr: address of the i2c/SMBus target
> > + * @flags: command options
> > + * @read_write: read from or write to device
> > + * @command: the i2c/SMBus command to issue
> > + * @size: SMBus transaction type
> > + * @data: read/write data buffer
> > + */
> > +static int ismt_access(struct i2c_adapter *adap, u16 addr,
> > +		       unsigned short flags, char read_write, u8 command,
> > +		       int size, union i2c_smbus_data *data)
> > +{
> > +	int ret;
> > +	dma_addr_t dma_addr =3D 0; /* address of the data buffer */
> > +	u8 dma_size =3D 0;
> > +	enum dma_data_direction dma_direction =3D 0;
> > +	struct ismt_desc *desc;
> > +	struct ismt_priv *priv =3D i2c_get_adapdata(adap);
> > +	struct device *dev =3D &priv->pci_dev->dev;
> > +
> > +	desc =3D &priv->hw[priv->head];
> > +
> > +	/* Initialize the descriptor */
> > +	memset(desc, 0, sizeof(struct ismt_desc));
> > +	desc->tgtaddr_rw =3D ISMT_DESC_ADDR_RW(addr, read_write);
> > +
> > +	/* Create a temporary buffer for the DMA transaction */
> > +	/* and insert the command at the beginning of the buffer */
> > +	if ((read_write =3D=3D I2C_SMBUS_WRITE) &&
> > +	    (size !=3D I2C_SMBUS_QUICK)) {
>=20
> If I read the code below properly, this can be skipped for size =3D=3D
> I2C_SMBUS_BYTE too, right?
I don't think so.  The command field contains the data, and that is rig=
ht below
the memcpy in that if clause.  We can certainly optimize this however, =
given
that I need to fix the memcpy sizes anyway.

>=20
> > +		memcpy(priv->dma_buffer + 1, data,
> > +		       min(sizeof(*data), (size_t)I2C_SMBUS_BLOCK_MAX));
>=20
> Thinking about it some more, this is wrong for block transactions.
> Sorry for not spotting it before. For block transactions,
> data->block[0] is used for the length, so you can't just copy the uni=
on
> i2c_smbus_data blindly to dma_buffer. You have to start copying from
> data->block[1], and data->block[0] could be used to limit the length =
of
> the memcpy. For non-block writes, length can only be 1 or 2 so you
> could limit it to 2.
>=20
understood.

> > +		priv->dma_buffer[0] =3D command;
> > +	}
> > +
> > +	/* Initialize common control bits */
> > +	if (likely(priv->using_msi))
> > +		desc->control =3D ISMT_DESC_INT | ISMT_DESC_FAIR;
> > +	else
> > +		desc->control =3D ISMT_DESC_FAIR;
> > +
> > +	if ((flags & I2C_CLIENT_PEC) && (size !=3D I2C_SMBUS_QUICK)
> > +	    && (size !=3D I2C_SMBUS_I2C_BLOCK_DATA))
> > +		desc->control |=3D ISMT_DESC_PEC;
> > +
> > +	switch (size) {
> > +	case I2C_SMBUS_QUICK:
> > +		dev_dbg(dev, "I2C_SMBUS_QUICK\n");
> > +		break;
> > +
> > +	case I2C_SMBUS_BYTE:
> > +		if (read_write =3D=3D I2C_SMBUS_WRITE) {
> > +			/*
> > +			 * Send Byte
> > +			 * The command field contains the write data
> > +			 */
> > +			dev_dbg(dev, "I2C_SMBUS_BYTE:  WRITE\n");
> > +			desc->control |=3D ISMT_DESC_CWRL;
> > +			desc->wr_len_cmd =3D command;
> > +		} else {
> > +			/* Receive Byte */
> > +			dev_dbg(dev, "I2C_SMBUS_BYTE:  READ\n");
> > +			dma_size =3D 1;
> > +			dma_direction =3D DMA_FROM_DEVICE;
> > +			desc->rd_len =3D 1;
> > +		}
> > +
>=20
> This blank line could go away. There are more occurrences of this in
> this function.
>=20
Ok

> > +
> > +	case I2C_SMBUS_BLOCK_DATA:
> > +		if (read_write =3D=3D I2C_SMBUS_WRITE) {
> > +			/* Block Write */
> > +			dev_dbg(dev, "I2C_SMBUS_BLOCK_DATA:  WRITE\n");
> > +			dma_size =3D data->block[0] + 1;
> > +			dma_direction =3D DMA_TO_DEVICE;
> > +			desc->wr_len_cmd =3D dma_size;
> > +			desc->control |=3D ISMT_DESC_BLK;
> > +		} else {
> > +			/* Block Read */
> > +			dev_dbg(dev, "I2C_SMBUS_BLOCK_DATA:  READ\n");
> > +			dma_size =3D I2C_SMBUS_BLOCK_MAX + 1;
>=20
> I am the one who asked for the + 1 here, now I realize it might not b=
e
> correct. It really depends on what the hardware is returning on SMBus
> block reads.
>=20
> What you are supposed to return to the caller, per Linux' i2c API, is
> the block length in data->block[0] and that many bytes in
> data->block[1..n]. Question is, what do you get from the hardware in
> dma_buffer? If you get the block length followed by the data then
> "dma_size =3D I2C_SMBUS_BLOCK_MAX + 1" is correct and the code in
> ismt_process_desc() is almost correct as well (you only have to get t=
he
> memcpy size right.)
>=20
> OTOH if the hardware gives your only the data bytes in dma_buffer, th=
en
> the "+ 1" above is wrong, and we also face an issue with retrieving t=
he
> block length. Where is the hardware making it available to us? I
> certainly hope it does.=20
>=20
It better, I'll speak with Intel and see if I can't get the datasheet f=
or this
device, and make the appropriate fix here.


> > +			dma_direction =3D DMA_FROM_DEVICE;
> > +			desc->rd_len =3D dma_size;
> > +			desc->wr_len_cmd =3D command;
> > +			desc->control |=3D (ISMT_DESC_BLK | ISMT_DESC_CWRL);
> > +		}
> > +
> > +		break;
> > +
> > +	default:
> > +		dev_err(dev, "Unsupported transaction %d\n",
> > +			size);
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	/* map the data buffer */
> > +	if (dma_size !=3D 0) {
> > +		dev_dbg(dev, " dev=3D%p\n", dev);
> > +		dev_dbg(dev, " data=3D%p\n", data);
> > +		dev_dbg(dev, " dma_buffer=3D%p\n", priv->dma_buffer);
> > +		dev_dbg(dev, " dma_size=3D%d\n", dma_size);
> > +		dev_dbg(dev, " dma_direction=3D%d\n", dma_direction);
> > +
> > +		dma_addr =3D dma_map_single(dev,
> > +				      priv->dma_buffer,
> > +				      dma_size,
> > +				      dma_direction);
> > +
> > +		if (dma_mapping_error(dev, dma_addr)) {
> > +			dev_err(dev, "Error in mapping dma buffer %p\n", priv->dma_buff=
er);
> > +			return -EIO;
> > +		}
> > +
> > +		dev_dbg(dev, " dma_addr =3D 0x%016llX\n",
> > +			dma_addr);
> > +
> > +		desc->dptr_low =3D lower_32_bits(dma_addr);
> > +		desc->dptr_high =3D upper_32_bits(dma_addr);
> > +	}
> > +
> > +	INIT_COMPLETION(priv->cmp);
> > +
> > +	/* Add the descriptor */
> > +	ismt_submit_desc(priv);
> > +
> > +	/* Now we wait for interrupt completion, 1s */
> > +	ret =3D wait_for_completion_timeout(&priv->cmp, HZ*1);
> > +
> > +	/* unmap the data buffer */
> > +	if (dma_size !=3D 0)
> > +		dma_unmap_single(&adap->dev, dma_addr, dma_size, dma_direction);
> > +
> > +	if (unlikely(!ret)) {
> > +		dev_err(dev, "completion wait timed out\n");
> > +		ret =3D -ETIMEDOUT;
> > +	}=20
> > +
> > +	/* do any post processing of the descriptor here */
> > +	ret =3D ismt_process_desc(desc, data, priv->dma_buffer, size, rea=
d_write);
>=20
> There's something wrong here, the "ret =3D -ETIMEDOUT" above is
> overwritten by this call so the error code is lost. Bill's code did n=
ot
> have the problem, not sure why you changed it.
>=20
I changed it because you asked for this to be modified to the uninterru=
ptible
version of the completion api.  I see what you mean though, I didn't ha=
ndle the
ETIMEDOUT error case properly.

> > +
> > +	/* Update the ring pointer */
> > +	priv->head++;
> > +	priv->head %=3D ISMT_DESC_ENTRIES;
> > +
> > +	return ret;
> > +}
> > +
> > (...)
> > +/**
> > + * ismt_hw_init() - initialize the iSMT hardware
> > + * @priv: iSMT private data
> > + */
> > +static void ismt_hw_init(struct ismt_priv *priv)
> > +{
> > +	u32 val;
> > +	struct device *dev =3D &priv->pci_dev->dev;
> > +
> > +	/* initialize the Master Descriptor Base Address (MDBA) */
> > +	writel(priv->io_rng_dma, priv->smba + ISMT_MSTR_MDBA);
> > +	writel(priv->io_rng_dma >> 32, priv->smba + ISMT_MSTR_MDBA + 4);
> > +
> > +	/* initialize the Master Control Register (MCTRL) */
> > +	writel(ISMT_MCTRL_MEIE, priv->smba + ISMT_MSTR_MCTRL);
> > +
> > +	/* initialize the Master Status Register (MSTS) */
> > +	writel(0, priv->smba + ISMT_MSTR_MSTS);
> > +
> > +	/* initialize the Master Descriptor Size (MDS) */
> > +	val =3D readl(priv->smba + ISMT_MSTR_MDS);
> > +	writel((val & ~ISMT_MDS_MASK) | (ISMT_DESC_ENTRIES - 1),
> > +		priv->smba + ISMT_MSTR_MDS);
> > +
> > +	/*
> > +	 * Set the SMBus speed (could use this for slow HW debuggers)
> > +	 */
> > +
> > +	val =3D readl(priv->smba + ISMT_SPGT);
> > +
> > +	switch (bus_speed) {
> > +	case 0:
> > +		break;
> > +
> > +	case 80:
> > +		dev_dbg(dev, "Setting SMBus clock to 80 kHz\n");
>=20
> You did add a space here between "80" and "kHz" as I asked, but...
>=20
> > +		writel(((val & ~ISMT_SPGT_SPD_MASK) | ISMT_SPGT_SPD_80K),
> > +			priv->smba + ISMT_SPGT);
> > +		break;
> > +
> > +	case 100:
> > +		dev_dbg(dev, "Setting SMBus clock to 100kHz\n");
>=20
> ... not here...
>=20
> > +		writel(((val & ~ISMT_SPGT_SPD_MASK) | ISMT_SPGT_SPD_100K),
> > +			priv->smba + ISMT_SPGT);
> > +		break;
> > +
> > +	case 400:
> > +		dev_dbg(dev, "Setting SMBus clock to 400kHz\n");
>=20
> ... nor here...
>=20
> > +		writel(((val & ~ISMT_SPGT_SPD_MASK) | ISMT_SPGT_SPD_400K),
> > +			priv->smba + ISMT_SPGT);
> > +		break;
> > +
> > +	case 1000:
> > +		dev_dbg(dev, "Setting SMBus clock to 1MHz\n");
>=20
> ... nor here.
>=20
> > +		writel(((val & ~ISMT_SPGT_SPD_MASK) | ISMT_SPGT_SPD_1M),
> > +			priv->smba + ISMT_SPGT);
> > +		break;
> > +
> > +	default:
> > +		dev_dbg(dev, "Invalid SMBus clock speed, only 1-4 are valid\n");
>=20
> Valid values are now 80, 100, 400 and 1000. This is more than a debug
> message BTW, this should be a warning IMHO.
>=20
Ok

> > +		break;
> > +	}
> > +
> > +	switch (val & ISMT_SPGT_SPD_MASK) {
> > +	case ISMT_SPGT_SPD_80K:
> > +		bus_speed =3D 80;
> > +		break;
> > +	case ISMT_SPGT_SPD_100K:
> > +		bus_speed =3D 100;
> > +		break;
> > +	case ISMT_SPGT_SPD_400K:
> > +		bus_speed =3D 400;
> > +		break;
> > +	case ISMT_SPGT_SPD_1M:
> > +		bus_speed =3D 1000;
> > +		break;
> > +	}
> > +	dev_dbg(dev, "SMBus clock is running at %d KHz\n", bus_speed);
>=20
> This is incorrect. You changed the value of register ISMT_SPGT based =
on
> the value of bus_speed, however you did not update "val" accordingly.
> So if the user forced a specific speed, the value you are printing is
> the speed at which the bus _was_ running before.
>=20
> So you must update val prior to writing the new value to the register=
=2E
>=20
Ah, you're right, thanks.

> Also note that the proper casing is "kHz".
>=20
>=20


Give me a day or two, and I'll have these fixed up.
Neil
