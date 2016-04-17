From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 1/2] i2c: exynos5: Check clk_prepare_enable() return
 value
Date: Sun, 17 Apr 2016 15:32:40 +0200
Message-ID: <20160417133240.GB3620@kozik-lap>
References: <1460855693-28225-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460855693-28225-1-git-send-email-javier@osg.samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Apr 16, 2016 at 09:14:52PM -0400, Javier Martinez Canillas wrote:
> The clk_prepare_enable() function can fail so check the return value
> and propagate the error to the caller in case of a failure.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/i2c/busses/i2c-exynos5.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>


Hi,

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
