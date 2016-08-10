From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/4] media: pci: netup_unidvb: don't print error when
 adding adapter fails
Date: Wed, 10 Aug 2016 16:56:56 +0200
Message-ID: <20160810145656.GD1607@katana>
References: <1470742517-12774-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470742517-12774-2-git-send-email-wsa-dev@sang-engineering.com>
 <CAK3bHNWmxQsAtefcUocoOcEwtWnpptiVxzhXR-+jVU524RmnPw@mail.gmail.com>
 <20160809145856.GC1666@katana>
 <CAK3bHNUL3NjFFex4US09ZnxvKV-1oJAu=qVrZUSgeKy90CBiAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OROCMA9jn6tkzFBc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK3bHNUL3NjFFex4US09ZnxvKV-1oJAu=qVrZUSgeKy90CBiAA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Abylay Ospan <aospan@netup.ru>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Sergey Kozlov <serjk@netup.ru>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media <linux-media@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> if we do not remove this it's also ok, right ? What the big deal to
> remove this type of messages (i'm just interested) ?

* Saving memory, especially at runtime.
* Giving consistent and precise error messages

This series is a first step of trying to move generic error messages
=66rom drivers to subsystem cores.


--OROCMA9jn6tkzFBc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXq0C4AAoJEBQN5MwUoCm209YP/jjuQcBKPDTSoGK0Oex4kpmD
Bp/EgNeFMyKvXpTMsIr+wrSBZ7mABF4/DU3+wvZ5MscrmJfQCcMRnUYOfj/f5ELL
nAdDKuXaucfH8FJFDFNxqf8A9jjH4sqk6uI0VbyMBgChiSKZqDlp5jNr/91w6bWa
alLTyFQa876q32krSiQssH2U6/siK7t7Qbcky9OlBqmbUIsUN0rn4eozoUgvxsY6
yZuPNxiPiwqiENmElGq7QguoFCEmS7D11/MVyjx/x9zs1BLaTgq12HWcUsmbzNWt
ZZeYRh5eA7JuhdDxEwYfkecJ5jMEOejlk1AZxUiI7FLNEck35yUb4COD/hGG7r1f
uz1aPqXnQ0vIaCA1yiWTPLGbqN2Fe4aQkTgm75ChF+h4H/F8QSc8XZfYTOKiecib
lS/7y/4O7svgWhMEAURCP4/uYx2hblVgosHbsZCXruCG3sEqK+bGNzwUD09zdVpe
wjyo5UiMyZm6F58cToa3YkUKAh5azm6vSuT6HlbdYtP9wicaZfUTxEUsDMxodVqg
lrNcMco7kPT7nNdqAPt982v5ua6nG/O+AgYxWf9VJUyMmii3BoRG0L6uLSnFWBJW
7GqJ+NstL5Xn/Nb0YCxGGG8bq9v+uiRIraDKsJdyNAtXPriu0XTKaC1pbO5BKXcv
ThlMFSgopJTwXq5PzOAk
=dlU7
-----END PGP SIGNATURE-----

--OROCMA9jn6tkzFBc--
