From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH 1/5] ARM: shmobile: kzm9g legacy: Set i2c clks_per_count
 to 2
Date: Mon, 10 Nov 2014 10:02:25 +0900
Message-ID: <20141110010225.GF16836@verge.net.au>
References: <1415274730-310-1-git-send-email-geert+renesas@glider.be>
 <1415274730-310-2-git-send-email-geert+renesas@glider.be>
 <20141107052420.GA1278@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141107052420.GA1278@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 07, 2014 at 06:24:21AM +0100, Wolfram Sang wrote:
> On Thu, Nov 06, 2014 at 12:52:06PM +0100, Geert Uytterhoeven wrote:
> > On sh73a0/kzm9g-legacy, probing of the i2c masters fails with:
> > 
> >     i2c-sh_mobile i2c-sh_mobile.0: timing values out of range: L/H=0x208/0x1bf
> >     sh_mobile: probe of i2c-sh_mobile.0 failed with error -22
> 
> Yay, so the warning I added found another bug \o/
> 
> > 
> > According to the datasheet, the transfer rate is derived from the HP
> > clock (which runs at 104 MHz) divided by two. Hence
> > i2c_sh_mobile_platform_data.clks_per_count should be set to two.
> > 
> > Now probing succeeds, and i2c works:
> > 
> >     i2c-sh_mobile i2c-sh_mobile.0: I2C adapter 0 with bus speed 100000 Hz (L/H=0x104/0xe0)
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> 
> Reviewed-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

Thanks, I have queued this up.
