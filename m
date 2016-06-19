From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/3] i2c: designware-pci: refactor and add Merrifield
 support
Date: Sun, 19 Jun 2016 21:08:11 +0300
Message-ID: <1466359691.30123.171.camel@linux.intel.com>
References: <1466003107-19375-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20160619174239.GH2933@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:10833 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269AbcFSSJj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 19 Jun 2016 14:09:39 -0400
In-Reply-To: <20160619174239.GH2933@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org

On Sun, 2016-06-19 at 19:42 +0200, Wolfram Sang wrote:
> On Wed, Jun 15, 2016 at 06:05:04PM +0300, Andy Shevchenko wrote:
> > Tested on bare metal (Intel Edison) by enumerating I2C GPIO
> > expanders.
> >=20
> > In v2:
> > - leave bus 3 at STD speed for Medfield
> > - be consistent with workflow, i.e. call ->setup, and _then_ assign
> > to i2c
> > =C2=A0 properties
> > - add a comment to explain magic numbers for Merrifield
> > - add an Ack for patch 3
> >=20
> > Andy Shevchenko (3):
> > =C2=A0 i2c: designware-pci: Make bus number allocation robust
> > =C2=A0 i2c: designware-pci: Introduce Merrifield support
> > =C2=A0 i2c: designware-pci: Sort header block alphabetically
> >=20
> > =C2=A0drivers/i2c/busses/i2c-designware-core.h=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A0=C2=A01 +
> > =C2=A0drivers/i2c/busses/i2c-designware-pcidrv.c | 143 ++++++++++++=
+++++-
> > -----------
> > =C2=A02 files changed, 86 insertions(+), 58 deletions(-)
>=20
> Applied to for-next, thanks!

Thanks.

Wolfram, just noticed that comment message in the second patch is not
fully clear. I would update it as follows

--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -125,10 +125,10 @@ static int mfld_setup(struct pci_dev *pdev, struc=
t
dw_pci_controller *c)
=C2=A0static int mrfld_setup(struct pci_dev *pdev, struct dw_pci_contro=
ller
*c)
=C2=A0{
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* On Intel Merrifield =
the i2c busses are enumerated [1..7]. So,
we add
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* 1 to shift the defau=
lt range. Besides that the first PCI slot
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* provides 4 functions=
, that's why we have to add 0 to the head
slot
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* and 4 to the tail on=
e.
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* On Intel Merrifield =
the user visible i2c busses are
enumerated
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* [1..7]. So, we add 1=
 to shift the default range. Besides that
the
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* first PCI slot provi=
des 4 functions, that's why we have to
add 0 to
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* the fisrt slot and 4=
 to the next one.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch (PCI_SLOT(pdev->=
devfn)) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case 8:

Should I send a new patch or you can fold it?

--=20

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
