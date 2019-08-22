From: Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH RESEND] i2c: mediatek: disable zero-length transfers for mt8183
Date: Thu, 22 Aug 2019 17:35:02 +0800
Message-ID: <CAJMQK-hr5m_YETnObsgw8M5etm+9xL_KY=54V6==fSbY191F_g@mail.gmail.com>
References: <20190822055737.142384-1-hsinyi@chromium.org> <1566462278.26641.1.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1566462278.26641.1.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Nicolas Boichat <drinkcat@chromium.org>, Alexandru M Stan <amstan@chromium.org>, Jun Gao <jun.gao@mediatek.com>, lkml <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Qii Wang <qii.wang@mediatek.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 22, 2019 at 5:24 PM Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
>
> Why do you need to change this part?
>
> Joe.C
>
You're right. We don't need to change this. I'll revert this back.
