From: Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: [PATCH RESEND] i2c: mediatek: disable zero-length transfers for
 mt8183
Date: Thu, 22 Aug 2019 16:24:38 +0800
Message-ID: <1566462278.26641.1.camel@mtksdaap41>
References: <20190822055737.142384-1-hsinyi@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822055737.142384-1-hsinyi@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org, Nicolas Boichat <drinkcat@chromium.org>, Alexandru M Stan <amstan@chromium.org>, Jun Gao <jun.gao@mediatek.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Qii Wang <qii.wang@mediatek.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2019-08-22 at 13:57 +0800, Hsin-Yi Wang wrote:
> When doing i2cdetect quick write mode, we would get transfer
> error ENOMEM, and i2cdetect shows there's no device at the address.
> Quoting from mt8183 datasheet, the number of transfers to be
> transferred in one transaction should be set to bigger than 1,
> so we should forbid zero-length transfer and update functionality.


<...>

> @@ -933,8 +942,8 @@ static int mtk_i2c_probe(struct platform_device *pdev)
>  	i2c->dev = &pdev->dev;
>  	i2c->adap.dev.parent = &pdev->dev;
>  	i2c->adap.owner = THIS_MODULE;
> -	i2c->adap.algo = &mtk_i2c_algorithm;
>  	i2c->adap.quirks = i2c->dev_comp->quirks;
> +	i2c->adap.algo = &mtk_i2c_algorithm;
>  	i2c->adap.timeout = 2 * HZ;
>  	i2c->adap.retries = 1;
>  

Why do you need to change this part?

Joe.C
