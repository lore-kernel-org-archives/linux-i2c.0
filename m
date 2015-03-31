From: Eddie Huang <eddie.huang@mediatek.com>
Subject: Re: [PATCH v5 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Tue, 31 Mar 2015 19:50:58 +0800
Message-ID: <1427802658.32196.8.camel@mtksdaap41>
References: <1426917922-61356-1-git-send-email-eddie.huang@mediatek.com>
	 <1426917922-61356-3-git-send-email-eddie.huang@mediatek.com>
	 <20150323084237.GG9742@pengutronix.de>
	 <1427703252.26464.14.camel@mtksdaap41>
	 <20150330172309.GB9742@pengutronix.de>
	 <1427785715.3500.16.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427785715.3500.16.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Doug Anderson <dianders@chromium.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, David Box <david.e.box@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Jean Delvare <jdelvare@suse.de>, Xudong Chen =?UTF-8?Q?=28=E9=99=88=E6=97=AD=E4=B8=9C=29?= <Xudong.Chen@mediatek.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Pawel Moll <pawel.moll@arm.com>, Liguo Zhang =?UTF-8?Q?=28=E5=BC=A0=E7=AB=8B=E5=9B=BD=29?= <Liguo.Zhang@mediatek.com>, Wei Yan <sledge.yanwei@huawei.com>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Beniamino Galvani <b.ga>
List-Id: linux-i2c@vger.kernel.org

Hi Sascha,

On Tue, 2015-03-31 at 15:08 +0800, Eddie Huang wrote:
> Hi Sascha,
> 
> On Mon, 2015-03-30 at 19:23 +0200, Sascha Hauer wrote:
> > On Mon, Mar 30, 2015 at 04:14:12PM +0800, Eddie Huang wrote:
> > > Hi Sascha,
> > >
> > > >
> > > > [...]
> > > >
> > > > > +       if (i2c->speed_hz > 400000)
> > > > > +               control_reg |= I2C_CONTROL_RS;
> > > > > +       if (i2c->op == I2C_MASTER_WRRD)
> > > > > +               control_reg |= I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS;
> > > > > +       mtk_i2c_writew(control_reg, i2c, OFFSET_CONTROL);
> > > > > +
> > > > > +       /* set start condition */
> > > > > +       if (i2c->speed_hz <= 100000)
> > > > > +               mtk_i2c_writew(I2C_ST_START_CON, i2c, OFFSET_EXT_CONF);
> > > > > +       else
> > > > > +               mtk_i2c_writew(I2C_FS_START_CON, i2c, OFFSET_EXT_CONF);
> > > > > +
> > > > > +       if (~control_reg & I2C_CONTROL_RS)
> > > > > +               mtk_i2c_writew(I2C_DELAY_LEN, i2c, OFFSET_DELAY_LEN);
> > > >
> > > > speed <= 400000 here to make this more obvious?
> > > There are two cases, not only speed<=400000, but I2C_MASTER_WRRD. I tend
> > > to keep it.
> >
> > Still it looks strange. You only ever write this default value to the
> > register. Putting this register write under an if() seems bogus since
> > the same value will be in the register the next time this code is
> > executed. It looks like you should move this register write to some
> > initialization function.
> OK, move to mtk_i2c_init_hw function
> 
Sorry for my negligence. Write-then-read (I2C_MASTER_WRRD) decides
according to each I2C transfer, so I still need to judge whether set
I2C_CONTROL_RS and DELAY_LEN here. Other control setting can move to
init function.

Eddie
