From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 3/8] pinctrl: msm: Add ability for drivers to supply a
 reserved GPIO list
Date: Wed, 12 Jun 2019 09:25:47 +0200
Message-ID: <CACRpkdaXHC6dfOMMOj-a8o1zCzqqZoeQLEEAZ=XpPWKN_nf=9w@mail.gmail.com>
References: <20190610084213.1052-1-lee.jones@linaro.org> <20190610084213.1052-3-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610084213.1052-3-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alokc@codeaurora.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jeffrey Hugo <jlhugo@gmail.com>, linux-i2c <linux-i2c@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 10, 2019 at 10:42 AM Lee Jones <lee.jones@linaro.org> wrote:

> When booting MSM based platforms with Device Tree or some ACPI
> implementations, it is possible to provide a list of reserved pins
> via the 'gpio-reserved-ranges' and 'gpios' properties respectively.
> However some ACPI tables are not populated with this information,
> thus it has to come from a knowledgable device driver instead.
>
> Here we provide the MSM common driver with additional support to
> parse this informtion and correctly populate the widely used
> 'valid_mask'.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

I have queued patches 3 and 4 in the pin control tree on an
immutable branch with Bjorn's ACKs:
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
ib-qcom-acpi

I have also merge this to pinctrl's devel branch for next.

Yours,
Linus Walleij
