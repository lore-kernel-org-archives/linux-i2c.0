From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: smbus: kill memory leak on emulated and failed DMA
 SMBus xfers
Date: Tue, 26 Jun 2018 11:37:24 +0900
Message-ID: <20180626023723.dwsr2b4tdsi6duax@ninjato>
References: <20180620094323.8447-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180620094323.8447-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 20, 2018 at 11:43:23AM +0200, Peter Rosin wrote:
> If DMA safe memory was allocated, but the subsequent I2C transfer
> fails the memory is leaked. Plug this leak.
> 
> Fixes: 8a77821e74d6 ("i2c: smbus: use DMA safe buffers for emulated SMBus transactions")
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to for-current, thanks!
