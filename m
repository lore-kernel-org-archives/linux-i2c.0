From: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH resend 0/2] i2c: hix5hd2: add i2c controller driver
Date: Tue, 16 Sep 2014 03:56:10 +0800
Message-ID: <CABQgh9EH=cA-bPWNNZEARzQbvHi6E=UdXfaFU+1sPq8RpuSQsA@mail.gmail.com>
References: <1409030722-30709-1-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409030722-30709-1-git-send-email-zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Haifeng Yan <haifeng.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jason Xue <jchxue-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 26 August 2014 13:25, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Resend: verified on 3.17-rc1
>
> Wei Yan (2):
>   i2c: hix5hd2: add devicetree documentation
>   i2c: hix5hd2: add i2c controller driver
>
>  .../devicetree/bindings/i2c/i2c-hix5hd2.txt        |   31 ++
>  drivers/i2c/busses/Kconfig                         |   16 +
>  drivers/i2c/busses/Makefile                        |    1 +
>  drivers/i2c/busses/i2c-hix5hd2.c                   |  576 ++++++++++++++++++++
>  4 files changed, 624 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hix5hd2.txt
>  create mode 100644 drivers/i2c/busses/i2c-hix5hd2.c
>

Any comments, thanks a lot.
