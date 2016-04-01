From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: Clean up sysfs attributes
Date: Fri, 1 Apr 2016 12:59:57 +0200
Message-ID: <20160401105957.GA1389@katana>
References: <1459438805.18533.3.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:57371 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbcDALAH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 1 Apr 2016 07:00:07 -0400
Content-Disposition: inline
In-Reply-To: <1459438805.18533.3.camel@codethink.co.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-i2c@vger.kernel.org, CT kernel <linux-kernel@lists.codethink.co.uk>, Ben Dooks <ben.dooks@codethink.co.uk>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2016 at 04:40:05PM +0100, Ben Hutchings wrote:
> sysfs attributes should use the same format for reads and writes,
> rather than pretty-printing on read.
>=20
> * Make the "cur_master" attribute read back as just the name of the
>   master
> * Expose the list of all masters as a read-only "available_masters"
>   attribute, using space separators as in similar attributes of other
>   devices
>=20
> Also, spell out "cur_master" in full as "current_master".
>=20
> Fixes: 50a5ba876908 ("i2c: mux: demux-pinctrl: add driver")
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>

Applied to for-current, thanks!


--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW/lStAAoJEBQN5MwUoCm20dEQAJ3VincnNaTv0ShW5do7UN9g
yc1zKFSDY4i99ByxVyi65D4M1k8J4SVHfyZ7Y8199K4ds2Gcl48+nJiHcZfL/iyh
bFStBuO7oQypufk/tQBvWoxiQpdCn+Y3pqq2RM57V3wMYtO26qf+X1nvXb++ayk3
XCKD3CEJEzMuasukVWE3B51UaUAds1uTolTw7Xqa+hCX8CS120Pik+r9RZRpQLl8
C1tE74LqW3pSayJlOQSo9beTfg0h0yYCVBxsWQKUgtxhcN9fq58pM1DC9MmRtZGE
QYEHeM5ZzV7SBWVAQ7xfmwAK3cFHP1xxKRpkYPjDuCeERT5Qds8eg5iw00MfmYP9
ZXy75Ov229PIv0F9Eeoj3odRaqC+gp/Ta3PaIgPorvGU9s8OOzOZeIkiCzyU0cB0
dNx0w3wxnxUPUNBdUlAC2DoUA4dhLSf4OADl8QdmzOqAQVT5DMKf0TR4hzLtnwDA
LnQj4JjYr1UjrpbBDvHzuPR7Zcs5I6ldSJ5ASu4CPUTtr6hDZ8+USD0W4lpuJHUK
4wKOMcCD/G3ymUT5pCM8i9pD0r0sYxi6zr/9TGG874a6t968nfRItZbw7/09jYEP
SnBV7RvE7jvHdpMgKbHnVXJdnmrVz3MVChmucqMs35gjhWiLP/a0wGc7YEJ+EH7x
oswqd07zkyIJFtkUW6bC
=kTsg
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
