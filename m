From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] sfc: falcon: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 19:31:45 -0700 (PDT)
Message-ID: <20200326.193145.1768651462214618265.davem@davemloft.net>
References: <20200326211001.13171-1-wsa+renesas@sang-engineering.com>
        <20200326211001.13171-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326211001.13171-3-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org, linux-net-drivers@solarflare.com, ecree@solarflare.com, mhabets@solarflare.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Thu, 26 Mar 2020 22:10:00 +0100

> Move away from the deprecated API and return the shiny new ERRPTR where
> useful.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied.
