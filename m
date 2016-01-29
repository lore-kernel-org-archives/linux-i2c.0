From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v3] i2c: mt8173: add 4GB mode support in i2c driver.
Date: Fri, 29 Jan 2016 17:48:54 +0800
Message-ID: <CAGS+omB40onjA35r=8GZ74vKCWSTH8=8ui=Xj4M0qsmA14uDDA@mail.gmail.com>
References: <1454031331-9107-1-git-send-email-liguo.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454031331-9107-1-git-send-email-liguo.zhang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liguo Zhang <liguo.zhang@mediatek.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, srv_heupstream <srv_heupstream@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, Xudong Chen <xudong.chen@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, Linux I2C <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 29, 2016 at 9:35 AM, Liguo Zhang <liguo.zhang@mediatek.com> wrote:
> If 4GB mode is enable, we should add 4gb mode support in i2c driver.
> Set 4GB mode register to support 4GB mode.
>
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
