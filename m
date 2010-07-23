From: Kenneth Heitke <kheitke@codeaurora.org>
Subject: Re: [PATCH] i2c: Single-wire Serial Bus Interface for Qualcomm MSM
 chipsets
Date: Fri, 23 Jul 2010 14:50:14 -0600
Message-ID: <4C4A0086.3040009@codeaurora.org>
References: <1279734768-8436-1-git-send-email-kheitke@codeaurora.org> <4C496C58.1080806@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C496C58.1080806@emlix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
Cc: khali@linux-fr.org, ben-linux@fluff.org, linux-arm-msm@vger.kernel.org, sdharia@codeaurora.org, Crane Cai <crane.cai@amd.com>, Samuel Ortiz <sameo@linux.intel.com>, Linus Walleij <linus.walleij@stericsson.com>, Ralf Baechle <ralf@linux-mips.org>, srinidhi kasagar <srinidhi.kasagar@stericsson.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Daniel Gl=F6ckner wrote:
> On 07/21/2010 07:52 PM, Kenneth Heitke wrote:
>> Unlike I2C, SSBI is a point-to-point connection, and therefore there=
 is no
>> need to specify a slave device address. The SSBI implementation
>> overrides the slave device address to be a device register address
>> instead.  This restricts the client drivers from using the SMBus
>> communication APIs unless they update the address field (addr) of th=
e
>> i2c_client structure prior to every SMBus function call.
>=20
> Is it just me who is uncomfortable with this?
>=20
> If I am not mistaken, you still have to update the i2c_client structu=
re
> when using the SMBus API.

Yes, you are correct if the SMBus API is being used.

Each SSBI transaction consists of an address and a data word.  I need t=
o=20
get the address information somehow and I didn't want to have to fetch=20
this information from the data buffer passed in for the clients.

>=20
> And how do you intend to bind a driver to an SSBI device if there is =
not a
> single address to bind to?

There is only one device per controller therefore the binding is done=20
using the bus number.  If I have 3 devices, then I have 3 independent b=
uses.

>=20
> The Qualcomm SSBI patent mentiones the possibility of adding logic to=
 chips
> to be accessible over both SSBI and the three wire SBI interface. The=
 SBI
> interface on the other hand is even closer to I2C and requires the us=
e of
> a slave ID byte. If you didn't abuse the address field, you could wri=
te
> drivers that work on both interfaces.

The driver doesn't support the three wire SBI interface.  That interfac=
e=20
   has been replaced with the single wire interface and won't be suppor=
t=20
under Linux.

>=20
> Why not use one of the special addresses mentioned in the I2C specifi=
cation
> for SSBI? 0x02 might be appropriate.
>=20

--=20
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um.
