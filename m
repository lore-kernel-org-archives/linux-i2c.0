From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH 2/4] i2c: i2c-bcm-kona: Add support for high-speed
 mode
Date: Thu, 7 Nov 2013 21:13:32 +0100
Message-ID: <20131107201332.GA7119@katana>
References: <1381960909-1735-1-git-send-email-tim.kryger@linaro.org>
 <1381960909-1735-3-git-send-email-tim.kryger@linaro.org>
 <20131101130835.GC6734@katana>
 <CAAYSxhrrkSvOJpYPz7txVsot1you3fFzkXJ6fqaS4OgRM0Z2gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAYSxhrrkSvOJpYPz7txVsot1you3fFzkXJ6fqaS4OgRM0Z2gA@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tim Kryger <tim.kryger@linaro.org>
Cc: Christian Daudt <bcm@fixthebug.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, Device Tree List <devicetree@vger.kernel.org>, linux-doc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> While the bus speed property is really a configuration parameter (and
> not a true description of of the hardware) it seems improper to put
> driver specific details into the binding document.

OK. Then please change the error message for unsupported bus speeds to
contain the supported ones. I don't think it is good practice to force
users to look into the sourcecode to find this information.

Regards,

   Wolfram


--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSe/RsAAoJEBQN5MwUoCm27S8P/R9Qb0Ohol9Kl7vSPYcZ1kNZ
+I5P1jmHZkVFSzuJT+k8Brm40krLMmTOP+r9yVvhFVVF7kc9Ul0/UNOjPCJITxTf
xd6xl3UAkBc65Wc27Ox584QOVRlIKAZ+rTkCXGXNYnKQi4asRSr076dX4Cy+sfxV
bqTPMk1p8qFO8d9iUTe9DYhMAktzDXmSrC9eIKB11TB6YA1k0txyjpGNnM1oxGTQ
D9DPk0ZBpSH9bBdMOxH+QZeukcLECrsjSm283+BmjZlulWYDe/lir+T8w5FHQ6A+
LvUmLPhX+W3dBMR0dVDfaPHiaft75qQGIgUSu8b9XitDxHchNfPSKt6USKShnES0
s80MKbIh/U/9zreBXqZOPTap3318Bp7D3rqoZMN8q53uPdyjYoGyEXXEHlX25IKx
7kc/lOZ/3tlLs760Kt0W52CP9M7iha7J6CS8AEKLewsMw2/KswMft7CTJM6vbftt
Uw8fHuv1XXRa90pHPp+coPR+VZvtJMr4wWnvdbESpjxF2caGvwnaE1X5rO9qhjgD
ROyPw7gx6625Rn2w1WzFlMyPQQxfTnjDGdlsFlRhoKuDRT685Yw3LeGixP8GF2i0
yEXhsRijtasrvvwqemgqvjZ5pXNpt3nijg1sfTW2Q3juXW7/KBtHGxfXzEPqDk81
0e7TKB+70pUIYT0KtcG9
=s0Qd
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
