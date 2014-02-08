From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH] i2c: mv64xxx: Fix locked bus when offload is selected
 but not used on a message
Date: Sat, 8 Feb 2014 12:01:28 -0500
Message-ID: <20140208170128.GI8533@titan.lakedaemon.net>
References: <1391770588-1344-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391770588-1344-1-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 07, 2014 at 11:55:54AM +0100, Gregory CLEMENT wrote:
> Offload can be used only on regular transactions and for 1 to byte
> transfers. In the other cases we switch back to usual work flow.
> 
> In this case we need to call mv64xxx_i2c_prepare_for_io() as this
> function is not used when we try to use offloading.
> 
> This commit adds this missing call when offloading have failed in the
> MV64XXX_I2C_ACTION_OFFLOAD_SEND_START case.
> 
> This fix the timeout seen when the the i2c driver try to access an
> address where the device is absent on the Armada XP bases board.
> 
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v3.12+
> Fixes: 930ab3d403ae (i2c: mv64xxx: Add I2C Transaction Generator support)
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Acked-by: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>

thx,

Jason.
