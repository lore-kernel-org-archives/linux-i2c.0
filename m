From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [Patch v2] power/mpc85xx: Add delay after enabling I2C master
Date: Mon, 23 Sep 2013 09:10:12 +0200
Message-ID: <20130923071012.GD3051@katana>
References: <1379369185-14590-1-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1379369185-14590-1-git-send-email-yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index b80c768..55dce43 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -106,7 +106,12 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
>  static void mpc_i2c_fixup(struct mpc_i2c *i2c)
>  {
>  	int k;
> -	u32 delay_val = 1000000 / i2c->real_clk + 1;
> +	u32 delay_val;
> +#ifdef CONFIG_PPC_85xx
> +	delay_val = 65536 / (fsl_get_sys_freq() / 2000000);	/* 64K cycle */
> +#else
> +	delay_val = 1000000 / i2c->real_clk + 1;
> +#endif

Please, no unnecessary #ifdefs in code. We have 'struct mpc_i2c_data'
already.


--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSP+lUAAoJEBQN5MwUoCm2izoQALD2MnmT6xUounqJZ056Nf2J
J26wr4sNk9EjirUic1dIu95eTz4EWinuKeK1PM9z8YeNe8+oS6mwgRoO0E0/7V54
iE8os2S0cnd9fijQYLEyV/YCGoCn+lSkVYsXhgksePE8S+1DRqrrIzYHJ4Jf7lKu
zciQZ5fk7j6Amp1Ee8CBd7d8v96wQsbKEbDCQU/EEJHupnxujVsLc4+1jZiRmk8X
BkEFkJ2+Kq1x/8OrKD9pl0IJnKW/2hqnKrvqjmVZir4e9hGXYHQb+rWHWMZ5qbFT
b0zk6cbMZWx/AEnsB59amBBq/v2Y1DFtDOvW7x/1Rs97eozvv7mbDnMMqjlJqupU
Q7id2iQUVjREv0HrDjQFz8XxUP/MaNA7NwMUe96LSjINTio1sa5jzxVWr22WUzTU
kexrcPiP0+u3LYnwHw4RETM5b1VVAdaka1fvnl1L55aswgjKlUxhCmvnaRqR5b6z
6oqz3tYvcfMCdT3DDiXliPbxdE4G6aK40frt8s+ybTRURlMJRjmmX8twv68KAwu9
ADjK9c1W1RFM+srePUZCs1pqtK0hbsh7pq2qBqPHmIdU+cd/fnq3oMM/CZfoqx/Y
VQ1SnoKaBwAsAz19TZaBhGLkLT46MjsTmhCp8p6tHb12TwkENe0mjp0QDaPpJ8uV
y8uhmy7TaM5BVCvPwgIi
=4xZC
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
