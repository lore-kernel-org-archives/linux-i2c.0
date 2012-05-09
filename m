From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH V2 06/11] ASoC: fsl_ssi: convert to use devm_clk_get
Date: Wed, 9 May 2012 13:01:57 +0100
Message-ID: <20120509120156.GP3955@opensource.wolfsonmicro.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-7-git-send-email-richard.zhao@freescale.com>
 <20120509115041.GM3955@opensource.wolfsonmicro.com>
 <CAAQ0ZWSiRysfkUnu2ZoDXFtiJz-nfrQ-DTKOgCpKpCe5LpQj3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zfao1/4IORAeFOVj"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAQ0ZWSiRysfkUnu2ZoDXFtiJz-nfrQ-DTKOgCpKpCe5LpQj3Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Zfao1/4IORAeFOVj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2012 at 07:59:20PM +0800, Shawn Guo wrote:
> On 9 May 2012 19:50, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:

> > I'll apply this when devm_clk_get() makes it into mainline (hopefully in
> > the merge window); please remind me if I forget.

> We will have rmk's clkdev branch appear on arm-soc as dependency
> anyway.  Can we have this series go over arm-soc tree, since we will
> have all the dependencies on clk and pinctrl meet and conflicts solved
> there?

This change is totally unrelated to the rest of the series, it's just a
random cleanup to the driver - it really shouldn't have been part of the
series at all.

--Zfao1/4IORAeFOVj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqlyWAAoJEBus8iNuMP3dw6oP/2BIBZ3xqk9PnHrqLKu4i75p
O6RAHAeN2Vi0ACqY//TQUKVlvTHZYhH8FPqMKjdxkFOGYSrMS32Q6zwwitEb05Td
p9V8GiLXIR+j7sPSYO9VNKRJW8GLCrskpl8r4XjMNP842/UYqJUzJM4RFZvRzMTI
wRA59+qLnv6MNduYovOHbohWDeHcSFvJacJN8mdw10RQ9Sow4FHlumYr2oULkx2n
BtvGSMXvK1/1wytVaR9ySKu5sdnWvabdwQWbbACPVlHM1ltduENfcypfLk3Obfcn
paDUoZg0mKikHkoRScDBtFmI00Jp+nwzwFVud3PnKNRHlvSOnsDtjcn0Di9UPT+Z
2s+sRL3b3p5kzoAogTtoEkd8DJuczaw/PMcYXhapEvtIoI1ckn0cTd9/hVIDddht
SRO2vBNvqdF2QZFUyanYLlibwv0va2yV33RqfpOrZM2Nh1ko6OwYfmgxjQTBJiSD
O3e/DncTafdPp1Q2O09SJmzNvP98uK2TXdaQ5qYZ991doQ7Ex+/Gwl8SSTQX63C/
QoZxVPoTiz79fYy6k3JhhgGGq6rOc9q7R371vgMXycBJTmO8egeIkjNFNFfSsLb0
PPAL/HS8bdvv2gUPlnpP5Ybp1KAH18tqMVTqc+o57cq7oXDsY2h33cATT9LSKd4C
GTGZR4hleN9l5iwnQmyn
=a5zk
-----END PGP SIGNATURE-----

--Zfao1/4IORAeFOVj--
