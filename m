From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 20/21] i2c: stu300: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 21:54:44 +0200
Message-ID: <CACRpkdbE+wjocxyg0yx7im=220F7Cb2RhRYsXKEFhUnaaDStCg@mail.gmail.com>
References: <20180514145330.4857-1-peda@axentia.se> <20180514145330.4857-21-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514145330.4857-21-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, May 14, 2018 at 4:53 PM, Peter Rosin <peda@axentia.se> wrote:

> Because it looks neater.
>
> Also restructure debug output for resends, since that code as a
> result is only handling debug output.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Looks good to me!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
