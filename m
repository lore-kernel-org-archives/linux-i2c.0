From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V3 5/6] clk: qoriq: Add ls1043a support.
Date: Mon, 14 Dec 2015 17:32:59 -0600
Message-ID: <1450135979.15946.406.camel@freescale.com>
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
	 <1444822498-16477-6-git-send-email-B48286@freescale.com>
	 <20151014183113.GE26883@codeaurora.org>
	 <1444870621.5185.223.camel@freescale.com>
	 <20151015195456.GT4558@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20151015195456.GT4558@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Zhiqiang Hou <B48286@freescale.com>, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, mark.rutland@arm.com, Mingkai.Hu@freescale.com, Shaohui.Xie@freescale.com, bhupesh.sharma@freescale.com, leoli@freescale.com, wsa@the-dreams.de, wim@iguana.be, corbet@lwn.net, mturquette@baylibre.com, Wenbin.Song@freescale.com, Russell King <linux@arm.linux.org.uk>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2015-10-15 at 12:54 -0700, Stephen Boyd wrote:
> On 10/14, Scott Wood wrote:
> > On Wed, 2015-10-14 at 11:31 -0700, Stephen Boyd wrote:
> > > On 10/14, Zhiqiang Hou wrote:
> > > > From: Hou Zhiqiang <B48286@freescale.com>
> > > > 
> > > > Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> > > > ---
> > > 
> > > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> > > 
> > 
> > Could you ack my clock patchset that this depends on (if there are no 
> > 
> > objections)?  Mike Turquette acked the RFC version a while back, but it's 
> > 
> > changed a bit since then (including the new clk_get_num_parents() and 
> > 
> > clk_get_parent_by_index() -- I CCed Russell King on that but got no 
> > 
> > response), and got no response when I asked whether the ack was still good
> > 
> > for v3.
> > 
> > 
> 
> Done. The consumer APIs look ok too, but I'd like to see if
> Russell has any comments.

I've pinged Russell several times and gotten no response -- how should we
proceed?

-Scott

