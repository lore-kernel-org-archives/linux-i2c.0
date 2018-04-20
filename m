From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 6/7] i2c: i2c-xiic: move header to platform_data
Date: Fri, 20 Apr 2018 09:05:46 +0100
Message-ID: <20180420080546.7cywc752teflrag5@dell>
References: <20180419200015.15095-1-wsa@the-dreams.de>
 <20180419200015.15095-7-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180419200015.15095-7-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 19 Apr 2018, Wolfram Sang wrote:

> This header only contains platform_data. Move it to the proper directory.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/i2c/busses/i2c-xiic.c                | 2 +-
>  drivers/mfd/timberdale.c                     | 2 +-
>  include/linux/{ => platform_data}/i2c-xiic.h | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename include/linux/{ => platform_data}/i2c-xiic.h (100%)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
