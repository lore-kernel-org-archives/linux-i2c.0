From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v3 03/13] ARM: dts: rockchip: add i2c dt node for rv1108
Date: Sun, 13 Aug 2017 14:07:23 +0200
Message-ID: <2959487.ZoJNOzBQYB@phil>
References: <1502422578-30611-1-git-send-email-andy.yan@rock-chips.com> <1502422790-30776-1-git-send-email-andy.yan@rock-chips.com> <20170812144047.w3oe432bw3rwhzxb@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170812144047.w3oe432bw3rwhzxb@ninjato>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Am Samstag, 12. August 2017, 16:40:47 CEST schrieb Wolfram Sang:
> On Fri, Aug 11, 2017 at 11:39:50AM +0800, Andy Yan wrote:
> > There are four i2c controllers on rv1108, add
> > device tree node for them.
> > 
> > Signed-off-by: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> 
> This usually needs to go via some arm tree.

correct, and with the driver side being applied I've now also
applied this devicetree patch for 4.14
[With some slight reordering of properties]


Thanks
Heiko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
