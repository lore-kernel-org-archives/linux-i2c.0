From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH 3/3] i2c: qcom-geni: Drop of_platform.h include
Date: Tue, 4 Feb 2020 13:20:51 -0800
Message-ID: <CAFd5g45KEKd0NcorYyxpw84FX=H8yeBz8i+GJWEvrMN3Z9aGkw@mail.gmail.com>
References: <20200204193152.124980-1-swboyd@chromium.org> <20200204193152.124980-4-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33962 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgBDVVG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 4 Feb 2020 16:21:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id j4so10321337pgi.1
        for <linux-i2c@vger.kernel.org>; Tue, 04 Feb 2020 13:21:05 -0800 (PST)
In-Reply-To: <20200204193152.124980-4-swboyd@chromium.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Girish Mahadevan <girishm@codeaurora.org>, Dilip Kota <dkota@codeaurora.org>, Alok Chauhan <alokc@codeaurora.org>, Douglas Anderson <dianders@chromium.org>

On Tue, Feb 4, 2020 at 11:32 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This driver doesn't call any DT platform functions like of_platform_*().
> Remove the include as it isn't used.
>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Dilip Kota <dkota@codeaurora.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
