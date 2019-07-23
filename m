From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/4] rtc: max77686: convert to i2c_new_dummy_device
Date: Tue, 23 Jul 2019 17:27:01 +0200
Message-ID: <CAJKOXPcjEnrBiCD_cBDaeWcVqEDh4k8Lyx6cN=XCwuuytxK72w@mail.gmail.com>
References: <20190722172618.4061-1-wsa+renesas@sang-engineering.com> <20190722172618.4061-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172618.4061-3-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 22 Jul 2019 at 19:26, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.
>
>  drivers/rtc/rtc-max77686.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
