From: Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [v7,1/1] i2c: add master driver for mellanox systems
Date: Fri, 18 Nov 2016 02:50:32 +0000
Message-ID: <AM5PR0501MB2097AC75771FC260CFAA4474A2B00@AM5PR0501MB2097.eurprd05.prod.outlook.com>
References: <1479388708-37054-1-git-send-email-vadimp@mellanox.com>
 <20161117221522.GA10875@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0044.outbound.protection.outlook.com ([104.47.2.44]:10400
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751613AbcKRI4W (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 18 Nov 2016 03:56:22 -0500
In-Reply-To: <20161117221522.GA10875@katana>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, Michael Shych <michaelsh@mellanox.com>

Hi Wolfram,

Thank you for review.

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa-dev@sang-engineering.com]
> Sent: Friday, November 18, 2016 12:15 AM
> To: Vadim Pasternak <vadimp@mellanox.com>
> Cc: wsa@the-dreams.de; linux-i2c@vger.kernel.org; linux-
> kernel@vger.kernel.org; jiri@resnulli.us; Michael Shych
> <michaelsh@mellanox.com>
> Subject: Re: [v7,1/1] i2c: add master driver for mellanox systems
>=20
> Hi,
>=20
> thanks for the patch and the prompt reworks. Also thank you to Vladimir f=
or
> initial reviews!
>=20
> > Device supports:
> >  - Master mode
> >  - One physical bus
> >  - Polling mode
>=20
> Out of interest: is there any interrupt at all?

Yes, it's possible to configure interrupt mode in HW, but we've never used =
it.

>=20
> > diff --git a/MAINTAINERS b/MAINTAINERS index 411e3b8..26d05f8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7881,6 +7881,14 @@ W:	http://www.mellanox.com
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
>=20
> No need to change right now, but I think you could simplify all your driv=
ers in
> one entry with
>=20
> F: *mlxcpld*
>=20
> or something similar to keep MAINTAINERS compact.
>=20
> > +/**
> > + * struct  mlxcpld_i2c_curr_xfer - current transaction parameters:
> > + * @cmd: command;
> > + * @addr_width: address width;
> > + * @data_len: data length;
> > + * @cmd: command register;
> > + * @msg_num: message number;
> > + * @msg: pointer to message buffer;
> > + */
>=20
> While I value effort to describe struct members, this is so self-explaini=
ng that I
> think it could be left out.
>=20
> > +/**
> > + * struct mlxcpld_i2c_priv - private controller data:
> > + * @adap: i2c adapter;
> > + * @base_addr: base IO address;
> > + * @lock: bus access lock;
> > + * @xfer: current i2c transfer block;
> > + * @dev: device handle;
> > + */
>=20
> ditto
>=20
> > +/*
> > + * Check validity of current i2c message and all transfer.
> > + * Calculate also common length of all i2c messages in transfer.
> > + */
> > +static int mlxcpld_i2c_invalid_len(struct mlxcpld_i2c_priv *priv,
> > +				   const struct i2c_msg *msg, u8 *comm_len) {
> > +	u8 max_len =3D msg->flags =3D=3D I2C_M_RD ? MLXCPLD_I2C_DATA_REG_SZ -
> > +		     MLXCPLD_I2C_MAX_ADDR_LEN :
> MLXCPLD_I2C_DATA_REG_SZ;
> > +
> > +	if (msg->len > max_len)
> > +		return -EINVAL;
>=20
> If you populate a 'struct i2c_adapter_quirks' the core will do this check=
 for you.
>=20
> > +	*comm_len +=3D msg->len;
> > +	if (*comm_len > MLXCPLD_I2C_DATA_REG_SZ)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Check validity of received i2c messages parameters.
> > + * Returns 0 if OK, other - in case of invalid parameters
> > + * or common length of data that should be passed to CPLD  */ static
> > +int mlxcpld_i2c_check_msg_params(struct mlxcpld_i2c_priv *priv,
> > +					struct i2c_msg *msgs, int num,
> > +					u8 *comm_len)
> > +{
> > +	int i;
> > +
> > +	if (!num) {
> > +		dev_err(priv->dev, "Incorrect 0 num of messages\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (unlikely(msgs[0].addr > 0x7f)) {
> > +		dev_err(priv->dev, "Invalid address 0x%03x\n",
> > +			msgs[0].addr);
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i =3D 0; i < num; ++i) {
> > +		if (unlikely(!msgs[i].buf)) {
> > +			dev_err(priv->dev, "Invalid buf in msg[%d]\n",
> > +				i);
> > +			return -EINVAL;
> > +		}
>=20
> I was about to write "the core will check this for you", but wow, we are =
not
> good at this... I will try to come up with some patches soon. No need for=
 you to
> changes this right now.
>=20
> ...
>=20
> > +	case MLXCPLD_LPCI2C_ACK_IND:
> > +		if (priv->xfer.cmd !=3D I2C_M_RD)
> > +			return (priv->xfer.addr_width + priv->xfer.data_len);
> > +
> > +		if (priv->xfer.msg_num =3D=3D 1)
> > +			i =3D 0;
> > +		else
> > +			i =3D 1;
> > +
> > +		if (!priv->xfer.msg[i].buf)
> > +			return -EINVAL;
> > +
> > +		/*
> > +		 * Actual read data len will be always the same as
> > +		 * requested len. 0xff (line pull-up) will be returned
> > +		 * if slave has no data to return. Thus don't read
> > +		 * MLXCPLD_LPCI2C_NUM_DAT_REG reg from CPLD.
> > +		 */
> > +		datalen =3D priv->xfer.data_len;
> > +
> > +		mlxcpld_i2c_read_comm(priv, MLXCPLD_LPCI2C_DATA_REG,
> > +				      priv->xfer.msg[i].buf, datalen);
> > +
> > +		return datalen;
> > +
> > +	case MLXCPLD_LPCI2C_NACK_IND:
> > +		return -EAGAIN;
>=20
> -EAGAIN is for arbitration lost. -ENXIO is for NACK. See
> Documentation/i2c/fault-codes.
>=20
> What kind of testing have you done with the driver?
>=20

Actually we are using these driver on a wide range of different Mellanox sy=
stems (about 10 systems, TORs and modular systems), which we have on the fi=
led about two years.
After updating it with the upstream review comments, I performed some basic=
 set of the functional testing on a couple of our systems - access to all t=
he devices (1, 2, 4 byte width), access to broken device (transaction TO), =
some kind of stress test.

> Thanks,
>=20
>    Wolfram

Thanks,

Vadim.
