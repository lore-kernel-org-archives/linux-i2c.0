From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
Date: Sun, 12 Jan 2014 03:57:07 +0000
Message-ID: <1389499027.3720.42.camel@deadeye.wl.decadent.org.uk>
References: <1388678476-12875-1-git-send-email-gregory.clement@free-electrons.com>
	 <1388678476-12875-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-NRxYPK52gyGgxvRj4QD3"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1388678476-12875-2-git-send-email-gregory.clement@free-electrons.com>
Sender: stable-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--=-NRxYPK52gyGgxvRj4QD3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2014-01-02 at 17:01 +0100, Gregory CLEMENT wrote:
> All the mvebu SoCs have information related to their variant and
> revision that can be read from the PCI control register.
>=20
> This patch adds support for Armada XP and Armada 370. This reading of
> the revision and the ID are done before the PCI initialization to
> avoid any conflicts. Once these data are retrieved, the resources are
> freed to let the PCI subsystem use it.
[...]
> --- /dev/null
> +++ b/include/linux/mvebu-soc-id.h
> @@ -0,0 +1,32 @@
> +/*
> + * Marvell EBU SoC ID and revision definitions.
> + *
> + * Copyright (C) 2014 Marvell Semiconductor
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __LINUX_MVEBU_SOC_ID_H
> +#define __LINUX_MVEBU_SOC_ID_H
> +
> +/* Armada XP ID */
> +#define MV78230_DEV_ID	    0x7823
> +#define MV78260_DEV_ID	    0x7826
> +#define MV78460_DEV_ID	    0x7846
> +
> +/* Armada XP Revision */
> +#define MV78XX0_A0_REV	    0x1
> +#define MV78XX0_B0_REV	    0x2
> +
> +#ifdef CONFIG_ARCH_MVEBU
> +int mvebu_get_soc_id(u32 *dev, u32 *rev);
> +#else
> +int mvebu_get_soc_id(u32 *dev, u32 *rev)

This definition needs to be static inline, assuming anything will
actually include this header when !defined(CONFIG_ARCH_MVEBU).

Ben.

> +{
> +	return -1;
> +}
> +#endif
> +
> +#endif /* __LINUX_MVEBU_SOC_ID_H */

--=20
Ben Hutchings
Quantity is no substitute for quality, but it's the only one we've got.

--=-NRxYPK52gyGgxvRj4QD3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIVAwUAUtISlOe/yOyVhhEJAQqPrg//Y7cxjsqoJ+IZobuPQGnPosZ+uIkZek7A
84jvPFFq/9FOHBWuJm6UVqAr+gqZyHJz8AqYQnC38sJjiccAgH8Qb14XpDeYMsYD
27xsi5RfqreoZVrmGC8qaRXQRZmNjIQIb9bMU5D5uYFCQUdNX1ys0+OdwvWMYgto
pHbDcltDIhQfJV1xS89sJSldPTeXMI09CyKUEp7vlo7BeZra8iWSQNRApO1gsr6Q
eqv+ggSySVGtb5a/HC7VjDbbopWmoEOUjOndkBs8nFCJIgsj4zJeok8vk6IPnrmu
jMKcapAYBx/2Dd70Qh01c040UZSM247RkKMby7G4UNiOtoNT8KGMAnSU0jL9cLyG
jsaU9gG/zY5ft8Sfl6av+037Oac3F6F3FVdr6/g4Y1hxShlZnvesez/X1RC5IN3l
/geeoiBgZa+95JCPhsWlpkGfVeVHQ2ufpQSyfEYAH2rCpNeFuLaGLPNHTcxtZeeM
UR0TqKVcUyKY8s4PHQV9weezJM/N4IpfUCrSy6cEVgaZbWfYOHRn6R0RO4LFFdAJ
D62h/0tjQqUZn6pLpngMlD7unEBDWzmQQvmNo3tP5iEyGRU/ZRWVuUwPecRu3Dh9
a4VAR0/mYmTr2PN8gcoVCJaeNG8f8uO1COilfQtoQIKFoWIHCduf/txkjSIsOlX2
wn59lCUAkDk=
=Sepb
-----END PGP SIGNATURE-----

--=-NRxYPK52gyGgxvRj4QD3--
