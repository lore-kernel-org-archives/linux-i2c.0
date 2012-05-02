From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/11] ASoC: fsl: add sgtl5000 clock
 support for imx-sgtl5000
Date: Wed, 2 May 2012 13:22:29 +0100
Message-ID: <20120502122228.GC5722@opensource.wolfsonmicro.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
	<1335510185-7906-4-git-send-email-richard.zhao@freescale.com>
	<20120501134446.GK2194@S2101-09.ap.freescale.net>
	<20120502105024.GC2982@b20223-02.ap.freescale.net>
	<20120502114121.GB5722@opensource.wolfsonmicro.com>
	<20120502121222.GZ2194@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7087713863392230691=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120502121222.GZ2194@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, w.sang@pengutronix.de, Richard Zhao <richard.zhao@linaro.org>, Richard Zhao <richard.zhao@freescale.com>, linux-i2c@vger.kernel.org, kernel@pengutronix.de, dan.j.williams@intel.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============7087713863392230691==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 02, 2012 at 08:12:24PM +0800, Shawn Guo wrote:
> On Wed, May 02, 2012 at 12:41:22PM +0100, Mark Brown wrote:

> > The major problem here is that we can't rely on having the clock API
> > present at all on most platforms so as soon as we start adding clock
> > support into things we have to do a performance with HAVE_CLK which is
> > at best annoying.

> Is this something that the series below tries to solve?

> http://thread.gmane.org/gmane.linux.ports.arm.kernel/163652

Well, it helps building but that's only part of the issue - we've still
got registration problems and if we were using the API in anger we would
need things like clk_set_rate() to actually work.  It's not just a case
of simply enabling and disabling clocks (which can be stubbed out pretty
effectively), audio generally needs to manage the clock rates too.

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPoSb9AAoJEBus8iNuMP3dw8cP+wQYrFWQa016n6OjSoxu4YFi
DlHmPcvkLurUZN3WCcOo9itmjAaIFuyXJS0gkAC9UCAL58wgFnTqaMikApmUddzu
+HL+N0VduyZ0eLhe2ukl3jvPePPeN4EFBe0kp8Dk9d/BwgRn6wqu9w3RdyO4VTb0
naaAP9w69/qf8iJIXSfD42nmM5ztX5cR8ur234PaPW+dlmcjdF/cOhX17UsEYVAx
GHTfqoul3fFW4VAcVN8BITRMTWqQlDIrCypPCoCh2VZDjpbZKNtQq14C9ypcyAdt
RCET5PJBpgCWZDUTpXCwE+glxH/vCwz+LxKLsa2BKR1QHr8ojZaNcwQ+nGRh2/h+
MLd9M1/j6VPb8x3TLDZw+JZbEymjhWpZMzJ0ZpITbopdkyxlU5i+nVQkKtPqu1V9
IKrgCYqDkhmJUzN/qXYF5Pz5pWXAQ2aLwmsmVY0mcw//1HsJV5vpM95E5VSOGpiQ
0ldmIqxCPgpzj3ak0JQ58gVpIvmJtyiTbSFL+uFVayVYwC923dk21DBSOcE/ZM1p
140kYJP3UCvJMF/PmeH7/yfQtakQKCF2FdSfs6soaFNmcLgQxc+CGo4aGgLJOyBx
F5zrtrw5ZS+yo4kk0oO+s5wXFhPyVrUaiA+jF3zCiNoSFw2zoGF8z1NNjpMtcO95
LL/4i6Fs6UT4s0xGhnaN
=rtNH
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--

--===============7087713863392230691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7087713863392230691==--
