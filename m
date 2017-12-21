From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 5/5] eeprom: at24: extend the list of chips supported in DT
Date: Thu, 21 Dec 2017 14:22:46 +0100
Message-ID: <CABxcv=mbK23MbByOXLu0a1xfbVq6ZRc3Jv90JVDz0Fut6dz2Fw@mail.gmail.com>
References: <20171221130830.16813-1-brgl@bgdev.pl> <20171221130830.16813-6-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:39071 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752617AbdLUNWr (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Dec 2017 08:22:47 -0500
Received: by mail-io0-f179.google.com with SMTP id g70so8472975ioj.6
        for <linux-i2c@vger.kernel.org>; Thu, 21 Dec 2017 05:22:46 -0800 (PST)
In-Reply-To: <20171221130830.16813-6-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>, Linux I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Thu, Dec 21, 2017 at 2:08 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> Add all supported at24 variants to the of_match table.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier
