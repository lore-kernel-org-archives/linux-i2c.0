From: Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [patch v2] i2c: add master driver for mellanox systems
Date: Thu, 3 Nov 2016 04:53:16 +0000
Message-ID: <AM5PR0501MB2097D3D92D5C21C40E1CBC5BA2A30@AM5PR0501MB2097.eurprd05.prod.outlook.com>
References: <1474297231-36264-1-git-send-email-vadimp@mellanox.com>
 <1bf3000c-0390-395b-8b8c-633c6a417e0e@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1bf3000c-0390-395b-8b8c-633c6a417e0e@mleia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, Michael Shych <michaelsh@mellanox.com>
List-Id: linux-i2c@vger.kernel.org



> -----Original Message-----
> From: Vladimir Zapolskiy [mailto:vz@mleia.com]
> Sent: Thursday, November 03, 2016 1:09 AM
> To: Vadim Pasternak <vadimp@mellanox.com>; wsa@the-dreams.de
> Cc: linux-i2c@vger.kernel.org; linux-kernel@vger.kernel.org; jiri@resnull=
i.us;
> Michael Shych <michaelsh@mellanox.com>
> Subject: Re: [patch v2] i2c: add master driver for mellanox systems
>=20
> Hi Vadim,

Hi Vladimir,

Thank you very much for you review.

>=20
> On 19.09.2016 18:00, vadimp@mellanox.com wrote:
> > From: Vadim Pasternak <vadimp@mellanox.com>
> >
> > Device driver for Mellanox I2C controller logic, implemented in
> > Lattice CPLD device.
> > Device supports:
> >  - Master mode
> >  - One physical bus
> >  - Polling mode
> >
> > The Kconfig currently controlling compilation of this code is:
> > drivers/i2c/busses/Kconfig:config I2C_MLXCPLD
> >
> > Signed-off-by: Michael Shych <michaelsh@mellanox.com>
> > Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> > Reviewed-by: Jiri Pirko <jiri@mellanox.com>
> > v1->v2
> >  Fixes added by Vadim:
> >  - Put new record in Makefile in alphabetic order;
> >  - Remove http://www.mellanox.com from MAINTAINERS record;
>=20
> the change does not apply cleanly on top of the recent source, please con=
sider
> to rebase it.

I suppose this is because the patch has been sent quite long time ago and i=
t was created in 4.8 i2c/for-next. I'll redo it in latest i2c/for-next bran=
ch.
I suppose this is also the reason of checkpatch warnings, since it passed c=
lean the validation in 4.8.

>=20
> Anyway please consider to check some review points found below.
>=20
> > ---
> >  Documentation/i2c/busses/i2c-mlxcpld |  47 +++
> >  MAINTAINERS                          |   8 +
> >  drivers/i2c/busses/Kconfig           |  12 +
> >  drivers/i2c/busses/Makefile          |   1 +
> >  drivers/i2c/busses/i2c-mlxcpld.c     | 597
> +++++++++++++++++++++++++++++++++++
> >  5 files changed, 665 insertions(+)
> >  create mode 100644 Documentation/i2c/busses/i2c-mlxcpld
> >  create mode 100644 drivers/i2c/busses/i2c-mlxcpld.c
> >
> > diff --git a/Documentation/i2c/busses/i2c-mlxcpld
> > b/Documentation/i2c/busses/i2c-mlxcpld
> > new file mode 100644
> > index 0000000..0f8678a
> > --- /dev/null
> > +++ b/Documentation/i2c/busses/i2c-mlxcpld
> > @@ -0,0 +1,47 @@
> > +Driver i2c-mlxcpld
> > +
> > +Author: Michael Shych <michaelsh@mellanox.com>
> > +
> > +This is a for Mellanox I2C controller logic, implemented in Lattice
> > +CPLD device.
> > +Device supports:
> > + - Master mode.
> > + - One physical bus.
> > + - Polling mode.
> > +
> > +This controller is equipped within the next Mellanox systems:
> > +"msx6710", "msx6720", "msb7700", "msn2700", "msx1410", "msn2410",
> > +"msb7800", "msn2740", "msn2100".
> > +
> > +The next transaction types are supported:
> > + - Receive Byte/Block.
> > + - Send Byte/Block.
> > + - Read Byte/Block.
> > + - Write Byte/Block.
> > +
> > +Registers:
> > +CTRL		0x1 - control reg.
> > +			Resets all the registers.
> > +HALF_CYC	0x4 - cycle reg.
> > +			Configure the width of I2C SCL half clock cycle (in 4
> LPC_CLK
> > +			units).
> > +I2C_HOLD	0x5 - hold reg.
> > +			OE (output enable) is delayed by value set to this
> register
> > +			(in LPC_CLK units)
> > +CMD			0x6 - command reg.
> > +			Bit 7(lsb), 0 =3D write, 1 =3D read.
> > +			Bits [6:0] - the 7bit Address of the I2C device.
> > +			It should be written last as it triggers an I2C transaction.
> > +NUM_DATA	0x7 - data size reg.
> > +			Number of address bytes to write in read transaction
> > +NUM_ADDR	0x8 - address reg.
> > +			Number of address bytes to write in read transaction.
> > +STATUS		0x9 - status reg.
> > +			Bit 0 - transaction is completed.
> > +			Bit 4 - ACK/NACK.
> > +DATAx		0xa - 0x54  - 68 bytes data buffer regs.
> > +			For write transaction address is specified in four first
> bytes
> > +			(DATA1 - DATA4), data starting from DATA4.
> > +			For read transactions address is send in separate
> transaction and
> > +			specified in four first bytes (DATA0 - DATA3). Data is
> reading
> > +			starting from DATA0.
> > diff --git a/MAINTAINERS b/MAINTAINERS index 6781a3f..dc31231 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7667,6 +7667,14 @@ W:	http://www.mellanox.com
> >  Q:	http://patchwork.ozlabs.org/project/netdev/list/
> >  F:	drivers/net/ethernet/mellanox/mlxsw/
> >
> > +MELLANOX MLXCPLD I2C DRIVER
> > +M:	Vadim Pasternak <vadimp@mellanox.com>
> > +M:	Michael Shych <michaelsh@mellanox.com>
> > +L:	linux-i2c@vger.kernel.org
> > +S:	Supported
> > +F:	drivers/i2c/busses/i2c-mlxcpld.c
> > +F:	Documentation/i2c/busses/i2c-mlxcpld
> > +
> >  SOFT-ROCE DRIVER (rxe)
> >  M:	Moni Shoua <monis@mellanox.com>
> >  L:	linux-rdma@vger.kernel.org
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index 5c3993b..1126142a 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -1203,4 +1203,16 @@ config I2C_OPAL
> >  	  This driver can also be built as a module. If so, the module will b=
e
> >  	  called as i2c-opal.
> >
> > +config I2C_MLXCPLD
> > +        tristate "Mellanox I2C driver"
> > +        depends on X86_64
> > +        default y
> > +        help
>=20
> Please use one tab symbol as indentation above.
>=20
> Please add the section preserving the alphabetical order.
>=20
> > +	  This exposes the Mellanox platform I2C busses to the linux I2C laye=
r
> > +	  for X86 based systems.
> > +	  Controller is implemented as CPLD logic.
> > +
> > +	  This driver can also be built as a module. If so, the module will b=
e
> > +	  called as i2c-mlxcpld.
> > +
> >  endmenu
> > diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> > index 37f2819..4df3578 100644
> > --- a/drivers/i2c/busses/Makefile
> > +++ b/drivers/i2c/busses/Makefile
> > @@ -118,5 +118,6 @@ obj-$(CONFIG_I2C_PCA_ISA)	+=3D i2c-pca-isa.o
> >  obj-$(CONFIG_I2C_SIBYTE)	+=3D i2c-sibyte.o
> >  obj-$(CONFIG_I2C_XGENE_SLIMPRO) +=3D i2c-xgene-slimpro.o
> >  obj-$(CONFIG_SCx200_ACB)	+=3D scx200_acb.o
> > +obj-$(CONFIG_I2C_MLXCPLD)	+=3D i2c-mlxcpld.o
>=20
> Please add the line preserving the alphabetical order.
>=20
> >
> >  ccflags-$(CONFIG_I2C_DEBUG_BUS) :=3D -DDEBUG diff --git
> > a/drivers/i2c/busses/i2c-mlxcpld.c b/drivers/i2c/busses/i2c-mlxcpld.c
> > new file mode 100644
> > index 0000000..dd62190
> > --- /dev/null
> > +++ b/drivers/i2c/busses/i2c-mlxcpld.c
> > @@ -0,0 +1,597 @@
> > +/*
> > + * drivers/i2c/busses/i2c-mlxcpld.c
> > + * Copyright (c) 2016 Mellanox Technologies. All rights reserved.
> > + * Copyright (c) 2016 Michael Shych <michaels@mellanox.com>
> > + *
> > + * Redistribution and use in source and binary forms, with or without
> > + * modification, are permitted provided that the following conditions =
are
> met:
> > + *
> > + * 1. Redistributions of source code must retain the above copyright
> > + *    notice, this list of conditions and the following disclaimer.
> > + * 2. Redistributions in binary form must reproduce the above copyrigh=
t
> > + *    notice, this list of conditions and the following disclaimer in =
the
> > + *    documentation and/or other materials provided with the distribut=
ion.
> > + * 3. Neither the names of the copyright holders nor the names of its
> > + *    contributors may be used to endorse or promote products derived =
from
> > + *    this software without specific prior written permission.
> > + *
> > + * Alternatively, this software may be distributed under the terms of
> > +the
> > + * GNU General Public License ("GPL") version 2 as published by the
> > +Free
> > + * Software Foundation.
> > + *
> > + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
> CONTRIBUTORS "AS IS"
> > + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> LIMITED
> > +TO, THE
> > + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> PARTICULAR
> > +PURPOSE
> > + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
> > +CONTRIBUTORS BE
> > + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
> > +OR
> > + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
> PROCUREMENT
> > +OF
> > + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> > +BUSINESS
> > + * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
> > +WHETHER IN
> > + * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
> > +OTHERWISE)
> > + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
> > +ADVISED OF THE
> > + * POSSIBILITY OF SUCH DAMAGE.
>=20
> So the code is dual licensed under BSD 3-Clause / GPLv2.
>=20
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +
> > +/* General defines */
> > +#define MLXPLAT_CPLD_LPC_I2C_BASE_ADRR	0x2000
>=20
> s/ADRR/ADDR/
>=20
> > +#define MLXCPLD_I2C_DEVICE_NAME		"i2c_mlxcpld"
> > +#define MLXCPLD_I2C_VALID_FLAG		(I2C_M_RECV_LEN |
> I2C_M_RD)
> > +#define MLXCPLD_I2C_BUS_NUM		1
> > +#define MLXCPLD_I2C_DATA_REG_SZ		36
> > +#define MLXCPLD_I2C_MAX_ADDR_LEN	4
> > +#define MLXCPLD_I2C_RETR_NUM		2
> > +#define MLXCPLD_I2C_XFER_TO		500000 /* msec */
> > +#define MLXCPLD_I2C_POLL_TIME		2000   /* msec */
> > +
> > +/* LPC I2C registers */
> > +#define MLXCPLD_LPCI2C_LPF_REG		0x0
> > +#define MLXCPLD_LPCI2C_CTRL_REG		0x1
> > +#define MLXCPLD_LPCI2C_HALF_CYC_REG	0x4
> > +#define MLXCPLD_LPCI2C_I2C_HOLD_REG	0x5
> > +#define MLXCPLD_LPCI2C_CMD_REG		0x6
> > +#define MLXCPLD_LPCI2C_NUM_DAT_REG	0x7
> > +#define MLXCPLD_LPCI2C_NUM_ADDR_REG	0x8
> > +#define MLXCPLD_LPCI2C_STATUS_REG	0x9
> > +#define MLXCPLD_LPCI2C_DATA_REG		0xa
> > +
> > +/* LPC I2C masks and parametres */
> > +#define MLXCPLD_LPCI2C_RST_SEL_MASK	0x1
>=20
> This macro is not used.
>=20
> > +#define MLXCPLD_LPCI2C_LPF_DFLT		0x2
>=20
> This macro is not used.
>=20
> > +#define MLXCPLD_LPCI2C_HALF_CYC_100	0x1f
>=20
> This macro is not used.
>=20
> > +#define MLXCPLD_LPCI2C_I2C_HOLD_100	0x3c
>=20
> This macro is not used.
>=20
> > +#define MLXCPLD_LPCI2C_TRANS_END	0x1
> > +#define MLXCPLD_LPCI2C_STATUS_NACK	0x10
>=20
> This macro is not used.
>=20
> > +#define MLXCPLD_LPCI2C_ERR_IND		-1
>=20
> This macro is not used.
>=20
> > +#define MLXCPLD_LPCI2C_NO_IND		0
> > +#define MLXCPLD_LPCI2C_ACK_IND		1
> > +#define MLXCPLD_LPCI2C_NACK_IND		2
> > +
> > +/**
> > + * mlxcpld_i2c_regs - controller registers:
> > + * @half_cyc - half cycle register
> > + * @i2c_hold - hold register
> > + * @config - config register
> > + * @cmd - command register
> > + * @cmd - status register
> > + * @data - register data
> > +**/
>=20
> checkpatch warning:
>=20
> WARNING: Block comments should align the * on each line
> #85: FILE: drivers/i2c/busses/i2c-mlxcpld.c:85:
> + * @data - register data
> +**/
>=20
> Also for improving readability please add an empty line before the follow=
ing
> struct declaration.
>=20
> > +struct mlxcpld_i2c_regs {
> > +	u8 half_cyc;
> > +	u8 i2c_hold;
> > +	u8 config;
> > +	u8 cmd;
> > +	u8 status;
> > +	u8 data[MLXCPLD_I2C_DATA_REG_SZ];
> > +};
> > +
>=20
> This structure is not used, please remove it.
>=20
> > +/**
> > + * mlxcpld_i2c_curr_transf - current transaction parameters:
> > + * @cmd - command
> > + * @addr_width - address width
> > + * @data_len - data length
> > + * @cmd - command register
> > + * @msg_num - message number
> > + * @msg - pointer to message buffer
> > +**/
>=20
> checkpatch warning:
>=20
> WARNING: Block comments should align the * on each line
> #103: FILE: drivers/i2c/busses/i2c-mlxcpld.c:103:
> + * @msg - pointer to message buffer
> +**/
>=20
> Also for improving readability please add an empty line before the follow=
ing
> struct declaration.
>=20
> > +struct mlxcpld_i2c_curr_transf {
> > +	u8 cmd;
> > +	u8 addr_width;
> > +	u8 data_len;
> > +	u8 msg_num;
> > +	struct i2c_msg *msg;
> > +};
> > +
> > +/**
> > + * mlxcpld_i2c_priv - private controller data:
> > + * @lpc_gen_dec_reg - register space
> > + * @adap - i2c adapter
> > + * @dev_id - device id
> > + * @base_addr - base IO address
> > + * @poll_time - polling time
> > + * @xfer_to - transfer timeout in microsec (500000)
> > + * @retr_num - access retries number (2)
> > + * @block_sz - maximum data block size (36),
> > + * @lock - bus access lock
> > + * @lpc_i2c_res - lpc i2c resourse
> > + * @lpc_cpld_res - lpc cpld resource
> > + * @xfer - current i2c transfer block
> > + * @pdev - platform device
> > +**/
>=20
> WARNING: Block comments should align the * on each line
> #127: FILE: drivers/i2c/busses/i2c-mlxcpld.c:127:
> + * @pdev - platform device
> +**/
>=20
> Also for improving readability please add an empty line before the follow=
ing
> struct declaration.
>=20
> > +struct mlxcpld_i2c_priv {
> > +	struct i2c_adapter adap;
> > +	u16 dev_id;
> > +	u16 base_addr;
> > +	u16 poll_time;
> > +	int xfer_to;
> > +	int retr_num;
>=20
> Remove 'retr_num', set MLXCPLD_I2C_RETR_NUM directly.
>=20
> Alsoe see my comment for .probe() function.
>=20
> > +	int block_sz;
> > +	struct mutex lock;
> > +	struct mlxcpld_i2c_curr_transf xfer;
> > +	struct platform_device *pdev;
> > +};
>=20
> checkpatch complains:
>=20
> CHECK: Please use a blank line after function/struct/union/enum declarati=
ons
> #140: FILE: drivers/i2c/busses/i2c-mlxcpld.c:140:
> +};
> +struct platform_device *mlxcpld_i2c_plat_dev;
>=20
> > +struct platform_device *mlxcpld_i2c_plat_dev;
> > +
> > +static void mlxcpld_i2c_lpc_write_buf(u8 *data, u8 len, u32 addr) {
> > +	int i, nbyte, ndword;
> > +
> > +	nbyte =3D len % 4;
> > +	ndword =3D len / 4;
> > +	for (i =3D 0; i < ndword; i++)
> > +		outl(*((u32 *)data + i), addr + i * 4);
> > +	ndword *=3D 4;
> > +	addr +=3D ndword;
> > +	data +=3D ndword;
> > +	for (i =3D 0; i < nbyte; i++)
> > +		outb(*(data + i), addr + i);
> > +}
> > +
> > +static void mlxcpld_i2c_lpc_read_buf(u8 *data, u8 len, u32 addr) {
> > +	int i, nbyte, ndword;
> > +
> > +	nbyte =3D len % 4;
> > +	ndword =3D len / 4;
> > +	for (i =3D 0; i < ndword; i++)
> > +		*((u32 *)data + i) =3D inl(addr + i * 4);
> > +	ndword *=3D 4;
> > +	addr +=3D ndword;
> > +	data +=3D ndword;
> > +	for (i =3D 0; i < nbyte; i++)
> > +		*(data + i) =3D inb(addr + i);
> > +}
> > +
> > +static void mlxcpld_i2c_read_comm(struct mlxcpld_i2c_priv *priv, u8 of=
fs,
> > +				  u8 *data, u8 datalen)
> > +{
> > +	u32 addr =3D priv->base_addr + offs;
> > +
> > +	switch (datalen) {
> > +	case 1:
> > +		*(data) =3D inb(addr);
> > +		break;
> > +	case 2:
> > +		*((u16 *)data) =3D inw(addr);
> > +		break;
> > +	case 3:
> > +		*((u16 *)data) =3D inw(addr);
> > +		*(data + 2) =3D inb(addr + 2);
> > +		break;
> > +	case 4:
> > +		*((u32 *)data) =3D inl(addr);
> > +		break;
> > +	default:
> > +		mlxcpld_i2c_lpc_read_buf(data, datalen, addr);
> > +		break;
> > +	}
> > +}
> > +
> > +static void mlxcpld_i2c_write_comm(struct mlxcpld_i2c_priv *priv, u8 o=
ffs,
> > +				   u8 *data, u8 datalen)
> > +{
> > +	u32 addr =3D priv->base_addr + offs;
> > +
> > +	switch (datalen) {
> > +	case 1:
> > +		outb(*(data), addr);
> > +		break;
> > +	case 2:
> > +		outw(*((u16 *)data), addr);
> > +		break;
> > +	case 3:
> > +		outw(*((u16 *)data), addr);
> > +		outb(*(data + 2), addr + 2);
> > +		break;
> > +	case 4:
> > +		outl(*((u32 *)data), addr);
> > +		break;
> > +	default:
> > +		mlxcpld_i2c_lpc_write_buf(data, datalen, addr);
> > +		break;
> > +	}
> > +}
> > +
> > +/* Check validity of current i2c message and all transfer.
> > + * Calculate also coomon length of all i2c messages in transfer.
> > + */
> > +static int mlxcpld_i2c_invalid_len(struct mlxcpld_i2c_priv *priv,
> > +				   const struct i2c_msg *msg, u8 *comm_len) {
> > +	u8 max_len =3D msg->flags =3D=3D I2C_M_RD ? priv->block_sz -
> > +		     MLXCPLD_I2C_MAX_ADDR_LEN : priv->block_sz;
> > +
> > +	if (msg->len < 0 || msg->len > max_len)
> > +		return -EINVAL;
> > +
> > +	*comm_len +=3D msg->len;
> > +	if (*comm_len > priv->block_sz)
> > +		return -EINVAL;
> > +	else
> > +		return 0;
>=20
> Just 'return 0;' without else and indentation.
>=20
> > +}
> > +
> > +/* Check validity of received i2c messages parameters.
> > + *  Returns 0 if OK, other - in case of invalid parameters
> > + *  or common length of data that should be passed to CPLD  */ static
> > +int mlxcpld_i2c_check_msg_params(struct mlxcpld_i2c_priv *priv,
> > +					struct i2c_msg *msgs, int num,
> > +					u8 *comm_len)
> > +{
> > +	int i;
> > +
> > +	if (!num) {
> > +		dev_err(&priv->pdev->dev, "Incorrect 0 num of messages\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (unlikely(msgs[0].addr > 0x7f)) {
> > +		dev_err(&priv->pdev->dev, "Invalid address 0x%03x\n",
> > +			msgs[0].addr);
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i =3D 0; i < num; ++i) {
> > +		if (unlikely(!msgs[i].buf)) {
> > +			dev_err(&priv->pdev->dev, "Invalid buf in msg[%d]\n",
> > +				i);
> > +			return -EINVAL;
> > +		}
> > +		if (unlikely(msgs[0].addr !=3D msgs[i].addr)) {
> > +			dev_err(&priv->pdev->dev, "Invalid addr in msg[%d]\n",
> > +				i);
> > +			return -EINVAL;
> > +		}
> > +		if (unlikely(mlxcpld_i2c_invalid_len(priv, &msgs[i],
> > +						     comm_len))) {
> > +			dev_err(&priv->pdev->dev, "Invalid len %d msg[%d],
> addr 0x%x, lag %u\n",
> > +				msgs[i].len, i, msgs[i].addr, msgs[i].flags);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/* Check if transfer is completed and status of operation.
> > + * Returns 0 - transfer completed (both ACK or NACK),
> > + * negative - transfer isn't finished.
> > + */
> > +static int mlxcpld_i2c_check_status(struct mlxcpld_i2c_priv *priv,
> > +int *status) {
> > +	u8 val;
> > +
> > +	mlxcpld_i2c_read_comm(priv, MLXCPLD_LPCI2C_STATUS_REG, &val, 1);
> > +
> > +	if (val & MLXCPLD_LPCI2C_TRANS_END) {
> > +		if (val & MLXCPLD_LPCI2C_STATUS_NACK)
> > +			/* The slave is unable to accept the data. No such
> > +			 * slave, command not understood, or unable to accept
> > +			 * any more data.
> > +			 */
> > +			*status =3D MLXCPLD_LPCI2C_NACK_IND;
> > +		else
> > +			*status =3D MLXCPLD_LPCI2C_ACK_IND;
> > +		return 0;
> > +	}
> > +	*status =3D MLXCPLD_LPCI2C_NO_IND;
> > +
> > +	return -EIO;
> > +}
> > +
> > +static void mlxcpld_i2c_set_transf_data(struct mlxcpld_i2c_priv *priv,
> > +					struct i2c_msg *msgs, int num,
> > +					u8 comm_len)
> > +{
> > +	priv->xfer.msg =3D msgs;
> > +	priv->xfer.msg_num =3D num;
> > +
> > +	/*
> > +	 * All upper layers currently are never use transfer with more than
> > +	 * 2 messages. Actually, it's also not so relevant in Mellanox system=
s
> > +	 * because of HW limitation. Max size of transfer is o more than 20B
> > +	 * in current x86 LPCI2C bridge.
> > +	 */
> > +	priv->xfer.cmd =3D (msgs[num - 1].flags & I2C_M_RD);
> > +
> > +	if (priv->xfer.cmd =3D=3D I2C_M_RD) {
> > +		if (comm_len =3D=3D msgs[0].len) {
> > +			/* Special case of addr_width =3D 0 */
> > +			priv->xfer.addr_width =3D 0;
> > +			priv->xfer.data_len =3D comm_len;
> > +		} else {
> > +			priv->xfer.addr_width =3D msgs[0].len;
> > +			priv->xfer.data_len =3D comm_len - priv-
> >xfer.addr_width;
> > +		}
> > +	} else {
> > +		/* Width (I2C_NUM_ADDR reg) isn't used in write command. */
> > +		priv->xfer.addr_width =3D 0;
> > +		priv->xfer.data_len =3D comm_len;
> > +	}
>=20
> 	if (priv->xfer.cmd =3D=3D I2C_M_RD && comm_len !=3D msgs[0].len) {
> 		priv->xfer.addr_width =3D msgs[0].len;
> 		priv->xfer.data_len =3D comm_len - priv->xfer.addr_width;
> 	} else {
> 		priv->xfer.addr_width =3D 0;
> 		priv->xfer.data_len =3D comm_len;
> 	}
>=20
> 7 lines vs. 12 lines.
>=20
> > +}
> > +
> > +/* Reset CPLD LPCI2C block */
> > +static void mlxcpld_i2c_reset(struct mlxcpld_i2c_priv *priv) {
> > +	u8 val;
> > +
> > +	mutex_lock(&priv->lock);
> > +	mlxcpld_i2c_read_comm(priv, MLXCPLD_LPCI2C_CTRL_REG, &val, 1);
> > +	val &=3D ~MLXCPLD_LPCI2C_RST_SEL_MASK;
> > +	mlxcpld_i2c_write_comm(priv, MLXCPLD_LPCI2C_CTRL_REG, &val, 1);
> > +	mutex_unlock(&priv->lock);
>=20
> I would recomment to insert empty lines after mutex_lock() and before
> mutex_unlock().
>=20
> > +}
> > +
> > +/* Make sure the CPLD is ready to start transmitting.
> > + * Return 0 if it is, -EBUSY if it is not.
> > + */
> > +static int mlxcpld_i2c_check_busy(struct mlxcpld_i2c_priv *priv) {
> > +	u8 val;
> > +
> > +	mlxcpld_i2c_read_comm(priv, MLXCPLD_LPCI2C_STATUS_REG, &val, 1);
> > +
> > +	if (val & MLXCPLD_LPCI2C_TRANS_END)
> > +		return 0;
> > +
> > +	return -EIO;
> > +}
> > +
> > +static int mlxcpld_i2c_wait_for_free(struct mlxcpld_i2c_priv *priv) {
> > +	int timeout =3D 0;
> > +
> > +	do {
> > +		if (!mlxcpld_i2c_check_busy(priv))
> > +			break;
> > +		usleep_range(priv->poll_time/2, priv->poll_time);
>=20
> checkpatch complains:
>=20
> CHECK: spaces preferred around that '/' (ctx:VxV)
> #375: FILE: drivers/i2c/busses/i2c-mlxcpld.c:375:
> +		usleep_range(priv->poll_time/2, priv->poll_time);
>  		                            ^
>=20
> > +		timeout +=3D priv->poll_time;
> > +	} while (timeout < priv->xfer_to);
> > +
> > +	if (timeout > priv->xfer_to)
>=20
> Corner case (timeout =3D=3D priv->xfer_to) is missed here.
>=20
> if (timeout >=3D priv->xfer_to)
>=20
> > +		return -ETIMEDOUT;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Wait for master transfer to complete.
> > + * It puts current process to sleep until we get interrupt or timeout =
expires.
> > + * Returns the number of transferred or read bytes or error (<0).
> > + */
> > +static int mlxcpld_i2c_wait_for_tc(struct mlxcpld_i2c_priv *priv) {
> > +	int status, i =3D 1, timeout =3D 0;
> > +	u8 datalen;
> > +	int err =3D 0;
>=20
> Just "int err;"
>=20
> See "The Power of Undefined Values" https://rusty.ozlabs.org/?p=3D232
>=20
> > +
> > +	do {
> > +		usleep_range(priv->poll_time / 2, priv->poll_time);
> > +		if (!mlxcpld_i2c_check_status(priv, &status))
> > +			break;
> > +		timeout +=3D priv->poll_time;
> > +	} while (status =3D=3D 0 && timeout < priv->xfer_to);
> > +
> > +	switch (status) {
> > +	case MLXCPLD_LPCI2C_NO_IND:
> > +		return -ETIMEDOUT;
>=20
> Please insert an empty line here to improve readability.
>=20
> > +	case MLXCPLD_LPCI2C_ACK_IND:
> > +		if (priv->xfer.cmd =3D=3D I2C_M_RD) {
> > +			/*
> > +			 * Actual read data len will be always the same as
> > +			 * requested len. 0xff (line pull-up) will be returned
> > +			 * if slave has no data to return. Thus don't read
> > +			 * MLXCPLD_LPCI2C_NUM_DAT_REG reg from CPLD.
> > +			 */
> > +			err =3D datalen =3D priv->xfer.data_len;
>=20
> checkpatch complains:
>=20
> CHECK: multiple assignments should be avoided
> #414: FILE: drivers/i2c/busses/i2c-mlxcpld.c:414:
> +			err =3D datalen =3D priv->xfer.data_len;
>=20
> > +			if (priv->xfer.msg_num =3D=3D 1)
> > +				i =3D 0;
> > +
> > +			if (!priv->xfer.msg[i].buf)
> > +				err =3D -EINVAL;
> > +			else
> > +				mlxcpld_i2c_read_comm(priv,
> > +
> MLXCPLD_LPCI2C_DATA_REG,
> > +						      priv->xfer.msg[i].buf,
> > +						      datalen);
> > +		} else {
> > +			err =3D priv->xfer.addr_width + priv->xfer.data_len;
> > +		}
>=20
> Please try to avoid unnecessary indendation of big code chunks.
>=20
> For example here you may consider to rewrite it as:
>=20
> 	if (priv->xfer.cmd !=3D I2C_M_RD)
> 		return (priv->xfer.addr_width + priv->xfer.data_len);
>=20
> 	if (priv->xfer.msg_num =3D=3D 1)
> 		i =3D 0;
> 	else
> 		i =3D 1;
>=20
> 	if (!priv->xfer.msg[i].buf)
> 		return -EINVAL;
>=20
> 	datalen =3D priv->xfer.data_len;
>=20
> 	mlxcpld_i2c_read_comm(priv, MLXCPLD_LPCI2C_DATA_REG,
> 			      priv->xfer.msg[i].buf, datalen);
>=20
> 	return datalen;
>=20
> > +		break;
> > +	case MLXCPLD_LPCI2C_NACK_IND:
> > +		err =3D -EAGAIN;
> > +		break;
> > +	case MLXCPLD_LPCI2C_ERR_IND:
> > +		err =3D -EIO;
> > +		break;
>=20
> This is dead code, from mlxcpld_i2c_check_status() function the 'status'
> variable can not be set to MLXCPLD_LPCI2C_ERR_IND.
>=20
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return err;
> > +}
> > +
> > +static void mlxcpld_i2c_xfer_msg(struct mlxcpld_i2c_priv *priv) {
> > +	int i, len =3D 0;
> > +	u8 cmd;
> > +
> > +	mlxcpld_i2c_write_comm(priv, MLXCPLD_LPCI2C_NUM_DAT_REG,
> > +			       &priv->xfer.data_len, 1);
> > +	mlxcpld_i2c_write_comm(priv, MLXCPLD_LPCI2C_NUM_ADDR_REG,
> > +			       &priv->xfer.addr_width, 1);
> > +
> > +	for (i =3D 0; i < priv->xfer.msg_num; i++) {
> > +		if ((priv->xfer.msg[i].flags & I2C_M_RD) !=3D I2C_M_RD) {
> > +			/* Don't write to CPLD buffer in read transaction */
> > +			mlxcpld_i2c_write_comm(priv,
> MLXCPLD_LPCI2C_DATA_REG +
> > +					       len, priv->xfer.msg[i].buf,
> > +					       priv->xfer.msg[i].len);
> > +			len +=3D priv->xfer.msg[i].len;
> > +		}
> > +	}
> > +
> > +	/* Set target slave address with command for master transfer.
> > +	 * It should be latest executed function before CPLD transaction.
> > +	 */
> > +	cmd =3D (priv->xfer.msg[0].addr << 1) | priv->xfer.cmd;
> > +	mlxcpld_i2c_write_comm(priv, MLXCPLD_LPCI2C_CMD_REG, &cmd, 1);
> }
> > +
> > +/* Generic lpc-i2c transfer.
> > + * Returns the number of processed messages or error (<0).
> > + */
> > +static int mlxcpld_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *=
msgs,
> > +			    int num)
> > +{
> > +	struct mlxcpld_i2c_priv *priv =3D i2c_get_adapdata(adap);
> > +	u8 comm_len =3D 0;
> > +	int err;
> > +
> > +	err =3D mlxcpld_i2c_check_msg_params(priv, msgs, num, &comm_len);
> > +	if (err) {
> > +		dev_err(&priv->pdev->dev, "Incorrect message\n");
> > +		return err;
> > +	}
> > +
> > +	/* Check bus state */
> > +	if (mlxcpld_i2c_wait_for_free(priv)) {
> > +		dev_err(&priv->pdev->dev, "LPCI2C bridge is busy\n");
> > +
> > +		/*
> > +		 * Usually it means something serious has happened.
> > +		 * We can not have unfinished previous transfer
> > +		 * so it doesn't make any sense to try to stop it.
> > +		 * Probably we were not able to recover from the
> > +		 * previous error.
> > +		 * The only reasonable thing - is soft reset.
> > +		 */
> > +		mlxcpld_i2c_reset(priv);
> > +		if (mlxcpld_i2c_check_busy(priv)) {
> > +			dev_err(&priv->pdev->dev, "LPCI2C bridge is busy after
> reset\n");
> > +			return -EIO;
> > +		}
> > +	}
> > +
> > +	mlxcpld_i2c_set_transf_data(priv, msgs, num, comm_len);
> > +
> > +	mutex_lock(&priv->lock);
>=20
> Please consider to insert an empty line here for readability.
>=20
> > +	/* Do real transfer. Can't fail */
> > +	mlxcpld_i2c_xfer_msg(priv);
>=20
> Please consider to insert an empty line here for readability.
>=20
> > +	/* Wait for transaction complete */
> > +	err =3D mlxcpld_i2c_wait_for_tc(priv);
>=20
> Please consider to insert an empty line here for readability.
>=20
> > +	mutex_unlock(&priv->lock);
> > +
> > +	return err < 0 ? err : num;
> > +}
> > +
> > +static u32 mlxcpld_i2c_func(struct i2c_adapter *adap) {
> > +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
> > +I2C_FUNC_SMBUS_BLOCK_DATA; }
> > +
> > +static const struct i2c_algorithm mlxcpld_i2c_algo =3D {
> > +	.master_xfer	=3D mlxcpld_i2c_xfer,
> > +	.functionality	=3D mlxcpld_i2c_func
> > +};
> > +
> > +static struct i2c_adapter mlxcpld_i2c_adapter =3D {
> > +	.owner          =3D THIS_MODULE,
> > +	.name           =3D "i2c-mlxcpld",
> > +	.class          =3D I2C_CLASS_HWMON | I2C_CLASS_SPD,
> > +	.algo           =3D &mlxcpld_i2c_algo,
> > +};
> > +
> > +static int mlxcpld_i2c_probe(struct platform_device *pdev) {
> > +	struct mlxcpld_i2c_priv *priv;
> > +	int err;
> > +
> > +	priv =3D devm_kzalloc(&pdev->dev, sizeof(struct mlxcpld_i2c_priv),
> > +			    GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&priv->lock);
> > +	platform_set_drvdata(pdev, priv);
>=20
> Please insert an empty line here for readability.
>=20
> > +	priv->pdev =3D pdev;
>=20
> You store "pdev" in private data only to get &pdev->dev in runtime.
> Please store the pointer to that 'struct device' instead of pdev.
>=20
> > +	priv->xfer_to =3D MLXCPLD_I2C_XFER_TO;
> > +	priv->retr_num =3D MLXCPLD_I2C_RETR_NUM;
> > +	priv->block_sz =3D MLXCPLD_I2C_DATA_REG_SZ;
> > +	priv->poll_time =3D MLXCPLD_I2C_POLL_TIME;
>=20
> Why do you set all these constant values in runtime?
> Please consider to replace all of them in the code by the correspondent m=
acros.
>=20
> And also please insert an empty line here for readability.
>=20
> > +	/* Register with i2c layer */
> > +	priv->adap =3D mlxcpld_i2c_adapter;
> > +	priv->adap.dev.parent =3D &pdev->dev;
> > +	i2c_set_adapdata(&priv->adap, priv);
> > +	priv->adap.retries =3D priv->retr_num;
>=20
> priv->adap.retries =3D MLXCPLD_I2C_RETR_NUM;
>=20
> > +	priv->adap.nr =3D MLXCPLD_I2C_BUS_NUM;
> > +	priv->adap.timeout =3D usecs_to_jiffies(priv->xfer_to);
> > +
> > +	err =3D i2c_add_numbered_adapter(&priv->adap);
>=20
> Why do you use i2c_add_numbered_adapter() instead of i2c_add_adapter() ?

Here it is set to 1. On our systems we used to have i2c0 for Intel i801, an=
d i2c1 for our CPLD LPC/I2C logic.=20

After all I I want to enforce adapter id to pdev->id.
I already submitted code in module mlx-paltform.c  for next, which will set=
 this id and will probe this driver. Since all this code new and going to d=
ifferent branches it is not so trivial to sync different modules.=20

>=20
> > +	if (err) {
> > +		dev_err(&pdev->dev, "Failed to add %s adapter (%d)\n",
> > +			MLXCPLD_I2C_DEVICE_NAME, err);
> > +		goto fail_adapter;
> > +	}
> > +
> > +	priv->base_addr =3D MLXPLAT_CPLD_LPC_I2C_BASE_ADRR;
>=20
> Consider to move this assignment up to the rest of them.
>=20
> > +	return 0;
> > +
> > +fail_adapter:
> > +	mutex_destroy(&priv->lock);
> > +	return err;
> > +}
> > +
> > +static int mlxcpld_i2c_remove(struct platform_device *pdev) {
> > +	struct mlxcpld_i2c_priv *priv =3D platform_get_drvdata(pdev);
> > +
> > +	i2c_del_adapter(&priv->adap);
> > +	mutex_destroy(&priv->lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver mlxcpld_i2c_driver =3D {
> > +	.probe		=3D mlxcpld_i2c_probe,
> > +	.remove		=3D mlxcpld_i2c_remove,
> > +	.driver =3D {
> > +		.name =3D MLXCPLD_I2C_DEVICE_NAME,
> > +	},
> > +};
> > +
> > +module_platform_driver(mlxcpld_i2c_driver);
> > +
> > +MODULE_AUTHOR("Michael Shych (michaels@mellanox.com)");
>=20
> Consider to enclose email into <>, see RFC822.
>=20
> > +MODULE_DESCRIPTION("Mellanox I2C-CPLD controller driver");
> > +MODULE_LICENSE("GPL v2");
>=20
> MODULE_LICENSE("Dual BSD/GPL");
>=20
> Correct?
>=20
> > +MODULE_ALIAS("platform:i2c-mlxcpld");
> >
>=20
> --
> With best wishes,
> Vladimir
