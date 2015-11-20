From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: core: fix wakeup irq parsing
Date: Fri, 20 Nov 2015 16:19:05 +0100
Message-ID: <20151120151904.GE1752@katana>
References: <1447335746-11114-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59857 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760609AbbKTPTI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 20 Nov 2015 10:19:08 -0500
Content-Disposition: inline
In-Reply-To: <1447335746-11114-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, "# v4 . 3" <stable@vger.kernel.org>


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2015 at 03:42:26PM +0200, Grygorii Strashko wrote:
> This patch fixes obvious copy-past error in wake up irq parsing
> code which leads to the fact that dev_pm_set_wake_irq() will
> be called with wrong IRQ number when "wakeup" IRQ is not
> defined in DT.
>=20
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: <stable@vger.kernel.org> # v4.3
> Fixes: 3fffd1283927 ("i2c: allow specifying separate wakeup interrupt in =
device tree")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applied to for-current, thanks!


--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWTznoAAoJEBQN5MwUoCm2sLkP/jrmUwXLdFafMVNH39k8v9ue
7pdABYWpm4GscZQKlChWvnMPXw7ULaYJnCi0kAp68Mwx5CR3Wc27deEXZ3a4IYbB
mfwUEXFJ2A/SOQRK6ptkbG0c7TEQkr2rjszgP4CaKnSCg3Veq+FnJVgJMm6CaSgd
8lQ/OI3+dazvuvC9ZkJg4hzUdMF+15/C0CfEXuH7GTP9F7REbCLKJiCNg23cwtmx
sRW8XvsscfRoIif4PPqSw3gmW/ruPGkBJI137WFpepDVHDA8yFgp0rlRPWVdEGKE
bSk9u3PMWmbD9i3R6f3j9dhQPUPI6pTUO27yPYyDuVmM2dvHxpDZQGH7yqPrkyGm
oliqepW0iO94SIHrp/EJrLVGHrxvWTFJA/sHlporz5dpBFUUBE5ChpgiE7OSXUr3
XkF9GPSzjAjRWtAy2VTRQChQp3IuzRHHZyqk70y2+KD5ujOutLHqWdD3M6Iuq8Li
wshwfRZ3nm0EM00VdbgIn5Hc8KzRM+CF0HsBVNmN4eswNPZI8ztt+gJhTO/hLXbN
trGlwPGuIc1cK24Sf4ebgUt/iW7IV+Fv1OhtWg6gg1UrlK0g6mADop0drsutkPbB
dXN6ZJOyEEn/Qer3LGT6WptkvBoP2DFs5H05mfrgwxKsAQR4hpn9za9xdcht/4eJ
cParofwJ3uzPijVMs2Zj
=LabC
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--
