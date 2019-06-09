From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 28/34] rtc: rv8803: simplify getting the adapter of a
 client
Date: Sun, 9 Jun 2019 16:49:04 +0200
Message-ID: <20190609144904.GD25472@piout.net>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
 <20190608105619.593-29-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190608105619.593-29-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 08/06/2019 12:56:07+0200, Wolfram Sang wrote:
> We have a dedicated pointer for that, so use it. Much easier to read and
> less computation involved.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Please apply to your subsystem tree.
> 
>  drivers/rtc/rtc-rv8803.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
