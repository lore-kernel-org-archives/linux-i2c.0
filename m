From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 5/5] ARM: shmobile: r8a73a4 dtsi: Add SoC-specific IIC
 compatible properties
Date: Mon, 10 Nov 2014 10:04:47 +0900
Message-ID: <20141110010447.GG16836@verge.net.au>
References: <1415274730-310-1-git-send-email-geert+renesas@glider.be>
 <1415274730-310-6-git-send-email-geert+renesas@glider.be>
 <20141107052616.GC1278@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141107052616.GC1278@katana>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 07, 2014 at 06:26:16AM +0100, Wolfram Sang wrote:
> On Thu, Nov 06, 2014 at 12:52:10PM +0100, Geert Uytterhoeven wrote:
> > The IIC nodes used the generic compatible properties only.
> > This may cause the driver to fail when using Standard Speed on IIC
> > masters where the operational clock is driven by the 130 MHz HP clock.
> > 
> > Add the SoC-specific compatible property to fix this.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, I have queued this up.

