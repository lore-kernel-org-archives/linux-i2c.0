From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] i2c: i2c-qcom-geni: Properly handle DMA safe buffers
Date: Wed, 19 Sep 2018 22:14:48 -0700
Message-ID: <153742048814.119890.14655726482695872149@swboyd.mtv.corp.google.com>
References: <20180918194126.138455-1-swboyd@chromium.org> <20180918221646.GA970@kunai>
 <153738150448.119890.13258586980997802695@swboyd.mtv.corp.google.com>
 <20180919204527.GA889@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919204527.GA889@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

Quoting Wolfram Sang (2018-09-19 13:45:28)
> =

> > But now when I try to use it I'm not exicted when the buffer is bounced
> > but we fail to map the buffer with the DMA APIs. For an I2C_M_RD
> =

> Yes, this was reported before and the function to unmap looks different
> now as of v4.19-rc2...
> =

> > the buffer that we setup. Or we can pass an argument to
> > i2c_release_dma_safe_msg_buf() to indicate if we should do the memcpy or
> > not?
> =

> ... exactly like this :)
> =


Ok great. I haven't synced to the latest stuff. I'll resend this
tomorrow when I test again.
