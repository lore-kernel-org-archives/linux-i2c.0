From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH] i2c: exynos5: use core helper to get driver data
Date: Mon, 6 Mar 2017 12:32:44 -0300
Message-ID: <ec1304b4-ddf1-e1c4-6edd-03384dbb84f2@osg.samsung.com>
References: <CGME20170224133606eucas1p2c3c6afb60b9e39ad501c1ddbdbfc180f@eucas1p2.samsung.com>
 <1487943360-6421-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1487943360-6421-1-git-send-email-a.hajda@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>, Wolfram Sang <wsa@the-dreams.de>, Krzysztof Kozlowski <krzk@kernel.org>, linux-i2c@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-i2c@vger.kernel.org

Hello Andrzej,

On 02/24/2017 10:36 AM, Andrzej Hajda wrote:
> Driver core provides of_device_get_match_data which can be used
> to get driver data instead of custom helper.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
