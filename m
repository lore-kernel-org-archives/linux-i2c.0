From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH v2 0/9] eeprom: at24: at24cs series serial number
 read
Date: Sat, 2 Jan 2016 21:50:41 +0100
Message-ID: <20160102205041.GC1589@katana>
References: <1449051926-21918-1-git-send-email-bgolaszewski@baylibre.com>
 <20151211120831.GA2742@katana>
 <CAMpxmJVag2E4GFSUW10vqCS32cCg0ymqkz=BOE1XS_qo655vBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:54859 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584AbcABUuu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 2 Jan 2016 15:50:50 -0500
Content-Disposition: inline
In-Reply-To: <CAMpxmJVag2E4GFSUW10vqCS32cCg0ymqkz=BOE1XS_qo655vBQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 11, 2015 at 02:55:10PM +0100, Bartosz Golaszewski wrote:
> 2015-12-11 13:08 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
> > On Wed, Dec 02, 2015 at 11:25:17AM +0100, Bartosz Golaszewski wrote:
> >> Chips from the at24cs EEPROM series have an additional read-only memor=
y area
> >> containing a factory pre-programmed serial number. In order to access =
it, a
> >> dummy write must be executed before reading the serial number bytes.
> >
> > Can't you instantiate a read-only EEPROM on this second address? Or a
> > seperate driver attaching to this address? What is the advantage of
> > having this in at24?
> >
>=20
> The regular memory area and serial number read-only block share the
> internal address pointer. We must ensure that there's no race
> conditions between normal EEPROM reads/writes and serial number reads.

I don't get it. Both, regular at24 reads and the serial read, setup the
pointer every time by using two messages, first write to set the
pointer, then read. The per-adapter lock makes sure those two messages
will not get interrupted. So, it looks to me that it would be OK if a
serial read access gets inbetween a eeprom read access. Am I wrong?


--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWiDggAAoJEBQN5MwUoCm2fsAP/j7uYNJGwUrZjywCxsMbYgiI
HNxRAb9hDRIVmUqaE/3wUolUfMalxjNA4zMKteUfb5n6M/y4HBjUo49JGTgczt15
TALHJcXUJpkutpNVx+wjlMiKbjA6VWnQKMtSJlFOg7klCvIZZ3O8wQlscilyNzDW
89r4DvUjkAOed1+cM0vlgaG1kAJCrCEagS2RV+6deKlXr8eVvP+OugQdtFiB5yBS
PLwp+KEQMF0GMe2mLOPZLcJC/K9KJnY8ouTPodGzTXAatAHt1S82438GqzBB/PWZ
hG0Wzzf94Vto/EetELyXnUtpPs3hYnVpgrYSd1FiQquFkkJloIt82KD9tNz2cSZq
W8qHt9cTpqAQ/na/gDbUyJTbjUK0i82Ogn8+5FaTEtDBLYwpbvGocofkjxgTh05P
zn8EbjwM0wfssn2YUdphQOWeWKT4R/cilhsJsdSbLXOMoelvYw+B0+XurLsofmoa
S3HXeIFTZcbun2OtJykkqquuy1YmCR/f9ZQWRstOclOpDO/NKleHK4ZP8PLrbS6B
+rOnc+qCUTFzoUenjXLNLJmgqh/t4aVvP20b5U4+pPl42/5eCZulig96Xs1jxLAF
fpppRlbkSH8TvE4pgnQ0d2DRgwPpFbVKMNXevhPMsMQRFFDsuay4kXDuN76QATda
XW1mNHIHJ4g4fJurL8II
=pxs0
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
