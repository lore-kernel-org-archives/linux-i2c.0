From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: piix4: Avoid race conditions with IMC
Date: Thu, 12 Jan 2017 21:27:01 +0100
Message-ID: <20170112202701.GA1527@katana>
References: <20170111091144.6881-1-ricardo.ribalda@gmail.com>
 <CAHp75VeV2TfgfaYni7oS4ax4H87euJa9ReWX+vYjZ4b5nYRsMg@mail.gmail.com>
 <20170112192908.zvi7puq72rnfcj6j@ninjato>
 <CAHp75VfiwtAY6=9-Pz-NNzcYaJaHmxAB3vacMB=XMwb5wFLBkg@mail.gmail.com>
 <20170112195424.mprdpyjscnj6vq6j@ninjato>
 <CAPybu_36pu5SDhcxnqmFwviQ4NiEH9cAx0mr7bUF6_oaGfL_Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:59256 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750834AbdALU1E (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 12 Jan 2017 15:27:04 -0500
Content-Disposition: inline
In-Reply-To: <CAPybu_36pu5SDhcxnqmFwviQ4NiEH9cAx0mr7bUF6_oaGfL_Mg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I still believe that we miss a Credit-to: or Co-author: tag ;). Most

Co-author is just a second signed-off (in my book at least).

> times we do not give enough credit to the hardware engineers.

True. Yet again, I'd favor simply multiple SoB here.

> Thanks all of you for your fast review!

You are welcome!


--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYd+aUAAoJEBQN5MwUoCm2RsQP/jlWiAmyPPDK2I+Xs4BxCH73
pjG+ut5V0O+3+a1q+dqoGycbT324991O6iyZdEev1rQiubr/29GGUbufte0p0P9s
7b8LU+FsQ2sajwJ0/g2MJffD8n6yHiCEIqjRpPGEtm4KWh2K3ey9nTL463jJCO//
Z6KkUWAfMaK66aH9E4bd8aCyekgHlEeLveABiMTqhE4u4EYczn4/t5nSWtdDtNtE
XLXOTpSJcSi56nfo0UufxW0UiS5b/NjMeyGqULxLfEkHraNzN1ibjVWQdXI5ahMt
yMz4pGbMIoMmLN3BAGvltca+Ps8p2Q5drxLI0kNvrBCJPQUXuIgT7ZqpDr7+Ku2p
j4YueeQZSuWqOXQwjEaSyzDfn7IIRCmQHdfUvdaObOydcLLZvFioeMRjqGjeV+G6
ILzCbNOMxAJYyb6f/9KbGsGzxp6w26BBSFr2PgnxbkDdJReCedUW+KOVWFRegIFk
r/eJvnKpR1RQoswKshejRIiwIupMCKSkfkGy2tD/xHkLCa+WeoZFMFLvj3j3Wy8v
su8YV6ZaRqzgAV1tI/AZDl3J7uCWR0hI6DDtaPBdBpoaKYpZGdxviSKLcGfgjrN3
xRMCDdlitYiQAA+CDFB8FNSPT1vTmr+bwqUFDNEy+eXviTlFck8WmiZh4/vE90E0
N4UKRrd8UNCfBjaT5i01
=4gQp
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
