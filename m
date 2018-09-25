From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 3/3] i2c: i2c-qcom-geni: Simplify irq handler
Date: Tue, 25 Sep 2018 14:49:45 -0700
Message-ID: <CAD=FV=WWCrY3Kxa1qXXvYd4FM_8cAtWnKMm4mYU8zxEfQmHmVw@mail.gmail.com>
References: <20180924235235.182649-1-swboyd@chromium.org> <20180924235235.182649-3-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924235235.182649-3-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Mon, Sep 24, 2018 at 4:52 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't need to use goto here, we can just collapse the if statement
> and goto chain into multiple branches and then combine some duplicate
> completion calls into one big if statement. Let's do it to clean up code
> some more.
>
> Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Cc: Sagar Dharia <sdharia@codeaurora.org>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 70 +++++++++++++-----------------
>  1 file changed, 29 insertions(+), 41 deletions(-)

It doesn't gleam as powerfully the cleanups in patch 2/3 but this does
have a few nice readability improvements.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
