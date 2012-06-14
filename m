From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] i2c: let the core register devices from devicetree
Date: Thu, 14 Jun 2012 21:35:24 +1000
Message-ID: <1339673724.9220.164.camel@pasglop>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
 <1339623217.9220.119.camel@pasglop> <20120614091434.GB14419@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120614091434.GB14419@pengutronix.de>
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
Cc: Viresh Kumar <viresh.kumar@st.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Laxman Dewangan <ldewangan@nvidia.com>, linux-i2c@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@nvidia.com>, Barry Song <21cnbao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Deepak Sikri <deepak.sikri@st.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Wolfram Sang <wolfram@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>, Rusty Russell <rusty@rustcorp.com.au>, Tang Yuantian <B29983@freescale.com>, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, Magnus Damm <damm@opensource.se>, Lars-Peter Clausen <lars@metafoo.de>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, linux-arm-ke
List-Id: linux-i2c@vger.kernel.org

On Thu, 2012-06-14 at 11:14 +0200, Wolfram Sang wrote:
> On Thu, Jun 14, 2012 at 07:33:37AM +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2012-06-13 at 23:12 +0200, Wolfram Sang wrote:
> > > Currently, every driver has to do it on its own, but it should be done
> > > in the core, like we already do with board_info structs.
> > > 
> > > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > > ---
> > > 
> > > Based on v3.5-rc2. Only build tested, I don't have a OF based device
> > > around at the moment.
> > 
> > Won't that conflict with i2c-powermac doing it its own way ?
> 
> Yup :(
> 
> I assume there is no chance that the powermac devicetree can be
> pre-processed to be compatible with of_i2c_register_devices?

That would be nasty and need a lot of testing on all sort of machines I
don't have direct access to.

Maybe we can set a flag somewhere to indicate to the core not to run the
default probing on that controller ?

Cheers,
Ben.
