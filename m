From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] i2c: meson: add gxbb compatible string
Date: Sat, 24 Sep 2016 01:26:42 +0200
Message-ID: <20160923232641.GB5683@katana>
References: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
 <20160915194146.GB7863@katana>
 <CAL_JsqKNFzo6RWJO5WOvsyO3e4UTo5Zn48aaDac=+uL_CQWerQ@mail.gmail.com>
 <20160923221312.GA5683@katana>
 <CAL_JsqKi9Dk5-nF9xFD-89TTUinaGjMv5s1=N2b-Xyu98b+S3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56069 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752017AbcIWX0t (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 23 Sep 2016 19:26:49 -0400
Content-Disposition: inline
In-Reply-To: <CAL_JsqKi9Dk5-nF9xFD-89TTUinaGjMv5s1=N2b-Xyu98b+S3w@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I intentionally don't ask people to send me the patches squashed. So,
> > you will have them seperate in patchwork et al. I only squash them just
> > before commiting to my tree. That's because I found that when digging
> > through git history, it is much more convenient to have all the
> > information in one commit.
>=20
> If git history was the only thing that mattered, then that would be
> fine. But it is not. Maintainers should apply what's on the list.
> Period.

Huh? If you would *ask* me to stop squashing, I am listening to reasons.
If you want to force arbitrary rules on me, I am not. There are reasons
where squashing/modifying patches makes more sense compared to forcing
the author to resend. DTS bindings may not be one, we can discuss that.
But that rule without allowing exceptions seems impractical to me.


--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5boxAAoJEBQN5MwUoCm2HBQP/Agwbei8uHzkJwmNoH7cGrS5
gUA3avuq40s8cKwOa/64zjSfPY0vPkwrvaw75OKqM1fIj2Bm316zwG6/6n3C5cvO
s7D0m76j+7++HP/FA3N8awWDWlDSgB6trgavBOdBd2YXGJXMUh2JOuJgndP0D8YI
6WyPr/d7ksypAWrTI9TnO0IVDtJoNvvgqe+Rf6viCmPgKPUFgE/w2XjKPvjVHG/t
hlKO0fvfLw7q4VFtPro2VLFiz/RDS3uC1yaZmhRqIqDNeFkMJsWJFxQ3Bc5SPoDi
X7b3DwHnUHnIqf76urS+pV8ATfyt0ylH1sHWvycI0EP+lk8FcXB+mOOdu/bvb4Nq
7236laSLCnszkb+vtyOtG0hEonFk9qak8cFvi2E6Km991CMoxbME+09VAAQKAsTe
c8a+hqJZsXHGWm6Atf5/IKbH0Jc8+uMmMORcmStcLuIl79JX5vbH9a7eS/8p62Jo
uQDCLSbjUDx18qEag/5brfEzLhtjMsF8lMK8vPp0580WLdqbkt7Mbrd7Qq3wgKoG
HSZHhTh2re9DvnRDrgnBJh0Y4QoEvSTUFVPdm1Ek+UVfJLUiDqvZwg9/P/AKVwDM
Vv+Oke1HsZAq02tqAGLoQ9+9zrEQ9aU1QFKWbs4WvS3YWqazRCSqGzDE08fblhwo
6dqATNoX8rnIZi3HTLh6
=vfkI
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
