From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: simtec: Convert to use devm_* APIs
Date: Wed, 13 Apr 2016 10:19:36 +0200
Message-ID: <20160413081936.GA1563@katana>
References: <1460449814.28557.0.camel@ingics.com>
 <20160412214831.GI1526@katana>
 <CAFRkauAArNSY-_nytHYTVScjM46Zy8yTogjSMM7iqK421CTKOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34669 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754681AbcDMITn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 13 Apr 2016 04:19:43 -0400
Content-Disposition: inline
In-Reply-To: <CAFRkauAArNSY-_nytHYTVScjM46Zy8yTogjSMM7iqK421CTKOg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Ben Dooks <ben@simtec.co.uk>, linux-i2c@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 13, 2016 at 08:43:49AM +0800, Axel Lin wrote:
> 2016-04-13 5:48 GMT+08:00 Wolfram Sang <wsa@the-dreams.de>:
> > On Tue, Apr 12, 2016 at 04:30:14PM +0800, Axel Lin wrote:
> >> Use devm_* APIs to simplify the code a bit.
> >>
> >> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> >
> > Thanks! Were you able to test it on hardware?
> >
> I don't have this h/w, so I cannot test it.

OK, so I'll rate this as RFT.


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXDgEXAAoJEBQN5MwUoCm2GmkP/ir5lZhZEqcdHsNl+/42SO+S
5Yw8oIeGoMG+90QMqXnrmKe2SFlGywmBy9F2mL0vyj1ICJjj6VmJb2NKJJNNxsBo
znpCgbQszsHt6bH8889i+4ub7zVuBTsagC6Mmy3GSgafcL+ujixU1upOyX4qq2eO
qmtTKv4cqpC22TfGjdzh3fAhuYZBarodXNLwAu8ZQFOCiOE+v9Vb/6cyQr13Jfmp
LJlfDMdCVIVKq704NYKJg9KYMLN0LiFTMf5SMFERBqhQZy8BMB09BR8ayzQeoY8I
8Y2M//V9/lQkwl1s5sTaJO0RA4uIzBPWMM+wpKTZwfWUEzvTlhMAPeYykGA8zPTn
ze1Il3eo/no5XItng2k7lV7aS2DYDndRahzKHQqjK/hJSFx3crMl1SdGv4tjodMG
A0TTgzKnI6TjgsFjhbGmx47jFJ5fNR+L0dpy0YL1qAXiTSsftOv9QPzGYTz8Sy7W
lv19q8TyYoadSas9kdk06gKqR5QsTHvN0wiEGFJApl4A4IE82IptjKJUsXTjmRri
FQN38KqfeRPGEU23jS6wR/28fOXApmEdXllrh6xCX9gi5+x94X3mjYr1u+JzXRuu
edMgZy7zvXNrYl60ABJCE/7n5m4JdQM36ov+L8FZMov1a61VPlB7J2zCDtZu6Sq1
dGFIm5Xj9kx2PUI3kfxQ
=j9AX
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
