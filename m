From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 0/8] misc: remove boundary checks from bin attr users
Date: Sat, 8 Aug 2015 18:49:06 +0200
Message-ID: <20150808164906.GA1528@katana>
References: <1437945502-27944-1-git-send-email-vz@mleia.com>
 <20150807161055.GD25357@katana>
 <55C4D9B2.3000708@mleia.com>
 <20150807223456.GA1527@katana>
 <55C5FB6A.5010300@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55C5FB6A.5010300-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Ian Munsie <imunsie-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org>, Michael Neuling <mikey-/owAOxkjmzZAfugRpC6u6w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 08, 2015 at 03:51:54PM +0300, Vladimir Zapolskiy wrote:
> Hi Wolfram,
>=20
> On 08.08.2015 01:34, Wolfram Sang wrote:
> >=20
> >> if we're talking about this particular series, you should have them in
> >> your mailbox, since you have them applied in wsa/i2c/for-next:
> >=20
> > Those are already in linus tree. I mean all drivers which use struct
> > i2c_driver. Or do you prefer they go via Greg? I am fine with both.
> >=20
>=20
> I think you may find most of the changes applied by Greg into
> misc/char-misc-next branch.

Great, thanks for the heads up!


--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVxjMCAAoJEBQN5MwUoCm2k7oP/iApUSry8gJWINI2FWr1PvEr
k87oay3i4lkL7BZiYp2TJNtjMS7xT6hDsnIfo/nrZlauRP7ayqw4cyypeqEklj2D
BuAXQvSY99MgECR8s/NE3mWamBPPzpGBRP7TvIQhVS5XKspvfapc1eWt+wfD5Dol
X2HOtLCC+5yZV4oywc0rbL8u0VJ/DvG9RNEMenEdDLsfmMQkVMJTjR14mT+CtE8b
1dm9qJtiWZJu3w2KZj61tiQbQ8Yv6qCW55oVt0WKLG5oCm2Yb5oGha6R5i8VZJ/N
79k5iabgwryf1BFk5Fr4IiY5k43Apx1zrba1T5JPX7RaFrq1xJyG5SnELj/RZ7fY
IrRg9W/nrbw0XZNwqyHCIqtgSmw1Ev3Rt2l5lr39sHU4ov1lC+Ok4EbrJbPGVB3j
MKbGysBJ97h3rfQSIMI2CduDAwF2Ccz7pIfWOxE+RU9ioIe8V2RIEFLEOJtv0Ppw
QGXm+I4ONdgFx8KndClZJoe9hR5XHWRC8AeJqIzsxxC4Y+FDOykJTUdJTXuupWNZ
snykg6srf0e+tzhjWx4GQY6iGXpypb33fK0dhw+NkJUtO1i9Wusb/HhihhAQpwVS
hzdjHi1Rkz5DtcuqB+VCK0kKNulACR55tykUmrH//2t4lx8sf8VrmdBWkFsUfpGD
C8qzS/6IDZXx+FhRFpkL
=deHO
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
