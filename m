From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: New location for i2c-tools.git
Date: Thu, 23 Jun 2016 20:50:00 +0200
Message-ID: <20160623185000.GA1611@katana>
References: <1434710432-4182-2-git-send-email-wsa@the-dreams.de>
 <20160427173308.GN7946@pengutronix.de>
 <20160619195641.GD26875@pengutronix.de>
 <20160621111255.1a27363e@endymion>
 <20160622185252.5ecfdf1d@endymion>
 <20160623073249.GM26875@pengutronix.de>
 <CA+TH9VkztGak0FugD0zLgOigBope5pT4FheQJkqhvg3xrnUxcw@mail.gmail.com>
 <20160623115314.1e20f84f@endymion>
 <CA+TH9VkXPFBgAiLHwx+_B96RRYMmtG-Kc_5qN-0Ps6FceBrVhg@mail.gmail.com>
 <20160623194016.6d89dc01@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50085 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbcFWSuJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 23 Jun 2016 14:50:09 -0400
Content-Disposition: inline
In-Reply-To: <20160623194016.6d89dc01@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-i2c@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The only remaining problem is that some files have occurrences of $Id$,
> $Revision$ and $Date$, which SVN would replace on the fly but git does
> not. Not sure what to do with them, replace them with something git
> supports (not sure that exists?), or discard them.

Discard them, I'd say. You have all the history on your disk, so you
have all the information from there.


--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXbC9YAAoJEBQN5MwUoCm2McsQAKjBidIOdMlv/FYhzLzura0s
whlq8CV5drc1mM4EUPkZUdDGOgodWL8bozJS75/9yhEhpaYS3yo3PGzyf2FcKp8z
/Xjm8aQkrpy1QXWBliCexKaBQpx/+RR4iutOlIwbHXmMmtumZudQspcYIBs2hh5S
LeLtVlXrlApw9nIq9lDdUVEOyfKle/KFV/HD4zb7iEydbPwylShCJQSOVGuAF6Ni
Hq2Mri4yuDQGfHsjElVHq2/PLxhHByRIRTGdCA31R3jriEV5Dwl8nXlDEXHfRJwS
VFM1F25q5T81r8ZwVroVUNXnF8HmdexsF9abrN/TTgV1ggZdhzteVYeME9T9JA3e
Ryrg43q56NJwQHYDg16t35hu3bEvoQEoAFQdWP3PKm7bX6j8SP3DEeK4XgzSox3R
/IFNCWHdxWbaaDzGHir8lBakMKEZCi7cfjcJT8suFXVgiCcA3qok5/x9c1V1NLai
L7RkKcHMYoDtd5lOCX3V6GuUDLJg5BjD78V/aSjbk6DzND1/scdU+hciheC/1/Hq
KWWceWcy4FMrQLC4Tpvs0eCCg/8te3xWwxQbRw8AOOb2ne9hKY2q/odlF2XK/5k3
N/fHwrJKvFDh8rFkS9+nH07NS75+eUParDQNU80Zo9ZSP7Y8k7zd8LCdb/H8USrV
xOvkewxfCM8RPFKxHjdG
=ZCSO
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
