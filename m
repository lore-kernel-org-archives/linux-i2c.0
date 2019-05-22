From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 5/8] MAINTAINERS: add I2C DT bindings to Rockchip platform
Date: Wed, 22 May 2019 09:51:27 +0200
Message-ID: <2847662.8Nn05j9K3f@phil>
References: <20190521082137.2889-1-wsa@the-dreams.de>
 <20190521082137.2889-6-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190521082137.2889-6-wsa@the-dreams.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Am Dienstag, 21. Mai 2019, 10:21:34 CEST schrieb Wolfram Sang:
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Heiko Stuebner <heiko@sntech.de>

not sure if you want me to apply this or just want to pick it up
yourself (I don't have a hard preference here). In any case, if you
want to pick it up, it is obviously

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1a60cd98aad5..09f32866bdef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2145,6 +2145,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	linux-rockchip@lists.infradead.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
>  F:	arch/arm/boot/dts/rk3*
>  F:	arch/arm/boot/dts/rv1108*
>  F:	arch/arm/mach-rockchip/
> 
