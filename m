From: Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [PATCH v4 0/1] Add support for IPMB driver
Date: Tue, 30 Apr 2019 21:24:29 +0000
Message-ID: <AM6PR05MB5224FCACBD4EF55F3890EC6AA23A0@AM6PR05MB5224.eurprd05.prod.outlook.com>
References: <cover.1556645340.git.Asmaa@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1556645340.git.Asmaa@mellanox.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "minyard@acm.org" <minyard@acm.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, Michael Shych <michaelsh@mellanox.com>
Cc: Asmaa Mnebhi <Asmaa@mellanox.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org



> -----Original Message-----
> From: Asmaa Mnebhi <Asmaa@mellanox.com>
> Sent: Tuesday, April 30, 2019 8:59 PM
> To: minyard@acm.org; wsa@the-dreams.de; Vadim Pasternak
> <vadimp@mellanox.com>; Michael Shych <michaelsh@mellanox.com>
> Cc: Asmaa Mnebhi <Asmaa@mellanox.com>; linux-kernel@vger.kernel.org;
> linux-i2c@vger.kernel.org
> Subject: [PATCH v4 0/1] Add support for IPMB driver
>=20
> Thank you for your feedback Vadim. I have addressed your comments.

Hi Asmaa,

Thank you for your comments and added doc.

>=20
> 1) You are correct. This driver is not specific to Mellanox so I have rem=
oved the
> Mellanox attribute.
>=20
> 2) I have added a documentation file called IPMB.txt which explains how t=
his
> module works and how it should be instantiated. It is very similar to the=
 existing
> linux i2c-slave-eeprom module.
>=20
> The HW for my testing works as follows:
> A BMC is connected to a Satellite MC via I2C (I2C is equivalent to IPMB).=
 The
> BMC initiates the IPMB requests and sends them via I2C.
> Obviously the BMC needs its own driver to do this which I haven't include=
d in this
> code. We have no intent of upstreaming that at the moment.

I believe you are going to do it at some point, right?

> This ipmb-dev-int driver is to be loaded and instantiated on the Satellit=
e MC to
> be able to receive IPMB requests. These IPMB request messages will be pic=
ked
> up by a user space program such (in my case it is OpenIPMI) to handle the
> request and generate a response.
> The response will be then passed from the user program back to kernel spa=
ce.
> Then this driver would send that response back to the BMC.
>=20
> 3) You asked the following:
>=20
> "Is it expected to be zero in vaid case?"
> The 8 least significant bits of the sum is always expected to be 0 in the=
 case
> where the checksum is valid. I have added a comment for clarifications.


>=20
> "why do you need this cast?"
> buf[++ipmb_dev_p->msg_idx]=3D(u8)(client->addr<<1)
> This is because client->addr is of type unsigned short which is
> 2 bytes so it is safer to typecast it to u8 (u8* buf)

Better, if you can avoid cast.
Would compiler warn if you use for example
rol16(client->addr, 1) & GENMASK(7, 0);
or something like it?


>=20
> "It could be only single ipmb-dev within the system? Couldn't it be few, =
like
> master/slave for example?"
> My understanding of your question is that: what if we have multiple insta=
nces of
> ipmb-dev-int, that we register it under different addresses?
> This driver only works as a slave so it will only be instantiated once on=
 the
> Satellite MC under one slave address.

I mentioned some config like:
BMC1 (master)  -- busA --|
			Satellite
BMC2 (standby)	-- busB --|=20

Since this is not Mellanox specific driver, maybe it would be good to suppo=
rt
multiple instances of it.

>=20
> Asmaa Mnebhi (1):
>   Add support for IPMB driver
>=20
>  Documentation/IPMB.txt           |  53 ++++++
>  drivers/char/ipmi/Kconfig        |   8 +
>  drivers/char/ipmi/Makefile       |   1 +
>  drivers/char/ipmi/ipmb_dev_int.c | 381
> +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 443 insertions(+)
>  create mode 100644 Documentation/IPMB.txt  create mode 100644
> drivers/char/ipmi/ipmb_dev_int.c
>=20
> --
> 2.1.2
