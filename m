From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv2 2/9] i2c: xiic: move the xiic_process to thread context
Date: Thu, 9 Jul 2015 19:31:58 +0200
Message-ID: <20150709173158.GD4744@katana>
References: <1434554299-23443-1-git-send-email-shubhraj@xilinx.com>
 <1434554299-23443-3-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UoPmpPX/dBe4BELn"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434554299-23443-3-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

>  static int xiic_bus_busy(struct xiic_i2c *i2c)
> @@ -602,16 +601,21 @@ static void xiic_start_send(struct xiic_i2c *i2c)
>  static irqreturn_t xiic_isr(int irq, void *dev_id)
>  {
>  	struct xiic_i2c *i2c = dev_id;
> -
> -	spin_lock(&i2c->lock);
> +	u32 pend, isr, ier;
> +	irqreturn_t ret = IRQ_HANDLED;
> +	/* Do not processes a devices interrupts if the device has no
> +	 * interrupts pending
> +	 */

Shouldn't you init 'ret' to IRQ_NONE then?


--UoPmpPX/dBe4BELn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnrANAAoJEBQN5MwUoCm2SxgQALK0AbtQOkeDovnGyQzbnRYp
D59Rn1lF5/6GVnMsxhp6Gj531DdZ0q+PLP1HzEy67Ie15DdgPGJE802dcVu8v0yq
HU9jl4kCmwJ0ri5scMiEO5xSIZxU+UXTwZLhGLzWBOgAF2RVwUUqeeT9K+xlOdpi
ov9OQpD2RSY1qE2CIc3rVb1Ag9nTMOTo1KQfETOs6vZI3mSEsgqhC6IkxQ479zKe
CGawj+got6In55cIlxI41NpiyLpYVqIPl8pyz1/QbDbe7qTd4L/1UIDHOkPmVAah
V9iPwzoJrNeu/5JtgLdNg4eEGqHFvAsHCzmzqaBmwm+Vmn2BGscdrMl0dbSBRbsH
kkcA3FkkRxx7cOaiTPlbatJNHv1Gb2wW7xvqT9pufXqzS1qO/Q/OZZwXhUPDoY4H
nrB+Ce1JMoGiCGPJdXeOY+RDNxjD/mzUFhrSjNEC21j1UzfA2vzhAr883OwESqWw
+8hMIHISQtKgj7OLGHkheABLXM2enN8DgSWDic08DW5fotIahDIWdEVZYQsuc/Lc
c3KS3VTWat/LZ0GJdLENmZQSgWrplRkmnZqJVb7wkKC2abV/43/FWhEdWHgQiOP5
mq7+uoJqzf4o25uRDM4XKHlJbdqnTUrR9tDJ9Kg6RF+q2anz0PCaEDylD7lnl8OT
YgQxB/ESNKH5d6bV3yVd
=Qciz
-----END PGP SIGNATURE-----

--UoPmpPX/dBe4BELn--
