From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: Re: [PATCHv2] i2c-mpc: Correct I2C reset procedure
Date: Sun, 18 Jun 2017 16:27:32 +0000
Message-ID: <1497803249.4241.104.camel@infinera.com>
References: <20170511122033.22471-1-joakim.tjernlund@infinera.com>
         <1494947612.7509.24.camel@infinera.com>
         <1495547252.17446.60.camel@infinera.com> <20170529210419.GA2527@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn3nam01on0051.outbound.protection.outlook.com ([104.47.33.51]:27728
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752992AbdFRQ1i (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 18 Jun 2017 12:27:38 -0400
In-Reply-To: <20170529210419.GA2527@katana>
Content-Language: en-US
Content-ID: <2795F7FB1C0AC443B832BD082C94A15C@infinera.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "oss@buserror.net" <oss@buserror.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Mon, 2017-05-29 at 23:04 +0200, Wolfram Sang wrote:
> On Tue, May 23, 2017 at 01:47:34PM +0000, Joakim Tjernlund wrote:
> > On Tue, 2017-05-16 at 17:13 +0200, Joakim Tjernlund wrote:
> > > On Thu, 2017-05-11 at 14:20 +0200, Joakim Tjernlund wrote:
> > > > Current I2C reset procedure is broken in two ways:
> > > > 1) It only generate 1 START instead of 9 STARTs and STOP.
> > > > 2) It leaves the bus Busy so every I2C xfer after the first
> > > >    fixup calls the reset routine again, for every xfer there after.
> > > >=20
> > > > This fixes both errors.
> > >=20
> > > Ping?
> >=20
> > Ping again, pretty please?
>=20
> I am interested in this patch. Especially why you think the generic
> recovery structure is not suitable and if we maybe need to update that,
> too. But I need time to think into it and that may still need 1-2 weeks.
> I am aiming for 4.12 nonetheless.
>=20

I don't see this anywhere ...
