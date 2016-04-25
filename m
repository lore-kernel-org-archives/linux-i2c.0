From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 10/19] i2c: octeon: Add support for cn78xx chips
Date: Mon, 25 Apr 2016 23:45:50 +0200
Message-ID: <20160425214549.GF1550@katana>
References: <cover.1460387640.git.jglauber@cavium.com>
 <878b7035b447b6700abc7ec79c375df090067ebc.1460387640.git.jglauber@cavium.com>
 <20160420215218.GE1546@katana>
 <5718027F.7050707@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kbCYTQG2MZjuOjyn"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47183 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965053AbcDYVpz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 25 Apr 2016 17:45:55 -0400
Content-Disposition: inline
In-Reply-To: <5718027F.7050707@caviumnetworks.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Jan Glauber <jglauber@cavium.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <david.daney@cavium.com>


--kbCYTQG2MZjuOjyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Personally, I preferred the old way where each device had interrupt enable
> bits that could be controlled independently of the interrupt controller.  I
> have been told that I should abandon my preference for that type of
> antiquated architecture and welcome the brave new world of the unified
> interrupt enable bit.  Never the less, I still feel some nostalgia for the
> old way.

:) I think I am with you on this one.


--kbCYTQG2MZjuOjyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXHpANAAoJEBQN5MwUoCm257wP/39+xeLxzi0l3vSd4zz8ZC+b
hcQyUGX2q9M9Ii5gK2Ye1V4P+yHaFLqWK4YJ2lRgwPHLIhjRnqw0/bbunQOuAsZv
Z5gJn/TeQ9NTNOyjk5vnwdRJUVtVJD24qkTK68lJ4T0Ul/HhwwK1izn2leuVHb36
ykSMsinajt6n0Dw4s/mCJKMK1g8hislbeb9IiR9zlfDpEUGSZnjnhWD3ztlPXHUT
VRd8xuXdnJXtd2xx5Gvlp3pQGjYRgEIn38g0POPbdIXfrZ1OAEhlq2B3G9avG70W
a+z9Mwy4MqAE/JecwpJp5/j1esSnD9cdHtvRgNR3tq6X6cRV/E3640R8cW8tFfxy
s8XvYfax5mizMC3Q32VsjZ2uXFd05sKFSBo6mNmO4FnMrmw6w2/IPqe3L4/CJU7r
QtgccdcqvyQr7TFs2wc2udpxetxcdEEG0Q/gKMhjSGHNrC3liqUfjHOTdZZVP+Jy
6qfREjHpHZSEjnkoTfZWnVUXjIlVBDs4FbZ1IadK+JcE6OxMbSA+JASf4P/BfkUF
kyklLsx1tF7meiQPl5G1nT2P49g6N1ZwRnKzCIbLCh4XX0rHrzo7lT2pZrEswVqP
05AXyVZzV1Gnbmw4RxlZvGRMUw3wTakPPtG9TPwawTbZwP4ZZsuY500jjlIEjSoh
iEJ1iE9dm5fmY1u6gHc+
=OW17
-----END PGP SIGNATURE-----

--kbCYTQG2MZjuOjyn--
