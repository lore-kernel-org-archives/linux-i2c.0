From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/1] i2c: aspeed: add proper support fo 24xx clock
 params
Date: Sat, 12 Aug 2017 13:30:13 +0200
Message-ID: <20170812113013.2ajkurbj7ongg5cq@ninjato>
References: <20170728204558.6455-1-brendanhiggins@google.com>
 <20170728204558.6455-2-brendanhiggins@google.com>
 <CAPLgG==69mNpqoqKUf-0tT4iJJ5-aCg+1uaAoLJ5QSe+8LGYkw@mail.gmail.com>
 <CAPLgG=kUxfriYRq-fc+AD=eo1T+6xa4imzda7Fd_aXmAb2pD3Q@mail.gmail.com>
 <CAFd5g45O7rJymFgnWj3SnSKhCvXoX4_xCO8FqeBFCe0-Du9AYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dfq5twjtmfw3izn6"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:42717 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750885AbdHLLaO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 12 Aug 2017 07:30:14 -0400
Content-Disposition: inline
In-Reply-To: <CAFd5g45O7rJymFgnWj3SnSKhCvXoX4_xCO8FqeBFCe0-Du9AYg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Rick Altherr <raltherr@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Robi Buranyi <rburanyi@google.com>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


--dfq5twjtmfw3izn6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> That being said, I could implement this as a custom clock subclass, which
> would probably be cleaner that what I have done.

Shall I wait for that one or do you want this patch to be included?
I don't mind, your call here...


--dfq5twjtmfw3izn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmO5sUACgkQFA3kzBSg
KbYtYQ//YVHAHTJsF1rzm5WDWGLL+Uk4TEOdRPorqp2AxYnVEcMTzleESf02YxcG
N1aiweTaAf78m6fjFakG1iOX2ud6qRldr/RWw5LtoIW5JhXu5WXpDZ5bgg7NfUi+
shiiJ2QlNw8RTXgdvq3f7j/5PB03eImj4wnF/oL3AcTX/bSXm+RU36JBh6Grw8RA
eypNJyw78WTpnq5Dzn9XYGEcoRTJUyPTIYSPapIE5Vjvz13RKggnP5VZEV8+td1r
DK+i83g3SCWsc/+JqEfF8MO1KvPB0m23EfL8vfjERdKWWsayIfBhJFskYS/K7750
tGO50ZIUiRHTKBbkzq0msAlxxPE41HjiY2hP3gGRP/0ORMLRN0ahBVoDkA8D1wyQ
uszICZgb07T7utrfpfoGY3gybmihwdW19JBqJNhwSQAWBrjbKi+OUiG/oz+Dtefw
JkB4wl+G1EL6B2oPNYw/XmVZJcMpSC1ec05bFGg6t5/LYMVosV8dSow1JDW6ffxt
FLPtIRqbYaoyyWqXn5iGkb796A8ZlLKjPu5Hwz7ZK0ceSVqR6/w4k9ekA0z2dOba
Wx/Do25welfgVLjn0v9LH1z1rPzhUNMXvJzFyITBEmUkQaIeq3OnVwsPRSiBI3c/
EBvvvNIpoBJ7ZNW0J3+ot5gHXoJgvY91/6audsaBquZCulmlV7k=
=6hK4
-----END PGP SIGNATURE-----

--dfq5twjtmfw3izn6--
