From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: Re: [PATCHv2] i2c-mpc: Correct I2C reset procedure
Date: Thu, 22 Jun 2017 08:40:25 +0000
Message-ID: <1498120824.14148.27.camel@infinera.com>
References: <20170511122033.22471-1-joakim.tjernlund@infinera.com>
         <1494947612.7509.24.camel@infinera.com>
         <1495547252.17446.60.camel@infinera.com> <20170529210419.GA2527@katana>
         <1496095395.17446.111.camel@infinera.com> <20170621213647.GA2419@katana>
         <20170621215924.GB2419@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn3nam01on0051.outbound.protection.outlook.com ([104.47.33.51]:47123
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752650AbdFVIkb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Jun 2017 04:40:31 -0400
In-Reply-To: <20170621215924.GB2419@katana>
Content-Language: en-US
Content-ID: <23E5ACA0108D9646B498DCDA46B34A38@infinera.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "oss@buserror.net" <oss@buserror.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Wed, 2017-06-21 at 23:59 +0200, Wolfram Sang wrote:
> > Toggling 9x even means you could then write something somewhere
> > which in case of a PMIC can be really dangerous.
>=20
> I am partly wrong here because you send a START beforehand. And devices
> are required to reset their state machine when they detect a START (I2C
> Specs 3.1.10, Note 4). So, it *shouldn't* be dangerous. If all devices
> follow that rule, that is...
>=20
> However, you can only send START when SDA is not stuck. And still, this
> whole toggling is to reanimate a stuck SDA. So, it still looks to me
> that it doesn't make sense to have START & STOP around the toggling and
> rather have a single STOP before you try toggling.
>=20
> Makes sense?

STOP must be last so the bus is released, this was one of the problems the =
patch fixed as
next transfer would find the bus busy and the went into fixup again.

In general you cannot known if the slave stuck in somewhere in READ/WRITE o=
r
some other state. Stuck is probably the wrong word here, not in sync is a b=
etter description.

If you are afraid the slave won't see the the STARTs why would it see any S=
TOPs?
Take this case:
> So, for the write case, I'd think a single STOP before toggling should
> do. Toggling 9x even means you could then write something somewhere
> which in case of a PMIC can be really dangerous.
Why would a STOP do anything here? The device is not listening until you ge=
t to
end of the byte where it will listen to NACK, STOP or START.=20

The best way to get the slaves attention is the send the 9 clocks with a ST=
ART,
if possible, in each clock. That will get the slaves attention and place th=
e slave
in START state, then you finish with a STOP so all devices, including any m=
asters,=A0
sees that the bus is free.

   Jocke=
