From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 2/5] dt-bindings: at24: add a missing compatible
Date: Thu, 21 Dec 2017 14:20:51 +0100
Message-ID: <CABxcv=kKCoWFfDKq_8-PBoP0fX5AOnMpdMEGBxnwN6445uYViQ@mail.gmail.com>
References: <20171221130830.16813-1-brgl@bgdev.pl> <20171221130830.16813-3-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:37728 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbdLUNUw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Dec 2017 08:20:52 -0500
Received: by mail-io0-f174.google.com with SMTP id d16so21055211iob.4
        for <linux-i2c@vger.kernel.org>; Thu, 21 Dec 2017 05:20:52 -0800 (PST)
In-Reply-To: <20171221130830.16813-3-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>, Linux I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Thu, Dec 21, 2017 at 2:08 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> "atmel,spd" is reported by checkpatch as undocumented in the device
> tree bindings. Add it to the list of supported compatible strings.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier
