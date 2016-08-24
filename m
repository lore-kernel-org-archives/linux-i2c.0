From: Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [patch 2/2] i2c: mux: mellanox: add driver
Date: Wed, 24 Aug 2016 16:20:38 +0000
Message-ID: <AM5PR0501MB2097482A438B1E22ED663174A2EA0@AM5PR0501MB2097.eurprd05.prod.outlook.com>
References: <1472046988-111956-1-git-send-email-vadimp@mellanox.com>
 <9cf2abd0-443b-2964-c809-1ac5a4321f8b@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9cf2abd0-443b-2964-c809-1ac5a4321f8b@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, Michael Shych <michaelsh@mellanox.com>
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

Thank you very much for your review.

> -----Original Message-----
> From: Peter Rosin [mailto:peda@axentia.se]
> Sent: Wednesday, August 24, 2016 4:55 PM
> To: Vadim Pasternak <vadimp@mellanox.com>; wsa@the-dreams.de
> Cc: linux-i2c@vger.kernel.org; linux-kernel@vger.kernel.org; jiri@resnull=
i.us;
> Michael Shych <michaelsh@mellanox.com>
> Subject: Re: [patch 2/2] i2c: mux: mellanox: add driver
>=20
> On 2016-08-24 15:56, Vadim Pasternak wrote:
> > From: Vadim Pasternak <vadimp@mellanox.com>
> >
> > This driver allows I2C routing controlled through CPLD select
> > registers on wide range of Mellanox systems (CPLD Lattice device).
> > MUX selection is provided by digital and analog HW. Analog part is not
> > under SW control. Digital part is under CPLD control (channel selection=
/de-
> selection).
> >
> > MUX logic description.
> > Mux selector can control 256 mux (channels), if utilized one CPLD
> > register
> > (8 bits) as select register - register value specifies mux id.
> > Mux selector can control n*256 mux, if utilized n CPLD registers as
> > select registers.
> > The number of registers within the same CPLD can be combined to
> > support mux hierarchy.
> > This logic can be applied for LPC attached CPLD and fro I2C attached CP=
LD.
> > Driver can support different mux control logic, according to CPLD
> > implementation.
>=20
> This paragraph is strangely wrapped. And please limit to 75 chars per lin=
e as per
> checkpatch.
>=20
> Also, I have a hard time getting the grips on the actual number of mux ch=
annels
> that can be controlled. You talk about n * 256 channels if you have n reg=
isters.
> But the code below appears to only deal with one register. So why complic=
ate
> things in the comments and the commit message? It is also not entirely cl=
ear to
> me if you support 8 channels or if you really support 256 channels. That =
would
> be huge number of pins.

In CPLD we have three channel selection registers, which one can support up=
 to 256 channels.
CPLD could be programmed with the bigger number of selection registers.
I tried to explain it in description.
Since it's misleading, I'll remove it.

>=20
> Because from the text above, I would have guessed 256, but below...
>=20
> > Connectivity schema.
> > i2c-mlxcpld                                 Digital               Analo=
g
> > driver
> > *--------*                                 * -> mux1 (virt bus2) -> mux=
 -> |
> > | I2CLPC | i2c physical                    * -> mux2 (virt bus3) -> mux=
 -> |
> > | bridge | bus 1                 *---------*                           =
    |
> > | logic  |---------------------> * mux reg *                           =
    |
> > | in CPLD|                       *---------*                           =
    |
> > *--------*   i2c-mux-mlxpcld          ^    * -> muxn (virt busn) -> mux=
 -> |
> >     |        driver                   |                                =
    |
> >     |        *---------------*        |                              De=
vices
> >     |        * CPLD (LPC bus)* select |
> >     |        * registers for *--------*
> >     |        * mux selection * deselect
> >     |        *---------------*
> >     |                 |
> > <-------->     <----------->
> > i2c cntrl      Board cntrl reg
> > reg space      space (mux select,
> >     |          IO, LED, WD, info)
> >     |                 |                  *-----*   *-----*
> >     *------------- LPC bus --------------| PCH |---| CPU |
> >                                          *-----*   *-----*
> >
> > i2c-mux-mlxpcld does not necessary required i2c-mlxcpld. It can be use
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
> >  drivers/i2c/muxes/Kconfig           |  11 ++
> >  drivers/i2c/muxes/Makefile          |   1 +
> >  drivers/i2c/muxes/i2c-mux-mlxcpld.c | 352
> ++++++++++++++++++++++++++++++++++++
> >  include/linux/i2c/mlxcpld.h         |  67 +++++++
> >  4 files changed, 431 insertions(+)
> >  create mode 100644 drivers/i2c/muxes/i2c-mux-mlxcpld.c
> >  create mode 100644 include/linux/i2c/mlxcpld.h
> >
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
> >
> >  ccflags-$(CONFIG_I2C_DEBUG_BUS) :=3D -DDEBUG diff --git
> > a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> > b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> > new file mode 100644
> > index 0000000..ae860de
> > --- /dev/null
> > +++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> > @@ -0,0 +1,352 @@
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
> > +#include <linux/module.h>
> > +#include <linux/version.h>
> > +#include <linux/init.h>
> > +#include <linux/slab.h>
> > +#include <linux/device.h>
> > +#include <linux/i2c.h>
> > +#include <linux/i2c-mux.h>
> > +#include <linux/io.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/i2c/mlxcpld.h>
> > +
> > +#define CPLD_MUX_MAX_NCHANS	8
> > +#define CPLD_MUX_EXT_MAX_NCHANS	24
>=20
> ...here, you say 8. Or 24 for some ext thingy, which is not mentioned in =
the
> commit message. So, what's going on? Why mess things up by mentioning 256=
?
>=20
Yes, we have systems only with 8 and 24 channels.
Since through one register it's possible to control up to 256 channels, I m=
entioned it in description.
I'll remove it.=20
> > +
> > +/*
> > + * mlxcpld_mux types - kind of mux supported by driver:
> > + * @mlxcpld_mux_tor - LPC access; 8 channels/legs; select/deselect -
> > + *		      channel=3Dfirst defined channel(2/10) + channel/leg
> > + * @mlxcpld_mux_mgmt - LPC access; 8 channels/legs; select/deselect  -
> > + *		       channel=3D1 + channel/leg
> > + * @mlxcpld_mux_mgmt_ext - LPC access; 24 channels/legs; select/desele=
ct
> -
> > + *			   channel=3D1 + channel/leg
> > + * @mlxcpld_mux_module - I2C access; 8 channels/legs; select/deselect =
 -
> > + *			 channel=3D1 + channel/leg
> > + */
>=20
> Channels? Legs? If they are the same, then pick one name, and use it
> throughout. I prefer channels in that case.

Channels.

>=20
> If you mean channels per leg, then you need to define what a leg is.
>=20
> > +enum mlxcpld_mux_type {
> > +	mlxcpld_mux_tor,
> > +	mlxcpld_mux_mgmt,
> > +	mlxcpld_mux_mgmt_ext,
> > +	mlxcpld_mux_module,
> > +};
> > +
> > +/* mlxcpld_mux_type - underlying physical bus, to which device is conn=
ected:
> > + * @lpc_access - LPC connected CPLD device
> > + * @i2c_access - I2C connected CPLD device  */ enum
> > +mlxcpld_mux_access_type {
> > +	lpc_access,
> > +	i2c_access,
> > +};
> > +
> > +/* mlxcpld_mux - mux control structure:
> > + * @type - mux type
> > + * @last_chan - last register value
> > + * @client - I2C device client
> > + */
> > +struct mlxcpld_mux {
> > +	enum mlxcpld_mux_type type;
> > +	u8 last_chan;
> > +	struct i2c_client *client;
> > +};
> > +
> > +/* mlxcpld_mux_desc - mux descriptor structure:
> > + * @nchans - number of channels
> > + * @muxtype - physical mux type (LPC or I2C)  */ struct
> > +mlxcpld_mux_desc {
> > +	u8 nchans;
> > +	enum mlxcpld_mux_access_type muxtype; };
> > +
> > +/* MUX logic description.
> > + * Mux selector can control 256 mux (channels), if utilized one CPLD
> > +register
> > + * (8 bits) as select register - register value specifies mux id.
> > + * Mux selector can control n*256 mux, if utilized n CPLD registers
> > +as select
> > + * registers.
> > + * The number of registers within the same CPLD can be combined to
> > +support
> > + * mux hierarchy.
> > + * This logic can be applied for LPC attached CPLD and fro I2C attache=
d CPLD.
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
> > + *     |        * CPLD (LPC bus)* select |
> > + *     |        * registers for *--------*
> > + *     |        * mux selection * deselect
> > + *     |        *---------------*
> > + *     |                 |
> > + * <-------->     <----------->
> > + * i2c cntrl      Board cntrl reg
> > + * reg space      space (mux select,
> > + *     |          IO, LED, WD, info)
> > + *     |                 |                  *-----*   *-----*
> > + *     *------------- LPC bus --------------| PCH |---| CPU |
> > + *                                          *-----*   *-----*
> > + *
> > + * i2c-mux-mlxpcld does not necessary required i2c-mlxcpld. It can be
> > +use along
> > + * with another bus driver, and still control i2c routing through
> > +CPLD mux
> > + * selection, in case the system is equipped with CPLD capable of mux
> > +selection
> > + * control.
> > + */
> > +static const struct mlxcpld_mux_desc muxes[] =3D {
> > +	[mlxcpld_mux_tor] =3D {
> > +		.nchans =3D CPLD_MUX_MAX_NCHANS,
> > +		.muxtype =3D lpc_access,
> > +	},
> > +	[mlxcpld_mux_mgmt] =3D {
> > +		.nchans =3D CPLD_MUX_MAX_NCHANS,
> > +		.muxtype =3D lpc_access,
> > +	},
> > +	[mlxcpld_mux_mgmt_ext] =3D {
> > +		.nchans =3D CPLD_MUX_EXT_MAX_NCHANS,
> > +		.muxtype =3D lpc_access,
> > +	},
> > +	[mlxcpld_mux_module] =3D {
> > +		.nchans =3D CPLD_MUX_MAX_NCHANS,
> > +		.muxtype =3D i2c_access,
> > +	},
> > +};
> > +
> > +static const struct i2c_device_id mlxcpld_mux_id[] =3D {
> > +	{ "mlxcpld_mux_tor", mlxcpld_mux_tor },
> > +	{ "mlxcpld_mux_mgmt", mlxcpld_mux_mgmt },
> > +	{ "mlxcpld_mux_mgmt_ext", mlxcpld_mux_mgmt_ext },
> > +	{ "mlxcpld_mux_module", mlxcpld_mux_module },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, mlxcpld_mux_id);
> > +
> > +/* Write to mux register. Don't use i2c_transfer() and
> > + * i2c_smbus_xfer() for this as they will try to lock adapter a
> > +second time  */ static int mlxcpld_mux_reg_write(struct i2c_adapter
> > +*adap,
> > +				 struct i2c_client *client, u8 val,
> > +				 enum mlxcpld_mux_access_type muxtype) {
> > +	struct mlxcpld_mux_platform_data *pdata =3D
> > +						dev_get_platdata(&client-
> >dev);
> > +	int ret =3D -ENODEV;
> > +
> > +	switch (muxtype) {
> > +	case lpc_access:
> > +		outb(val, pdata->addr); /* addr =3D CPLD base + offset */
> > +		ret =3D 1;
> > +		break;
> > +
> > +	case i2c_access:
> > +		if (adap->algo->master_xfer) {
> > +			struct i2c_msg msg;
> > +			u8 msgbuf[] =3D {pdata->sel_reg_addr, val};
>=20
> You assume there is pdata for all muxes connected via i2c. Is that certai=
n?

Yes

>=20
> > +
> > +			msg.addr =3D pdata->addr;
> > +			msg.flags =3D 0;
> > +			msg.len =3D 2;
> > +			msg.buf =3D msgbuf;
> > +			return adap->algo->master_xfer(adap, &msg, 1);
> > +		}
> > +		dev_err(&client->dev, "SMBus isn't supported on this
> adapter\n");
> > +		break;
> > +
> > +	default:
> > +		dev_err(&client->dev, "Incorrect muxtype %d\n", muxtype);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int mlxcpld_mux_select_chan(struct i2c_mux_core *muxc, u32
> > +chan) {
> > +	struct mlxcpld_mux *data =3D i2c_mux_priv(muxc);
> > +	struct i2c_client *client =3D data->client;
> > +	struct mlxcpld_mux_platform_data *pdata =3D
> > +						dev_get_platdata(&client-
> >dev);
> > +	const struct mlxcpld_mux_desc *mux =3D &muxes[data->type];
> > +	u8 regval;
> > +	int err;
> > +
> > +	switch (data->type) {
> > +	case mlxcpld_mux_tor:
> > +		regval =3D pdata->first_channel + chan;
>=20
> You assume that there is pdata for all muxes of type mlxcpld_mux_tor. Is =
that
> certain?

Yes

>=20
> > +		break;
> > +
> > +	case mlxcpld_mux_mgmt:
> > +	case mlxcpld_mux_mgmt_ext:
> > +	case mlxcpld_mux_module:
> > +		regval =3D chan + 1;
> > +		break;
> > +
> > +	default:
> > +		return -ENXIO;
> > +	}
> > +
> > +	/* Only select the channel if its different from the last channel */
> > +	if (data->last_chan !=3D regval) {
> > +		err =3D mlxcpld_mux_reg_write(muxc->parent, client, regval,
> > +					    mux->muxtype);
>=20
> You are not making use of err, and you then set last_chan as if no error =
could
> ever occur. Is that a problem?


Missed.
Should return err;
>=20
> > +		data->last_chan =3D regval;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int mlxcpld_mux_deselect(struct i2c_mux_core *muxc, u32 chan)
> > +{
> > +	struct mlxcpld_mux *data =3D i2c_mux_priv(muxc);
> > +	struct i2c_client *client =3D data->client;
> > +	const struct mlxcpld_mux_desc *mux =3D &muxes[data->type];
> > +
> > +	/* Deselect active channel */
> > +	data->last_chan =3D 0;
> > +
> > +	return mlxcpld_mux_reg_write(muxc->parent, client, data->last_chan,
> > +				     mux->muxtype);
> > +}
> > +
> > +/* I2C init/probing/exit functions */ static int
> > +mlxcpld_mux_probe(struct i2c_client *client,
> > +			     const struct i2c_device_id *id) {
> > +	struct i2c_adapter *adap =3D to_i2c_adapter(client->dev.parent);
> > +	struct mlxcpld_mux_platform_data *pdata =3D
> > +						dev_get_platdata(&client-
> >dev);
> > +	struct i2c_mux_core *muxc;
> > +	int num, force;
> > +	u8 nchans;
> > +	struct mlxcpld_mux *data;
> > +	int err;
> > +
> > +	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE))
> > +		return -ENODEV;
> > +
> > +	switch (id->driver_data) {
> > +	case mlxcpld_mux_tor:
> > +	case mlxcpld_mux_mgmt:
> > +	case mlxcpld_mux_mgmt_ext:
> > +	case mlxcpld_mux_module:
> > +		nchans =3D muxes[id->driver_data].nchans;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	muxc =3D i2c_mux_alloc(adap, &client->dev, nchans, sizeof(*data), 0,
> > +			     mlxcpld_mux_select_chan, mlxcpld_mux_deselect);
> > +	if (!muxc)
> > +		return -ENOMEM;
> > +
> > +	data =3D i2c_mux_priv(muxc);
> > +	i2c_set_clientdata(client, muxc);
> > +	data->client =3D client;
> > +	data->type =3D id->driver_data;
> > +	data->last_chan =3D 0; /* force the first selection */
> > +
> > +	/* Only in mlxcpld_mux_tor first_channel can be different.
> > +	 * In other mlxcpld_mux types channel numbering begin from 1
> > +	 * Now create an adapter for each channel
> > +	 */
> > +	for (num =3D 0; num < muxes[data->type].nchans; num++) {
> > +		force =3D 0; /* dynamic adap number */
> > +		if (pdata) {
> > +			if (num < pdata->num_modes)
> > +				force =3D pdata->first_channel + num;
>=20
> It looks as if you, as soon as pdata is supplied, tie the adapter number =
to the
> needed register value to select the mux channel.
> That's not good. At all.
>=20
> Looks like you need to dig into pdata->modes[num].adap_id

Do you suggest to replace=20
force =3D pdata->first_channel + num; with
force =3D pdata->modes[num].adap_id;
Right?

>=20
> > +			else
> > +				/* discard unconfigured channels */
> > +				break;
> > +		}
> > +
> > +		err =3D i2c_mux_add_adapter(muxc, force, num, 0);
> > +		if (err) {
> > +			dev_err(&client->dev, "failed to register multiplexed
> adapter %d as bus %d\n",
> > +				num, force);
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
> > +		.owner	=3D THIS_MODULE,
>=20
> .owner is not needed.
>=20
> > +	},
> > +	.probe		=3D mlxcpld_mux_probe,
> > +	.remove		=3D mlxcpld_mux_remove,
> > +	.id_table	=3D mlxcpld_mux_id,
> > +};
> > +
>=20
> Replace from here...
>=20
> > +static int __init mlxcpld_mux_init(void) {
> > +	return i2c_add_driver(&mlxcpld_mux_driver);
> > +}
> > +
> > +static void __exit mlxcpld_mux_exit(void) {
> > +	i2c_del_driver(&mlxcpld_mux_driver);
> > +}
> > +
> > +module_init(mlxcpld_mux_init);
> > +module_exit(mlxcpld_mux_exit);
>=20
> ...to here, with
>=20
> module_i2c_driver(mlxcpld_mux_driver);
>=20
> > +
> > +MODULE_AUTHOR("Michael Shych (michaels@mellanox.com)");
> > +MODULE_DESCRIPTION("Mellanox I2C-CPLD-MUX driver");
> > +MODULE_LICENSE("GPL v2"); MODULE_ALIAS("platform:i2c-mux-mlxcpld");
> > diff --git a/include/linux/i2c/mlxcpld.h b/include/linux/i2c/mlxcpld.h
> > new file mode 100644 index 0000000..cc3236e
> > --- /dev/null
> > +++ b/include/linux/i2c/mlxcpld.h
> > @@ -0,0 +1,67 @@
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
> > +/* mlxcpld_mux_platform_mode - per channel initialisation data:
> > + * @adap_id: bus number for the adapter. 0 =3D don't care
> > + * @deselect_on_exit: set this entry to 1, if your H/W needs deselecti=
on
> > + *		      of this channel after transaction.
> > + */
> > +struct mlxcpld_mux_platform_mode {
> > +	int adap_id;
> > +	unsigned int deselect_on_exit;
> > +};
>=20
> deselect_on_exit is not used anywhere...
>=20
> > +
> > +/* mlxcpld_mux_platform_data - per mux data, used with
> > +i2c_register_board_info
> > + * @modes - mux configuration model
> > + * @num_modes - number of adapters
> > + * @sel_reg_addr - mux select register offset in CPLD space
> > + * @first_channel - first channel to start virtual busses vector
> > + * @addr - address of mux device - set to mux select register offset o=
n LPC
> > + *	   connected CPLDs or to I2C address on I2C conncted CPLDs
> > + */
> > +struct mlxcpld_mux_platform_data {
> > +	struct mlxcpld_mux_platform_mode *modes;
>=20
> ...in fact, this entire member is not used at all, which makes the above =
struct
> mlxcpld_mux_platform_mode useless. Unless you intend to fix the above
> problem with mixing channel number with adapter number.

I'll remove mlxcpld_mux_platform_data and replace *modes with *adap_id.
When select registers is written out, the previous value is overwritten.


>=20
> > +	int num_modes;
> > +	int sel_reg_addr;
> > +	int first_channel;
> > +	unsigned short addr;
> > +};
> > +
> > +#endif /* _LINUX_I2C_MLXCPLD_H */
> >
>=20
> I'm missing an entry in MAINTAINERS. Who will fix problems?

I'll add at myself.

> I'm missing devicetree bindings. Is that not applicable?

It could be something very simple, like
cpldmux@da {
                compatible =3D "i2c-mux-mlxcpld";
                #address-cells =3D <1>;
                #size-cells =3D <0>;
               i2c@0 {
                  ...
               }
}
Do you think it worth adding?

Also most of our systems is based x86 (but also PPC).
So I'll must to add
#ifdef CONFIG_OF
static const struct of_device_id i2c_mux_mlxcpld_of_match[] =3D {
        { .compatible =3D " i2c-mux-mlxcpld ", },
        {},
};
MODULE_DEVICE_TABLE(of, i2c_mux_mlxcpld_of_match);
#endif

Do you th9ink it's OK to have such ifdef?

>=20
> Cheers,
> Peter
