From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 3/3] i2c-piix4: Pre-shift the port number
Date: Fri, 29 Jan 2016 12:09:05 +0100
Message-ID: <1454065745.4904.1.camel@chaos.site>
References: <20160129104146.50f06562@endymion.delvare>
	 <20160129104637.582b95ea@endymion.delvare>
	 <20160129110228.GL1778@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43295 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbcA2LJQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 29 Jan 2016 06:09:16 -0500
In-Reply-To: <20160129110228.GL1778@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Christian Fetzer <fetzer.ch@gmail.com>, Wolfram Sang <wsa@the-dreams.de>

Le Friday 29 January 2016 =C3=A0 13:02 +0200, Mika Westerberg a =C3=A9c=
rit :
> On Fri, Jan 29, 2016 at 10:46:37AM +0100, Jean Delvare wrote:
> > Shift the port number at initialization time, so that it is ready t=
o
> > use at run time. That way we don't have to do it again for every SM=
Bus
> > transaction.
> >=20
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Christian Fetzer <fetzer.ch@gmail.com>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > ---
> >  drivers/i2c/busses/i2c-piix4.c |   10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > --- linux-4.5-rc0.orig/drivers/i2c/busses/i2c-piix4.c	2016-01-29 07=
:57:13.706365999 +0100
> > +++ linux-4.5-rc0/drivers/i2c/busses/i2c-piix4.c	2016-01-29 10:38:3=
4.720453729 +0100
> > @@ -158,7 +158,7 @@ struct i2c_piix4_adapdata {
> > =20
> >  	/* SB800 */
> >  	bool sb800_main;
> > -	u8 port;
> > +	u8 port;		/* Port number, shifted */
> >  };
> > =20
> >  static int piix4_setup(struct pci_dev *PIIX4_dev,
> > @@ -589,8 +589,8 @@ static s32 piix4_access_sb800(struct i2c
> >  	smba_en_lo =3D inb_p(SB800_PIIX4_SMB_IDX + 1);
> > =20
> >  	port =3D adapdata->port;
> > -	if ((smba_en_lo & SB800_PIIX4_PORT_IDX_MASK) !=3D (port << 1))
> > -		outb_p((smba_en_lo & ~SB800_PIIX4_PORT_IDX_MASK) | (port << 1),
> > +	if ((smba_en_lo & SB800_PIIX4_PORT_IDX_MASK) !=3D port)
> > +		outb_p((smba_en_lo & ~SB800_PIIX4_PORT_IDX_MASK) | port,
> >  		       SB800_PIIX4_SMB_IDX + 1);
> > =20
> >  	retval =3D piix4_access(adap, addr, flags, read_write,
> > @@ -676,7 +676,7 @@ static int piix4_add_adapter(struct pci_
> > =20
> >  	adapdata->smba =3D smba;
> >  	adapdata->sb800_main =3D sb800_main;
> > -	adapdata->port =3D port;
> > +	adapdata->port =3D port << 1;
> > =20
> >  	/* set up the sysfs linkage to our parent device */
> >  	adap->dev.parent =3D &dev->dev;
> > @@ -812,7 +812,7 @@ static void piix4_adap_remove(struct i2c
> > =20
> >  	if (adapdata->smba) {
> >  		i2c_del_adapter(adap);
> > -		if (adapdata->port =3D=3D 0) {
> > +		if (adapdata->port =3D=3D (0 << 1)) {
>=20
> I suppose this is only for documentation purposes, right?

Yes. This change wasn't originally part of the patch, as I know it is a
no-op, but I thought it was more correct to include it.

> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>=20
> >  			release_region(adapdata->smba, SMBIOSIZE);
> >  			if (adapdata->sb800_main)
> >  				release_region(SB800_PIIX4_SMB_IDX, 2);
> >=20

Thanks for the reviews!

--=20
Jean Delvare
SUSE L3 Support
