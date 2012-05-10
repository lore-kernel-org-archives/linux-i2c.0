From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 03/11] ASoC: imx-audmux: add pinctrl
	support
Date: Thu, 10 May 2012 09:44:04 +0100
Message-ID: <20120510084403.GA3908@opensource.wolfsonmicro.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
	<1336563190-19974-4-git-send-email-richard.zhao@freescale.com>
	<20120509160005.GG3955@opensource.wolfsonmicro.com>
	<20120510003532.GG2982@b20223-02.ap.freescale.net>
	<20120510063904.GB17875@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6728817901696534201=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120510063904.GB17875@S2101-09.ap.freescale.net>
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
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, vinod.koul@intel.com, w.sang@pengutronix.de, timur@freescale.com, Richard Zhao <richard.zhao@freescale.com>, linux-i2c@vger.kernel.org, kernel@pengutronix.de, dan.j.williams@intel.com, dong.aisheng@linaro.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============6728817901696534201==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 10, 2012 at 02:39:06PM +0800, Shawn Guo wrote:
> On Thu, May 10, 2012 at 08:35:33AM +0800, Richard Zhao wrote:

> > It's based on your for-next. But for working, it depends on
> > pinctl/for-next.

> Mark, may I have your ack to have it go through arm-soc?  I will ask
> Arnd pull your sound/for-v3.5 branch into arm-soc as a dependency.
> You need to ensure the branch will not be rebased.

for-3.5 is the entire undifferentiated blob of ASoC stuff, it's not
really suitable for merging elsewhere.  It won't actually get rebased
but the idea of merging it into other trees doesn't seem terribly
clever, it'd make having topic branches in arm-soc a bit of a joke and
if you pull it right now you'll get problems in -next due to the the
ux500 stuff.

What does "working" mean in this context - what happens without the
pinctl changes?

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPq3/LAAoJEBus8iNuMP3dsgkP/0kU/TSaTg/EhmVlhG8Fj1Ik
wpHwLCMjYTxEWO0eWO/cbKwGZonM7YMSKMox66tG63J6acFBCLO3taNVP8dGLAp4
P+JiJos65ZG3Z6V2cUgyMHgFXpYZ5z/Nc9Ak/YRfwutBHsywSWxq3uWzi4SwuhC/
Rxap3yRegqbXsQzXcsZ5MWNSBSfjyQFRNEshlvs9L/+XRg9aFSEgL3qtf1aWt9Tx
vAc8U20osoOwMe4mrQi8OanG/XiWe0PlOO4AiGNWJkuRD3PnxEN/jcNfAiplUGVT
HzwqX3VT5e0CXzSWa/E+1ifZ/sO+g3XBXc4M7k14x/8bO/XSVZeuHFiuWD3IPwGh
7QR59kMqSLKiwUlZ6SEzE9uJBBFZiD7sKyKE6nAmSq28wVBE1IWATWdHwTBWRdvk
IaYmqCPLqY8M3eQcE+kkOguA4lCJnynneVtDK+ZYAID68bpH7We8RC13N5IpaHVr
CS4T+SFBFtn9TAZBk6PJrmZuVnaxDs6iufwABbYEJG56FcR8dL5hD3bdyTEJFExF
tHqWzqaewa0j/M8WWwnt24Cl2W+TNGf5UZ+wJT1hHYJeRDCd+kKwgzQRAvXa94YK
s/ce2sXhQpE7H4KWRtkUfX4KcKFye76aC9vjzGtBuBZ+TzebWnxZUyaFP0QH8zbz
mNhV9H1D5jReTlwcTgRh
=B+3U
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--

--===============6728817901696534201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6728817901696534201==--
