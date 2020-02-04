From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH 1/3] i2c: qcom-geni: Let firmware specify irq trigger flags
Date: Tue, 4 Feb 2020 13:05:27 -0800
Message-ID: <CAFd5g45FtwHyfptDEZJ=QJT1uRcwWa6+sHgqaodcNGD4izmT5w@mail.gmail.com>
References: <20200204193152.124980-1-swboyd@chromium.org> <20200204193152.124980-2-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200204193152.124980-2-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Girish Mahadevan <girishm@codeaurora.org>, Dilip Kota <dkota@codeaurora.org>, Alok Chauhan <alokc@codeaurora.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 4, 2020 at 11:32 AM Stephen Boyd <swboyd@chromium.org> wrote:
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

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Seems pretty straightforward to me.
