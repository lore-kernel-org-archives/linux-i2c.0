From: Peter Rosin <peda@axentia.se>
Subject: Re: [patch v6 1/1] i2c: add master driver for mellanox systems
Date: Thu, 17 Nov 2016 09:05:38 +0100
Message-ID: <eba5d313-2c6e-e1a6-b140-9c6f29a1bbce@axentia.se>
References: <1479371408-171218-1-git-send-email-vadimp@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0115.outbound.protection.outlook.com ([104.47.2.115]:59104
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932110AbcKQIFt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Nov 2016 03:05:49 -0500
In-Reply-To: <1479371408-171218-1-git-send-email-vadimp@mellanox.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: vadimp@mellanox.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us, Michael Shych <michaelsh@mellanox.com>

Hi!

Some comments inline.

Cheers,
Peter

On 2016-11-17 09:30, vadimp@mellanox.com wrote:
> From: Vadim Pasternak <vadimp@mellanox.com>
> 
> Device driver for Mellanox I2C controller logic, implemented in Lattice
> CPLD device.
> Device supports:
>  - Master mode
>  - One physical bus
>  - Polling mode
> 
> The Kconfig currently controlling compilation of this code is:
> drivers/i2c/busses/Kconfig:config I2C_MLXCPLD
> 
> Signed-off-by: Michael Shych <michaelsh@mellanox.com>
> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> Reviewed-by: Jiri Pirko <jiri@mellanox.com>
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
> v5->v6:
>  Comments pointed out by Vladimir:
>  - Drop the line with module path from the header;
>  - In description of mlxcpld_i2c_priv remove lpc_gen_dec_reg asnd dev_id;
>  - In mlxcpld_i2c_priv change type of the filed base_addr to u16 for
>    the alignment with in/out and remove unused dev_id;
>  - Fix misspelling in comment for mlxcpld_i2c_invalid_len;
>  - Remove comment regarding EBUSY return in mlxcpld_i2c_check_busy;
>  - Use sizeof of the target storage in allocation in probe routine;
> v4->v5:
>  Comments pointed out by Vladimir:
>  - Remove "default n" from Kconfig;
>  - Fix the comments for timeout and pool time;
>  - Optimize error flow in mlxcpld_i2c_probe;
> v3->v4:
>  Comments pointed out by Vladimir:
>  - Set default to no in Kconfig;
>  - Make mlxcpld_i2c_plat_dev static and add empty line before the
>    declaration;
>  - In function mlxcpld_i2c_invalid_len remove (msg->len < 0), since len is
>    unsigned;
>  - Remove unused symbol mlxcpld_i2c_plat_dev;
>  - Remove extra spaces in comments to mlxcpld_i2c_check_msg_params;
>  - Remove unnecessary round braces in mlxcpld_i2c_set_transf_data;
>  - Remove the assignment of 'i' variable in mlxcpld_i2c_wait_for_tc;
>  - Add extra line in mlxcpld_i2c_xfer;
>  - Move assignment of the adapter's fields retries and nr inside
>    mlxcpld_i2c_adapter declaration;
> v2->v3:
>  Comments pointed out by Vladimir:
>  - Use tab symbol as indentation in Kconfig
>  - Add the Kconfig section preserving the alphabetical order - added
>    within "Other I2C/SMBus bus drivers" after I2C_ELEKTOR (but after this
>    sections others are not follow alphabetical);
>  - Change license to dual;
>  - Replace ADRR with ADDR in macros;
>  - Remove unused macros: MLXCPLD_LPCI2C_LPF_DFLT,
>    MLXCPLD_LPCI2C_HALF_CYC_100, MLXCPLD_LPCI2C_I2C_HOLD_100,
>    MLXCPLD_LPCI2C_HALF_CYC_REG, MLXCPLD_LPCI2C_I2C_HOLD_REG;
>  - Fix checkpatch warnings (**/ and the end of comment);
>  - Add empty line before structures mlxcpld_i2c_regs,
>    mlxcpld_i2c_curr_transf, mlxcpld_i2c_priv;
>  - Remove unused structure mlxcpld_i2c_regs;
>  - Remove from mlxcpld_i2c_priv the next fields:
>    retr_num, poll_time, block_sz, xfer_to; use instead macros
>    respectively: MLXCPLD_I2C_RETR_NUM, MLXCPLD_I2C_POLL_TIME,
>    MLXCPLD_I2C_DATA_REG_SZ, MLXCPLD_I2C_XFER_TO;
>  - In mlxcpld_i2c_invalid_len remove unnecessary else;
>  - Optimize mlxcpld_i2c_set_transf_data;
>  - mlxcpld_i2c_reset - add empty lines after/before mutex
>    lock/unlock;
>  - mlxcpld_i2c_wait_for_free - cover case timeout is equal
>    MLXCPLD_I2C_XFER_TO;
>  - mlxcpld_i2c_wait_for_tc:
>    - Do not assign err in declaration (also err is removed);
>    - Insert empty line before case MLXCPLD_LPCI2C_ACK_IND;
>    - inside case MLXCPLD_LPCI2C_ACK_IND - avoid unnecessary
>      indentation;
>    - Remove case MLXCPLD_LPCI2C_ERR_IND and remove this macro;
>  - Add empty lines in mlxcpld_i2c_xfer before/after mutex_lock/
>    mutex_unlock;
>  - In mlxcpld_i2c_probe add emtpy line after platform_set_drvdata;
>  - Replace platfrom handle pdev in mlxcpld_i2c_priv with the pointer
>    to the structure device;
>  - Place assignment of base_addr near the others;
>  - Enclose e-mail with <>;
>  Fixes added by Vadim:
>  - Change structure description format according to
>    Documentation/kernel-documentation.rst guideline;
>  - mlxcpld_i2c_wait_for_tc: return error if status reaches default case;
> v1->v2
>  Fixes added by Vadim:
>  - Put new record in Makefile in alphabetic order;
>  - Remove http://www.mellanox.com from MAINTAINERS record;
> ---
>  Documentation/i2c/busses/i2c-mlxcpld |  47 +++
>  MAINTAINERS                          |   8 +
>  drivers/i2c/busses/Kconfig           |  11 +
>  drivers/i2c/busses/Makefile          |   1 +
>  drivers/i2c/busses/i2c-mlxcpld.c     | 544 +++++++++++++++++++++++++++++++++++
>  5 files changed, 611 insertions(+)
>  create mode 100644 Documentation/i2c/busses/i2c-mlxcpld
>  create mode 100644 drivers/i2c/busses/i2c-mlxcpld.c
> 
> diff --git a/Documentation/i2c/busses/i2c-mlxcpld b/Documentation/i2c/busses/i2c-mlxcpld
> new file mode 100644
> index 0000000..0f8678a
> --- /dev/null
> +++ b/Documentation/i2c/busses/i2c-mlxcpld
> @@ -0,0 +1,47 @@
> +Driver i2c-mlxcpld
> +
> +Author: Michael Shych <michaelsh@mellanox.com>
> +
> +This is a for Mellanox I2C controller logic, implemented in Lattice CPLD

Grammar: "This is a <what> for Mellanox..."?

> +device.
> +Device supports:
> + - Master mode.
> + - One physical bus.
> + - Polling mode.
> +
> +This controller is equipped within the next Mellanox systems:
> +"msx6710", "msx6720", "msb7700", "msn2700", "msx1410", "msn2410", "msb7800",
> +"msn2740", "msn2100".
> +
> +The next transaction types are supported:
> + - Receive Byte/Block.
> + - Send Byte/Block.
> + - Read Byte/Block.
> + - Write Byte/Block.
> +
> +Registers:
> +CTRL		0x1 - control reg.
> +			Resets all the registers.
> +HALF_CYC	0x4 - cycle reg.
> +			Configure the width of I2C SCL half clock cycle (in 4 LPC_CLK
> +			units).
> +I2C_HOLD	0x5 - hold reg.
> +			OE (output enable) is delayed by value set to this register
> +			(in LPC_CLK units)
> +CMD			0x6 - command reg.
> +			Bit 7(lsb), 0 = write, 1 = read.

lsb? Why is lsb in bit 7? Isn't bit 7 msb per definition? Are you
referring to the fact that this bit is the lsb on-the-wire? I.e.
are you trying to say that the fields in this register are reversed
compared to the on-wire byte format? I assume so...

> +			Bits [6:0] - the 7bit Address of the I2C device.
> +			It should be written last as it triggers an I2C transaction.

...but it make me wonder if the byte is bit-reversed or if it is just
fields that are out of order? Probably not, but, odd!

> +NUM_DATA	0x7 - data size reg.
> +			Number of address bytes to write in read transaction

s/address/data/ ???

> +NUM_ADDR	0x8 - address reg.
> +			Number of address bytes to write in read transaction.
> +STATUS		0x9 - status reg.
> +			Bit 0 - transaction is completed.
> +			Bit 4 - ACK/NACK.
> +DATAx		0xa - 0x54  - 68 bytes data buffer regs.
> +			For write transaction address is specified in four first bytes
> +			(DATA1 - DATA4), data starting from DATA4.
> +			For read transactions address is send in separate transaction and

s/address is send in/the address is sent in a/

> +			specified in four first bytes (DATA0 - DATA3). Data is reading

s/in four/in the four/
s/reading/read/

> +			starting from DATA0.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 411e3b8..26d05f8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7881,6 +7881,14 @@ W:	http://www.mellanox.com
>  Q:	http://patchwork.ozlabs.org/project/netdev/list/
>  F:	drivers/net/ethernet/mellanox/mlxsw/
>  
> +MELLANOX MLXCPLD I2C DRIVER
> +M:	Vadim Pasternak <vadimp@mellanox.com>
> +M:	Michael Shych <michaelsh@mellanox.com>
> +L:	linux-i2c@vger.kernel.org
> +S:	Supported
> +F:	drivers/i2c/busses/i2c-mlxcpld.c
> +F:	Documentation/i2c/busses/i2c-mlxcpld
> +
>  MELLANOX MLXCPLD LED DRIVER
>  M:	Vadim Pasternak <vadimp@mellanox.com>
>  L:	linux-leds@vger.kernel.org
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index d252276..6399cea 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1150,6 +1150,17 @@ config I2C_ELEKTOR
>  	  This support is also available as a module.  If so, the module
>  	  will be called i2c-elektor.
>  
> +config I2C_MLXCPLD
> +	tristate "Mellanox I2C driver"
> +	depends on X86_64
> +	help
> +	  This exposes the Mellanox platform I2C busses to the linux I2C layer
> +	  for X86 based systems.
> +	  Controller is implemented as CPLD logic.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called as i2c-mlxcpld.
> +
>  config I2C_PCA_ISA
>  	tristate "PCA9564/PCA9665 on an ISA bus"
>  	depends on ISA
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 29764cc..645bf08 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -116,6 +116,7 @@ obj-$(CONFIG_I2C_BCM_KONA)	+= i2c-bcm-kona.o
>  obj-$(CONFIG_I2C_BRCMSTB)	+= i2c-brcmstb.o
>  obj-$(CONFIG_I2C_CROS_EC_TUNNEL)	+= i2c-cros-ec-tunnel.o
>  obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
> +obj-$(CONFIG_I2C_MLXCPLD)	+= i2c-mlxcpld.o
>  obj-$(CONFIG_I2C_OPAL)		+= i2c-opal.o
>  obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
>  obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
> diff --git a/drivers/i2c/busses/i2c-mlxcpld.c b/drivers/i2c/busses/i2c-mlxcpld.c
> new file mode 100644
> index 0000000..07d5657
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-mlxcpld.c
> @@ -0,0 +1,544 @@
> +/*
> + * Copyright (c) 2016 Mellanox Technologies. All rights reserved.
> + * Copyright (c) 2016 Michael Shych <michaels@mellanox.com>
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + * 3. Neither the names of the copyright holders nor the names of its
> + *    contributors may be used to endorse or promote products derived from
> + *    this software without specific prior written permission.
> + *
> + * Alternatively, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") version 2 as published by the Free
> + * Software Foundation.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
> + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> + * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> + * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> + * POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +/* General defines */
> +#define MLXPLAT_CPLD_LPC_I2C_BASE_ADDR	0x2000
> +#define MLXCPLD_I2C_DEVICE_NAME		"i2c_mlxcpld"
> +#define MLXCPLD_I2C_VALID_FLAG		(I2C_M_RECV_LEN | I2C_M_RD)
> +#define MLXCPLD_I2C_BUS_NUM		1
> +#define MLXCPLD_I2C_DATA_REG_SZ		36
> +#define MLXCPLD_I2C_MAX_ADDR_LEN	4
> +#define MLXCPLD_I2C_RETR_NUM		2
> +#define MLXCPLD_I2C_XFER_TO		500000 /* usec */
> +#define MLXCPLD_I2C_POLL_TIME		2000   /* usec */
> +
> +/* LPC I2C registers */
> +#define MLXCPLD_LPCI2C_LPF_REG		0x0
> +#define MLXCPLD_LPCI2C_CTRL_REG		0x1
> +#define MLXCPLD_LPCI2C_HALF_CYC_REG	0x4
> +#define MLXCPLD_LPCI2C_I2C_HOLD_REG	0x5
> +#define MLXCPLD_LPCI2C_CMD_REG		0x6
> +#define MLXCPLD_LPCI2C_NUM_DAT_REG	0x7
> +#define MLXCPLD_LPCI2C_NUM_ADDR_REG	0x8
> +#define MLXCPLD_LPCI2C_STATUS_REG	0x9
> +#define MLXCPLD_LPCI2C_DATA_REG		0xa
> +
> +/* LPC I2C masks and parametres */
> +#define MLXCPLD_LPCI2C_RST_SEL_MASK	0x1
> +#define MLXCPLD_LPCI2C_TRANS_END	0x1
> +#define MLXCPLD_LPCI2C_STATUS_NACK	0x10
> +#define MLXCPLD_LPCI2C_NO_IND		0
> +#define MLXCPLD_LPCI2C_ACK_IND		1
> +#define MLXCPLD_LPCI2C_NACK_IND		2
> +
> +/**
> + * struct mlxcpld_i2c_curr_transf - current transaction parameters:

"xfer" seems to be a more common abbreviation of "transfer".

> + * @cmd: command;
> + * @addr_width: address width;
> + * @data_len: data length;
> + * @cmd: command register;
> + * @msg_num: message number;
> + * @msg: pointer to message buffer;
> + */
> +
> +struct mlxcpld_i2c_curr_transf {

Dito.

> +	u8 cmd;
> +	u8 addr_width;
> +	u8 data_len;
> +	u8 msg_num;
> +	struct i2c_msg *msg;
> +};
> +
> +/**
> + * struct mlxcpld_i2c_priv - private controller data:
> + * @adap: i2c adapter;
> + * @base_addr: base IO address;
> + * @lock: bus access lock;
> + * @xfer: current i2c transfer block;
> + * @dev: device handle;
> + */
> +
> +struct mlxcpld_i2c_priv {
> +	struct i2c_adapter adap;
> +	u32 base_addr;
> +	struct mutex lock;
> +	struct mlxcpld_i2c_curr_transf xfer;
> +	struct device *dev;
> +};
> +
> +static void mlxcpld_i2c_lpc_write_buf(u8 *data, u8 len, u32 addr)
> +{
> +	int i, nbyte, ndword;
> +
> +	nbyte = len % 4;
> +	ndword = len / 4;
> +	for (i = 0; i < ndword; i++)
> +		outl(*((u32 *)data + i), addr + i * 4);
> +	ndword *= 4;
> +	addr += ndword;
> +	data += ndword;
> +	for (i = 0; i < nbyte; i++)
> +		outb(*(data + i), addr + i);
> +}

I find the below easier to read (untested):

static void mlxcpld_i2c_lpc_write_buf(u8 *data, u8 len, u32 addr)
{
	int i;

	for (i = 0; i < len - len % 4; i += 4)
		outl(*(u32 *)(data + i), addr + i);
	for (; i < len; ++i)
		outb(*(data + i), addr + i);
}

> +
> +static void mlxcpld_i2c_lpc_read_buf(u8 *data, u8 len, u32 addr)
> +{
> +	int i, nbyte, ndword;
> +
> +	nbyte = len % 4;
> +	ndword = len / 4;
> +	for (i = 0; i < ndword; i++)
> +		*((u32 *)data + i) = inl(addr + i * 4);
> +	ndword *= 4;
> +	addr += ndword;
> +	data += ndword;
> +	for (i = 0; i < nbyte; i++)
> +		*(data + i) = inb(addr + i);
> +}

Similar to the above, of course.

> +
> +static void mlxcpld_i2c_read_comm(struct mlxcpld_i2c_priv *priv, u8 offs,
> +				  u8 *data, u8 datalen)
> +{
> +	u32 addr = priv->base_addr + offs;
> +
> +	switch (datalen) {
> +	case 1:
> +		*(data) = inb(addr);
> +		break;
> +	case 2:
> +		*((u16 *)data) = inw(addr);
> +		break;
> +	case 3:
> +		*((u16 *)data) = inw(addr);
> +		*(data + 2) = inb(addr + 2);
> +		break;
> +	case 4:
> +		*((u32 *)data) = inl(addr);
> +		break;
> +	default:
> +		mlxcpld_i2c_lpc_read_buf(data, datalen, addr);
> +		break;
> +	}
> +}
> +
> +static void mlxcpld_i2c_write_comm(struct mlxcpld_i2c_priv *priv, u8 offs,
> +				   u8 *data, u8 datalen)
> +{
> +	u32 addr = priv->base_addr + offs;
> +
> +	switch (datalen) {
> +	case 1:
> +		outb(*(data), addr);
> +		break;
> +	case 2:
> +		outw(*((u16 *)data), addr);
> +		break;
> +	case 3:
> +		outw(*((u16 *)data), addr);
> +		outb(*(data + 2), addr + 2);
> +		break;
> +	case 4:
> +		outl(*((u32 *)data), addr);
> +		break;
> +	default:
> +		mlxcpld_i2c_lpc_write_buf(data, datalen, addr);
> +		break;
> +	}
> +}
> +
> +/* Check validity of current i2c message and all transfer.
> + * Calculate also common length of all i2c messages in transfer.
> + */

Multiline comments should start with a /* on a line on its own,
to form symmetry with the trailing */.

> +static int mlxcpld_i2c_invalid_len(struct mlxcpld_i2c_priv *priv,
> +				   const struct i2c_msg *msg, u8 *comm_len)
> +{
> +	u8 max_len = msg->flags == I2C_M_RD ? MLXCPLD_I2C_DATA_REG_SZ -
> +		     MLXCPLD_I2C_MAX_ADDR_LEN : MLXCPLD_I2C_DATA_REG_SZ;
> +
> +	if (msg->len > max_len)
> +		return -EINVAL;
> +
> +	*comm_len += msg->len;
> +	if (*comm_len > MLXCPLD_I2C_DATA_REG_SZ)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/* Check validity of received i2c messages parameters.
> + * Returns 0 if OK, other - in case of invalid parameters
> + * or common length of data that should be passed to CPLD
> + */

Dito.

> +static int mlxcpld_i2c_check_msg_params(struct mlxcpld_i2c_priv *priv,
> +					struct i2c_msg *msgs, int num,
> +					u8 *comm_len)
> +{
> +	int i;
> +
> +	if (!num) {
> +		dev_err(priv->dev, "Incorrect 0 num of messages\n");
> +		return -EINVAL;
> +	}
> +
> +	if (unlikely(msgs[0].addr > 0x7f)) {
> +		dev_err(priv->dev, "Invalid address 0x%03x\n",
> +			msgs[0].addr);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < num; ++i) {
> +		if (unlikely(!msgs[i].buf)) {
> +			dev_err(priv->dev, "Invalid buf in msg[%d]\n",
> +				i);
> +			return -EINVAL;
> +		}
> +		if (unlikely(msgs[0].addr != msgs[i].addr)) {
> +			dev_err(priv->dev, "Invalid addr in msg[%d]\n",
> +				i);
> +			return -EINVAL;
> +		}
> +		if (unlikely(mlxcpld_i2c_invalid_len(priv, &msgs[i],
> +						     comm_len))) {
> +			dev_err(priv->dev, "Invalid len %d msg[%d], addr 0x%x, lag %u\n",
> +				msgs[i].len, i, msgs[i].addr, msgs[i].flags);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/* Check if transfer is completed and status of operation.
> + * Returns 0 - transfer completed (both ACK or NACK),
> + * negative - transfer isn't finished.
> + */

Dito.

> +static int mlxcpld_i2c_check_status(struct mlxcpld_i2c_priv *priv, int *status)
> +{
> +	u8 val;
> +
> +	mlxcpld_i2c_read_comm(priv, MLXCPLD_LPCI2C_STATUS_REG, &val, 1);
> +
> +	if (val & MLXCPLD_LPCI2C_TRANS_END) {
> +		if (val & MLXCPLD_LPCI2C_STATUS_NACK)
> +			/* The slave is unable to accept the data. No such
> +			 * slave, command not understood, or unable to accept
> +			 * any more data.
> +			 */

Dito, and I see more below...

> +			*status = MLXCPLD_LPCI2C_NACK_IND;
> +		else
> +			*status = MLXCPLD_LPCI2C_ACK_IND;
> +		return 0;
> +	}
> +	*status = MLXCPLD_LPCI2C_NO_IND;
> +
> +	return -EIO;
> +}
> +
> +static void mlxcpld_i2c_set_transf_data(struct mlxcpld_i2c_priv *priv,
> +					struct i2c_msg *msgs, int num,
> +					u8 comm_len)
> +{
> +	priv->xfer.msg = msgs;
> +	priv->xfer.msg_num = num;
> +
> +	/*
> +	 * All upper layers currently are never use transfer with more than
> +	 * 2 messages. Actually, it's also not so relevant in Mellanox systems
> +	 * because of HW limitation. Max size of transfer is o more than 20B
> +	 * in current x86 LPCI2C bridge.
> +	 */
> +	priv->xfer.cmd = msgs[num - 1].flags & I2C_M_RD;
> +
> +	if (priv->xfer.cmd == I2C_M_RD && comm_len != msgs[0].len) {
> +		priv->xfer.addr_width = msgs[0].len;
> +		priv->xfer.data_len = comm_len - priv->xfer.addr_width;
> +	} else {
> +		priv->xfer.addr_width = 0;
> +		priv->xfer.data_len = comm_len;
> +	}
> +}
> +
> +/* Reset CPLD LPCI2C block */
> +static void mlxcpld_i2c_reset(struct mlxcpld_i2c_priv *priv)
> +{
> +	u8 val;
> +
> +	mutex_lock(&priv->lock);
> +
> +	mlxcpld_i2c_read_comm(priv, MLXCPLD_LPCI2C_CTRL_REG, &val, 1);
> +	val &= ~MLXCPLD_LPCI2C_RST_SEL_MASK;
> +	mlxcpld_i2c_write_comm(priv, MLXCPLD_LPCI2C_CTRL_REG, &val, 1);
> +
> +	mutex_unlock(&priv->lock);
> +}
> +
> +/* Make sure the CPLD is ready to start transmitting. */
> +static int mlxcpld_i2c_check_busy(struct mlxcpld_i2c_priv *priv)
> +{
> +	u8 val;
> +
> +	mlxcpld_i2c_read_comm(priv, MLXCPLD_LPCI2C_STATUS_REG, &val, 1);
> +
> +	if (val & MLXCPLD_LPCI2C_TRANS_END)
> +		return 0;
> +
> +	return -EIO;
> +}
> +
> +static int mlxcpld_i2c_wait_for_free(struct mlxcpld_i2c_priv *priv)
> +{
> +	int timeout = 0;
> +
> +	do {
> +		if (!mlxcpld_i2c_check_busy(priv))
> +			break;
> +		usleep_range(MLXCPLD_I2C_POLL_TIME / 2, MLXCPLD_I2C_POLL_TIME);
> +		timeout += MLXCPLD_I2C_POLL_TIME;
> +	} while (timeout <= MLXCPLD_I2C_XFER_TO);
> +
> +	if (timeout > MLXCPLD_I2C_XFER_TO)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +/*
> + * Wait for master transfer to complete.
> + * It puts current process to sleep until we get interrupt or timeout expires.
> + * Returns the number of transferred or read bytes or error (<0).
> + */
> +static int mlxcpld_i2c_wait_for_tc(struct mlxcpld_i2c_priv *priv)
> +{
> +	int status, i, timeout = 0;
> +	u8 datalen;
> +
> +	do {
> +		usleep_range(MLXCPLD_I2C_POLL_TIME / 2, MLXCPLD_I2C_POLL_TIME);
> +		if (!mlxcpld_i2c_check_status(priv, &status))
> +			break;
> +		timeout += MLXCPLD_I2C_POLL_TIME;
> +	} while (status == 0 && timeout < MLXCPLD_I2C_XFER_TO);
> +
> +	switch (status) {
> +	case MLXCPLD_LPCI2C_NO_IND:
> +		return -ETIMEDOUT;
> +
> +	case MLXCPLD_LPCI2C_ACK_IND:
> +		if (priv->xfer.cmd != I2C_M_RD)
> +			return (priv->xfer.addr_width + priv->xfer.data_len);
> +
> +		if (priv->xfer.msg_num == 1)
> +			i = 0;
> +		else
> +			i = 1;
> +
> +		if (!priv->xfer.msg[i].buf)
> +			return -EINVAL;
> +
> +		/*
> +		 * Actual read data len will be always the same as
> +		 * requested len. 0xff (line pull-up) will be returned
> +		 * if slave has no data to return. Thus don't read
> +		 * MLXCPLD_LPCI2C_NUM_DAT_REG reg from CPLD.
> +		 */
> +		datalen = priv->xfer.data_len;
> +
> +		mlxcpld_i2c_read_comm(priv, MLXCPLD_LPCI2C_DATA_REG,
> +				      priv->xfer.msg[i].buf, datalen);
> +
> +		return datalen;
> +
> +	case MLXCPLD_LPCI2C_NACK_IND:
> +		return -EAGAIN;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static void mlxcpld_i2c_xfer_msg(struct mlxcpld_i2c_priv *priv)
> +{
> +	int i, len = 0;
> +	u8 cmd;
> +
> +	mlxcpld_i2c_write_comm(priv, MLXCPLD_LPCI2C_NUM_DAT_REG,
> +			       &priv->xfer.data_len, 1);
> +	mlxcpld_i2c_write_comm(priv, MLXCPLD_LPCI2C_NUM_ADDR_REG,
> +			       &priv->xfer.addr_width, 1);
> +
> +	for (i = 0; i < priv->xfer.msg_num; i++) {
> +		if ((priv->xfer.msg[i].flags & I2C_M_RD) != I2C_M_RD) {
> +			/* Don't write to CPLD buffer in read transaction */
> +			mlxcpld_i2c_write_comm(priv, MLXCPLD_LPCI2C_DATA_REG +
> +					       len, priv->xfer.msg[i].buf,
> +					       priv->xfer.msg[i].len);
> +			len += priv->xfer.msg[i].len;
> +		}
> +	}
> +
> +	/* Set target slave address with command for master transfer.
> +	 * It should be latest executed function before CPLD transaction.
> +	 */
> +	cmd = (priv->xfer.msg[0].addr << 1) | priv->xfer.cmd;
> +	mlxcpld_i2c_write_comm(priv, MLXCPLD_LPCI2C_CMD_REG, &cmd, 1);
> +}
> +
> +/* Generic lpc-i2c transfer.
> + * Returns the number of processed messages or error (<0).
> + */
> +static int mlxcpld_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> +			    int num)
> +{
> +	struct mlxcpld_i2c_priv *priv = i2c_get_adapdata(adap);
> +	u8 comm_len = 0;
> +	int err;
> +
> +	err = mlxcpld_i2c_check_msg_params(priv, msgs, num, &comm_len);
> +	if (err) {
> +		dev_err(priv->dev, "Incorrect message\n");
> +		return err;
> +	}
> +
> +	/* Check bus state */
> +	if (mlxcpld_i2c_wait_for_free(priv)) {
> +		dev_err(priv->dev, "LPCI2C bridge is busy\n");
> +
> +		/*
> +		 * Usually it means something serious has happened.
> +		 * We can not have unfinished previous transfer
> +		 * so it doesn't make any sense to try to stop it.
> +		 * Probably we were not able to recover from the
> +		 * previous error.
> +		 * The only reasonable thing - is soft reset.
> +		 */
> +		mlxcpld_i2c_reset(priv);
> +		if (mlxcpld_i2c_check_busy(priv)) {
> +			dev_err(priv->dev, "LPCI2C bridge is busy after reset\n");
> +			return -EIO;
> +		}
> +	}
> +
> +	mlxcpld_i2c_set_transf_data(priv, msgs, num, comm_len);
> +
> +	mutex_lock(&priv->lock);
> +
> +	/* Do real transfer. Can't fail */
> +	mlxcpld_i2c_xfer_msg(priv);
> +
> +	/* Wait for transaction complete */
> +	err = mlxcpld_i2c_wait_for_tc(priv);
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return err < 0 ? err : num;
> +}
> +
> +static u32 mlxcpld_i2c_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_BLOCK_DATA;
> +}
> +
> +static const struct i2c_algorithm mlxcpld_i2c_algo = {
> +	.master_xfer	= mlxcpld_i2c_xfer,
> +	.functionality	= mlxcpld_i2c_func
> +};
> +
> +static struct i2c_adapter mlxcpld_i2c_adapter = {
> +	.owner          = THIS_MODULE,
> +	.name           = "i2c-mlxcpld",
> +	.class          = I2C_CLASS_HWMON | I2C_CLASS_SPD,
> +	.algo           = &mlxcpld_i2c_algo,
> +	.retries	= MLXCPLD_I2C_RETR_NUM,
> +	.nr		= MLXCPLD_I2C_BUS_NUM,
> +};
> +
> +static int mlxcpld_i2c_probe(struct platform_device *pdev)
> +{
> +	struct mlxcpld_i2c_priv *priv;
> +	int err;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	mutex_init(&priv->lock);
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->dev = &pdev->dev;
> +
> +	/* Register with i2c layer */
> +	mlxcpld_i2c_adapter.timeout = usecs_to_jiffies(MLXCPLD_I2C_XFER_TO);
> +	priv->adap = mlxcpld_i2c_adapter;
> +	priv->adap.dev.parent = &pdev->dev;
> +	priv->base_addr = MLXPLAT_CPLD_LPC_I2C_BASE_ADDR;
> +	i2c_set_adapdata(&priv->adap, priv);
> +
> +	err = i2c_add_numbered_adapter(&priv->adap);
> +	if (err)
> +		mutex_destroy(&priv->lock);
> +
> +	return err;
> +}
> +
> +static int mlxcpld_i2c_remove(struct platform_device *pdev)
> +{
> +	struct mlxcpld_i2c_priv *priv = platform_get_drvdata(pdev);
> +
> +	i2c_del_adapter(&priv->adap);
> +	mutex_destroy(&priv->lock);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mlxcpld_i2c_driver = {
> +	.probe		= mlxcpld_i2c_probe,
> +	.remove		= mlxcpld_i2c_remove,
> +	.driver = {
> +		.name = MLXCPLD_I2C_DEVICE_NAME,
> +	},
> +};
> +
> +module_platform_driver(mlxcpld_i2c_driver);
> +
> +MODULE_AUTHOR("Michael Shych <michaels@mellanox.com>");
> +MODULE_DESCRIPTION("Mellanox I2C-CPLD controller driver");
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_ALIAS("platform:i2c-mlxcpld");
> 
