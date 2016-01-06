From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] DT: i2c: Update vendor prefix for 24c00
Date: Wed, 6 Jan 2016 09:55:54 +0100
Message-ID: <20160106085554.GG1525@katana>
References: <1450898335-22814-1-git-send-email-akshay.bhat@timesys.com>
 <CAHp75VfvLJu+aL233izR3jh7UQg7ewEmS2Z3EhAg2WPZ9s1gyg@mail.gmail.com>
 <20160102212143.GG1589@katana>
 <CAHp75VcCEpf1XJgRXym4T78VGa=PS3GuzLAfyDbRWd8CvN=jQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yQbNiKLmgenwUfTN"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44866 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbcAFI4I (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 6 Jan 2016 03:56:08 -0500
Content-Disposition: inline
In-Reply-To: <CAHp75VcCEpf1XJgRXym4T78VGa=PS3GuzLAfyDbRWd8CvN=jQg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Akshay Bhat <akshay.bhat@timesys.com>, ktsai@capellamicro.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jiri Kosina <trivial@kernel.org>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, justin.waters@timesys.com


--yQbNiKLmgenwUfTN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 04, 2016 at 08:22:33PM +0200, Andy Shevchenko wrote:
> On Sat, Jan 2, 2016 at 11:21 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > On Sun, Dec 27, 2015 at 04:57:48PM +0200, Andy Shevchenko wrote:
> >> On Wed, Dec 23, 2015 at 9:18 PM, Akshay Bhat <akshay.bhat@timesys.com>=
 wrote:
> >> > "at" is not a valid vendor prefix, correcting the same to "atmel"
> >> >
> >>
> >> I'm afraid you can't just do this change alone as it's used in some
> >> DTS. Though you may deprecated it along with update of current users.
> >
> > Well, in Linux, I2C core currently strips the vendor anyhow. This will
> > probably be changed somewhen (tm), but for now, the impact for Linux
> > should be extremly close to 0.
>=20
> Okay, no objections to the original patch then.

Heh, I just go reminded that eeproms already have a seperate binding
description (Documentation/devicetree/bindings/eeprom/eeprom.txt).

I will update the eeprom bindings and remove the entries from trivial
devices.


--yQbNiKLmgenwUfTN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWjNaaAAoJEBQN5MwUoCm2v0wQAKlNl/j4j1pRVDh4IeNYQyBN
m62n7axcUiq4zEos+EJtOarN8I7K/X8NP3CPOK592ID+qOXVzOeR9HDfYX91KyIQ
G/zh7aEjKukszAURVO8zazTVPKiU7C8JSR+YHhEuQ+ThFO5JsfYJ4j7Xen+Mz9Ej
Zj3lDnBb+56Q5q5OvPs+bF29H+BiSSHNGb46gL1pHNL3wdpkSduq2IhZMOR66O+H
3XeEEnoi1rJP3XXBEpgBzGG4UujyhpwBjyKalAHMsU36J+qS3oyBuFB1Tu/ew/iW
9cV38LY6h1iN2++dvrxvCMmnAyYM1jJ+gg+KQUX36jWula7QNeohB7J3B27rLyJV
Uh1/8deM9KnxPAeu3S7HXp9YWrmvG6R7zCEU7lXx9EUWVY/ER/pLS++6bOr5/bFt
VPvho3/2AmOwFj8hnz7X9LrMRHCuxmTwsmxsACXuJcW6i+gauqAvwwqwde+0a/0Z
TcjaD+hNnKkIqn/IhkWP8J2+AWT4cdFEOyuekvGPCRC+kQnNFIlwPqpaG4Y598eT
GQX8doTo5m1O0y+UFkedvX61T3up1/Fq9XR+ydM6SiXRs+CSXis0SU/qWxcPFG3e
Vks867LBwxOwevl0Xw0PEpfO/ueb6zB6GYkUSPPtTM47OJkV3+zaR0LQ7Fo9PTuk
hwX/eCYi5upph4zjCes9
=OmAA
-----END PGP SIGNATURE-----

--yQbNiKLmgenwUfTN--
