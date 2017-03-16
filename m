From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/4] eeprom: at24: Add OF device ID table
Date: Thu, 16 Mar 2017 14:36:46 +0100
Message-ID: <20170316133645.3nlr75gjhx7io7mv@ninjato>
References: <20170314151638.23132-1-javier@osg.samsung.com>
 <20170314151638.23132-5-javier@osg.samsung.com>
 <CAHp75Vf5=E37Ccrc2zMo8xOWmA-A_FZL7d57q7Rxk07M-V5mhg@mail.gmail.com>
 <8e233f15-4f91-b495-5270-5a7f982b31be@osg.samsung.com>
 <20170315075835.GA1438@katana>
 <ed3caa80-2b73-752e-a13f-aa5d348abd18@osg.samsung.com>
 <20170316130714.n42zkjdei7pm7vgw@ninjato>
 <5da325d0-59d4-92e8-350f-43c25310dabb@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="42qvxlqbs47fbjes"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5da325d0-59d4-92e8-350f-43c25310dabb@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--42qvxlqbs47fbjes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Sorry, for not explaining myself correctly. I meant to ask who can do what you
> suggested before. I'm certainly not familiar with this driver to identify what
> is the minimum set of compatible strings that can be used as generic fallback.

Well, I am the maintainer of this driver :) But we should definately get
Rob into the boat if he is OK with updating all DTS files having such an
EEPROM.


--42qvxlqbs47fbjes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljKlO0ACgkQFA3kzBSg
KbY8ng/+L/ACdmZ5zLNaCs4V8dhS20UIU+2B4leugDXTCsbXkrLBrBUm4Y0fQF4I
wWSq1ATQI1M3d4JcOna/Im6Pfru8bpoiP3+z9ASRXLk54vDDbLi3mTt+lv18uF+R
hAN8jFCLNl1LxMWQUmsYD9t7CZF4BaJIxmxHiCwUE72zdUuTkNNxVCAvZN5wyy07
aCS/qGS5IwkU0AZeVHzeYq8Y3/WcCnSkcbo1vQ6lCrEEW1o+T43AmbIR9B6aWp8w
m9aIa3QMxy2xeGd4eod9CJ/92QrCEThkkw2p5cGTk9mAa4SorNihKp5TDgF106ad
DLHK3JJ41zrsOCIli/9oqxvFocTAZ9bebLgv0uAVBiS78hHipzhuUMwi10Ml0PeD
iIhAO11CNzmz9uynAuIc4O5DO4i0w/RZhY1IsQF/jv4oQDSvdrSIXBeBt5/iLJJQ
wKq+ZNMrG/H1gX1dagmf+6Rk1+JOuAFXqS5xgJfs4E/faru/tcKfDov4P6DbZARx
U3b5mXP1ZX6IxV8hnWoW+ReDVoXjDYWp2/FmP0iuDPczUoInZQlpGMQofirNutgE
VNRsK4qSPRr231xQRryAyxewjFFN9PbAxxRXPsepSBM4Ukt27VUXr+sRE5biBHw+
SC41dv2bVTuXspsbAhzd1ZDuFIyTTLgJc4EkKzhTfBS8tnsqJQw=
=xP1e
-----END PGP SIGNATURE-----

--42qvxlqbs47fbjes--
