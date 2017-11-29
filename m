From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 05/15] gpio: max732x: Remove duplicate NULL check
Date: Wed, 29 Nov 2017 13:26:01 +0100
Message-ID: <CACRpkdZU3ik2p+ugq3FT2dEuXKq0Cfe+uvZC38j6pCHOaRG1ZA@mail.gmail.com>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com> <20171031142149.32512-5-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:37987 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbdK2M0C (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 29 Nov 2017 07:26:02 -0500
Received: by mail-io0-f178.google.com with SMTP id d14so3473585ioc.5
        for <linux-i2c@vger.kernel.org>; Wed, 29 Nov 2017 04:26:02 -0800 (PST)
In-Reply-To: <20171031142149.32512-5-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org

On Tue, Oct 31, 2017 at 3:21 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Since i2c_unregister_device() became NULL-aware we may remove duplicate
> NULL check.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

For some reason this was missed since halloween.
Patch applied.

Yours,
Linus Walleij
