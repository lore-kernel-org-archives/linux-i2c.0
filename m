From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: Help Regarding I2C Driver...
Date: Mon, 23 Mar 2009 09:40:34 +0100
Message-ID: <20090323084034.GB28502@buzzloop.caiaq.de>
References: <000001c9ab6f$4ee35290$eca9f7b0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000001c9ab6f$4ee35290$eca9f7b0$@com>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uma Kanta Patro <upatro-cl0A3XQdnGcanlnWow0HJg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 23, 2009 at 09:54:50AM +0530, Uma Kanta Patro wrote:
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This is Uma Kanta, seek=
ing some help regarding the I2C
> driver development on ARM Linux 2.6.19 platform.

This version is ancient, you should consider updating to something more
recent.

> I referred the second part of i2C driver articles in Linux Journal by=
 Greg
> Kroah. As well as the book Essential Linux Device Drivers.
> I have to make I2C driver for a RTC (DS1340) and a camera module (Omn=
ivision
> OVM7670).
> I could be able to make a chip driver. Unfortunately I was unable to =
insert
> the core driver =93i2c_core=94 internally. So I inserted the i2c_core=
=2Eko and my
> own driver i2c_test.ko.
> Now both drivers are getting inserted fine but the problem exists is:
> In my init I am adding my i2c driver structure by using =93i2c_add_dr=
iver()=94,
> and my i2c driver structure named =93i2c_test_driver=94, whose declar=
ation is as
> follows:
>=20
> struct i2c_driver i2c_test_driver =3D {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .driver =3D {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =3D "i2c_test",
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .id =3D I2C_DRIVERID_OV=
CAMCHIP,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* OmniVision CMOS
> image sens.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *//* defined in include/=
linux/i2c-id.h */
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .attach_adapter=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D i2c_test_attach_adapter,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .detach_client=A0=A0 =3D=
 i2c_test_detach_client,
> };

attach_adapter and friends are legacy callbacks, you should not use the=
m
in new drivers. Did you read Documentation/i2c/writing-clients?

> So here =93list_for_each(item,&adapters)=94 returns FALSE for me. So =
my attach
> adapter function, =93i2c_test_attach_adapter()=94 is not getting call=
ed.

Probing should be done by setting i2c_board_info from your board suppor=
t
code - also described in Documentation/i2c/writing-clients.

> So I searched where the entry =93adapters=94 is getting a tail added =
in the
> function =93i2c_add_adapter()=94 So the function =93i2c_add_adapter (=
)=94 will be
> called by any client driver(as mentioned in comment=85).
> I tried by all =93*.ko=94 files in KERN_SRC/drivers/i2c/algos/ but no=
 effect.
> So now to get the full functional I2C chip driver do I need to write =
a
> client driver for it?

You're digging too much through the core code. It works well for others=
,
so debugging this part is not the first thing you should consider. Best
thing is probably to grab an existing driver and see how it does the
job.

Daniel
