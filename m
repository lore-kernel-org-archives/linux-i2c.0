From: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH linux-next] i2c-designware: use div_u64 to fix link
Date: Tue, 2 Jul 2013 14:12:39 -0700
Message-ID: <CAGa+x859XVrV3r_XAMREkUgQEdjNJ5Z+0E8ZQfPqfb+1e3SLaw@mail.gmail.com>
References: <1372758414-21513-1-git-send-email-vincent.stehle@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1372758414-21513-1-git-send-email-vincent.stehle-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 2, 2013 at 2:46 AM, Vincent Stehl=E9
<vincent.stehle-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> This fixes the following link error:
>
>   drivers/built-in.o: In function `dw_i2c_probe':
>   of_iommu.c:(.text+0x18c8f0): undefined reference to `__aeabi_uldivm=
od'
>   make: *** [vmlinux] Error 1
>
> Signed-off-by: Vincent Stehl=E9 <vincent.stehle-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> Cc: Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> ---
>
>
> Hi,
>
> Linux next-20130702 link broke for ARM config multi_v7_defconfig. Thi=
s is with
> gcc 4.7.2 but I am not sure it matters much here.
>
> This patch repairs the link.
>
> It did not break anything for me on i.MX6 sabre sd, but it does'nt ha=
ve a
> designware i2c, so more reviewing/testing is welcome.

This also broke a handful of other ARM defconfigs (notably spear*_defco=
nfig,)

I build tested this on top of next-20130702 for multi_v7_defconfig as
well as all 3 spear defconfigs, and confirm that linux-next is back to
building for those platforms.

Tested-by: Kevin Hilman <khilman-QSEj5FYQhm64UlQgPVntAg@public.gmane.org

Kevin
