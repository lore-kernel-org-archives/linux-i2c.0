From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-imx: Use correct function to write to register
Date: Mon, 19 Jun 2017 16:46:01 +0200
Message-ID: <20170619144601.vhswaa27f5mcxcxs@ninjato>
References: <681500CE65202E47A192754B01DAB4671B16747E36@SDE12.beckipc.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rcjwvwzvgunqvbsb"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:53569 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750761AbdFSOqD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 19 Jun 2017 10:46:03 -0400
Content-Disposition: inline
In-Reply-To: <681500CE65202E47A192754B01DAB4671B16747E36@SDE12.beckipc.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Michail Georgios Etairidis <m.etairidis@beck-ipc.com>
Cc: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>


--rcjwvwzvgunqvbsb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 09, 2017 at 03:28:12PM +0200, Michail Georgios Etairidis wrote:

> The i2c-imx driver incorrectly uses readb()/writeb() to read and write
> to the appropriate registers when performing a repeated start. The
> appropriate imx_i2c_read_reg()/imx_i2c_write_reg() functions should be
> used instead. Performing a repeated start results in a kernel panic.

On what platform? It has a different regshift, I assume. Anyone from PTX
or Freescale can confirm?

> I am resubmitting this patch as the previous one was erroneous. This
> patch is based on the current upstream kernel code.

There is no Signed-off-by. I need that. Read
Documentation/process/submit-checklist.rst if you don't know about it
yet.


--rcjwvwzvgunqvbsb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllH46UACgkQFA3kzBSg
KbbidRAAtPwu1GDZB7YC4HK0/mYhmpBSZTgMfjC/24YptDHQeB815iaI156hg0ta
TVM7oXFPgUKw1LRyZcrdN/g/eG1K3/ZXxNubgs0g0ZuzKqTnT2/12TdAE6xKg8vL
7hIuG42JkxLcGTkI8wC4ZCaND+EI+lawCcyTHyPScl7xQePP5sV8oGzr+CWeZpso
CU1Z0BXZThbNBrD4qp08ZJAGcDlSVmP26NnA1s4o8JbT0NieRIdEnzbIZD0N/ftd
NfBjBFAgk+4cGNrpz3xivbKsZGtpd39xRWEHZ7F+XIhC/AyWsESTz/bkLNr1LTkI
FLqFLOO/cLzth5CSUjj7Ivns3VDKb4VIu3LQxreYWSaJ9I187ZiGvpI01vTJ0K6W
pSNvL0BEl3wGqk8pJrZFLAD5OwkYT5DTL0n2b8sLuGUcBRL+53rFf4H0TmLgF1KO
b+6vXUG3wM9jg96iVo4Sk+6QwVuT6ffV7m5HNcBoUNUI+k+rstFDN1KAhh86sBYf
XYEYGhMcYa7lRXoZ05gExKJDbG5o2bhwmVBLI1/PS5THJ6u7KA+CvOCLZrUkSXmD
dCur+Dj00Yt6gi7afyv9VipUebIL8f8tiHFQoYZY0Wca/Nwy02t5ZLDhCJd9Ii9K
okB3dEHXUeUvRfpSQgDJ/D8zbtZ45uFcelCU8U6uVAqmaKbVanY=
=PK4/
-----END PGP SIGNATURE-----

--rcjwvwzvgunqvbsb--
