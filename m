From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 06/12] i2c: sh_mobile: Convert to clk_prepare/unprepare
Date: Tue, 29 Oct 2013 10:41:57 +0100
Message-ID: <1931500.glV2j5U5NL@avalon>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20131029050224.GA2643@katana> <20131029055807.GE11580@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20131029055807.GE11580@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Simon,

On Tuesday 29 October 2013 14:58:07 Simon Horman wrote:
> On Tue, Oct 29, 2013 at 06:02:24AM +0100, Wolfram Sang wrote:
> > On Mon, Oct 28, 2013 at 11:49:23PM +0100, Laurent Pinchart wrote:
> > > Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
> > > clk_disable_unprepare() to get ready for the migration to the common
> > > clock framework.
> > > 
> > > Cc: Wolfram Sang <wsa@the-dreams.de>
> > > Cc: linux-i2c@vger.kernel.org
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > Acked-by: Wolfram Sang <wsa@the-dreams.de>
> 
> Hi Wolfram, Hi Laurent,
> 
> correct me if I am wrong, but I think the plan was
> for Wolfram to take this patch.

That's correct. All patches in this series will need to go through their 
respective maintainers' git trees. It's going to be slightly painful to track 
on my side, but that means less work on your side :-)

As mentioned in the cover letter, I won't send a pull request for this series, 
so I expect all maintainers involved to pick their share of patches from the 
list.

-- 
Regards,

Laurent Pinchart

