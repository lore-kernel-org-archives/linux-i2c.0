From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH V2 06/11] ASoC: fsl_ssi: convert to use devm_clk_get
Date: Wed, 9 May 2012 12:50:42 +0100
Message-ID: <20120509115041.GM3955@opensource.wolfsonmicro.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-7-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6CiRFyVmOOJ3DkBX"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1336563190-19974-7-git-send-email-richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--6CiRFyVmOOJ3DkBX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2012 at 07:33:05PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

I'll apply this when devm_clk_get() makes it into mainline (hopefully in
the merge window); please remind me if I forget.

--6CiRFyVmOOJ3DkBX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqloLAAoJEBus8iNuMP3dkSgP/3SyySK1CCEsK3OxyW1HMqke
fclt/HC/JvfwXDSRfryw59zy7YXJlRHluDg4F1voYMaSeN7AgjpFSUeP/zVxkqET
3mcOu086xXFKqI/FpsKe65+sb0uw16CziX6brJHjQxK1svdckyAa7aOCWk1P3uqQ
c4PQelQtxkOKZLlGhlD6CxE+1kX0Y5CpcBJ3/bBeoX2gz+M9UG0nzpeRrbzUZ0RD
WHwoW/O012r78qZP99/20Nx4DbCrWvXPmbUb6yeeooaCPP+UT3AV0yr311lvDqdR
UkEy04XV8MZqYg5hjNCmDDaSawcwW/EK0rGP0Kghq9UhHIR3PliYKUINwAR5HYMa
KILeBcny5WZiubhC7QTMoMBgq8cTMFKeNhtjB/eGL/m/6828wkeiEXxrXd3Xakg0
jJaHB2H/iXvTtAoPhk+lWqp2xjpfRrl6QW0rdYAtWFqjQgDx+Apj5PTgpmfPtWdb
WAnlKamYWpfG0THq5wn00/dOBNl2BtGJ7lcXQVwpFaW9BcsKbNYyQXjXi1oTh2hb
YFM0sPaGAfssHK+rLfJax7lp74VjEBTbXgKAvUv58Sst/H6EdQ8AYGwDtgjGVQNe
eXGmQ+y+PzloiCWMuaMA7imjs2tU1dfKoa2VtFwru9OUciJbG4tvtq6VtivEm1dY
rV0PvITb8a7J9buPrsdk
=82c0
-----END PGP SIGNATURE-----

--6CiRFyVmOOJ3DkBX--
