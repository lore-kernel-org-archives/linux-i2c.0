From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 03/14] mfd: ab3100-core: convert to i2c_new_dummy_device
Date: Tue, 23 Jul 2019 10:30:02 +0200
Message-ID: <CACRpkdb4CtiiYbSwHEcC4godbRBA3DmABCHpx5_OKUCfxgcUSg@mail.gmail.com>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com> <20190722172623.4166-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172623.4166-4-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 22, 2019 at 7:26 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
