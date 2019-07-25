From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: sfc: falcon: convert to i2c_new_dummy_device
Date: Thu, 25 Jul 2019 11:19:38 -0700 (PDT)
Message-ID: <20190725.111938.1711332352368320537.davem@davemloft.net>
References: <20190722172635.4535-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190722172635.4535-1-wsa+renesas@sang-engineering.com>
Sender: netdev-owner@vger.kernel.org
To: wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org, linux-net-drivers@solarflare.com, ecree@solarflare.com, mhabets@solarflare.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Mon, 22 Jul 2019 19:26:35 +0200

> Move from i2c_new_dummy() to i2c_new_dummy_device(). So, we now get an
> ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied.
