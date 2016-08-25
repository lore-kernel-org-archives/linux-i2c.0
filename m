From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 3/8] dt-bindings: i2c: add support for 'i2c-gate'
 subnode
Date: Thu, 25 Aug 2016 18:15:25 +0200
Message-ID: <20160825161525.GC2856@katana>
References: <1471268431-5148-1-git-send-email-peda@axentia.se>
 <1471268431-5148-4-git-send-email-peda@axentia.se>
 <20160816135751.GA32704@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45989 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751615AbcHYQRa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 25 Aug 2016 12:17:30 -0400
Content-Disposition: inline
In-Reply-To: <20160816135751.GA32704@rob-hp-laptop>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > +			ax8975@0c {
>=20
> Drop the leading 0. With that,

I fixed that locally.


--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvxmdAAoJEBQN5MwUoCm2Fj8QAKva90It2WBPM9n32XDzmmnA
Ssyyxof2tqf84WucjNSXE/tUmTSD8YwA3ysO8WDf8dGHIen+6p/n0tinlW+CzbEU
4+3NReOxTf8lKiFJXK3bnVX64cNHCdWxOgMYa7a08hbcfmcGIvDkk+pcKnGDPQyp
GJ8wxWlXVXOj2d+unAXECNw10QcJN3ZBILMpkYcSJi8TN4bAArNfI7MnADRHRGo9
MwZC+dp6jQMwkzc/EyVmyuXFXU7zF35ncBedj1iDks9RDWtr/MYOeFrddeGvfdkr
QS5jSfeRrho8srsk3s92TI8Rt73gOg02+nW5qXGHBYOxBvTQk6PXMefrKH1fBmUf
+uc+rYewmib0iuuROMP3APsFQUTBWK8cK3dV/a8yHy4ioG8S14ED+snD4xgeS7l0
tSyFye8u4ENeQ1HpbzYK3l0C/S2DTLPLaj6+eEsH2CFx6OKdKii3mOnubktMnzXb
yqqpJtYBT4Bb0j7sfCUuoEdTl3tSGg/N2K7ABnBJdIbbUiyuqLMzk5+HpnRZ/ysd
5v5o/Rp4avmoZcGLhyE+59KL08/H1CeglklJkPRw6AB6raXuDppXFqojDcgbzORw
eRYrnrY3OmPsxyyM3ugx7wI8kE7h90wG3rRmweYsSyK0c+h0bfrByr5ZMbx6JqV/
h8UccqZZgWXATmg0TGGm
=u6of
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
