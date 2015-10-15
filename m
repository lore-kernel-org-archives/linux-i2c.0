From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V3 5/6] clk: qoriq: Add ls1043a support.
Date: Wed, 14 Oct 2015 19:57:01 -0500
Message-ID: <1444870621.5185.223.camel@freescale.com>
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
 <1444822498-16477-6-git-send-email-B48286@freescale.com>
 <20151014183113.GE26883@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151014183113.GE26883@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: mark.rutland@arm.com, corbet@lwn.net, linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org, bhupesh.sharma@freescale.com, catalin.marinas@arm.com, mturquette@baylibre.com, Zhiqiang Hou <B48286@freescale.com>, will.deacon@arm.com, wim@iguana.be, linux-i2c@vger.kernel.org, wsa@the-dreams.de, Mingkai.Hu@freescale.com, leoli@freescale.com, Wenbin.Song@freescale.com, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shaohui.Xie@freescale.com
List-Id: linux-i2c@vger.kernel.org

On Wed, 2015-10-14 at 11:31 -0700, Stephen Boyd wrote:
> On 10/14, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <B48286@freescale.com>
> > 
> > Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> > ---
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> 

Could you ack my clock patchset that this depends on (if there are no 

objections)?  Mike Turquette acked the RFC version a while back, but it's 

changed a bit since then (including the new clk_get_num_parents() and 

clk_get_parent_by_index() -- I CCed Russell King on that but got no 

response), and got no response when I asked whether the ack was still good 

for v3.

-Scott
