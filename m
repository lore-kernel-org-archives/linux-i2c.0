From: Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [patch v4] i2c: mux: mellanox: add driver
Date: Tue, 13 Sep 2016 18:37:28 +0000
Message-ID: <AM5PR0501MB209726C20727005A0AB70FF9A2FE0@AM5PR0501MB2097.eurprd05.prod.outlook.com>
References: <1473777525-187890-1-git-send-email-vadimp@mellanox.com>
 <9ee51a2a-83c4-f96d-09dd-5eeda233b3b5@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9ee51a2a-83c4-f96d-09dd-5eeda233b3b5@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, Michael Shych <michaelsh@mellanox.com>
List-Id: linux-i2c@vger.kernel.org



> -----Original Message-----
> From: Peter Rosin [mailto:peda@axentia.se]
> Sent: Tuesday, September 13, 2016 5:36 PM
> To: Vadim Pasternak <vadimp@mellanox.com>; wsa@the-dreams.de
> Cc: linux-i2c@vger.kernel.org; linux-kernel@vger.kernel.org; jiri@resnull=
i.us;
> Michael Shych <michaelsh@mellanox.com>
> Subject: Re: [patch v4] i2c: mux: mellanox: add driver
>=20
> It's shaping up, a few last nitpicks...
>=20
> On 2016-09-13 16:38, vadimp@mellanox.com wrote:
> > From: Vadim Pasternak <vadimp@mellanox.com>
> >
> > This driver allows I2C routing controlled through CPLD select
> > registers on wide range of Mellanox systems (CPLD Lattice device).
>=20
> s/wide/a wide/
>=20
> But is it really still "a wide range" now that i2c-mux-reg handles most C=
PLD mux
> types?

Yes. For all 1U systems we have port CPLD, where CPLD attached to i2c bus. =
And all QSFP are connected through this i2c CPLD muxes.
So, we'll use both mux drivers on most of our systems.

Thanks you very much for all your reviews.

=20
>=20
> > MUX selection is provided by digital and analog HW. Analog part is not
> > under SW control.
> > Digital part is under CPLD control (channel selection/de-selection).
> >
> > Connectivity schema.
> > i2c-mlxcpld                                 Digital               Analo=
g
> > driver
> > *--------*                                 * -> mux1 (virt bus2) -> mux=
 ->|
> > | I2CLPC | i2c physical                    * -> mux2 (virt bus3) -> mux=
 ->|
> > | bridge | bus 1                 *---------*                           =
   |
> > | logic  |---------------------> * mux reg *                           =
   |
> > | in CPLD|                       *---------*                           =
   |
> > *--------*   i2c-mux-mlxpcld          ^    * -> muxn (virt busn) -> mux=
 ->|
> >     |        driver                   |                                =
   |
> >     |        *---------------*        |                             Dev=
ices
> >     |        * CPLD (i2c bus)* select |
> >     |        * registers for *--------*
> >     |        * mux selection * deselect
> >     |        *---------------*
> >     |                 |
> > <-------->     <----------->
> > i2c cntrl      Board cntrl reg
> > reg space      space (mux select,
> >                IO, LED, WD, info)
> >
> > i2c-mux-mlxpcld does not necessarily require i2c-mlxcpld. It can be
> > use
>=20
> s/use/used/
>=20
> > along with another bus driver, and still control i2c routing through
> > CPLD mux selection, in case the system is equipped with CPLD capable
> > of mux selection control.
> >
> > The Kconfig currently controlling compilation of this code is:
> > drivers/i2c/muxes/Kconfig:config I2C_MUX_MLXCPLD
> >
> > Signed-off-by: Michael Shych <michaelsh@mellanox.com>
> > Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> > Reviewed-by: Jiri Pirko <jiri@mellanox.com>
> > ---
> > v3->v4
> >  Fixes issues pointed out by Peter:
> >   - Remove mlxcpld_mux_type;
> >   - Remove member type from mux control structure;
> >   - Remove variable muxes;
> >   - mlxcpld_mux_reg_write - set address from client;
> >   - mlxcpld_mux_reg_write - try smbus_xfer
> >   - mlxcpld_mux_select_chan - remove compare with for mux type;
> >   - mlxcpld_mux_probe - use I2C_FUNC_SMBUS_WRITE_BYTE_DATA instead
> of
> >     I2C_FUNC_SMBUS_BYTE
> >   - mlxcpld_mux_probe - remove switch statement
> >   - mlxcpld_mux_probe - update comment;
> >   - mlxcpld_mux_probe -change logic in testing num_adaps;
> >   - remove members first_channel and addr from mlxcpld_mux_plat_data
> >     structure;
> > v2->v3
> >  Fixes issues pointed out by Peter:
> >   - Fix several comments;
> >   - In MAINTAINERS file use linux-i2c instead of linux-kernel;
> >   - Place include files in alphabetic order;
> >   - When channel select fail, set last_chan to zero for cleaning last v=
alue;
> >   - Return with error from probe if there is no platform data;
> >   - Use i2c_mux_reg driver for the lpc_access cases:
> >     it fit well for Mellanox system with LPC access - has been tested a=
nd it
> > 	works good.
> >   - Limit this driver to i2c_access only one device (mlxcpld_mux_module=
).
> > v1->v2
> >  Fixes issues pointed out by Peter:
> >   - changes in commit cover massage;
> >   - change leg to channel in comments;
> >   - missed return err;
> >   - use platform data mux array rather the offset from 1st channel in p=
robe
> >     routine;
> >   - remove owner field from driver structure;
> >   - use module_i2c_driver macros, instead if __init and __exit;
> >   - remove deselect on exit flag;
> >   - add record to MAINTAINER file;
> > ---
> >  MAINTAINERS                         |   8 ++
> >  drivers/i2c/muxes/Kconfig           |  11 ++
> >  drivers/i2c/muxes/Makefile          |   1 +
> >  drivers/i2c/muxes/i2c-mux-mlxcpld.c | 224
> ++++++++++++++++++++++++++++++++++++
> >  include/linux/i2c/mlxcpld.h         |  52 +++++++++
> >  5 files changed, 296 insertions(+)
> >  create mode 100644 drivers/i2c/muxes/i2c-mux-mlxcpld.c
> >  create mode 100644 include/linux/i2c/mlxcpld.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index 0bbe4b1..be83d69 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7655,6 +7655,14 @@ W:	http://www.mellanox.com
> >  Q:	http://patchwork.ozlabs.org/project/netdev/list/
> >  F:	drivers/net/ethernet/mellanox/mlxsw/
> >
> > +MELLANOX MLXCPLD I2C MUX DRIVER
> > +M:	Vadim Pasternak <vadimp@mellanox.com>
> > +M:	Michael Shych <michaelsh@mellanox.com>
> > +L:	linux-i2c@vger.kernel.org
> > +S:	Supported
> > +W:	http://www.mellanox.com
> > +F:	drivers/i2c/muxes/i2c-mux-mlxcpld.c
> > +
> >  SOFT-ROCE DRIVER (rxe)
> >  M:	Moni Shoua <monis@mellanox.com>
> >  L:	linux-rdma@vger.kernel.org
> > diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> > index e280c8e..b7ab144 100644
> > --- a/drivers/i2c/muxes/Kconfig
> > +++ b/drivers/i2c/muxes/Kconfig
> > @@ -81,4 +81,15 @@ config I2C_DEMUX_PINCTRL
> >  	  demultiplexer that uses the pinctrl subsystem. This is useful if yo=
u
> >  	  want to change the I2C master at run-time depending on features.
> >
> > +config I2C_MUX_MLXCPLD
> > +        tristate "Mellanox CPLD based I2C multiplexer"
> > +        help
> > +          If you say yes to this option, support will be included for =
a
> > +          CPLD based I2C multiplexer. This driver provides access to
> > +          I2C busses connected through a MUX, which is controlled
> > +          by a CPLD registers.
>=20
> s/registers/register/
>=20
> > +
> > +          This driver can also be built as a module.  If so, the modul=
e
> > +          will be called i2c-mux-mlxcpld.
> > +
> >  endmenu
> > diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
> > index 7c267c2..e5c990e 100644
> > --- a/drivers/i2c/muxes/Makefile
> > +++ b/drivers/i2c/muxes/Makefile
> > @@ -10,5 +10,6 @@ obj-$(CONFIG_I2C_MUX_PCA9541)	+=3D i2c-mux-
> pca9541.o
> >  obj-$(CONFIG_I2C_MUX_PCA954x)	+=3D i2c-mux-pca954x.o
> >  obj-$(CONFIG_I2C_MUX_PINCTRL)	+=3D i2c-mux-pinctrl.o
> >  obj-$(CONFIG_I2C_MUX_REG)	+=3D i2c-mux-reg.o
> > +obj-$(CONFIG_I2C_MUX_MLXCPLD)	+=3D i2c-mux-mlxcpld.o
>=20
> Please keep these lines sorted too.
>=20
> >
> >  ccflags-$(CONFIG_I2C_DEBUG_BUS) :=3D -DDEBUG diff --git
> > a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> > b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> > new file mode 100644
> > index 0000000..08d3b1a
> > --- /dev/null
> > +++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> > @@ -0,0 +1,224 @@
> > +/*
> > + * drivers/i2c/muxes/i2c-mux-mlxcpld.c
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
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/i2c.h>
> > +#include <linux/i2c-mux.h>
> > +#include <linux/io.h>
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/version.h>
> > +#include <linux/i2c/mlxcpld.h>
> > +
> > +#define CPLD_MUX_MAX_NCHANS	8
> > +
> > +/* mlxcpld_mux - mux control structure:
> > + * @last_chan - last register value
> > + * @client - I2C device client
> > + */
> > +struct mlxcpld_mux {
> > +	u8 last_chan;
> > +	struct i2c_client *client;
> > +};
> > +
> > +/* MUX logic description.
> > + * Driver can support different mux control logic, according to CPLD
> > + * implementation.
> > + *
> > + * Connectivity schema.
> > + *
> > + * i2c-mlxcpld                                 Digital               A=
nalog
> > + * driver
> > + * *--------*                                 * -> mux1 (virt bus2) ->=
 mux -> |
> > + * | I2CLPC | i2c physical                    * -> mux2 (virt bus3) ->=
 mux -> |
> > + * | bridge | bus 1                 *---------*                       =
        |
> > + * | logic  |---------------------> * mux reg *                       =
        |
> > + * | in CPLD|                       *---------*                       =
        |
> > + * *--------*   i2c-mux-mlxpcld          ^    * -> muxn (virt busn) ->=
 mux -> |
> > + *     |        driver                   |                            =
        |
> > + *     |        *---------------*        |                            =
  Devices
> > + *     |        * CPLD (i2c bus)* select |
> > + *     |        * registers for *--------*
> > + *     |        * mux selection * deselect
> > + *     |        *---------------*
> > + *     |                 |
> > + * <-------->     <----------->
> > + * i2c cntrl      Board cntrl reg
> > + * reg space      space (mux select,
> > + *                IO, LED, WD, info)
> > + *
> > + */
> > +
> > +static const struct i2c_device_id mlxcpld_mux_id[] =3D {
> > +	{ "mlxcpld_mux_module", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, mlxcpld_mux_id);
> > +
> > +/* Write to mux register. Don't use i2c_transfer() and
> > + * i2c_smbus_xfer() for this as they will try to lock adapter a
> > +second time  */
>=20
> This comment has a strange shortish first line that disturbs me, and you =
are
> missing the ending period.
>=20
> /* Write to mux register. Don't use i2c_transfer() and i2c_smbus_xfer()
>  * for this as they will try to lock adapter a second time.
>  */
>=20
> > +static int mlxcpld_mux_reg_write(struct i2c_adapter *adap,
> > +				 struct i2c_client *client, u8 val) {
> > +	struct mlxcpld_mux_plat_data *pdata =3D
> > +dev_get_platdata(&client->dev);
> > +
> > +	if (adap->algo->master_xfer) {
> > +		struct i2c_msg msg;
> > +		u8 msgbuf[] =3D {pdata->sel_reg_addr, val};
> > +
> > +		msg.addr =3D client->addr;
> > +		msg.flags =3D 0;
> > +		msg.len =3D 2;
> > +		msg.buf =3D msgbuf;
> > +		return __i2c_transfer(adap, &msg, 1);
> > +	} else if (adap->algo->smbus_xfer) {
> > +		union i2c_smbus_data data;
> > +
> > +		data.byte =3D val;
> > +		return adap->algo->smbus_xfer(adap, client->addr,
> > +					      client->flags, I2C_SMBUS_WRITE,
> > +					      pdata->sel_reg_addr,
> > +					      I2C_SMBUS_BYTE_DATA, &data);
> > +	} else
> > +		return -ENODEV;
> > +}
> > +
> > +static int mlxcpld_mux_select_chan(struct i2c_mux_core *muxc, u32
> > +chan) {
> > +	struct mlxcpld_mux *data =3D i2c_mux_priv(muxc);
> > +	struct i2c_client *client =3D data->client;
> > +	u8 regval =3D chan + 1;
> > +	int err =3D 0;
> > +
> > +	/* Only select the channel if its different from the last channel */
> > +	if (data->last_chan !=3D regval) {
> > +		err =3D mlxcpld_mux_reg_write(muxc->parent, client, regval);
> > +		if (err)
> > +			data->last_chan =3D 0;
> > +		else
> > +			data->last_chan =3D regval;
> > +	}
> > +
> > +	return err;
> > +}
> > +
> > +static int mlxcpld_mux_deselect(struct i2c_mux_core *muxc, u32 chan)
> > +{
> > +	struct mlxcpld_mux *data =3D i2c_mux_priv(muxc);
> > +	struct i2c_client *client =3D data->client;
> > +
> > +	/* Deselect active channel */
> > +	data->last_chan =3D 0;
> > +
> > +	return mlxcpld_mux_reg_write(muxc->parent, client, data->last_chan);
> > +}
> > +
> > +/* I2C init/probing/exit functions */ static int
> > +mlxcpld_mux_probe(struct i2c_client *client,
> > +			     const struct i2c_device_id *id) {
> > +	struct i2c_adapter *adap =3D to_i2c_adapter(client->dev.parent);
> > +	struct mlxcpld_mux_plat_data *pdata =3D dev_get_platdata(&client-
> >dev);
> > +	struct i2c_mux_core *muxc;
> > +	int num, force;
> > +	struct mlxcpld_mux *data;
> > +	int err;
> > +
> > +	if (!pdata)
> > +		return -EINVAL;
> > +
> > +	if (!i2c_check_functionality(adap,
> I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
> > +		return -ENODEV;
> > +
> > +	muxc =3D i2c_mux_alloc(adap, &client->dev, CPLD_MUX_MAX_NCHANS,
> > +			     sizeof(*data), 0, mlxcpld_mux_select_chan,
> > +			     mlxcpld_mux_deselect);
> > +	if (!muxc)
> > +		return -ENOMEM;
> > +
> > +	data =3D i2c_mux_priv(muxc);
> > +	i2c_set_clientdata(client, muxc);
> > +	data->client =3D client;
> > +	data->last_chan =3D 0; /* force the first selection */
> > +
> > +	/* Create an adapter for each channel. */
> > +	for (num =3D 0; num < CPLD_MUX_MAX_NCHANS; num++) {
> > +		force =3D 0; /* dynamic adap number */
>=20
> This assignment can be dropped.
>=20
> > +		if (num >=3D pdata->num_adaps)
> > +			/* discard unconfigured channels */
> > +			break;
> > +
> > +		force =3D pdata->adap_ids[num];
> > +
> > +		err =3D i2c_mux_add_adapter(muxc, force, num, 0);
> > +		if (err) {
> > +			dev_err(&client->dev, "failed to register multiplexed
> adapter %d as bus %d\n",
> > +				num, force);
>=20
> There is generic error messages for all failures inside i2c_mux_add_adapt=
er, so
> this message can be dropped. If the generic messages are not sufficient, =
please
> expand them instead of adding extra messages.
>=20
> > +			goto virt_reg_failed;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +
> > +virt_reg_failed:
> > +	i2c_mux_del_adapters(muxc);
> > +	return err;
> > +}
> > +
> > +static int mlxcpld_mux_remove(struct i2c_client *client) {
> > +	struct i2c_mux_core *muxc =3D i2c_get_clientdata(client);
> > +
> > +	i2c_mux_del_adapters(muxc);
> > +	return 0;
> > +}
> > +
> > +static struct i2c_driver mlxcpld_mux_driver =3D {
> > +	.driver		=3D {
> > +		.name	=3D "mlxcpld-mux",
> > +	},
> > +	.probe		=3D mlxcpld_mux_probe,
> > +	.remove		=3D mlxcpld_mux_remove,
> > +	.id_table	=3D mlxcpld_mux_id,
> > +};
> > +
> > +module_i2c_driver(mlxcpld_mux_driver);
> > +
> > +MODULE_AUTHOR("Michael Shych (michaels@mellanox.com)");
> > +MODULE_DESCRIPTION("Mellanox I2C-CPLD-MUX driver");
> > +MODULE_LICENSE("GPL v2"); MODULE_ALIAS("platform:i2c-mux-mlxcpld");
> > diff --git a/include/linux/i2c/mlxcpld.h b/include/linux/i2c/mlxcpld.h
> > new file mode 100644 index 0000000..b08dcb1
> > --- /dev/null
> > +++ b/include/linux/i2c/mlxcpld.h
> > @@ -0,0 +1,52 @@
> > +/*
> > + * mlxcpld.h - Mellanox I2C multiplexer support in CPLD
> > + *
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
> > + */
> > +
> > +#ifndef _LINUX_I2C_MLXCPLD_H
> > +#define _LINUX_I2C_MLXCPLD_H
> > +
> > +/* Platform data for the CPLD I2C multiplexers */
> > +
> > +/* mlxcpld_mux_plat_data - per mux data, used with
> > +i2c_register_board_info
> > + * @adap_ids - adapter array
> > + * @num_adaps - number of adapters
> > + * @sel_reg_addr - mux select register offset in CPLD space  */
> > +struct mlxcpld_mux_plat_data {
> > +	int *adap_ids;
> > +	int num_adaps;
> > +	int sel_reg_addr;
> > +};
> > +
> > +#endif /* _LINUX_I2C_MLXCPLD_H */
> >
