From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c-piix4: Fix SB800 locking
Date: Tue, 26 Jan 2016 08:04:39 +0100
Message-ID: <1453791879.4772.2.camel@chaos.site>
References: <20160122141202.09c94802@endymion.delvare>
	 <20160126054212.GB1533@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49750 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280AbcAZHEn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Jan 2016 02:04:43 -0500
In-Reply-To: <20160126054212.GB1533@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Christian Fetzer <fetzer.ch@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Le Tuesday 26 January 2016 =C3=A0 06:42 +0100, Wolfram Sang a =C3=A9cri=
t :
> On Fri, Jan 22, 2016 at 02:12:02PM +0100, Jean Delvare wrote:
> > We need a single mutex for all 4 shared SMBus ports on the SB800. A
> > per-port mutex doesn't protect us from concurrent access.
> >=20
> > In theory the mutex should be per PCI device, however in practice w=
e
> > know that there's only ever a single instance of the device in a gi=
ven
> > system so we can use a global.
> >=20
> > Also take the mutex during initialization, as first port may be alr=
eady
> > in use when second port is initialized.
> >=20
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: Christian Fetzer <fetzer.ch@gmail.com>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
>=20
> Fixed a sparse warning by making the mutex static, took the freedom t=
o
> read Christian's mail as Tested-by and applied to for-current, thanks=
!

Oh, I thought I had fixed that before submitting but clearly I forgot.
Thanks for doing it :)

I'll send a patch restoring I2C bus names for older devices later today=
=2E
I have a few other fixups in mind but the rest isn't as urgent.

--=20
Jean Delvare
SUSE L3 Support
