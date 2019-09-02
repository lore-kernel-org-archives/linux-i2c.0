From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: htc-i2cpld: drop check because
 i2c_unregister_device() is NULL safe
Date: Mon, 2 Sep 2019 10:06:27 +0100
Message-ID: <20190902090627.GD32232@dell>
References: <20190820153443.7812-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190820153443.7812-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 20 Aug 2019, Wolfram Sang wrote:

> No need to check the argument of i2c_unregister_device() because the
> function itself does it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Build tested only, buildbot is happy, too.
> 
> Please apply to your tree.
> 
>  drivers/mfd/htc-i2cpld.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
