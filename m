From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 07/12] i2c: qup: use the complete transfer length to
 choose DMA mode
Date: Tue, 27 Feb 2018 16:59:52 -0600
Message-ID: <20180227225952.GH20901@hector.attlocal.net>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-8-git-send-email-absahu@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1517644697-30806-8-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, David Brown <david.brown@linaro.org>, Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Feb 03, 2018 at 01:28:12PM +0530, Abhishek Sahu wrote:
> Currently each message length in complete transfer is being
> checked for determining DMA mode and if any of the message length
> is less than FIFO length then non DMA mode is being used which
> will increase overhead. DMA can be used for any length and it
> should be determined with complete transfer length. Now, this
> patch introduces DMA threshold length and the transfer will be
> done in DMA mode if the total length is greater than this
> threshold length.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---

I agree with Sricharan's nit.

Reviewed-by: Andy Gross <andy.gross@linaro.org>
