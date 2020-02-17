From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH] i2c: omap: use devm_platform_ioremap_resource()
Date: Mon, 17 Feb 2020 09:13:24 +0100
Message-ID: <0e6c38d0-e3fd-de24-a24e-33aa4168bcee@lucaceresoli.net>
References: <1581755803-11242-1-git-send-email-qiwuchen55@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1581755803-11242-1-git-send-email-qiwuchen55@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: qiwuchen55@gmail.com, vigneshr@ti.com, tony@atomide.com, aaro.koskinen@iki.fi
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
List-Id: linux-i2c@vger.kernel.org

Hi,

On 15/02/20 09:36, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Use a new API devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>

Tested-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>

-- 
Luca
