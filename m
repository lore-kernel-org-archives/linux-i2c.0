From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 2/2] i2c: i2c-qcom-geni: Simplify tx/rx functions
Date: Thu, 20 Sep 2018 13:22:37 -0700
Message-ID: <CAD=FV=U=r0nkT+JO2j4WUHF03ZiJcmaVrzL6dsauDHV=a2m3tQ@mail.gmail.com>
References: <20180920180323.217377-1-swboyd@chromium.org> <20180920180323.217377-3-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920180323.217377-3-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

Hi,
On Thu, Sep 20, 2018 at 11:03 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We never really look at the 'ret' local variable in these functions, so
> let's remove it to make way for shorter and simpler code. Furthermore,
> we can shorten some lines by adding two local variables for the SE and
> the message length so that everything fits in 80 columns. And kernel
> style is to leave the return statement by itself, detached from the rest
> of the function.
>
> Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Cc: Sagar Dharia <sdharia@codeaurora.org>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 54 ++++++++++++++----------------
>  1 file changed, 25 insertions(+), 29 deletions(-)

I didn't hate the old code, but you're right that this looks a little better.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

NOTE: now that you're cleaning it up, I'd personally go even further
and totally get rid of the "mode" local variable.  Basically, just:

dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
if (dma_buf)
  geni_se_select_mode(se, GENI_SE_DMA);
else
  geni_se_select_mode(se, GENI_SE_FIFO);

...elsewhere just continue to use "dma_buf" being NULL to mean FIFO if
you have to fall back to the FIFO case you set dma_buf to NULL after
calling i2c_put_dma_safe_msg_buf() to indicate to later code that
you're in FIFO mode.

I prototyped this up and the net-net is one fewer line of code and
also the nice consistency that you never hold dma_buf in a pointer
after you've freed it.

-Doug
