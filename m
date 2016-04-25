From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 01/15] i2c: octeon: Improve error status checking
Date: Mon, 25 Apr 2016 23:20:28 +0200
Message-ID: <20160425212028.GB1550@katana>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
 <1461594824-7215-2-git-send-email-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47017 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964869AbcDYVUe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 25 Apr 2016 17:20:34 -0400
Content-Disposition: inline
In-Reply-To: <1461594824-7215-2-git-send-email-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2016 at 04:33:30PM +0200, Jan Glauber wrote:
> Introduce a function that checks for valid status codes depending
> on the phase of a transmit or receive. Also add all existing status
> codes and improve error handling for various states.
>=20
> The Octeon TWSI has an "assert acknowledge" bit (TWSI_CTL_AAK) that
> is required to be set in master receive mode until the last byte is
> requested. The state check needs to consider if this bit was set.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Applied to for-next, thanks!


--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXHoocAAoJEBQN5MwUoCm2VqAP/RhaHmtf8lt5bVMqAM7D6+PI
YciGL68m0P+oMrVDrQskojxqKy1JFQxAkoqgEU6nFCPv+cYDNvcius1Q5VL/nMZ7
aKRLjxb8AKiAYn03orAtFEjfx3TpSq4DkzQEmwtXgffkMHIVK7ngjiLsslWlZ0Co
hLt2H4HTuvYBoYyW0XCZkpAXXN5VDKkqMXAe5s717lz/mm1jWMWOugoorMP5omKh
oIWIcbl8RMt6PcUstoOobfhQto0FsZlf3plSiDiIqajIutSgz5BesLR2BdDnHZqq
8l3wMqFZ52jB4ESG/EaWP6je4eJjyDosNrGyJsDuUYLXVJDlqkeDiGR38zTGum7E
CTXKEgGMIVanRa6ix9d3kbh7zKuUtXqGYRQUWMhbndcuQljomEGm/Z7mICshc+Ga
kZRlK0yowDAVLNk7pH7kmVx6ozYuKVKTU5LzIUQcgON9JA82erYLSgGJ16AwXNm1
m+HZzlzUmA3MvJ4DRMZmX177iwTqNFeDzTNjgdw2R5nlAEb6OJO0Cx4djs9mlWs4
NmHR2c33MHfBjtm9E8C+j9abFdu2Fvxltp6ccGgcap3ttojfG8pex/mKCOHa6sKK
1yq+KLy/64Y7psuxVYtVpWdCL9fDPFp9KaVj+VTvaGQtQbL32OWYGAjMQfJ3ATf5
zy4Onv1FPpT4fJ/xadm0
=TMEN
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
