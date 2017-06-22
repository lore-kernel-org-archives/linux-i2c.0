From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: Re: [PATCHv2] i2c-mpc: Correct I2C reset procedure
Date: Thu, 22 Jun 2017 11:39:44 +0000
Message-ID: <1498131583.14148.33.camel@infinera.com>
References: <20170511122033.22471-1-joakim.tjernlund@infinera.com>
         <1494947612.7509.24.camel@infinera.com>
         <1495547252.17446.60.camel@infinera.com> <20170529210419.GA2527@katana>
         <1496095395.17446.111.camel@infinera.com> <20170621213647.GA2419@katana>
         <20170621215924.GB2419@katana> <1498120824.14148.27.camel@infinera.com>
         <20170622100047.pbzxez2w55ecxy2g@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sn1nam02on0068.outbound.protection.outlook.com ([104.47.36.68]:51441
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750852AbdFVLjv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Jun 2017 07:39:51 -0400
In-Reply-To: <20170622100047.pbzxez2w55ecxy2g@ninjato>
Content-Language: en-US
Content-ID: <AC488B18EAC90440AEC8E6B23566EC21@infinera.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "oss@buserror.net" <oss@buserror.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Thu, 2017-06-22 at 12:00 +0200, Wolfram Sang wrote:
> On Thu, Jun 22, 2017 at 08:40:25AM +0000, Joakim Tjernlund wrote:
> > On Wed, 2017-06-21 at 23:59 +0200, Wolfram Sang wrote:
> > > > Toggling 9x even means you could then write something somewhere
> > > > which in case of a PMIC can be really dangerous.
> > >=20
> > > I am partly wrong here because you send a START beforehand. And devic=
es
> > > are required to reset their state machine when they detect a START (I=
2C
> > > Specs 3.1.10, Note 4). So, it *shouldn't* be dangerous. If all device=
s
> > > follow that rule, that is...
> > >=20
> > > However, you can only send START when SDA is not stuck. And still, th=
is
> > > whole toggling is to reanimate a stuck SDA. So, it still looks to me
> > > that it doesn't make sense to have START & STOP around the toggling a=
nd
> > > rather have a single STOP before you try toggling.
> > >=20
> > > Makes sense?
> > STOP must be last so the bus is released, this was one of the problems
> > the patch fixed as next transfer would find the bus busy and the went
> > into fixup again.
>=20
> Yes, agreed. STOP must be last.
>=20
> > In general you cannot known if the slave stuck in somewhere in
> > READ/WRITE or some other state. Stuck is probably the wrong word here,
> > not in sync is a better description.
>=20
> I think those are two different issues. The bus can be stuck, namely
> when SCL or SDA is stuck low. We can't do anything about SCL other than
> HW reset, but for SDA we can try the toggling. For the device not in
> sync, I wonder how you detect this on bus driver level? If SCL and SDA
> are high, the device may still be out-of-sync but the bus will look free
> to the master. Or?

I don't. I can only find there is some problem and take guess ..

>=20
> > If you are afraid the slave won't see the the STARTs why would it see
> > any STOPs?
>=20
> Sure, it won't. I can't recall I was afraid of that. Maybe I was not
> clear what procedure I was proposing:
>=20
> 1) bus is in unkown condition -> send STOP
> 	a) good case: bus free, all devices wait for START again
> 	b) bad case: SDA stuck low, you can't send STOP
>=20
> 2) SDA is stuck low -> toggle SCL up to 9 times
> 	a) good case: SDA is released again, send STOP
> 	b) bad case: no SDA release, HW reset needed

As above, how will you select between these 2 cases? A bit banging
driver can but a real controller will have a hard time.

>=20
> > Why would a STOP do anything here? The device is not listening until
> > you get to end of the byte where it will listen to NACK, STOP or
> > START.=20
>=20
> And this is a key question, I think: A device should listen to STOP or
> START always (Specs 3.1.10 Note 4). Do you really have a device that
> doesn't follow this?
>=20
> Don't get me wrong: I know that there always can be devices out there
> which do not follow the spec. I'd really love to know if you have one.
> I'd even like to buy one for testing.

I don't have a device like that, we had a hw disturbance on the bus caused =
by
a i2c mux which were hard to trigger.

>=20
> But it might be an option to consider this device simply broken. If the
> solution for this device might mean that other devices get a write to a
> random location, then there is simply more risk than gain.
>=20
> > The best way to get the slaves attention is the send the 9 clocks with
> > a START, if possible, in each clock. That will get the slaves
> > attention and place the slave in START state, then you finish with a
> > STOP so all devices, including any masters,=A0 sees that the bus is
> > free.
>=20
> Even if I consider there are devices which do not react to START/STOP in
> the middle of a byte and need it to be fully transferred, I still can't
> see what a START gains you here. Because it won't react as we just said.
> After an additional cycle (up to 9 of them), it might react to a STOP
> then. That I see. And I think I agree of sending a STOP after each of
> these up to 9 cycles. But I wonder about the start. Note also, that
> START + STOP (void message) is considered illegal in the standard (Specs
> 3.1.10 Note 5), although most devices will likely handle it.
>=20
> That's how it looks to me currently. Did I miss something?

No, this is just speculation of what a device might do. Some will react to =
only
clk, some needs START and/or STOP. In the end of that day we can only do
out best and to me a device likelier to react on START than STOP when the d=
evice is
in a "odd" state. I cannot see how the STARTs can make things worse either.

The note of START+STOP is an illegal op. just a note. It does not give slav=
es a green card
to flip over on its back and no device I have seen the last 15 years has do=
ne that.

Given controller limitations, I2C subsystem should accept fixups that is 9 =
clks + STOP
with 0-9 STARTs in the clk sequence.

   Jocke
