From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 01/10] i2c-octeon: Cleanup i2c-octeon driver
Date: Sat, 5 Mar 2016 19:47:31 +0100
Message-ID: <20160305184731.GB1394@katana>
References: <cover.1457111728.git.jglauber@cavium.com>
 <4b342427bdf6d7dc7cf9ded9172deadd24a53650.1457111729.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33140 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbcCESrg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 5 Mar 2016 13:47:36 -0500
Content-Disposition: inline
In-Reply-To: <4b342427bdf6d7dc7cf9ded9172deadd24a53650.1457111729.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jan,

The description is not enough. A list what kind of changes you applied
would be nice.

I'd like to have these checkpatch issues fixed:

ERROR: trailing statements should be on next line
#177: FILE: drivers/i2c/busses/i2c-octeon.c:133:
+	while ((tmp & SW_TWSI_V) !=3D 0);

ERROR: trailing statements should be on next line
#202: FILE: drivers/i2c/busses/i2c-octeon.c:152:
+	while ((tmp & SW_TWSI_V) !=3D 0);

CHECK: Prefer using the BIT_ULL macro
#52: FILE: drivers/i2c/busses/i2c-octeon.c:39:
+#define SW_TWSI_V		(1ULL << 63)

Note: I don't care so much about the 80 char limit as long as the line
length is not too excessive.


> -#define DRV_NAME "i2c-octeon"
> +#define DRV_NAME		"i2c-octeon"

I'm in favor for indenting register and bit defines, but other than that
I think one space is enough. I won't force my opinion on you, though.
Just wanted to let you know.

> +#define INT_ENA_ST		0x1
> +#define INT_ENA_TS		0x2
> +#define INT_ENA_CORE		0x4

I assume those are bits? Then, they shouldn't be in the registers
section.

> +/* TWSI_INT values */
> +#define ST_INT			0x01
> +#define TS_INT			0x02
> +#define CORE_INT		0x04
> +#define ST_EN			0x10
> +#define TS_EN			0x20
> +#define CORE_EN			0x40
> +#define SDA_OVR			0x100
> +#define SCL_OVR			0x200
> +#define SDA			0x400
> +#define SCL			0x800

I think those should have a prefix. SDA and SCL are dangerously generic.

>  struct octeon_i2c {
> -	wait_queue_head_t queue;
> -	struct i2c_adapter adap;
> -	int irq;
> -	u32 twsi_freq;
> -	int sys_freq;
> -	resource_size_t twsi_phys;
> -	void __iomem *twsi_base;
> -	resource_size_t regsize;
> -	struct device *dev;
> +	wait_queue_head_t	queue;
> +	struct i2c_adapter	adap;
> +	int			irq;
> +	u32			twsi_freq;
> +	int			sys_freq;
> +	void __iomem		*twsi_base;
> +	struct device		*dev;

NAK. structs change often, and then one needs to fix the whole
indentation. One space is enough here.

>  };

> -static u8 octeon_i2c_read_sw(struct octeon_i2c *i2c, u64 eop_reg)
> +static u64 octeon_i2c_read_sw64(struct octeon_i2c *i2c, u64 eop_reg)
=2E..
> -	return tmp & 0xFF;
> +	return tmp;
> +}
=2E..
> +
> +/**
> + * octeon_i2c_read_sw - read lower bits of an I2C core register
> + * @i2c: The struct octeon_i2c
> + * @eop_reg: Register selector
> + *
> + * Returns the data.
> + *
> + * The I2C core registers are accessed indirectly via the SW_TWSI CSR.
> + */
> +static u8 octeon_i2c_read_sw(struct octeon_i2c *i2c, u64 eop_reg)
> +{
> +	return octeon_i2c_read_sw64(i2c, eop_reg);
>  }

This is not a cleanup!

> +/* disable the CORE interrupt */
>  static void octeon_i2c_int_disable(struct octeon_i2c *i2c)
>  {
> -	octeon_i2c_write_int(i2c, 0);
> +	/* clear TS/ST/IFLG events */
> +	octeon_i2c_write_int(i2c, TS_INT | ST_INT);
>  }

Isn't this a functional change?

>  /**
> - * octeon_i2c_unblock - unblock the bus.
> - * @i2c: The struct octeon_i2c.
> + * bitbang_unblock - unblock the bus
> + * @i2c: The struct octeon_i2c
>   *
> - * If there was a reset while a device was driving 0 to bus,
> - * bus is blocked. We toggle it free manually by some clock
> - * cycles and send a stop.
> + * If there was a reset while a device was driving 0 to bus, bus is bloc=
ked.
> + * We toggle it free manually by some clock cycles and send a stop.
>   */
> -static void octeon_i2c_unblock(struct octeon_i2c *i2c)
> +static void bitbang_unblock(struct octeon_i2c *i2c)

I dunno understand the change of the function name. However, this should
be refactored to use the i2c_bus_recovery infrastructure anyhow.

> -	result =3D wait_event_timeout(i2c->queue,
> -					octeon_i2c_test_iflg(i2c),
> -					i2c->adap.timeout);
> -
> +	result =3D wait_event_timeout(i2c->queue, octeon_i2c_test_iflg(i2c),
> +				    i2c->adap.timeout);

You could rename this variable to 'time_left' to make the code even
easier to read.

>  static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
> -			    const u8 *data, int length)
> +			    u8 *data, int length)

Why this change?

>  {
> -	int i, result;
> +	int result, i;

And this?

> -static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
> -			   u8 *data, int length)
> +static int octeon_i2c_read(struct octeon_i2c *i2c, int target, u8 *data,
> +			   u16 *rlength)
>  {
> +	int length =3D *rlength;

And this?

> @@ -353,15 +411,14 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, =
int target,
>  	if (result)
>  		return result;
> =20
> -	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, (target<<1) | 1);
> -	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
> -
> +	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, TWSI_CTL_ENAB);

Is this really the same?

>  static u32 octeon_i2c_functionality(struct i2c_adapter *adap)
> @@ -435,13 +490,10 @@ static struct i2c_adapter octeon_i2c_ops =3D {
>  	.owner =3D THIS_MODULE,
>  	.name =3D "OCTEON adapter",
>  	.algo =3D &octeon_i2c_algo,
> -	.timeout =3D HZ / 50,

This is a functional change, or?

> -	i2c->twsi_phys =3D res_mem->start;
> -	i2c->regsize =3D resource_size(res_mem);

Those are removed which is okay in general, but should be in a seperate
patch.

This patch was hard to review because so many changes were overlapping.
It really  should have been broken out. Like one patch only removing the
trailing "." in the kernel-doc. One fixing the indentation issues. One
removing the now superfluous fields in struct octeon_i2c, etc...

   Wolfram


--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW2ynDAAoJEBQN5MwUoCm2WkQP/0+iSRQoCgIFPTJBE0mnNpMR
VujWkMHbrR1dDnjJCY4crLKdcFXCQn7PvlKK3+W+nFFlb9yJpb7e7U0vte4CfqlS
gljccvYGxJNF3sm66kj+U0B3b4hyAeZLSP0rl3M5KhFQPQ6JIrMlXVnt1ga2zaem
6+478f01NAf1NPqAfmTWfgSCqCIMpnf7qnYAH+x0Swb0FnhZqlqfT6y2sheKaHPs
G8Bq6HHJJVovMu3383w96/nIzGnfiuHWT+SdWCwVJaG2pxf7EmCPzZyDvlTU9U3S
GzXI48E275fdH5wc/i2jgByCPKw9fADJ24HhRCBV+O+GXFTMf70nyemfwrI4a+nx
n2AIuc8ofyCa0RcLM406Uh9xx1obJ0xIm79sbv7ai+kXPI1scdtClKITl7GW5C/y
u/MIpzFA8VG0HFa967oIwBJDzhG60zZt+ae9tIVxapEOgibTWeTgue7stkTgLiU0
LVXm6yOFoXikCPQsjCy4HFPdqDF49Iu+vCWtdtqFcCS8mNhySUmF/IMXdwRAA2Ag
pMMDYxA6ezXpgGTJX/sY4gv1ISQthgfMW3xU1Z2OqoSwHaSD/V4DnCUtgkXAUSQh
hWIHIyxB46z8MjEEtS6NqKmLX0RuA8DohBCNF2DtMThbn/e6PeSOWAzyo2UZ0quN
xSpIEIA5YO5DoVO6NZpo
=Vo0a
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
