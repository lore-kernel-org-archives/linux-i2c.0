From: Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [patch v5] i2c: mux: mellanox: add driver
Date: Thu, 3 Nov 2016 05:20:25 +0000
Message-ID: <AM5PR0501MB2097C2A4BA889C44549A0E9FA2A30@AM5PR0501MB2097.eurprd05.prod.outlook.com>
References: <1473799071-12830-1-git-send-email-vadimp@mellanox.com>
 <c530714e-b61e-8a38-a054-9d335f0e8a71@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0058.outbound.protection.outlook.com ([104.47.2.58]:6901
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752677AbcKCGxW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 3 Nov 2016 02:53:22 -0400
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, Michael Shych <michaelsh@mellanox.com>

Hi,

I see that this patch has not been picked-up yet for i2c-next.
Is it possible it was missed from some reason?

Thanks,
Vadim.

> -----Original Message-----
> From: Vadim Pasternak
> Sent: Friday, September 23, 2016 2:57 PM
> To: 'Peter Rosin' <peda@axentia.se>; wsa@the-dreams.de
> Cc: linux-i2c@vger.kernel.org; linux-kernel@vger.kernel.org; jiri@resnull=
i.us;
> Michael Shych <michaelsh@mellanox.com>
> Subject: RE: [patch v5] i2c: mux: mellanox: add driver
>=20
>=20
>=20
> > -----Original Message-----
> > From: Peter Rosin [mailto:peda@axentia.se]
> > Sent: Friday, September 23, 2016 12:36 PM
> > To: Vadim Pasternak <vadimp@mellanox.com>; wsa@the-dreams.de
> > Cc: linux-i2c@vger.kernel.org; linux-kernel@vger.kernel.org;
> > jiri@resnulli.us; Michael Shych <michaelsh@mellanox.com>
> > Subject: Re: [patch v5] i2c: mux: mellanox: add driver
> >
> > On 2016-09-13 22:37, vadimp@mellanox.com wrote:
> > > From: Vadim Pasternak <vadimp@mellanox.com>
> > >
> > > This driver allows I2C routing controlled through CPLD select
> > > registers on a wide range of Mellanox systems (CPLD Lattice device).
> > > MUX selection is provided by digital and analog HW. Analog part is
> > > not under SW control.
> > > Digital part is under CPLD control (channel selection/de-selection).
> > >
> > > Connectivity schema.
> > > i2c-mlxcpld                                 Digital               Ana=
log
> > > driver
> > > *--------*                                 * -> mux1 (virt bus2) -> m=
ux ->|
> > > | I2CLPC | i2c physical                    * -> mux2 (virt bus3) -> m=
ux ->|
> > > | bridge | bus 1                 *---------*                         =
     |
> > > | logic  |---------------------> * mux reg *                         =
     |
> > > | in CPLD|                       *---------*                         =
     |
> > > *--------*   i2c-mux-mlxpcld          ^    * -> muxn (virt busn) -> m=
ux ->|
> > >     |        driver                   |                              =
     |
> > >     |        *---------------*        |                             D=
evices
> > >     |        * CPLD (i2c bus)* select |
> > >     |        * registers for *--------*
> > >     |        * mux selection * deselect
> > >     |        *---------------*
> > >     |                 |
> > > <-------->     <----------->
> > > i2c cntrl      Board cntrl reg
> > > reg space      space (mux select,
> > >                IO, LED, WD, info)
> >
> > Hmm, I'm wondering about the above schematics, which seems a bit
> > overly complex. I mean, it's not relevant to this driver how the
> > I2CLPC bridge logic in the CPLD is controlled. Particularly so since
> > it does not need to be a this particular i2c adapter that is muxed.
> >
> > But what I'm really wondering is if this mux can mux same other bus
> > than is used to control the mux. I.e. is it possible to do something li=
ke this:
> >
> >   .---.          .-------------.
> >   |   |          |             |-- i2c2 --
> >   | l |-- i2c0 --| mlxcpld mux |
> >   | i |          |             |-- i2c3 --
> >   | n |          '-------------'
> >   | u |                 |
> >   | x |-- i2c1 ---------'
> >   |   |
> >   '---'
> >
> > Or is it always as below, with the mux being controlled from the same
> > i2c bus it muxes?
> >
> >   .---.             .-------------.
> >   | l |             |             |-- i2c1 --
> >   | i |-- i2c0 --+--| mlxcpld mux |
> >   | n |          |  |             |-- i2c2 --
> >   | u |          |  '-------------'
> >   | x |          |         |
> >   '---'          '---------'
> >
>=20
> Hi Peter,
>=20
> Thank you very much for this and all previous feedbacks.
>=20
> Yes, it is not coupled with I2CLPC bridge logic.
> When I sent my initial patch, it was marked as 1/2, while 1/1 was patch f=
or i2c-
> mlxcpld controller.
> So, maybe my comment here is redundant I can make it simpler.
>=20
> Actual description you provided is better.
>=20
> Would you like me to submit patch with this modification only?
>=20
>=20
> Just as an example to show how we are going to use this driver.
>=20
> This is x86 systems, when we do have LPCI2C as controller (we have on the=
se
> systems management CPLD attached to LPC on carrier board and I2C attached
> CLPD on switch board:
> .---.             .-------------.
> | l |             |             |-- i2cx1 -- i2cy8
> | i |-- i2c1 --+--| mlxcpld mux |
> | n |          |  |             |-- i2y1 -- i2cy8
> | u |          |  '-------------'
> | x |          |         |
>  '---'          '---------'
>=20
> I2C CPLD is attached to bus 1 at 0x62, and has register 0x81 - 0x85 for a=
ccess to
> 4 or 5 banks of QSFP ports (each bank of 8).
>=20
> This is coming systems equipped with BMC Aspeed 2520 SoC ARM11 based (by
> the way this driver now also in review process):
> .---.             .-------------.
> | l |             |             |-- i2cx1 -- i2cy8
> | i |-- i2cn --+--| mlxcpld mux |
> | n |          |  |             |-- i2y1 -- i2cy8
> | u |          |  '-------------'
> | x |          |         |
>  '---'          '---------
>=20
> I2C CPLD is attached to bus n (SoC equipped with 14 I2C busses) at 0x62, =
and has
> register 0xz1 - 0xz1 for access to 4 or 5 banks of QSFP ports (each bank =
of 8).
>=20
> Cheers,
> Vadim.
>=20
> > Cheers,
> > Peter
