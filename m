From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/1] i2c: core: fix a code to suppress a warning
Date: Tue, 1 Dec 2015 01:28:28 +0100
Message-ID: <20151201002828.GA1517@katana>
References: <1442574399-26131-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1445514483.22669.47.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45627 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754234AbbLAA2f (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 30 Nov 2015 19:28:35 -0500
Content-Disposition: inline
In-Reply-To: <1445514483.22669.47.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2015 at 02:48:03PM +0300, Andy Shevchenko wrote:
> On Fri, 2015-09-18 at 14:06 +0300, Andy Shevchenko wrote:
> > There is a warning when compiling i2c-core.c
> > drivers/i2c/i2c-core.c:2561:36: warning: dubious: x | !y
> >=20
> > Fix it by using a plain bitwise AND since I2C_M_RD is a bit 0 and
> > thus we are
> > on the safe side.
>=20
> Wolfram, as of today I didn't see this in linux-next. Should I amend
> this one somehow?

I am working on my own series, introducing a macro for this operation
which can be used in drivers, too. Just need to fiddle a little more
with my coccinelle scripts. Stay tuned!

Thanks,

   Wolfram


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXOmsAAoJEBQN5MwUoCm23R0QAJow86C4dEpn/xZrMNidOLZQ
SsPe+OvumPLatvksV9gr5QrDpEnPcuOg5EtT+IJO3U5EpuksyFNBhOF0+eoooB4D
B2gNBe3OK/PZJQTw4p6c4fhQtVayumEXcfdbSOIuhwjC9sKWx6Rxb5UxoTF/jV9Y
v76KsWsymJoEZQJEyQeXs9wq8n5s56a5rhajxMspjF836IBxIWmDhN8aYDskP+3Y
IbpsOGYvQlu3w+w4pDdx1MUWmysNYfisYg/szgF9ML/Aenb1WuEBqMpqyt9UtBY0
1xDNKJViM2P3gRnF0JXWZqMRzdrjMuDWWQ6qKPSO+DM4BI9uI+QtHvGxnoy6hqDr
0rDivcY7iH2jOQ9pbVYv59+CcBce38RHrB2ryNqXDMqPHq+g3C7ld1aCA3HVu6/b
RoZznqJhlAADOAqQx8utiy9o3FRV8GEF8CeXWlOS4QPYdoe7tcyLIbfjdHrvq+bw
9XenZ8blErPMJtlnp6168SXd2CxeLMB4yBvIjZcjHfos3yfPr3HS5lo+HAIvn5QM
eRHGLwI10UG9227gXaQbrEZIZisdtUPh82L+VHXKwhG8jXLb6Cjswu0764bN1N7K
OoGjM+Se1Wi7pUBLe/X4Eo6XnmIDjwtiRjqFQwyWEMN+EJIce680AtyqeETiuSJw
dLzYVAsRRd5vAbiFNKI1
=q970
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
