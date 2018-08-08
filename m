From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v8 1/2] i2c: i2c-qcom-geni: Add bus driver for the
 Qualcomm GENI I2C controller
Date: Wed, 8 Aug 2018 11:14:19 -0700
Message-ID: <CAE=gft46X7Pwufd0w2KCGmzviC1Gn2JLxUWTmSaYeLkYRi3ULw@mail.gmail.com>
References: <1532971432-16784-1-git-send-email-kramasub@codeaurora.org>
 <1532971432-16784-2-git-send-email-kramasub@codeaurora.org> <20180731192004.acg5jnbj5wg55mpl@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731192004.acg5jnbj5wg55mpl@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, acourbot@chromium.org, swboyd@chromium.org, Doug Anderson <dianders@chromium.org>, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 31, 2018 at 12:20 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Mon, Jul 30, 2018 at 11:23:51AM -0600, Karthikeyan Ramasubramanian wrote:
> > This bus driver supports the GENI based i2c hardware controller in the
> > Qualcomm SOCs. The Qualcomm Generic Interface (GENI) is a programmable
> > module supporting a wide range of serial interfaces including I2C. The
> > driver supports FIFO mode and DMA mode of transfer and switches modes
> > dynamically depending on the size of the transfer.
> >
> > Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> > Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> > Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > Tested-by: Stephen Boyd <swboyd@chromium.org>
>
> Applied to for-next, thanks!
>
> As discussed, I squashed the MAINTAINER addition and the RPM fix by Evan
> into this commit. Please check later that I resolved the conflict
> correctly (once I pushed out).

The squashing in of my patch looks good!
