From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v5 6/6] i2c: use an IRQ to report Host Notify events, not
 alert
Date: Tue, 22 Nov 2016 12:49:22 +0100
Message-ID: <20161122114922.GA3993@katana>
References: <1476360640-12901-1-git-send-email-benjamin.tissoires@redhat.com>
 <1476360640-12901-7-git-send-email-benjamin.tissoires@redhat.com>
 <20161107002034.GB1442@katana>
 <20161121105248.GH2119@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:39114 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933116AbcKVLt0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 22 Nov 2016 06:49:26 -0500
Content-Disposition: inline
In-Reply-To: <20161121105248.GH2119@mail.corp.redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 21, 2016 at 11:52:48AM +0100, Benjamin Tissoires wrote:
> Hi Wolfram,
>=20
> On Nov 07 2016 or thereabouts, Wolfram Sang wrote:
> > On Thu, Oct 13, 2016 at 02:10:40PM +0200, Benjamin Tissoires wrote:
> > > The current SMBus Host Notify implementation relies on .alert() to
> > > relay its notifications. However, the use cases where SMBus Host
> > > Notify is needed currently is to signal data ready on touchpads.
> > >=20
> > > This is closer to an IRQ than a custom API through .alert().
> > > Given that the 2 touchpad manufacturers (Synaptics and Elan) that
> > > use SMBus Host Notify don't put any data in the SMBus payload, the
> > > concept actually matches one to one.
> >=20
> > I see the advantages. The only question I have: What if we encounter
> > devices in the future which do put data in the payload? Can this
> > mechanism be extended to handle that?
>=20
> I guess I haven't convinced you with my answer. Is there anything I can
> do to get this series in v4.10 or do you prefer waiting for v4.11?

I consider this v4.10 material. I was thinking a little about how to not
lose data with consecutive interrupts but then -EBUSY came along.
Nonetheless, it looks to me like the proper path to follow...

Thanks,

   Wolfram


--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYNDDCAAoJEBQN5MwUoCm2kesP/jYV6IgqQEnAC+IBFCzM1kHY
wWDCENNT5sFnfNPpUXZhe5L6Sm4G9EicyXZMM7Up8hLaaJJAm6GGGKdJiJDjLh8j
rvMPfny4epu5/w/rtjWhFr9S5M8F92i0hshQjWTQbkebjlA5sqJb1gdrZXdpxuab
NyzL78gxPaWkM0JhN1h0n1OTsS/MNZg2fFLmNGhZ/LgMDlHxKAkwDTsTddOr+bC0
Spo/zqSqyduFpunaxr7LxJ2mSHIt602EDc1hy2jQR1dzFnBGQEJ+WS20LbQJJ3YM
E4V6sO+3aXH2Ks1wDCuvHFojF7fmQwrDI5DKLdQ8dgkkMEdy0VFvECR4s9rYIeVh
9EncTgRNjqrwqaqwyW1on0wJ6DFEffTrOYQsuaThXV3o4xrwULUIG2JiA02ZAmGw
uAkasTnb3kCkw3Z7/PluHBtD5jKPfh6xRVyQj1uFnVHxrhFTNlYReGnTGii+ysY8
2YXGeWqHwiY7q4qh2IC70lQaEjl6CyaAL1Hzc8cQxniLV0WH2WF4pEFTijxYLuGN
XGuuD+CmcHO1gJT8f7bHZx+3fcXA7yxZJ6bFu5Ksb5it3XhL7h1x3FxsjlHZMR/T
fLhFprwtzAxDjZoqTuWLCdz7wAl4TBmjkilfXFAxioyEaOfLHMLgCaeE6TC3xVNv
Z+jHiiJ4IwtTe6D11TEU
=0I6I
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
