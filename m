From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: xgene-slimpro: Add ACPI support by using PCC
 mailbox
Date: Fri, 21 Apr 2017 08:31:57 +0200
Message-ID: <20170421063156.GB1434@katana>
References: <1490733977-23760-1-git-send-email-hotran@apm.com>
 <1490733977-23760-3-git-send-email-hotran@apm.com>
 <20170420080552.7hymw4gqy4kzecns@ninjato>
 <CAFHUOYxfivQ6kQwBwyX5X8QESbCFo4E_KM5iFHyjuChtTZq+uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:41656 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1035679AbdDUGb7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 21 Apr 2017 02:31:59 -0400
Content-Disposition: inline
In-Reply-To: <CAFHUOYxfivQ6kQwBwyX5X8QESbCFo4E_KM5iFHyjuChtTZq+uQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Loc Ho <lho@apm.com>, Keyur Chudgar <kchudgar@apm.com>


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I think it doesn't make sense to print a dev_err and return ENODEV which
> > is treated by the driver core as a non-error. It means "not present, but
> > OK". You probably want other error codes here.
>=20
> How about -EINVAL for these -ENODEV error codes? Do you have any suggesti=
on?

-EINVAL will do, I would go for -ENOENT, probably. But it doesn't matter
much.


--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY+adcAAoJEBQN5MwUoCm2lg4P/3WLA0g8Ar56Dx+9X2QEhjyS
+MfIJXffWElGG4OXEFonIfq+ayPRV8ejdsHyJQxzYTm+R0kmIFNNULllcVo7d5Ft
sFdXnPBAur0H4vptG6CmEXzgdPln4GQTsmvjl84F0CwUMX/yc+5nhCbNCFIpWRJ9
wIZVXL+wnO0eDbNKMbuDEyN1mFLs7ZO2pCM//N0R2U49xk8bW2g1veQNj7yBN+4/
PjEzNkCYVhH89Nsi6whzq/D1BqYURWwUYHouPoJj7QWoU1wCleWM5VatrdCcJaTW
AXwB/I34GpktLMo9Mgj66+JCKqgAb59fgKqGEylO78SDZ6QimTrrOGQ1axqLBb1T
CpdtkXQDURKQWHqeN4Zs+E1mC6t1dM4LWm82LetO5vYClYvxMGA+GvRFXw3xmOJl
Smq8K2lO1E8Bf2kdhnjHjWHo7yTZOZSQbLBVvEYStvTXX98lo6TKgaM8kIg71Lwa
9OqnwRtSG0ovRVuwIVJlHw60Q3K2OOtzcQ7xb2BKdn0ptorL2BJpxManiKeYb6U1
d88RTew5H3vWNibNihMSODqN2QIy8aK31oUNoJtTU04tSStn2k3cSijYx/BqG+4O
nqJR1hVfnCJInnwQwke1IzcMA1UohfCbQskswaHlRGcUmzfkIGME21IFuCQEwoLl
mKRX8zbrLfrsCbHPuetW
=DWPq
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
