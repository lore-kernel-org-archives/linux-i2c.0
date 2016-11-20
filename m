From: Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [patch v8 1/1] i2c: add master driver for mellanox systems
Date: Sun, 20 Nov 2016 09:15:00 +0000
Message-ID: <AM5PR0501MB209728FE8D00FA56657A2233A2B20@AM5PR0501MB2097.eurprd05.prod.outlook.com>
References: <1479455458-157627-1-git-send-email-vadimp@mellanox.com>
 <20161119210444.GB2856@katana>
 <AM5PR0501MB2097315FB75BFEF681512187A2B20@AM5PR0501MB2097.eurprd05.prod.outlook.com>
 <20161120090212.GA1554@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161120090212.GA1554@katana>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, Michael Shych <michaelsh@mellanox.com>
List-Id: linux-i2c@vger.kernel.org



> -----Original Message-----
> From: Wolfram Sang [mailto:wsa-dev@sang-engineering.com]
> Sent: Sunday, November 20, 2016 11:02 AM
> To: Vadim Pasternak <vadimp@mellanox.com>
> Cc: wsa@the-dreams.de; linux-i2c@vger.kernel.org; linux-
> kernel@vger.kernel.org; jiri@resnulli.us; Michael Shych
> <michaelsh@mellanox.com>
> Subject: Re: [patch v8 1/1] i2c: add master driver for mellanox systems
>=20
>=20
> > Possibly I should add validation for "num" parameter at the beginning o=
f
> mlxcpld_i2c_xfer?
>=20
> There is 'max_num_msgs' in the quirk structure.

Yes, I see it.
So I should just set max_num_msgs to 1, right?

Thanks you,

Vadim.
/
>=20
> Thanks,
>=20
>    Wolfram
