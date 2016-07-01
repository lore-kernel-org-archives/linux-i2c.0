From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 i2c/for-next] i2c: i801: recover from hardware PEC
 errors
Date: Fri, 1 Jul 2016 23:13:31 +0200
Message-ID: <20160701211331.GA6794@tetsubishi>
References: <1432332868-12705-1-git-send-email-ellen@cumulusnetworks.com>
 <20150709165939.GB4744@katana>
 <20160701113028.7a47c236@endymion>
 <20160701154918.GB1372@tetsubishi>
 <20160701201814.28524160@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34767 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142AbcGAVNq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 1 Jul 2016 17:13:46 -0400
Content-Disposition: inline
In-Reply-To: <20160701201814.28524160@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Ellen Wang <ellen@cumulusnetworks.com>, linux-i2c@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Thanks, will do. Do you happen to have rebased it to latest
> > i2c/for-next?
>=20
> Here it is. I don't remember having anything to do to get it to apply
> though, refreshing was trivial.

Well, the previous patch didn't apply for me, this one does. Thanks, and
if didn't cause much work for you, even better :)


--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXdtz6AAoJEBQN5MwUoCm2xDQP/RYHE3eyfwBnWeliZKhfZ1GP
aYOfahGeAiIm/Ml7XMCEqoK7QJFGedHwvYSzo3g/hb/bQX9vUhYmwXZe1KOOMktU
dmp9HP3JqU6pF00/b04cX8DGJMp4i/X+9tUZ+806yW4k99aniL/JZlB/ErnwUbGf
DdCj7MxOm0WyuEaOaYwaXYq5kW529vbh+k3olgiPaev/A3JouIjrHovMVlyiRLXB
oyEMbkoiGg9JoXqcRmc8xHP5mIQdinFHhgs9xrMlbetgQPneTDHvtqto2hCcXyF/
S0nQfb81BGSRATSaMt27BaSCv4ab7YuJLiSOUBko1xlyh1Pg8NJEWyVrhcFj5KAt
Q3UYg/gFy/FwgCz5hEpxGaCmiXUg/K/jtd9tOuUn6WqGaXGo3lKh5uT0rdN+sqxL
wrAXP42ddNYAFeKXCMDlG1asoahE4VaivlnEqonkT8Kuc5+JLp4CEctBkGKx7par
ph0MsjobIQndRy1bIzvqJuQqkpYL9Lk/CrJQw2h2Xrzgq+poyEbQGOp8/H0wY0V9
tvbhaAtisZsH0QVCP7dtg4OzoFvvQyH3R1pDzTAqrSN3OLF1xArZDnQp0Mpt+90t
s2L883zu/y/DCXv9vweuDwT/l4+27QMzd69WvYS8OYvwsjSnmPD1QjUq2d2lxx3b
OmR46z+dBnX19I7yIHpy
=+EfB
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
