From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 2/3] i2c: i2c-qcom-geni: Simplify tx/rx functions
Date: Tue, 25 Sep 2018 14:49:34 -0700
Message-ID: <CAD=FV=X9yDF95NvuJGFMWJHBFS87VG4jJP946oH6w8gB3LGRvQ@mail.gmail.com>
References: <20180924235235.182649-1-swboyd@chromium.org> <20180924235235.182649-2-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924235235.182649-2-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Mon, Sep 24, 2018 at 4:52 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We never really look at the 'ret' local variable in these functions, so
> let's remove it to make way for shorter and simpler code. Furthermore,
> we can shorten some lines by adding two local variables for the SE and
> the message length so that everything fits in 80 columns and testing the
> 'dma_buf' local variable in lieu of the 'mode' local variable.  And
> kernel style is to leave the return statement by itself, detached from
> the rest of the function.
>
> Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Cc: Sagar Dharia <sdharia@codeaurora.org>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 79 ++++++++++++++----------------
>  1 file changed, 36 insertions(+), 43 deletions(-)

It's so polished I can see my reflection in it now.  Looks like this
snuck in a few other cleanups compared to v2 (move "gi2c->cur = ..."
to be common between tx/rx and removed a pointless init of time_left).
Seems good.  In total 7 lines shorter and easier to read.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
