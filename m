From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 3/3] ARM: dts: hix5hd2: add i2c node
Date: Tue, 30 Sep 2014 11:02:34 +0200
Message-ID: <2637538.ufF2KQPbi9@wuerfel>
References: <1411878129-19743-1-git-send-email-zhangfei.gao@linaro.org> <1411878129-19743-4-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411878129-19743-4-git-send-email-zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, haifeng.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jchxue-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sunday 28 September 2014 12:22:09 Zhangfei Gao wrote:
> +
> +               i2c0: i2c@b10000 {
> +                       compatible = "hisilicon,hix5hd2-i2c";
> +                       reg = <0xb10000 0x1000>;
> +                       interrupts = <0 38 4>;
> +                       clocks = <&clock HIX5HD2_I2C0_RST>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";
> +               };
> 

HIX5HD2_I2C0_RST is not defined anywhere, so this will result in the
same build error that has required reverting a lot of patches for the
3.18 merge window.

How do you plan to deal with the dependency in the future?

	Arnd
