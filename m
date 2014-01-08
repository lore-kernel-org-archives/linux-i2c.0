From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4 2/3] ARM: mvebu: Add quirk for i2c
Date: Wed, 8 Jan 2014 14:39:59 +0100
Message-ID: <20140108133958.GA15182@katana>
References: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com>
 <1389112504-9931-3-git-send-email-gregory.clement@free-electrons.com>
 <20140107183853.GE4227@obsidianresearch.com>
 <20140107230610.GB2592@katana>
 <52CD2529.6090206@free-electrons.com>
 <20140108112926.GB2669@katana>
 <52CD4CBE.6010902@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52CD4CBE.6010902-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >>>> However, when I first read this I thought it should be a -a0 specific
> >>>> compatible string, not a 'offload-broken' property - any idea what t=
he
> >>>> DT consensus is here? I've seen both approach in use ..
> >>>
> >>> I prefer the replacement of the compatible string. If it should really
> >>> be a seperate property, then it should be a vendor specific property.=
 It
> >>> is not generic, at all.
> >>
> >> Something like "marvell,offload-broken" would be acceptable?
> >=20
> > A tad more, yes. Still, since this is a feature/quirk of the IP core
> > revision, it should be deduced from the compatible property IMO. It
> > cannot be configured anywhere, so it doesn't change on board level.
>=20
> So you would prefer using the "marvell,mv78230-a0-i2c" comaptible string =
and
> updating it with the follwing piece of code?

This is the approach I favour, yes. Can't say much about the
implementation. Looks OK, but dunno if this is minimal...


--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSzVUuAAoJEBQN5MwUoCm2qGcQALBoGwyV1fdpkpVRNuuDeaSx
RCV9Uhl+vfiMRGJOFUDrkLQ98Qcod40M8LzS1Z+k9oWT+w4qOaKWrMlRo4f1wlMm
0HsjwNSZvpMP6dOgIxJo9mlgZhP26Z+WXQXaTZ+qT+JQrWKpAZCJVjZopHXBiJeh
yV7QQiyAcSGAhIOEoNEzsXJ+4MeOV5HTwn5GB36Ar8ND74uGP2Wo8pNIh9NFBKbr
cvdJs9DQpvfUppBJo5iHqGOPkjFEy6KIThmMDtO48XS1XuS6QdEvmcQc8aYP2Y7b
ol7df4yDALA+hyZRGgR4gIK4m763dEBTkCek2Q031YiJD1Pco03OCr5Ljf8QLMNe
ZnME2gAscvnF4eYJZ0BeOLjI8YR7iLx9tift0i2at2CLSF256hYxoMj1wZOeQZEq
T/tgmyn9pxoPl+Rht3e1v5uTdkgaXBQvZSv6PnuCY7VFgPEQeI21POW2cGRBy+4/
BzvjfWA8s/F3SLP9pMv1pbgpE2DnZmqU9jtSknQM8C/Slkjae98sPRDv4qRhxTLN
ynUfwR3Gnl5AceuQb/gAHtTkg+F9avUwuDFSIsAaiPqnFvlRrMvX8BZvSyd2Y68F
/Q8gwOeQhC5r/ocC0F0NF29JzK4M3Rm6dOh9VvOwDyjMSqhbaqfzGP0DZk5FPYy7
HZe1X2vyij7a6VF8+6mx
=OCTd
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
