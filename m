From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v5 6/6] i2c: use an IRQ to report Host Notify events, not
 alert
Date: Thu, 24 Nov 2016 16:06:08 +0100
Message-ID: <20161124150608.GE4271@katana>
References: <1476360640-12901-1-git-send-email-benjamin.tissoires@redhat.com>
 <1476360640-12901-7-git-send-email-benjamin.tissoires@redhat.com>
 <20161107002034.GB1442@katana>
 <20161121105248.GH2119@mail.corp.redhat.com>
 <20161122114922.GA3993@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161122114922.GA3993@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
List-Id: linux-i2c@vger.kernel.org


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 22, 2016 at 12:49:22PM +0100, Wolfram Sang wrote:
> On Mon, Nov 21, 2016 at 11:52:48AM +0100, Benjamin Tissoires wrote:
> > Hi Wolfram,
> >=20
> > On Nov 07 2016 or thereabouts, Wolfram Sang wrote:
> > > On Thu, Oct 13, 2016 at 02:10:40PM +0200, Benjamin Tissoires wrote:
> > > > The current SMBus Host Notify implementation relies on .alert() to
> > > > relay its notifications. However, the use cases where SMBus Host
> > > > Notify is needed currently is to signal data ready on touchpads.
> > > >=20
> > > > This is closer to an IRQ than a custom API through .alert().
> > > > Given that the 2 touchpad manufacturers (Synaptics and Elan) that
> > > > use SMBus Host Notify don't put any data in the SMBus payload, the
> > > > concept actually matches one to one.
> > >=20
> > > I see the advantages. The only question I have: What if we encounter
> > > devices in the future which do put data in the payload? Can this
> > > mechanism be extended to handle that?
> >=20
> > I guess I haven't convinced you with my answer. Is there anything I can
> > do to get this series in v4.10 or do you prefer waiting for v4.11?
>=20
> I consider this v4.10 material. I was thinking a little about how to not
> lose data with consecutive interrupts but then -EBUSY came along.
> Nonetheless, it looks to me like the proper path to follow...

Applied to for-next, thanks!

Fixed the following checkpatch warning for you:

WARNING: struct irq_domain_ops should normally be const
#250: FILE: drivers/i2c/i2c-core.c:1838:
+static struct irq_domain_ops i2c_host_notify_irq_ops =3D {


--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYNwHfAAoJEBQN5MwUoCm2MWwQALPoR9M/8bCbHoa5Y/9rNWyG
SGMpl3yXmsQpbaho82jMO5cNrdjJD+57KT7xpHygz1MpLm/k2p4fDA6NgZ0KnMEX
Kr0s1CB+A8pTGd7bxu6V95jzqldCpkMS4QtGp5Y7YQyyGVFids8VVRDQ+S2TpyjJ
O3EpCrNFz2rCjCuT0HGfA5vfDI/FmySH+E2UMYbpFpg7zsyA4q59vKdL8rDadFDH
1kwTj7CysnCGFBumHN42SIYJk6XVQ/fKn+hTHLfTgGplV9jF0/bQGlRP0/+bjfzP
9Neq3xzW6UomrFBxoJVy8eBNnyfR7F9tXhST2IE3igqA8h/bjKSbu4fhLX5yKQN6
LjI6edXP6m0z+0Y+hkx3n4ro+vIIjoVSsrVKyz4syQNle3Eq0WMbgRYtvvDlAZzH
A/QwK2YxgFGRoui4KVnM6HtVTGDysDJs213kDvlmfJbJBUb/xsR9uKqdAMawZfVM
ClwdE1xwfYiMtB20kH3mV0Z9pNvpZKthkr2sezZrSWqd678YOzBJSNRkMFcy9ERF
TIczQNPZZG5ht+Ds+mKGrr4/XDGR2J1TUBRkP+uH8914iRE1nU488QgLU+GMyOKJ
Han+xaHoubbh5AE/8oY2wIa66IKs4H3omCiYAyZd2TJcxfxMSJNZFYBu3ODxsglw
V+3Oah8e46FEnE04CWN9
=B0+j
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--
