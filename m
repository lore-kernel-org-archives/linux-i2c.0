From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/2] i2c: octeon: thunderx: Check bus state before
 starting a transaction
Date: Sat, 24 Sep 2016 11:24:19 +0200
Message-ID: <20160924092418.GG1434@katana>
References: <cover.1474565039.git.jglauber@cavium.com>
 <ccf553c14d5220f3f9233ac7695d27ee0d55bcc7.1474565039.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BzCohdixPhurzSK4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58933 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761714AbcIXJYZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 24 Sep 2016 05:24:25 -0400
Content-Disposition: inline
In-Reply-To: <ccf553c14d5220f3f9233ac7695d27ee0d55bcc7.1474565039.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Dmitry Bazhenov <dmitry.bazhenov@auriga.com>


--BzCohdixPhurzSK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2016 at 11:40:38AM +0200, Jan Glauber wrote:
> Add an additional status check before starting a transaction. If the
> check fails wait for some time to tolerate multi-master mode. After the
> timeout expires trigger the recovery.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Need to think more about it, needs to wait for next cycle.


--BzCohdixPhurzSK4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5kZCAAoJEBQN5MwUoCm2mMUQAJ7Ll1fSzxKnO1Dqnw+kP7gN
14r7//IB8E1Vyd3xWA5MLOgTC1a/KO77qSXIR6jSdbHky7jtZS5UKoADR299dYF1
ndST3grV2axwETS8W4FlVohq+UQkieqCjQTwrQeU5brUVMozufKRaP7/GIR53BYu
2B3Qus1PBnOyORR0TLBAggOorcEF+xP5cyAY2/NeowtTpKAsdBnN8aWBmur+fBac
CZDM5voBplmXmp6N2EyWSyQOKIcOQf4nof851ksEoK3YgR9KzOpEaM5sO+YddxZD
7cJ5nJ6LtW9JVT3XdPAwRg969bpTkp5yIdpE3IDvNax9MlekgfkLsDL/Sj99vss2
kElk+K+AUsZqWl3Os+keIqWomD860QEFBFKah9if2m3jR7DNWxdt/pjLZsL4R9yk
CVoXwduUX7F990q1tPfzdW+44NUNGHkHhw2FuNVB4aa2NqytWcryAxjMBVmlsvBu
yI8vnRMdWtgjFTx8h2eyFrhImue+bAtPhSYz7D2xcMQujeUpn5cFCGXr8ySZRef6
uK02QwOnG0OEXO8CjmqmsXkJ4ghjhyO7MV8UW62S+dEs7VH4q9wNbC7PDYTzUG2u
aJVv8bfexZfSa6SxPzs9GBcxN3p6VIw4QSG4WoakS1ZzEv+BxJ85Oo9xepuP+gFT
hZnhz9Ipe2Sexgu8eieN
=th27
-----END PGP SIGNATURE-----

--BzCohdixPhurzSK4--
