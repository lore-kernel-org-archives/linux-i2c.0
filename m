From: Przemyslaw Sroka <psroka@cadence.com>
Subject: RE: [PATCH v2 2/7] i3c: Add core I3C infrastructure
Date: Tue, 27 Feb 2018 20:24:43 +0000
Message-ID: <MWHPR07MB278357B74A7D7E31EB109DC5CAC00@MWHPR07MB2783.namprd07.prod.outlook.com>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
        <20171214151610.19153-3-boris.brezillon@free-electrons.com>
        <b39f9016-b2ff-6d8d-96b3-945f32ab2b67@synopsys.com>
        <20180223213000.407461d2@bbrezillon>
        <1b8fe82f-079b-6f55-0e59-5773027faa8e@synopsys.com>
        <20180226213607.7161bb0a@bbrezillon>
        <b9c057ad-47a0-fa35-0f30-8d465d40b6f0@synopsys.com>
        <MWHPR07MB27833F0CAD2597BFDD37CE6CCAC00@MWHPR07MB2783.namprd07.prod.outlook.com>
 <20180227211302.26f76427@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180227211302.26f76427@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Vitor Soares <Vitor.Soares@synopsys.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.m>
List-Id: linux-i2c@vger.kernel.org

Hi Boris

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Tuesday, February 27, 2018 9:13 PM
> To: Przemyslaw Sroka <psroka@cadence.com>
> Cc: Vitor Soares <Vitor.Soares@synopsys.com>; Boris Brezillon
> <boris.brezillon@free-electrons.com>; Wolfram Sang <wsa@the-
> dreams.de>; linux-i2c@vger.kernel.org; Jonathan Corbet <corbet@lwn.net>;
> linux-doc@vger.kernel.org; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Arnd Bergmann <arnd@arndb.de>;
> Arkadiusz Golec <agolec@cadence.com>; Alan Douglas
> <adouglas@cadence.com>; Bartosz Folta <bfolta@cadence.com>; Damian
> Kos <dkos@cadence.com>; Alicja Jurasik-Urbaniak <alicja@cadence.com>;
> Cyprian Wronka <cwronka@cadence.com>; Suresh Punnoose
> <sureshp@cadence.com>; Thomas Petazzoni <thomas.petazzoni@free-
> electrons.com>; Nishanth Menon <nm@ti.com>; Rob Herring
> <robh+dt@kernel.org>; Pawel Moll <pawel.moll@arm.com>; Mark Rutland
> <mark.rutland@arm.com>; Ian Campbell <ijc+devicetree@hellion.org.uk>;
> Kumar Gala <galak@codeaurora.org>; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Geert Uytterhoeven <geert@linux-m68k.org>; Linus
> Walleij <linus.walleij@linaro.org>
> Subject: Re: [PATCH v2 2/7] i3c: Add core I3C infrastructure
>=20
> EXTERNAL MAIL
>=20
>=20
> Hi Przemek,
>=20
> On Tue, 27 Feb 2018 16:43:27 +0000
> Przemyslaw Sroka <psroka@cadence.com> wrote:
>=20
> > >
> > > >> Either important is the SETDASA for declared I3C devices. So the
> > > >> DAA process should start by send an SETDASA and them ENTDAA
> CCC
> > > command.
> > > > My understanding was that SETDASA was not mandatory, and was
> only
> > > > useful when one wants to assign a specific dynamic address to a
> > > > slave that has a static address (which is again not mandatory).
> > > > I've tested it, and even devices with a static address participate
> > > > to the DAA procedure if they've not been assigned a dynamic
> > > > address yet, so I don't see the need for this SETDASA step if you
> > > > don't need to assign a particular dynamic address to the device.
> > > >
> > > > Could you tell me why you think SETDASA is required?
> > >
> > > Yes, you are right... But in my opinion it is required as it does
> > > part of DAA process.
> >
> > SETDASA is simply faster than ENTDAA, but only if there is no need to
> > collect BCR/DCR/PID of such devices. I think most applications would
> > like to have them as an status information so  after all ENTDAA can be
> > regarded as an generic approach (unless I'm mistaken).
>=20
> Actually, we could retrieve BCR/DCR/PID (and all other relevant
> information, like MAXDS) even with the SETDASA approach. We just need to
> send the according CCC commands after SETDASA.
>=20
I agree, what I meant by "SETDASA is simply faster than ENTDAA, but only if=
 there is no need to collect BCR/DCR/PID of such devices." Is that it is fa=
ster than DAA but only if not followed by GET CCC commands to gather BCR/DC=
R/PID. I think we are on the same page here.

> But that's also my understanding that ENTDAA should always work, and
> SETDASA usage is only needed if you want to reserve a dynamic address
> and assign it to a device before DAA takes place. This way you can enforc=
e
> the device priority (WRT IBIs). But honestly, that's the only use case I =
can
> think of, and to me, it sounds like an advanced feature we may want to
> support at some point, but don't need in the initial implementation.
>
Still ENTDAA seems to be sufficient for IBI prioritization but I can imagin=
e some use cases where people would like to use it for such purposes. Note =
that SETDASA is applicable only for devices with SA so it is self-explanato=
ry that it cannot be considered as utility to define priorities for all dev=
ices before ENTDAA.=20

> --
> Boris Brezillon, Bootlin (formerly Free Electrons) Embedded Linux and
> Kernel engineering https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__bootlin.com&d=3DDwICAg&c=3DaUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3G
> Z-_haXqY&r=3Db0WPdqYyu0KH4-vSatt-ViJE1riZ603zdXl3hHHp_TU&m=3DwM54-
> BGcSfHEklVRsw02O-bnyNkLTe9c0RyBP_ExzPA&s=3DpxQrogG-
> Nq4XOMU7SPZ2FZNbgnbnjdERtMm_h7ZcdCE&e=3D

Regards,
Przemek
