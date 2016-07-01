From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 i2c/for-next] i2c: i801: recover from hardware PEC
 errors
Date: Fri, 1 Jul 2016 23:13:53 +0200
Message-ID: <20160701211353.GB6794@tetsubishi>
References: <1432332868-12705-1-git-send-email-ellen@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34771 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316AbcGAVOE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 1 Jul 2016 17:14:04 -0400
Content-Disposition: inline
In-Reply-To: <1432332868-12705-1-git-send-email-ellen@cumulusnetworks.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ellen Wang <ellen@cumulusnetworks.com>
Cc: jdelvare@suse.de, linux-i2c@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2015 at 03:14:28PM -0700, Ellen Wang wrote:
> On a CRC error while using hardware-supported PEC, an additional
> error bit is set in the auxiliary status register.  If this bit
> isn't cleared, all subsequent operations will fail, essentially
> hanging the controller.
>=20
> The fix is simple: check, report, and clear the bit in
> i801_check_post().  Also, in case the driver starts with the
> hardware in that state, clear it in i801_check_pre() as well.
>=20
> Signed-off-by: Ellen Wang <ellen@cumulusnetworks.com>

Applied to for-next, thanks!


--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJXdt0QAAoJEBQN5MwUoCm2mOoP+Jhr+kDwOVxXEwAxkMahGpiU
GsiBKxE4AC4KGVoPwWCxly3twKMO5SRzMO/fvJV46R+sD5Dtz25WEEJO1mLoc2FI
cEU5ks8BSs7yHOQxi1ga32IDBnA5sxh6Zs3twFWX03lpZUpsf/8rQljRz4nROtD4
xR+5RLTKHR9zoR4DygtqCu4cQk8z0d5WyBftEqKzJRDLGVvpJyqYKhPv7GwEFTzP
+5RUWrxRlkISnpcZE22mcLr8Vk6alkEUCOzOc5il/XWQkwJDDNFIpq+PjSN/prKl
IluZPSNBe7tpWwHd/u/zGPboI69D7bChMIb5fo7SB18WwT8iQ5hRbgxaMU/+eKHn
Nhcpw+PDGeOTdJ2bIMTdz/RGn9HB6HxMBkfsIxBi8zqnLHRlMEZh250AZ5PHzfx/
0V9LXL13cK0twVTeov6cyNfpWY/J+q/7zTJu7iuKM9Rc9j7nuTDMs91pi3XDXR4C
MQGPFLvZ4OJ2OuptMS0kKqKEKRwvkwezatelITV/4QKRx9g7GxVvTxvdraDs+yWC
Z+a3hG0gKYLi4oeD6ltUWrr0mcEXU4PcbITVNpVcwhINzcw5Jai9+xHVeylyMY/f
npk6VAgcZvOgBebUkDRSFuqG0Tj1w9puX9E7c4BplrxX7vymdJfIwfiBzdl3LRbG
D9dVqP0b9BYONLh0L1c=
=GLQa
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
