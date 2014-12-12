From: Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: [PATCH v3 0/2] ARM: mediatek: Add driver for Mediatek I2C
 controller
Date: Fri, 12 Dec 2014 10:40:22 +0800
Message-ID: <1418352022.4994.44.camel@mtksdaap41>
References: <1416821928-11453-1-git-send-email-xudong.chen@mediatek.com>
 <20141124121555.GG3733@katana> <1417096856.12707.59.camel@mtksdaap41>
 <20141127164536.GC5667@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141127164536.GC5667@katana>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, Xudong Chen <xudong.chen@mediatek.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, YH Chen <yh.chen@mediatek.com>, Liguo Zhang <Liguo.Zhang@mediatek.com>, Nathan Chung <nathan.chung@mediatek.com>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2014-11-27 at 17:45 +0100, Wolfram Sang wrote:
> > > I think there are now 3 drivers in my queue which are not fully I2C
> > > compatible but more supporting the very minimum to, say, read an eeprom.
> > > I am not feeling well to allow them to use I2C_FUNC_I2C. So, I want to
> > > think about ways how to communicate deficiencies like "only 255 byte" or
> > > "only WRRD messages" to users of that I2C controller. This is most
> > > likely not happening before 3.19. But assistance is very welcome.

Hi Wolfram,

We've started upstream work for MT8173[1].

We've fixed these issues for new SoC, and we believe it is fully I2C
compatible now. We'll add mt8173 support to this driver, so this driver
will support both fully I2C compatible SoC and the current one.

Joe.C

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/309847.html
