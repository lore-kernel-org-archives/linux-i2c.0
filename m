From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 2/2] rtc: s35390a: convert to
 devm_i2c_new_dummy_device()
Date: Sun, 1 Sep 2019 11:03:29 +0200
Message-ID: <20190901090329.GY21922@piout.net>
References: <20190830133124.21633-1-wsa+renesas@sang-engineering.com>
 <20190830133124.21633-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190830133124.21633-3-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 30/08/2019 15:31:24+0200, Wolfram Sang wrote:
> I was about to simplify the call to i2c_unregister_device() when I
> realized that converting to devm_i2c_new_dummy_device() will simplify
> the driver a lot. So I took this approach.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/rtc/rtc-s35390a.c | 54 ++++++++++-----------------------------
>  1 file changed, 13 insertions(+), 41 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
