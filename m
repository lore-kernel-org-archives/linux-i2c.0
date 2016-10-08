From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PULL REQUEST] i2c for 4.9
Date: Sat, 8 Oct 2016 21:42:21 +0200
Message-ID: <20161008194220.GA1442@katana>
References: <20161007093226.GA2058@katana>
 <CA+55aFxDBznCn_ui65W2F06ubZkdVVt2nQWn+ACFQpAQ26+aUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33298 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751882AbcJHTm3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 8 Oct 2016 15:42:29 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFxDBznCn_ui65W2F06ubZkdVVt2nQWn+ACFQpAQ26+aUw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 07, 2016 at 02:17:20PM -0700, Linus Torvalds wrote:
> On Fri, Oct 7, 2016 at 2:32 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> > here is the 4.9 pull request from I2C including:
>=20
> Would you mind double-checking my merge.
>=20
> It looked very trivial, but it would be good to have somebody else
> give that gpio-pca953x.c conflict a look to verify that I didn't screw
> up the 'id' variable split.

Looks good to me. Thanks!


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX+UwcAAoJEBQN5MwUoCm2d3IQAKofySVYWbqC9zngvYsYdQXL
MJSV++CXPXSe6FZv5htuURzfEX78oeAsAABsCnNOkb6chHgwJQu3gsPig1X+gg1G
BZgY06IBl5ypQ1wiR6izR2dFZAVJR8lJfhN/puabeXtEX4zXseEMb+eRULxaPsfb
+znga35V3PlPAQXgxfi+g7G7MQu1Ec9IeTnEBgSNJaXzHyP2aeIc+IyPtVRPpZVu
CtbvBrIIwKfX/OnIgvjtu81CsLuzLF0g7Eumism7O60fhOlWxsMepJWcfBKhR/eb
W3m8nPVkOr2dm6P1PB+WpsVVxcT3+gM8bmRNCPqslm2SyBzCB/7cSieeZLRyfzNc
HlqN0qSDKpX/OjcoqhYEsf8MKgWD4MHiqLZ7lICL0xpSRNR3gbYUi5wrS1EQM3BM
u2BMbH5lrOQvEmOCWCSqq4Yu+M/NposVVOlYIO+Uk8lCqN7QtFiiStJ2EC1qN9Ah
FX4lNMyhxSiu7XDHcVaT6pPTy91vapxjPGf9b1bmz8adZlBulCvXn5j5Iww9FtMr
r+vBZxcOUE5+xqabQw6PH3TsZEZwmZ3MezV7bSsHtwGIqXTlFOwyQ0j/fHjSY5j8
h7qJEapzqESrLouwumF+DcFnO4FUFO3PL5ofk5ixopsylRSuB0VBmZ1ZocA0qYHV
LQHEIngvcl4MKws2F4+F
=jmxI
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
