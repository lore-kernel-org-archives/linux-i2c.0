From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] treewide: remove redundent IS_ERR() before error code
 check
Date: Wed, 8 Jan 2020 14:17:59 -0600
Message-ID: <20200108201759.GA28519@bogus>
References: <20200106045833.1725-1-masahiroy@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200106045833.1725-1-masahiroy@kernel.org>
Sender: netdev-owner@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon,  6 Jan 2020 13:58:33 +0900, Masahiro Yamada wrote:
> 'PTR_ERR(p) == -E*' is a stronger condition than IS_ERR(p).
> Hence, IS_ERR(p) is unneeded.
> 
> The semantic patch that generates this commit is as follows:
> 
> // <smpl>
> @@
> expression ptr;
> constant error_code;
> @@
> -IS_ERR(ptr) && (PTR_ERR(ptr) == - error_code)
> +PTR_ERR(ptr) == - error_code
> // </smpl>
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  crypto/af_alg.c                      | 2 +-
>  drivers/acpi/scan.c                  | 2 +-
>  drivers/char/hw_random/bcm2835-rng.c | 2 +-
>  drivers/char/hw_random/omap-rng.c    | 4 ++--
>  drivers/clk/clk.c                    | 2 +-
>  drivers/dma/mv_xor_v2.c              | 2 +-
>  drivers/gpio/gpiolib-devres.c        | 2 +-
>  drivers/gpio/gpiolib-of.c            | 8 ++++----
>  drivers/gpio/gpiolib.c               | 2 +-
>  drivers/i2c/busses/i2c-mv64xxx.c     | 5 ++---
>  drivers/i2c/busses/i2c-synquacer.c   | 2 +-
>  drivers/mtd/ubi/build.c              | 2 +-
>  drivers/of/device.c                  | 2 +-
>  drivers/pci/controller/pci-tegra.c   | 2 +-
>  drivers/phy/phy-core.c               | 4 ++--
>  drivers/spi/spi-orion.c              | 3 +--
>  drivers/video/fbdev/imxfb.c          | 2 +-
>  fs/ext4/super.c                      | 2 +-
>  fs/f2fs/node.c                       | 2 +-
>  fs/ocfs2/suballoc.c                  | 2 +-
>  fs/sysfs/group.c                     | 2 +-
>  net/core/dev.c                       | 2 +-
>  net/core/filter.c                    | 2 +-
>  net/xfrm/xfrm_policy.c               | 2 +-
>  sound/soc/codecs/ak4104.c            | 3 +--
>  sound/soc/codecs/cs4270.c            | 3 +--
>  sound/soc/codecs/tlv320aic32x4.c     | 6 ++----
>  sound/soc/sunxi/sun4i-spdif.c        | 2 +-
>  28 files changed, 35 insertions(+), 41 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
