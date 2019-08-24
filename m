From: Qii Wang <qii.wang@mediatek.com>
Subject: Re: [PATCH v2] i2c: mediatek: disable zero-length transfers for mt8183
Date: Sat, 24 Aug 2019 11:23:20 +0800
Message-ID: <1566617000.19935.7.camel@mhfsdcap03>
References: <20190822094516.55130-1-hsinyi@chromium.org>
 <1566547772.19935.2.camel@mhfsdcap03>
 <CAJMQK-gb+A9dwyMqMcA5yaaXak9no8_=urwK0XbLnNAEGyZ_hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAJMQK-gb+A9dwyMqMcA5yaaXak9no8_=urwK0XbLnNAEGyZ_hg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Nicolas Boichat <drinkcat@chromium.org>, Alexandru M Stan <amstan@chromium.org>, Wolfram Sang <wsa@the-dreams.de>, Jun Gao <jun.gao@mediatek.com>, lkml <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Thomas Gleixner <tglx@linutronix.de>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 2019-08-23 at 16:13 +0800, Hsin-Yi Wang wrote:
> On Fri, Aug 23, 2019 at 4:09 PM Qii Wang <qii.wang@mediatek.com> wrote:
> 
> > >
> > >  static u32 mtk_i2c_functionality(struct i2c_adapter *adap)
> > >  {
> > > -     return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> > > +     if (adap->quirks->flags & I2C_AQ_NO_ZERO_LEN)
> > > +             return I2C_FUNC_I2C |
> > > +                     (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
> > > +     else
> > > +             return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> >
> > It can be removed?
> See previous discussion: https://patchwork.kernel.org/patch/10814391/#22484435
> but not all SoC's quirks has I2C_AQ_NO_ZERO_LEN.
ok, it looks good for me, thanks.
Reviewed-by: Qii Wang <qii.wang@mediatek.com>
