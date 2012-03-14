From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 0/3 v2] Updates for exynos4210 and DT-based systems
Date: Wed, 14 Mar 2012 10:49:48 +0900
Message-ID: <CAH9JG2VhDKN4skjtgsYXDJqrNbXbOuheKHo_hQPeQ3XdNgh1Lg@mail.gmail.com>
References: <1331657679-31302-1-git-send-email-k.lewandowsk@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1331657679-31302-1-git-send-email-k.lewandowsk@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Karol Lewandowski <k.lewandowsk@samsung.com>, Wolfram Sang <w.sang@pengutronix.de>
Cc: ben-linux@fluff.org, thomas.abraham@linaro.org, m.szyprowski@samsung.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, t.stanislaws@samsung.com
List-Id: linux-i2c@vger.kernel.org

+CC another i2c subsystem maintainer, Wolfram Sang.

On 3/14/12, Karol Lewandowski <k.lewandowsk@samsung.com> wrote:
> Changes since v1:
>  - Move unrelated code fragment to separate patch (of_match_ptr())
>  - Move device-type handling to separate function and rework its
>    internals a bit
>
> This patchset reworks i2c-s3c2410 driver a bit to better handle
> device tree-enabled platforms and adds two quirks required by
> exynos4210-specific I2C controller used by s5p-hdmi driver.
>
> This patchset is based on "i2c-bjdooks/for-34/i2c/i2c-samsung" branch
> taken from:
>
>   git://git.fluff.org/bjdooks/linux.git
>
> Karol Lewandowski (3):
>   i2c-s3c2410: Drop unused define
>   i2c-s3c2410: Rework device type handling
>   i2c-s3c2410: Add HDMIPHY quirk for S3C2440
>
>  .../devicetree/bindings/i2c/samsung-i2c.txt        |   10 ++-
>  drivers/i2c/busses/i2c-s3c2410.c                   |   93
> +++++++++++++++-----
>  2 files changed, 77 insertions(+), 26 deletions(-)
>
> --
> 1.7.9
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
