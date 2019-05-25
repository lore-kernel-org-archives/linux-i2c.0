From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 3/8] MAINTAINERS: add I2C DT bindings to LPC platforms
Date: Sat, 25 May 2019 11:33:23 +0300
Message-ID: <266e3199-840b-54e7-cacf-c6eb5fc1c6c5@mleia.com>
References: <20190521082137.2889-1-wsa@the-dreams.de>
 <20190521082137.2889-4-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190521082137.2889-4-wsa@the-dreams.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org
Cc: linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 05/21/2019 11:21 AM, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90abfe11b05c..01b5579cfa07 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1782,6 +1782,7 @@ ARM/LPC18XX ARCHITECTURE
>  M:	Vladimir Zapolskiy <vz@mleia.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/i2c/i2c-lpc2k.txt
>  F:	arch/arm/boot/dts/lpc43*
>  F:	drivers/i2c/busses/i2c-lpc2k.c
>  F:	drivers/memory/pl172.c
> @@ -1795,6 +1796,7 @@ M:	Sylvain Lemieux <slemieux.tyco@gmail.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  T:	git git://github.com/vzapolskiy/linux-lpc32xx.git
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/i2c/i2c-pnx.txt
>  F:	arch/arm/boot/dts/lpc32*
>  F:	arch/arm/mach-lpc32xx/
>  F:	drivers/i2c/busses/i2c-pnx.c
> 

it makes sense, thank you for the change!

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
