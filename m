From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v7 1/4] i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI
 I2C controller
Date: Wed, 13 Jun 2018 09:10:41 -0700
Message-ID: <152890624119.16708.17950072340975001909@swboyd.mtv.corp.google.com>
References: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org>
 <1528823348-30532-2-git-send-email-kramasub@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528823348-30532-2-git-send-email-kramasub@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, gregkh@linuxfoundation.org, mark.rutland@arm.com, robh+dt@kernel.org, wsa@the-dreams.de
Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, evgreen@chromium.org, acourbot@chromium.org, dianders@chromium.org, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

Quoting Karthikeyan Ramasubramanian (2018-06-12 10:09:05)
> This bus driver supports the GENI based i2c hardware controller in the
> Qualcomm SOCs. The Qualcomm Generic Interface (GENI) is a programmable
> module supporting a wide range of serial interfaces including I2C. The
> driver supports FIFO mode and DMA mode of transfer and switches modes
> dynamically depending on the size of the transfer.
> =

> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
