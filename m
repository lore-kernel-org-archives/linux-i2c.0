From: Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v2] i2c: mediatek: disable zero-length transfers for mt8183
Date: Fri, 23 Aug 2019 16:13:29 +0800
Message-ID: <CAJMQK-gb+A9dwyMqMcA5yaaXak9no8_=urwK0XbLnNAEGyZ_hg@mail.gmail.com>
References: <20190822094516.55130-1-hsinyi@chromium.org> <1566547772.19935.2.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1566547772.19935.2.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
To: Qii Wang <qii.wang@mediatek.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Nicolas Boichat <drinkcat@chromium.org>, Jun Gao <jun.gao@mediatek.com>, Thomas Gleixner <tglx@linutronix.de>, linux-i2c@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, Alexandru M Stan <amstan@chromium.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 23, 2019 at 4:09 PM Qii Wang <qii.wang@mediatek.com> wrote:

> >
> >  static u32 mtk_i2c_functionality(struct i2c_adapter *adap)
> >  {
> > -     return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> > +     if (adap->quirks->flags & I2C_AQ_NO_ZERO_LEN)
> > +             return I2C_FUNC_I2C |
> > +                     (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
> > +     else
> > +             return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>
> It can be removed?
See previous discussion: https://patchwork.kernel.org/patch/10814391/#22484435
but not all SoC's quirks has I2C_AQ_NO_ZERO_LEN.
