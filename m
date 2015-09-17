From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/4] i2c: stu300: Fix module autoload for OF platform driver
Date: Thu, 17 Sep 2015 22:52:10 +0200
Message-ID: <CACRpkdb6NxPq07L_L9g_7mOX9c9LREM4o9nPUdbXTDid6S0PNA@mail.gmail.com>
References: <20150917163647.GA26265@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150917163647.GA26265@goodgumbo.baconseed.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 17, 2015 at 6:36 PM, Luis de Bethencourt
<luis@debethencourt.com> wrote:

> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
>
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
