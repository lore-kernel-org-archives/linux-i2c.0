From: Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [patch v5] i2c: mux: mellanox: add driver
Date: Wed, 14 Sep 2016 08:10:21 +0000
Message-ID: <AM5PR0501MB209778ABF3397CD457AA1A69A2F10@AM5PR0501MB2097.eurprd05.prod.outlook.com>
References: <1473799071-12830-1-git-send-email-vadimp@mellanox.com>
 <eb927385-4598-2fd0-8200-7d6c4945569f@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <eb927385-4598-2fd0-8200-7d6c4945569f@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, Michael Shych <michaelsh@mellanox.com>
List-Id: linux-i2c@vger.kernel.org



> -----Original Message-----
> From: Peter Rosin [mailto:peda@axentia.se]
> Sent: Wednesday, September 14, 2016 10:50 AM
> To: Vadim Pasternak <vadimp@mellanox.com>; wsa@the-dreams.de
> Cc: linux-i2c@vger.kernel.org; linux-kernel@vger.kernel.org; jiri@resnull=
i.us;
> Michael Shych <michaelsh@mellanox.com>
> Subject: Re: [patch v5] i2c: mux: mellanox: add driver
>=20
> On 2016-09-13 22:37, vadimp@mellanox.com wrote:
> > From: Vadim Pasternak <vadimp@mellanox.com>
> >
> > This driver allows I2C routing controlled through CPLD select
> > registers on a wide range of Mellanox systems (CPLD Lattice device).
> > MUX selection is provided by digital and analog HW. Analog part is not
> > under SW control.
> > Digital part is under CPLD control (channel selection/de-selection).
>=20
> *snip*
>=20
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
>=20
> Hmm, you never confirmed that you need to support different register valu=
es in
> the CPLD with sel_reg_addr. I can see that there is a possibility that yo=
u actually
> really need it, but I'd like to remove that variable if at all possible.

Yes, it could be different register values.
Actually CPLD can also be programmed in different way.
So, I really need it.

>=20
> If you can confirm that you need that, this is
>=20
> Acked-by: Peter Rosin <peda@axentia.se>
>=20
> Otherwise, please just hard code the register address.
>=20
> Cheers,
> Peter
