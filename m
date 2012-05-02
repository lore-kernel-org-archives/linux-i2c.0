From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/11] ASoC: fsl: add sgtl5000 clock
 support for imx-sgtl5000
Date: Wed, 2 May 2012 12:41:22 +0100
Message-ID: <20120502114121.GB5722@opensource.wolfsonmicro.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
	<1335510185-7906-4-git-send-email-richard.zhao@freescale.com>
	<20120501134446.GK2194@S2101-09.ap.freescale.net>
	<20120502105024.GC2982@b20223-02.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9206927077386281731=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120502105024.GC2982@b20223-02.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, w.sang@pengutronix.de, Richard Zhao <richard.zhao@linaro.org>, linux-i2c@vger.kernel.org, kernel@pengutronix.de, dan.j.williams@intel.com, Shawn Guo <shawn.guo@linaro.org>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============9206927077386281731==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 02, 2012 at 06:50:24PM +0800, Richard Zhao wrote:
> On Tue, May 01, 2012 at 09:44:48PM +0800, Shawn Guo wrote:

> > > +	data->codec_clk = clk_get(&codec_dev->dev, NULL);

> > It's a clock of sgtl5000 codec.  I feel it makes more sense to have
> > sgtl5000 device driver than machine driver to manage this clock.

> The ASoC machine driver handled the clock settings, I just followed the
> same way, using snd_soc_dai_set_sysclk to set codec clk. But what you
> said  is reasonable. I also find it's impossible to use devm_get_clk.

> Mark, do you suggest get clk in ASoC machine driver or in codec driver?

We generally try to keep the clock API out of CODEC drivers due to the
issues with the clock API that the generic implementation is intended to
help us solve.

The major problem here is that we can't rely on having the clock API
present at all on most platforms so as soon as we start adding clock
support into things we have to do a performance with HAVE_CLK which is
at best annoying.

There's also the fact that even if the clock API is available we've no
way to register a clock consistently and since the audio clock tree
often needs management off-SoC for at least some components when the
clock API is in use you end up having to handle clock trees that go into
and out of the clock API.

The upshot of this is that while we really should be using the clock API
for clocks the API as it stands is somewhat difficult to deploy in cross
platform code.  What I'd suggest is connecting the clock to the CODEC in
the device tree but actually doing the clk_get() in the machine driver.

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPoR1bAAoJEBus8iNuMP3dfsEP/36/N5r3RHV5ILM8aBPPCdMx
Gha4UlPOj6hyAs510E5z/ou1xCP6ik30mlArRn4jaFkeKfVubRA7QhYQJdw5NWEo
t92Mwx8R48HEreoCNvtW4pMsZC3d93Wr8wfZUGGtyKe0QGmGIWq1/of/C0iME7kQ
+0BCRauyt75P4vrYlFWoXNf/9+pauet7D2XZS2AC0cNURpszYjh52Twjlw7lCoMB
jc9o9tbLwz3G/oOzMYolmsxPiPKZZjqnp/e20Ybgkjr/fqZj/qTDJ2MdidE9aGyr
mfx/X2YWTt/dApiLIY3et2inhPcshp4EIhHauM9s/y18P4kFXTAAsgmDqEc/Vycf
7QN66YOmHouClSISi8m3R7AdAbmxQLYiArAd6KnA1+QEeLPqHOyVNql0Fk2J+T4k
SwQQHgSdpCwthTrbxAVPtYd+zJFxWQKy505XwAUa4eThEeDKTqdZirWzwKygSj7c
PruUSyInd5Auefre633wbsIsDcn0AkgMI/XWzdZZ34sDhoaBcuFhKhicwQcybbUm
lFM32/ZcIqCKMyX1aumHwMfV8nE0AnB+iQs1U4NuxCCKK2mu2y2bRs/EhFKXfSDY
YnVmYMJy4nqz/obUmZ0UqMit4b4j0j6g6zxYKsQmNXO5g3Qr5qmG0zJEjatMFE4o
kJB8KcGXUQw54Ntzv2ZK
=Gmuk
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--

--===============9206927077386281731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9206927077386281731==--
