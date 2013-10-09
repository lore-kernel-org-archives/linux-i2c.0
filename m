From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/9] i2c: i2c-stu300: replace platform_driver_probe to
 support deferred probing
Date: Wed, 9 Oct 2013 15:37:57 +0200
Message-ID: <CACRpkdZ-UjuyybwyJpoO358raqyHe-p46REqPsYMwLZFHrQPoQ@mail.gmail.com>
References: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
	<1381264542-29396-5-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381264542-29396-5-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 8, 2013 at 10:35 PM, Wolfram Sang <wsa@the-dreams.de> wrote:

> Subsystems like pinctrl and gpio rightfully make use of deferred probing at
> core level. Now, deferred drivers won't be retried if they don't have a .probe
> function specified in the driver struct. Fix this driver to have that, so the
> devices it supports won't get lost in a deferred probe.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
