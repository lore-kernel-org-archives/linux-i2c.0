From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: tps80031: convert to devm_i2c_new_dummy_device
Date: Mon, 12 Aug 2019 08:37:38 +0100
Message-ID: <20190812073738.GP4594@dell>
References: <20190722172636.4589-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190722172636.4589-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 22 Jul 2019, Wolfram Sang wrote:

> Move from i2c_new_dummy() to devm_i2c_new_dummy_device(). So, we now get
> an ERRPTR which we use in error handling and we can skip removal of the
> created devices.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Only build tested. Part of a tree-wide move to deprecate
> i2c_new_dummy().
> 
>  drivers/mfd/tps80031.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
