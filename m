From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH v2 0/4] ARM: dts: renesas: Convert to named i2c-gpio
 bindings
Date: Fri, 1 Dec 2017 09:18:55 +0100
Message-ID: <20171201081850.4tqbnlvxdax7phfs@verge.net.au>
References: <1512046646-15253-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1512046646-15253-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 30, 2017 at 01:57:22PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> Commits 7d29f509d2cfd807 ("dt-bindings: i2c: i2c-gpio: Add support for
> named gpios") and 05c74778858d7d99 ("i2c: gpio: Add support for named
> gpios in DT") introduced named i2c-gpio DT bindings, and deprecated the
> more error-prone unnamed variant.
> 
> This patch series switches all Renesas boards to the new bindings, and
> adds the missing GPIO_OPEN_DRAIN I/O flags, which were implicitly
> assumed before.  The latter gets rid of messages like:
> 
>     gpio-208 (?): enforced open drain please flag it properly in DT/ACPI DSDT/board file
>     gpio-91 (?): enforced open drain please flag it properly in DT/ACPI DSDT/board file
> 
> Patch 1 was extracted from series "[PATCH/RFC 0/3] i2c: gpio: Add
> support for named gpios in DT", hence the v2.  All other patches are
> new.
> 
> Note that after this series is applied, the i2c-gpio buses are no longer
> detected when booting new DTBs on old (v4.14 and older) kernels, which
> should not be an issue.  Booting old DTBs on new kernels is not
> affected.
> 
> Thanks for applying!

Thanks, applied.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
