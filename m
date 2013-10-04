From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 2/3] i2c: xilinx: Set tx direction in write operation
Date: Fri, 4 Oct 2013 07:46:37 +0200
Message-ID: <20131004054636.GC3194@katana>
References: <f3fd6f38d2553e59b077edff1969f4d07f8aa811.1380550490.git.michal.simek@xilinx.com>
 <57a4f5352ce6f03bde7aafe8b880f91b52994379.1380550490.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57a4f5352ce6f03bde7aafe8b880f91b52994379.1380550490.git.michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, Kedareswara rao Appana <appana.durga.rao-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Kedareswara rao Appana <appanad-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	cr = xiic_getreg32(i2c, XIIC_CR_REG_OFFSET);
> +	cr |= XIIC_CR_DIR_IS_TX_MASK;
> +	xiic_setreg32(i2c, XIIC_CR_REG_OFFSET, cr);
> +

Is there no need to clear the bit again when receiving? And did
transferring ever work if this bit was never set before?


--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSTlY8AAoJEBQN5MwUoCm2pHgQAIkZeJvlk/F6iP1KVimtGAR/
d68d62EUPL4rLuioETJrNcwwfjal5ENIonIE12UmdeKfW8dXWsHloWNRvK57p7S4
vld3eO9idHvfnFE0pCj1k7VO0mLAy14L0LVTuYVH7Oh65Clps8bpgEsDoGiz/9kK
Xdi7nQ3VNTx3LIu0gwj9gNz5wfkaRV+Li/ILMJVllXZSN3K0k5cJbHdINhXcUZ1j
11dzMUFRYp1r2GyFFl1L8iT2ais0KWcE/vqzGKHJ4s78wJcQNnjfx7qpPyKszGLH
vYlCrBoxUN3a6rgA7n7O0oII/3yDNBXdD4ICEu0GIEpfoD8LJnExvpMZAIotTltD
Mlipcx3nQmaPzdvwnjYtVQravrJzrc3xG0qRFZSjEs4KSs6UlQfNps31UtYEMAD3
3lv4jAwRDtTuAFSSVBhUzms9bmcI7ehcoD930/Xw5qTH1g12adIZliNb0gQogOXX
vT9HojEV+ZId9dF3xIf29lADTuD01KwGe4lD8Q0wYgSxc2D1mmIJ6xkBKWJ8qVoG
RA6PtLSOZqyUQfr4dUMDEfps3LtobGWzATJAS9A5H6emmZWjd49P8o4wscMMi+J9
H0EHiSjUzUvAW2jJSIIpbjisBLPrD7wTZhXjN6T+PKWGZx4ON2CmLwgzgWF6h8Kv
1m265ha7UkXcAkCmdnsO
=SnUT
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
