From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND][PATCH 2/2] i2c: versatile: Convert to use resource
 managed devm_* APIs
Date: Thu, 14 Jul 2016 21:23:55 +0900
Message-ID: <20160714122354.GC4149@tetsubishi>
References: <1468042283.21863.2.camel@ingics.com>
 <1468042343.21863.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60896 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbcGNMYF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Jul 2016 08:24:05 -0400
Content-Disposition: inline
In-Reply-To: <1468042343.21863.3.camel@ingics.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Pawel Moll <pawel.moll@arm.com>, linux-i2c@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 09, 2016 at 01:32:23PM +0800, Axel Lin wrote:
> Use devm_* APIs to simplify the code a bit.
> This patch also fixes the memory leak when unload the module.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied to for-next, thanks!


--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXh4RaAAoJEBQN5MwUoCm2+U0QAKHTqslWL5JR4aQaVLg/Gnad
MnoMBPMxpjs3VVsBfzb9RyjS3SBrQvL6b1O5vE9GkTvPvUDlaak/+/IE11IigDBo
zw4B6qSFcQYx/DKhfITLI5diIVxP/9XmxFsQtQXS1VR9RnOwEqoHhng3bQ5ububh
SlV12TeW796KhFCrVR4OOWbjJpratGp1octfGULDITQoe1FoBKg/n2KjgEDEKlvJ
7avjW8mw0wUkQGyvEvCTjohPLrGHCts31yr78tbxOEuUGrlURBqfUhc7E4BsDX+d
oLnwY1l2ReT2DjHeo520ORViM8DVjFJg7/+NglLzZEd/EbBpzYMDU+LcOBDTce8R
y2VSH2WEZnHqtWJFcIEjj/kVrSyqFRMd8BhmPO5ep6acFR/+hgzPjbtW7Q3AwGUn
/Ojo+WrluSSQw0yfwtpUw3uA/NHvMRp/f5DyCGI7n8tfEzvxG9E4dakPuPAm4JUo
/3kf5N8uqnLc4OcoSr8Fr7vz5vzrvbbNdjrn45QLr1txEJyFDAdLBszoGIaojE1N
jMM4h7XqBD+E8juRbe/HrejN0aaPfen4j1LHUjF29v1BHiVPkiFeUtw7MSrNOgnx
Fnor8Q2uEX7zLnToyFtLueq0GoRTpKU4XuwRVyibUySvQNqLKccL9zhsUu3UtqHy
VcZhfEsXM4Xc3SUxsMbY
=jbR8
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
