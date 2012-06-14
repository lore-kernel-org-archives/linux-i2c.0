From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] i2c: let the core register devices from devicetree
Date: Thu, 14 Jun 2012 09:31:49 +0200
Message-ID: <87ehpiwdqy.fsf@macbook.be.48ers.dk>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de> (Wolfram
 Sang's message of "Wed, 13 Jun 2012 23:12:10 +0200")
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
Cc: Viresh Kumar <viresh.kumar@st.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Haojian Zhuang <haojian.zhuang@marvell.com>, Grant Likely <grant.likely@secretlab.ca>, Laxman Dewangan <ldewangan@nvidia.com>, linux-i2c@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@nvidia.com>, Olof Johansson <olof@lixom.net>, Barry Song <21cnbao@gmail.com>, Jochen Friedrich <jochen@scram.de>, Deepak Sikri <deepak.sikri@st.com>, Li Yang <leoli@freescale.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Vitaly Wool <vitalywool@gmail.com>, Wolfram Sang <wolfram@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>, Rusty Russell <rusty@rustcorp.com.au>, Tang Yuantian <B29983@freescale.com>, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, Magnus
List-Id: linux-i2c@vger.kernel.org

>>>>> "Wolfram" == Wolfram Sang <w.sang@pengutronix.de> writes:

 Wolfram> Currently, every driver has to do it on its own, but it should
 Wolfram> be done in the core, like we already do with board_info
 Wolfram> structs.

 Wolfram> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
 Wolfram> ---

 Wolfram> Based on v3.5-rc2. Only build tested, I don't have a OF based device
 Wolfram> around at the moment.

Neither have I, but it looks good.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

 Wolfram> @Peter: Why does ocores do the device registration manually via
 Wolfram> platform_data instead of using board_info?

Because of dd14be4c274 (i2c-ocores: Can add I2C devices to the bus), a
patch I wasn't CC'ed on and haven't acked. I only noticed it later when
the I2C tree got merged into mainline.

-- 
Bye, Peter Korsgaard
