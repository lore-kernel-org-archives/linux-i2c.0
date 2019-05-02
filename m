From: Asmaa Mnebhi <Asmaa@mellanox.com>
Subject: RE: [PATCH v4 0/1] Add support for IPMB driver
Date: Thu, 2 May 2019 18:06:12 +0000
Message-ID: <VI1PR05MB62392EDC0FD3C960519C91ABDA340@VI1PR05MB6239.eurprd05.prod.outlook.com>
References: <cover.1556645340.git.Asmaa@mellanox.com>
 <AM6PR05MB5224FCACBD4EF55F3890EC6AA23A0@AM6PR05MB5224.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM6PR05MB5224FCACBD4EF55F3890EC6AA23A0@AM6PR05MB5224.eurprd05.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vadim Pasternak <vadimp@mellanox.com>, "minyard@acm.org" <minyard@acm.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, Michael Shych <michaelsh@mellanox.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Vadim, Hi Corey,

Please find inline comments answering your questions.

-----Original Message-----
From: Vadim Pasternak=20
Sent: Tuesday, April 30, 2019 5:24 PM
To: Asmaa Mnebhi <Asmaa@mellanox.com>; minyard@acm.org; wsa@the-dreams.de; =
Michael Shych <michaelsh@mellanox.com>
Cc: Asmaa Mnebhi <Asmaa@mellanox.com>; linux-kernel@vger.kernel.org; linux-=
i2c@vger.kernel.org
Subject: RE: [PATCH v4 0/1] Add support for IPMB driver



> -----Original Message-----
> From: Asmaa Mnebhi <Asmaa@mellanox.com>
> Sent: Tuesday, April 30, 2019 8:59 PM
> To: minyard@acm.org; wsa@the-dreams.de; Vadim Pasternak=20
> <vadimp@mellanox.com>; Michael Shych <michaelsh@mellanox.com>
> Cc: Asmaa Mnebhi <Asmaa@mellanox.com>; linux-kernel@vger.kernel.org;=20
> linux-i2c@vger.kernel.org
> Subject: [PATCH v4 0/1] Add support for IPMB driver
>=20
> Thank you for your feedback Vadim. I have addressed your comments.

Hi Asmaa,

Thank you for your comments and added doc.

>=20
> 1) You are correct. This driver is not specific to Mellanox so I have=20
> removed the Mellanox attribute.
>=20
> 2) I have added a documentation file called IPMB.txt which explains=20
> how this module works and how it should be instantiated. It is very=20
> similar to the existing linux i2c-slave-eeprom module.
>=20
> The HW for my testing works as follows:
> A BMC is connected to a Satellite MC via I2C (I2C is equivalent to=20
> IPMB). The BMC initiates the IPMB requests and sends them via I2C.
> Obviously the BMC needs its own driver to do this which I haven't=20
> included in this code. We have no intent of upstreaming that at the momen=
t.

>> I believe you are going to do it at some point, right?
@Vadim Pasternak: I would.
@Corey: The ipmb-dev-int driver is not responsible for sending requests via=
 I2C (unlike for example the ipmi_ssif driver). It is only responsible for =
receiving those requests and passing them to a user space program. Once a r=
esponse is received from user space, it will forward that response back to =
the requester So in my testing for example, the source requester is the BMC=
, so I issue ipmitool commands from the BMC itself.

The driver that I have on my BMC (which I primarily designed for testing ip=
mb-dev-int) works hand in hand with the ipmi_msghandler and ipmi_devint to =
create the /dev/ipmi0 device file to enable the use of ipmitool program on =
the BMC. Once an ipmitool command is issued on the BMC,  the request messag=
e is sent to the Satellite MC. Once the BMC driver gets the response back f=
rom the Satellite MC, it will pass it to the ipmitool program which will di=
splay the output to the user.=20

Please note that this ipmb-dev-int driver does not need ipmi_msghandler nor=
 does it need ipmi_devintf to be loaded.

> This ipmb-dev-int driver is to be loaded and instantiated on the=20
> Satellite MC to be able to receive IPMB requests. These IPMB request=20
> messages will be picked up by a user space program such (in my case it=20
> is OpenIPMI) to handle the request and generate a response.
> The response will be then passed from the user program back to kernel spa=
ce.
> Then this driver would send that response back to the BMC.
>=20
> 3) You asked the following:
>=20
> "Is it expected to be zero in vaid case?"
> The 8 least significant bits of the sum is always expected to be 0 in=20
> the case where the checksum is valid. I have added a comment for clarific=
ations.


>=20
> "why do you need this cast?"
> buf[++ipmb_dev_p->msg_idx]=3D(u8)(client->addr<<1)
> This is because client->addr is of type unsigned short which is
> 2 bytes so it is safer to typecast it to u8 (u8* buf)

>>Better, if you can avoid cast.
>>Would compiler warn if you use for example rol16(client->addr, 1) & GENMA=
SK(7, 0); or something like it?
I thought it wouldn't be too much of an issue to use typecast here since ot=
her existing ipmi drivers use typecasting: bt-bmc.c, kcs_bmc_aspeed.c, kcs_=
bmc_npcm7xx.c all use (u8) typecasting.=20
But if you really think it is worth it, I could do that.
I just think it is not as straight forward to read this code as using a sim=
ple typecast. Some might wonder why a GENMASK is needed in this case.



>=20
> "It could be only single ipmb-dev within the system? Couldn't it be=20
> few, like master/slave for example?"
> My understanding of your question is that: what if we have multiple=20
> instances of ipmb-dev-int, that we register it under different addresses?
> This driver only works as a slave so it will only be instantiated once=20
> on the Satellite MC under one slave address.

>>I mentioned some config like:
>>BMC1 (master)  -- busA --|
>>			Satellite
>>BMC2 (standby)	-- busB --|=20

>>Since this is not Mellanox specific driver, maybe it would be good to sup=
port multiple instances of it.

I see, I understand now. That sounds good.
I added support to instantiate several ipmb devices for the purpose of havi=
ng multiple BMC masters for one Satellite MC. The design consists in naming=
 each instantiated device with the IPMBus/I2C bus number associated with it=
. For example, :
BMC1 -----I2C/IPMB bus 1 ----- Satellite MC (/dev/ipmb-1)
BMC2 -----I2C/IPMB bus 2 ----- Satellite MC (/dev/ipmb-2)

I added documentation for that as well.

>
> Asmaa Mnebhi (1):
>   Add support for IPMB driver
>=20
>  Documentation/IPMB.txt           |  53 ++++++
>  drivers/char/ipmi/Kconfig        |   8 +
>  drivers/char/ipmi/Makefile       |   1 +
>  drivers/char/ipmi/ipmb_dev_int.c | 381
> +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 443 insertions(+)
>  create mode 100644 Documentation/IPMB.txt  create mode 100644=20
> drivers/char/ipmi/ipmb_dev_int.c
>=20
> --
> 2.1.2
