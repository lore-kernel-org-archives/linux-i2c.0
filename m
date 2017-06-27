From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1] x86/io: Include asm-generic/io.h to architectural code
Date: Tue, 27 Jun 2017 22:06:28 +0200
Message-ID: <20170627200628.7oupopm3m7nbpukp@ninjato>
References: <20170627160641.75712-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d55cgdavc7x4egtw"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54195 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753132AbdF0UGa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 27 Jun 2017 16:06:30 -0400
Content-Disposition: inline
In-Reply-To: <20170627160641.75712-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang@spreadtrum.com>, linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Shawn Guo <shawnguo@kernel.org>


--d55cgdavc7x4egtw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2017 at 07:06:41PM +0300, Andy Shevchenko wrote:
> asm-generic/io.h defines few helpers which would be useful in the drivers,
> such as writesb() and readsb().
>=20
> Include it to the asm/io.h in architectural folder.
>=20
> Note, to apply above we need to define macros for functions which do not =
have
> them yet defined, such as readb() or writeb(). This is done here as well.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Yes, we had to drop COMPILE_TEST from drivers because of readsb/writesb
not being available. Would be nice to have that fixed.

Acked-by: Wolfram Sang <wsa@the-dreams.de>

No thorough review, though. Adding Shawn to CC who also hit this issue
recently.

> ---
>  arch/x86/include/asm/io.h | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index 7afb0e2f07f4..abb3090a5822 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -69,6 +69,9 @@ build_mmio_write(__writeb, "b", unsigned char, "q", )
>  build_mmio_write(__writew, "w", unsigned short, "r", )
>  build_mmio_write(__writel, "l", unsigned int, "r", )
> =20
> +#define readb readb
> +#define readw readw
> +#define readl readl
>  #define readb_relaxed(a) __readb(a)
>  #define readw_relaxed(a) __readw(a)
>  #define readl_relaxed(a) __readl(a)
> @@ -76,6 +79,9 @@ build_mmio_write(__writel, "l", unsigned int, "r", )
>  #define __raw_readw __readw
>  #define __raw_readl __readl
> =20
> +#define writeb writeb
> +#define writew writew
> +#define writel writel
>  #define writeb_relaxed(v, a) __writeb(v, a)
>  #define writew_relaxed(v, a) __writew(v, a)
>  #define writel_relaxed(v, a) __writel(v, a)
> @@ -119,6 +125,7 @@ static inline phys_addr_t virt_to_phys(volatile void =
*address)
>  {
>  	return __pa(address);
>  }
> +#define virt_to_phys virt_to_phys
> =20
>  /**
>   *	phys_to_virt	-	map physical address to virtual
> @@ -137,6 +144,7 @@ static inline void *phys_to_virt(phys_addr_t address)
>  {
>  	return __va(address);
>  }
> +#define phys_to_virt phys_to_virt
> =20
>  /*
>   * Change "struct page" to physical address.
> @@ -220,6 +228,7 @@ memset_io(volatile void __iomem *addr, unsigned char =
val, size_t count)
>  {
>  	memset((void __force *)addr, val, count);
>  }
> +#define memset_io(dst,c,count) memset_io(dst,c,count)
> =20
>  /**
>   * memcpy_fromio	Copy a block of data from I/O memory
> @@ -234,6 +243,7 @@ memcpy_fromio(void *dst, const volatile void __iomem =
*src, size_t count)
>  {
>  	memcpy(dst, (const void __force *)src, count);
>  }
> +#define memcpy_fromio(to,from,count) memcpy_fromio(to,from,count)
> =20
>  /**
>   * memcpy_toio		Copy a block of data into I/O memory
> @@ -248,6 +258,7 @@ memcpy_toio(volatile void __iomem *dst, const void *s=
rc, size_t count)
>  {
>  	memcpy((void __force *)dst, src, count);
>  }
> +#define memcpy_toio(to,from,count) memcpy_toio(to,from,count)
> =20
>  /*
>   * ISA space is 'always mapped' on a typical x86 system, no need to
> @@ -341,9 +352,32 @@ BUILDIO(b, b, char)
>  BUILDIO(w, w, short)
>  BUILDIO(l, , int)
> =20
> +#define inb inb
> +#define inw inw
> +#define inl inl
> +#define inb_p inb_p
> +#define inw_p inw_p
> +#define inl_p inl_p
> +#define insb insb
> +#define insw insw
> +#define insl insl
> +
> +#define outb outb
> +#define outw outw
> +#define outl outl
> +#define outb_p outb_p
> +#define outw_p outw_p
> +#define outl_p outl_p
> +#define outsb outsb
> +#define outsw outsw
> +#define outsl outsl
> +
>  extern void *xlate_dev_mem_ptr(phys_addr_t phys);
>  extern void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
> =20
> +#define xlate_dev_mem_ptr xlate_dev_mem_ptr
> +#define unxlate_dev_mem_ptr unxlate_dev_mem_ptr
> +
>  extern int ioremap_change_attr(unsigned long vaddr, unsigned long size,
>  				enum page_cache_mode pcm);
>  extern void __iomem *ioremap_wc(resource_size_t offset, unsigned long si=
ze);
> @@ -365,6 +399,8 @@ extern bool xen_biovec_phys_mergeable(const struct bi=
o_vec *vec1,
> =20
>  #define IO_SPACE_LIMIT 0xffff
> =20
> +#include <asm-generic/io.h>
> +
>  #ifdef CONFIG_MTRR
>  extern int __must_check arch_phys_wc_index(int handle);
>  #define arch_phys_wc_index arch_phys_wc_index
> --=20
> 2.11.0
>=20

--d55cgdavc7x4egtw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllSur8ACgkQFA3kzBSg
Kbbaew//YY3NU1wQNL5De4FvzUWWzPbubnExQU+x1fuwwG9IHLc4PHGnsMnm9it0
4YLnj9ePubETYyv/8A6g+uvt+rXUEgpUyaOiHD4M2Ve7cBlMSRrWoMaRUlEJqfkz
xwcmhNwrlTeSOz0dtMRcL+GdtuDUxYuhqjSXQuFNWJFtPY+Li013IkHSQDpBdOAT
QnREE6TMyHucNO0ZliJhjZay12f+2Z4d/R7UvvDPYggjaSW0HufaQf8uBJN/wI4C
9/ODnUs5hvhOqFNv1fHb+BrtCD5dfWT73gk8P8A/bWfN7raU0o8X9k2YSj88C4ot
TIDPLNmEoNo9mzILe8GpFjNSu+I2dJuosn8tIAUydSKyezC4lSJ4XFNcIomkikOg
r23YczjQndKLHnt3CM/u+SajHKIF1ZCc3YRLvyq5t0/claGQzGHnCy9zJdG0v6Za
a58LR6aDgdYxHTpLIpKyx7m2trhjgbwW6wAkpFd8NFUIMUPKcLd02QGQRbBcxkgL
N02dipHyLJUX2lB04ccDi+VTy+6M+RZ7CgQFR4Z3dLjGQEo3xzQXdSghVB7N8Dag
LETAvP6Tmsncq87Un62/Hjsuj5ZWRYWFD7m40qJ1ycF9N9IJE4T4xQ/OjIrbUcgf
Vz2kmm2r8wESvx3YIFqOw5RUwB57sWX2tX/xi6jTTmDciWX7ZlA=
=N/Ti
-----END PGP SIGNATURE-----

--d55cgdavc7x4egtw--
