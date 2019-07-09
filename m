From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/3] of: unittest: simplify getting the adapter of a
 client
Date: Mon, 8 Jul 2019 20:23:38 -0600
Message-ID: <20190709022338.GA18910@bogus>
References: <20190610095157.11814-1-wsa+renesas@sang-engineering.com>
 <20190610095157.11814-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190610095157.11814-4-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 10 Jun 2019 11:51:56 +0200, Wolfram Sang wrote:
> We have a dedicated pointer for that, so use it. Much easier to read and
> less computation involved.
> 
> Reported-by: Peter Rosin <peda@axentia.se>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Please apply to your subsystem tree.
> 
>  drivers/of/unittest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
