From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: Re: [PATCH] i2c-mpc: Correct I2C reset procedure
Date: Thu, 11 May 2017 11:42:16 +0000
Message-ID: <1494502934.5113.62.camel@infinera.com>
References: <20170509120351.28273-1-joakim.tjernlund@infinera.com>
         <20170511112828.nwdmd7kqx3zciyaa@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2nam01on0040.outbound.protection.outlook.com ([104.47.34.40]:40078
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754846AbdEKLmV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 11 May 2017 07:42:21 -0400
In-Reply-To: <20170511112828.nwdmd7kqx3zciyaa@ninjato>
Content-Language: en-US
Content-ID: <6E1FD7C3B8807543A21B0CF53AE43D23@infinera.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "scottwood@freescale.com" <scottwood@freescale.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Thu, 2017-05-11 at 13:28 +0200, Wolfram Sang wrote:
> On Tue, May 09, 2017 at 02:03:51PM +0200, Joakim Tjernlund wrote:
> > Current I2C reset procedure is broken in two ways:
> > 1) It only generate 1 START instead of 9 STARTs and STOP.
> > 2) It leaves the bus Busy so every I2C xfer after the first
> >    fixup calls the reset routine again, for every xfer there after.
> >=20
> > This fixes both errors. Add an iobarrier_rw() when writing the
> > I2C control register as well to make sure the register reaches the
> > controller in time.
> >=20
> > Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
>=20
> BTW can this driver be converted to make use of the bus_recovery
> infrastructure?
>=20

Maybe, I not familiar with this infrastructure. I did take a look at i2c_ge=
neric_recovery()
though and I do not agree with that impl.

The 9 clk's fixup does not cover the the case when an I2C device is stuck w=
rite.
To fix stuck in both cases(read or write) you need to generate 9 clk's with=
 a
START in each clk, then a STOP to release the bus.

 Jocke  =
