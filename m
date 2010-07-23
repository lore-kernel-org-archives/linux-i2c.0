From: Kenneth Heitke <kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Single-wire Serial Bus Interface for Qualcomm MSM
 chipsets
Date: Fri, 23 Jul 2010 14:48:46 -0600
Message-ID: <4C4A002E.6020100@codeaurora.org>
References: <1279734768-8436-1-git-send-email-kheitke@codeaurora.org> <4C496C58.1080806@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C496C58.1080806-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-15?Q?Daniel_Gl=F6ckner?= <dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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
