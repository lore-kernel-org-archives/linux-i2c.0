From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/3] i2c: qcom-geni: Let firmware specify irq trigger flags
Date: Tue, 4 Feb 2020 13:17:54 -0800
Message-ID: <CAD=FV=Wf99AkNqtJ_W92sDNGS3dKQN3FK3960-=Oq8sJf7kKVA@mail.gmail.com>
References: <20200204193152.124980-1-swboyd@chromium.org> <20200204193152.124980-2-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39717 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgBDVSH (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 4 Feb 2020 16:18:07 -0500
Received: by mail-ua1-f65.google.com with SMTP id 73so31194uac.6
        for <linux-i2c@vger.kernel.org>; Tue, 04 Feb 2020 13:18:07 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id d191sm4160842vka.37.2020.02.04.13.18.05
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 13:18:06 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id t12so12427107vso.13
        for <linux-i2c@vger.kernel.org>; Tue, 04 Feb 2020 13:18:05 -0800 (PST)
In-Reply-To: <20200204193152.124980-2-swboyd@chromium.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-i2c@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Girish Mahadevan <girishm@codeaurora.org>, Dilip Kota <dkota@codeaurora.org>, Alok Chauhan <alokc@codeaurora.org>

Hi,

On Tue, Feb 4, 2020 at 11:31 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't need to force IRQF_TRIGGER_HIGH here as the DT or ACPI tables
> should take care of this for us. Just use 0 instead so that we use the
> flags from the firmware. Also, remove specify dev_name() for the irq
> name so that we can get better information in /proc/interrupts about
> which device is generating interrupts.
>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Dilip Kota <dkota@codeaurora.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
