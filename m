From: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v5 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Wed, 1 Apr 2015 10:11:17 +0800
Message-ID: <1427854277.21285.15.camel@mtksdaap41>
References: <1426917922-61356-1-git-send-email-eddie.huang@mediatek.com>
	 <1426917922-61356-3-git-send-email-eddie.huang@mediatek.com>
	 <20150323084237.GG9742@pengutronix.de>
	 <1427703252.26464.14.camel@mtksdaap41>
	 <20150330172309.GB9742@pengutronix.de>
	 <1427785715.3500.16.camel@mtksdaap41> <1427802658.32196.8.camel@mtksdaap41>
	 <20150331175234.GK9742@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150331175234.GK9742-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Xudong Chen =?UTF-8?Q?=28=E9=99=88=E6=97=AD=E4=B8=9C=29?= <Xudong.Chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Liguo Zhang =?UTF-8?Q?=28=E5=BC=A0=E7=AB=8B=E5=9B=BD=29?= <Liguo.Zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Uwe Kleine-Konig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Beniamino Galvani <b.ga>
List-Id: linux-i2c@vger.kernel.org

Hi Sascha,

On Tue, 2015-03-31 at 19:52 +0200, Sascha Hauer wrote:
> On Tue, Mar 31, 2015 at 07:50:58PM +0800, Eddie Huang wrote:
> > Hi Sascha,
> > 
> > On Tue, 2015-03-31 at 15:08 +0800, Eddie Huang wrote:
> > > Hi Sascha,
> > > 
> > > > > > speed <= 400000 here to make this more obvious?
> > > > > There are two cases, not only speed<=400000, but I2C_MASTER_WRRD. I tend
> > > > > to keep it.
> > > >
> > > > Still it looks strange. You only ever write this default value to the
> > > > register. Putting this register write under an if() seems bogus since
> > > > the same value will be in the register the next time this code is
> > > > executed. It looks like you should move this register write to some
> > > > initialization function.
> > > OK, move to mtk_i2c_init_hw function
> > > 
> > Sorry for my negligence. Write-then-read (I2C_MASTER_WRRD) decides
> > according to each I2C transfer, so I still need to judge whether set
> > I2C_CONTROL_RS and DELAY_LEN here. Other control setting can move to
> > init function.
> 
> You need to decide whether you have to set the I2C_CONTROL_RS bit, but
> you don't need to write the same value to the DELAY_LEN register each
> time. It won't change under your hood.
> 
Yes, you are right. DELAY_LEN should only be set one time in init
function. Thanks your correction.

Eddie
