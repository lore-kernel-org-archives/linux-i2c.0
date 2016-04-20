From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 10/19] i2c: octeon: Add support for cn78xx chips
Date: Wed, 20 Apr 2016 23:52:19 +0200
Message-ID: <20160420215218.GE1546@katana>
References: <cover.1460387640.git.jglauber@cavium.com>
 <878b7035b447b6700abc7ec79c375df090067ebc.1460387640.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hK8Uo4Yp55NZU70L"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45908 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179AbcDTVwX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 20 Apr 2016 17:52:23 -0400
Content-Disposition: inline
In-Reply-To: <878b7035b447b6700abc7ec79c375df090067ebc.1460387640.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, David Daney <david.daney@cavium.com>


--hK8Uo4Yp55NZU70L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2016 at 05:28:41PM +0200, Jan Glauber wrote:
> From: David Daney <david.daney@cavium.com>
>=20
> cn78xx has a different interrupt architecture, so we have to manage
> the interrupts differently.

I'd appreciate if you could explain here why interrupts use NOAUTOEN and
have to be manually en-/disabled? This is surely unusual.

>=20
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>  drivers/i2c/busses/i2c-octeon.c | 131 ++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 120 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-oct=
eon.c
> index 0bb9f0b..fff1ac0 100644
> --- a/drivers/i2c/busses/i2c-octeon.c
> +++ b/drivers/i2c/busses/i2c-octeon.c
> @@ -11,6 +11,7 @@
>   * warranty of any kind, whether express or implied.
>   */
> =20
> +#include <linux/atomic.h>
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -112,11 +113,18 @@ struct octeon_i2c {
>  	wait_queue_head_t queue;
>  	struct i2c_adapter adap;
>  	int irq;
> +	int hlc_irq;		/* For cn7890 only */
>  	u32 twsi_freq;
>  	int sys_freq;
>  	void __iomem *twsi_base;
>  	struct device *dev;
>  	bool hlc_enabled;
> +	void (*int_en)(struct octeon_i2c *);
> +	void (*int_dis)(struct octeon_i2c *);
> +	void (*hlc_int_en)(struct octeon_i2c *);
> +	void (*hlc_int_dis)(struct octeon_i2c *);

I'd prefer having 'enable' and 'disable' written out, but I leave that
to you.

> +	atomic_t int_en_cnt;
> +	atomic_t hlc_int_en_cnt;
>  };
> =20

--hK8Uo4Yp55NZU70L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXF/oSAAoJEBQN5MwUoCm2j2IP/RYQW1jgsemC6sWog/05VmC2
4weTScFqjIjjIEtXs6jrCcs0jWqKhtukXGla3SLYGKIPZG/h3I6R2FxsFtg5AQzE
RLq74pdE2RDheW9VnknORslfIkcEV0NHjDzSJJtIz237yaMBw0HYKQ4sE2u1mseE
PraqZH+jJ/pm8YT93wQ0tvumg8lilj2V8aQKWU+XPzBsRJRTPH+pMRTkm+DMJU8s
d2uoW87lVOSk0g99q7wxJs6Ahxy/khnBmNZaqgQOfP1gypJpVqlkmIy3kywaLmtR
yWu92oCRXgcaP2G2vCNbkkqX+wyKxBLh6gX86poXSa8Pv7uRZAh0hOWnNPJkF80h
ViLV6p5jJM+LNFEEqq2w+sOu/yMmnjiSSK+xjSw+hzi3OTrFz6jhpftWUIRFg1F2
Mt7WCg7hubPZUM2N1AIWGpCdPWXfIGxtVIOVtI5Io39ZsvSMcuKfBi/bcGiQY1f+
h5GJt5R4ZUpCIs6Z92Ce3OrAhWdN41vCRCk4z55ek5x84PyqndhnJ2KtKGPDmwjS
ykxM5/hTZkpGH1EhkvKL2uPqAiMtckLXwAeypUiPN06Ky2G/+TRF7LM2iFtSP70/
V7a4wGtK4Ggdx+b1JywwGDx1UcfiBtqNqelU/tr6VIlom3HNRBPF060lImMndTzk
/7jFPQXTj/It66xnl90v
=A9GM
-----END PGP SIGNATURE-----

--hK8Uo4Yp55NZU70L--
