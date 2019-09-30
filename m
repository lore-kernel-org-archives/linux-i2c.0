From: Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v2] i2c: i2c-mt65xx: fix NULL ptr dereference
Date: Mon, 30 Sep 2019 16:26:46 -0700
Message-ID: <CAJMQK-g_PaNsfvX-H4_BA86aUOdyqpDt9oK86O7_mRWTjWSjHQ@mail.gmail.com>
References: <20190930152846.5062-1-fparent@baylibre.com> <aa0487c21e1f9f04402f209358b18c75@kernel.wtf>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aa0487c21e1f9f04402f209358b18c75@kernel.wtf>
Sender: linux-kernel-owner@vger.kernel.org
To: Cengiz Can <cengiz@kernel.wtf>
Cc: Fabien Parent <fparent@baylibre.com>, linux-i2c@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Qii Wang <qii.wang@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 30, 2019 at 2:20 PM Cengiz Can <cengiz@kernel.wtf> wrote:
>
> On 2019-09-30 18:28, Fabien Parent wrote:
> > Fixes: abf4923e97c3 ("i2c: mediatek: disable zero-length transfers for
> > mt8183")
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
>
> Reviewed-by: Cengiz Can <cengiz@kernel.wtf>
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

Thanks!
