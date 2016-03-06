From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 01/10] i2c-octeon: Cleanup i2c-octeon driver
Date: Sun, 6 Mar 2016 15:35:22 +0100
Message-ID: <20160306143522.GA5376@katana>
References: <cover.1457111728.git.jglauber@cavium.com>
 <4b342427bdf6d7dc7cf9ded9172deadd24a53650.1457111729.git.jglauber@cavium.com>
 <20160305184731.GB1394@katana>
 <20160306130038.GC4736@hardcore>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58168 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305AbcCFOfa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 6 Mar 2016 09:35:30 -0500
Content-Disposition: inline
In-Reply-To: <20160306130038.GC4736@hardcore>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Fixed. Strange that checkpatch.pl -f (use on file) does not report these
> errors though.

Huh, indeed.

> > >  struct octeon_i2c {
> > > -	wait_queue_head_t queue;
> > > -	struct i2c_adapter adap;
> > > -	int irq;
> > > -	u32 twsi_freq;
> > > -	int sys_freq;
> > > -	resource_size_t twsi_phys;
> > > -	void __iomem *twsi_base;
> > > -	resource_size_t regsize;
> > > -	struct device *dev;
> > > +	wait_queue_head_t	queue;
> > > +	struct i2c_adapter	adap;
> > > +	int			irq;
> > > +	u32			twsi_freq;
> > > +	int			sys_freq;
> > > +	void __iomem		*twsi_base;
> > > +	struct device		*dev;
> >=20
> > NAK. structs change often, and then one needs to fix the whole
> > indentation. One space is enough here.
>=20
> Not sure I understand your argument. I find this form more readable
> but I can change that to one space.

a) it spoils git history and makes harder to find out which patch
   added which member of the struct
b) patches get harder to read when the indentation of the whole
   struct changes. New members are not always put at the end.

> > I dunno understand the change of the function name. However, this should
> > be refactored to use the i2c_bus_recovery infrastructure anyhow.
>=20
> I'll leave the function name as it is. Would it be possbile to address
> the refactoring in a follow-up patch after this series is finished?

Yes, that makes sense.

> I'll split it into several patches then.

Sounds good. Thanks!


--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW3EAqAAoJEBQN5MwUoCm2eY0P/3zTz9+0nIaB3wddQx2lcQHJ
NULcJzt2ozYS8Jeg+WWrCKXufgRP4qewC4Cm+oy1/RiMN/jtQuD+IeCUHhgH2tSS
rp8F3Q3zzA3Cn4GKXTpwlhJBifPvrXUdlZdDH27JbzgAssSWEQFQS/1IF9J7YgS1
ul6NAvDMB1yllwCaFbshX0ZwjGwm/TOK5mmWuLLeTKquBed+6zeSqyfCqrTg8yVM
/AnHzJ7jZ1po4ylYYyNPcbdizEp2VhbBeOPIXZwKFwfUteAie6lvsaHmhzvlt1Gf
hstfq2WUsAEIP4ouzDJ9+34JYqlel/B4oP6vKJGaYxZfF9YnMy/RRXTcmXXXO8BS
4YVtlFMwslnV9LfTSIEdftQiJmpKomVov2a6e8dUwBlKNFgVuxVk4o/lYokIKDlz
RG2lvX4THuCuFRP+GVT0677HR0tpKDUwE3IIHo/Yz42deBgjZqfvoRx8g0/EVY0F
IJJRahEbGjK1T+mbdINb/o4G2GGOTuXfXVaG+FF4UU+5FfQAnkB4Z5D4BpczDRI+
Ekz3K9mjfi+BhAa+97R2HXL/2lZ4DeUDHHHTPnByf4Ai2pctZwBzMKGTjTJ35KTB
uhTfVVWpt5nufDAWbJg1+2hFZKHdyfEsj6EoTWTcPxSCpwPXDKboYae6BW7GAujj
r414bQHBsKslA9rq/BUQ
=GM+Y
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
