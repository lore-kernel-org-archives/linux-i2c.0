From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v3 2/2] i2c: imx:
 Add Vybrid VF610 I2C controller support
Date: Wed, 14 Aug 2013 11:29:21 +0800
Message-ID: <20130814032812.GB16915@S2101-09.ap.freescale.net>
References: <1375418648-22760-1-git-send-email-b35083@freescale.com>
 <1375418648-22760-2-git-send-email-b35083@freescale.com>
 <20130810140827.GC18085@e106331-lin.cambridge.arm.com>
 <B56CDBE15CE27145A4B77D2D24263E851FE7AC@039-SN1MPN1-004.039d.mgd.msft.net>
 <20130812164354.GF27165@e106331-lin.cambridge.arm.com>
 <52096E77.4040003@wwwdotorg.org>
 <20130813074620.GR26614@pengutronix.de>
 <520A5558.708@wwwdotorg.org>
 <20130813161214.GV26614@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20130813161214.GV26614@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, ian.campbell@citrix.com, pawel.moll@arm.com, "wsa@the-dreams.de" <wsa@the-dreams.de>, Estevam Fabio-R49496 <r49496@freescale.com>, Stephen Warren <swarren@wwwdotorg.org>, tomasz.figa@gmail.com, rob.herring@calxeda.com, Jin Zhengxiong-R64188 <R64188@freescale.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, galak@codeaurora.org, Lu Jingchang-B35083 <B35083@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, grant.likely@linaro.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 13, 2013 at 06:12:14PM +0200, s.hauer@pengutronix.de wrote:
> I vote for having the exact SoC revision in the binding documentation
> rather than wildcards or references to the list of i.MX SoCs. Otherwise
> only the driver code gives a clue that the i2c driver matches imx1-i2c,
> imx21-i2c and vf610-i2c, but not imx31-i2c.

+1

Shawn
