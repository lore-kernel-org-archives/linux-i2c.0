From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 8/9] iio: gyro: mpu3050: stop double error reporting
Date: Mon, 3 Apr 2017 19:56:02 +0200
Message-ID: <CACRpkdZMx4EEXqXzT435mE=yHkgCnFbtU0e__C0WD47L2cmjPw@mail.gmail.com>
References: <1491208718-32068-1-git-send-email-peda@axentia.se> <1491208718-32068-9-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:35230 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbdDCR4E (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 3 Apr 2017 13:56:04 -0400
Received: by mail-it0-f50.google.com with SMTP id y18so51245361itc.0
        for <linux-i2c@vger.kernel.org>; Mon, 03 Apr 2017 10:56:03 -0700 (PDT)
In-Reply-To: <1491208718-32068-9-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Peter Korsgaard <peter.korsgaard@barco.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>

On Mon, Apr 3, 2017 at 10:38 AM, Peter Rosin <peda@axentia.se> wrote:

> i2c_mux_add_adapter already logs a message on failure.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
