From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] i2c-cht-wc: Workaround CHT GPIO controller IRQ issues
Date: Thu, 17 Aug 2017 18:16:20 +0200
Message-ID: <20170817161620.fsvxtfkq76avjdyr@ninjato>
References: <20170814201726.21045-1-hdegoede@redhat.com>
 <20170814201726.21045-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qgm5gcszoimrdcdo"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:60363 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752647AbdHQQQW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Aug 2017 12:16:22 -0400
Content-Disposition: inline
In-Reply-To: <20170814201726.21045-4-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org


--qgm5gcszoimrdcdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 10:17:26PM +0200, Hans de Goede wrote:
> The Cherry Trail Whiskey Cove PMIC's IRQ line is attached to one of
> the GPIOs of the Cherry Trail SoC. The CHT GPIO controller sometimes
> fails to deliver IRQs (seen when there is an IRQ storm on another pin).
>=20
> This commit works around this by reducing the long timeout which was
> a poor attempt to workaround this from 3s to 30ms and after that
> manually checking the status register for transfer completion by
> calling the threaded IRQ handler directly.
>=20
> This is safe todo as the entire threaded IRQ handler is protected
> by a mutex.
>=20
> Note 30ms should be more then long enough, at 100KHz any smbus single
> byte transaction should be finished in 4ms.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-next, thanks!


--qgm5gcszoimrdcdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmVwVQACgkQFA3kzBSg
KbZ40hAAo8FXbcY3FfnFwcD8B6m524NH54Eru9bzcT+5t7IcKvWs/bevfLH1jTJ8
K68/nZUUvorA1akuLUjKmTe62rnJt4T7sUtxuKFaqOVscpeW9UIgPLhCQ0sTxjUU
n/6gv5q0G/55zoWCw8ugArrxt/luEaOq8nK3CPEVmGPApLfwW+2FLFfKNpdS2Z7O
9Ri6L1QNrL4tL3yiusKd19r3a2crlkq9ze6i7vevstiPqgfxlRbb3kUDG43lwztb
iszexgAIZ0JpLFLSMMpUCkaAFWG2aHg8UwZMy+sCB5uai5FAOc0ZooggbxVqXx0Z
76Ok94HOQAWwMO0F5DfSbtRyURmPsnemV6FZndn+S1gLKnYphKq9VOBVBMp/L28/
8fP0JlijZGCghFKC8qd3sR4YnwLWJe44GVFK9CQ7ilHtl7FqmStgh8611ZkrLZmO
+KmKHfC/a7uxgJhzK7WDKRBzRdN1rnhoAwx90ISoL40yeoKnQ9E1RREKeOxNiw9L
uJMPFUWRuomrE7W7jjVcHyXGksNB0wV8U21w9zmqVRA0oGkKuKCzD9X7Q4puQarc
3NYwU+PaqjnO87kENX0VHMNhz3iQexc6GuWYBy+hJYKuBKrVmU2NR5kIxwl+GNTG
82nqRtmgESp95Mxrsowiaf5OOwoYN8O20wr7mrRL1Clf5Pc+Bro=
=xe0t
-----END PGP SIGNATURE-----

--qgm5gcszoimrdcdo--
