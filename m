From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/8] MAINTAINERS: add I2C DT bindings to Zynq platform
Date: Tue, 21 May 2019 10:55:29 +0200
Message-ID: <997813fc-ca05-3847-7ad1-068e8cb5be57@xilinx.com>
References: <20190521082137.2889-1-wsa@the-dreams.de>
 <20190521082137.2889-2-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190521082137.2889-2-wsa@the-dreams.de>
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
Cc: linux-i2c@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>
List-Id: linux-i2c@vger.kernel.org

On 21. 05. 19 10:21, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Michal Simek <michal.simek@xilinx.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 509a8e6d2dcc..5cb019f8e597 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2532,6 +2532,8 @@ F:	drivers/cpuidle/cpuidle-zynq.c
>  F:	drivers/block/xsysace.c
>  N:	zynq
>  N:	xilinx
> +F:	Documentation/devicetree/bindings/i2c/i2c-cadence.txt
> +F:	Documentation/devicetree/bindings/i2c/i2c-xiic.txt
>  F:	drivers/clocksource/timer-cadence-ttc.c
>  F:	drivers/i2c/busses/i2c-cadence.c
>  F:	drivers/mmc/host/sdhci-of-arasan.c
> 

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
