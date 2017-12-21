From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 4/5] dt-bindings: at24: extend the list of supported chips
Date: Thu, 21 Dec 2017 14:22:14 +0100
Message-ID: <CABxcv==EkRG4sUNxHNdOGwXeMH9aHB8P2CKvZXDcgTORgRuVRA@mail.gmail.com>
References: <20171221130830.16813-1-brgl@bgdev.pl> <20171221130830.16813-5-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:35385 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbdLUNWP (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Dec 2017 08:22:15 -0500
Received: by mail-it0-f41.google.com with SMTP id f143so10842502itb.0
        for <linux-i2c@vger.kernel.org>; Thu, 21 Dec 2017 05:22:15 -0800 (PST)
In-Reply-To: <20171221130830.16813-5-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>, Linux I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Thu, Dec 21, 2017 at 2:08 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> Add other variants of at24 EEPROMs we support in the driver to the

Again I wouldn't mention the driver here, but instead say that there
are variations of the chip that are compatible or something like that.

> list of allowed compatible strings.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier
