From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv2] i2c-mpc: Correct I2C reset procedure
Date: Thu, 22 Jun 2017 12:00:47 +0200
Message-ID: <20170622100047.pbzxez2w55ecxy2g@ninjato>
References: <20170511122033.22471-1-joakim.tjernlund@infinera.com>
 <1494947612.7509.24.camel@infinera.com>
 <1495547252.17446.60.camel@infinera.com>
 <20170529210419.GA2527@katana>
 <1496095395.17446.111.camel@infinera.com>
 <20170621213647.GA2419@katana>
 <20170621215924.GB2419@katana>
 <1498120824.14148.27.camel@infinera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="23mjvsvbhxtmzure"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:36681 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752563AbdFVKAz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Jun 2017 06:00:55 -0400
Content-Disposition: inline
In-Reply-To: <1498120824.14148.27.camel@infinera.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "oss@buserror.net" <oss@buserror.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--23mjvsvbhxtmzure
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2017 at 08:40:25AM +0000, Joakim Tjernlund wrote:
> On Wed, 2017-06-21 at 23:59 +0200, Wolfram Sang wrote:
> > > Toggling 9x even means you could then write something somewhere
> > > which in case of a PMIC can be really dangerous.
> >=20
> > I am partly wrong here because you send a START beforehand. And devices
> > are required to reset their state machine when they detect a START (I2C
> > Specs 3.1.10, Note 4). So, it *shouldn't* be dangerous. If all devices
> > follow that rule, that is...
> >=20
> > However, you can only send START when SDA is not stuck. And still, this
> > whole toggling is to reanimate a stuck SDA. So, it still looks to me
> > that it doesn't make sense to have START & STOP around the toggling and
> > rather have a single STOP before you try toggling.
> >=20
> > Makes sense?
>=20

> STOP must be last so the bus is released, this was one of the problems
> the patch fixed as next transfer would find the bus busy and the went
> into fixup again.

Yes, agreed. STOP must be last.

> In general you cannot known if the slave stuck in somewhere in
> READ/WRITE or some other state. Stuck is probably the wrong word here,
> not in sync is a better description.

I think those are two different issues. The bus can be stuck, namely
when SCL or SDA is stuck low. We can't do anything about SCL other than
HW reset, but for SDA we can try the toggling. For the device not in
sync, I wonder how you detect this on bus driver level? If SCL and SDA
are high, the device may still be out-of-sync but the bus will look free
to the master. Or?

> If you are afraid the slave won't see the the STARTs why would it see
> any STOPs?

Sure, it won't. I can't recall I was afraid of that. Maybe I was not
clear what procedure I was proposing:

1) bus is in unkown condition -> send STOP
	a) good case: bus free, all devices wait for START again
	b) bad case: SDA stuck low, you can't send STOP

2) SDA is stuck low -> toggle SCL up to 9 times
	a) good case: SDA is released again, send STOP
	b) bad case: no SDA release, HW reset needed

> Why would a STOP do anything here? The device is not listening until
> you get to end of the byte where it will listen to NACK, STOP or
> START.=20

And this is a key question, I think: A device should listen to STOP or
START always (Specs 3.1.10 Note 4). Do you really have a device that
doesn't follow this?

Don't get me wrong: I know that there always can be devices out there
which do not follow the spec. I'd really love to know if you have one.
I'd even like to buy one for testing.

But it might be an option to consider this device simply broken. If the
solution for this device might mean that other devices get a write to a
random location, then there is simply more risk than gain.

> The best way to get the slaves attention is the send the 9 clocks with
> a START, if possible, in each clock. That will get the slaves
> attention and place the slave in START state, then you finish with a
> STOP so all devices, including any masters,=C2=A0 sees that the bus is
> free.

Even if I consider there are devices which do not react to START/STOP in
the middle of a byte and need it to be fully transferred, I still can't
see what a START gains you here. Because it won't react as we just said.
After an additional cycle (up to 9 of them), it might react to a STOP
then. That I see. And I think I agree of sending a STOP after each of
these up to 9 cycles. But I wonder about the start. Note also, that
START + STOP (void message) is considered illegal in the standard (Specs
3.1.10 Note 5), although most devices will likely handle it.

That's how it looks to me currently. Did I miss something?

Regards,

   Wolfram


--23mjvsvbhxtmzure
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllLlUsACgkQFA3kzBSg
KbYAuRAAprQJoxMQRqnHqfJbQlENA05R1dSoktHkeFMM3y8tLitZgJLKLRugrKm8
kU840vIbAVTFm7NgMHNBSkT+lt9BgIggWVtFvqfiYB+xwN9kZdbaYwuauStOhQbm
rt8wauR86ttHIZtwS2oUJZ7tSq8AQ9a3OeGS5sikEOFmFQvO70HiJ9V0/6yKMwiK
7eZWtHah3P62bn5VsUj8l493uvXw4/THDcXRHgFtXC2wkKIue7n1aHEAD2rpdS8P
D4kUXPk215f4hVll2zDQzrttbXCqMT+cy+j2r9H96SqVoR2Qo2x/6JpwHCkBGWB9
uPQlzzc7NWHu1Rvy7VdwNc+0q+5MoKYaIXAtF8gfkcQL53rdaD+ClgH0pZaZ1Mj3
6BohO9JQ63rYPKtV2JdtyUk433Qgj4/iWTvMSOfA9wLK5bmKPZdTrYl5UyVzLg7E
bRbmHBbMeYJJf0aTRLIs9B/dA28kWR7nVEFpvuyHkyrs5whVMs43vFLWO6isCdgv
KtMPkVrwZ6EiTkJq52Tl86yc8Q5HiR7bQ6IGnFklcGjqSD0cYhnSE0otWAdprnMW
kiRFSn51YpvHZgvSm4POw6yKKMg81db4xibE/6tuhgNpbWjCN7BHGFCZmJ70Wndh
tL8VFayUC6A3zFQf1Y9jp+4E1T/He2YOQBXQuCx12A5GAMwDFZA=
=3NbY
-----END PGP SIGNATURE-----

--23mjvsvbhxtmzure--
