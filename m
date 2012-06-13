From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] i2c: let the core register devices from devicetree
Date: Wed, 13 Jun 2012 16:03:30 -0600
Message-ID: <4FD90E32.5040309@wwwdotorg.org>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Viresh Kumar <viresh.kumar@st.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Jochen Friedrich <jochen@scram.de>, Grant Likely <grant.likely@secretlab.ca>, Laxman Dewangan <ldewangan@nvidia.com>, linux-i2c@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@nvidia.com>, Barry Song <21cnbao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Deepak Sikri <deepak.sikri@st.com>, Li Yang <leoli@freescale.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Vitaly Wool <vitalywool@gmail.com>, Wolfram Sang <wolfram@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>, Rusty Russell <rusty@rustcorp.com.au>, Tang Yuantian <B29983@freescale.com>, Jean Delvare (PC
List-Id: linux-i2c@vger.kernel.org

On 06/13/2012 03:12 PM, Wolfram Sang wrote:
> Currently, every driver has to do it on its own, but it should be done
> in the core, like we already do with board_info structs.

At least on Tegra this works fine,
Tested-by: Stephen Warren <swarren@wwwdotorg.org>
