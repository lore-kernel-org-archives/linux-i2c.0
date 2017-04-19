From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 09/38] Annotate hardware config module parameters in
 drivers/i2c/
Date: Wed, 19 Apr 2017 21:25:04 +0200
Message-ID: <20170419192504.s5bo6tmqns3vx45f@ninjato>
References: <149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
 <149141148368.29162.12692004178864468110.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jxdx5lp5y4q36bqq"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44692 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762476AbdDSTZG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 19 Apr 2017 15:25:06 -0400
Content-Disposition: inline
In-Reply-To: <149141148368.29162.12692004178864468110.stgit@warthog.procyon.org.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, Jean Delvare <jdelvare@suse.com>, gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-i2c@vger.kernel.org


--jxdx5lp5y4q36bqq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 05:58:03PM +0100, David Howells wrote:
> When the kernel is running in secure boot mode, we lock down the kernel to
> prevent userspace from modifying the running kernel image.  Whilst this
> includes prohibiting access to things like /dev/mem, it must also prevent
> access by means of configuring driver modules in such a way as to cause a
> device to access or modify the kernel image.
>=20
> To this end, annotate module_param* statements that refer to hardware
> configuration and indicate for future reference what type of parameter th=
ey
> specify.  The parameter parser in the core sees this information and can
> skip such parameters with an error message if the kernel is locked down.
> The module initialisation then runs as normal, but just sees whatever the
> default values for those parameters is.
>=20
> Note that we do still need to do the module initialisation because some
> drivers have viable defaults set in case parameters aren't specified and
> some drivers support automatic configuration (e.g. PNP or PCI) in addition
> to manually coded parameters.
>=20
> This patch annotates drivers in drivers/i2c/.
>=20
> Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Wolfram Sang <wsa@the-dreams.de>
> cc: Jean Delvare <jdelvare@suse.com>
> cc: linux-i2c@vger.kernel.org

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--jxdx5lp5y4q36bqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlj3uZAACgkQFA3kzBSg
KbbxBA/+PY4e/7kAvvUF3aHrc4dyw4DXT3+4CenBJd0CV+7GVa2vJS8EfhyDydcv
4HcOnEAZ4QI02xEdJ/abKdg0qh0phLWg7j160VWFASIw5+KPeuy8FdK7RG9IZvdJ
wJKlANP5nuKrymr/IIUYaiZeBaJAPYORXdolSNvwipbJr5wJrILQsrQQ95SVpN5q
64GwP/7MekFxO5iaCwb8zvyaJgqhkzrtULhS7wRF61CFo4FPU9O11h4jXZhxmR3o
jUUay5M/eiZ/zuvlaMcHHcrDBsl7mQGaQfbTYTnCqOj1wmFaKGTxgETZ6bfAOGs7
jOS4duhmMzCEN/6whgI6MsbSYy4ThAdSn1F1hyFCn0RWnz5OTmArCg2ddCy47RmC
Cwhb/PrIbuX1M6iT+cHLW5F+ZJQU7EZlTAm2JPj2uJNtVA8DdUzvWUNExhgmTL60
x/JI32o2fELbOXyh3SYXGzcYKroPz3WUMnt0MTN4vp4yXmSc21pmJoLQUsOcA4j3
zw4YY5b9mETMDHew9J9VvkzfJbLHThWVlVAED6/FNz5A7z4qjvYQ+9j9xmLO2fX8
4oVfEU5rPAWK5Z77QZxa8nGFZ+Uo20nXm3TFrHfrSI2zppQsjLRG/dJffvUIYWKK
DbkTGWm8zhjrc65O5E0lnwFWBZaDJi7AVI9khgthhGln3S3mRro=
=xuRz
-----END PGP SIGNATURE-----

--jxdx5lp5y4q36bqq--
