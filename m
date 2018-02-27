From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 10/12] i2c: qup: send NACK for last read sub transfers
Date: Tue, 27 Feb 2018 17:17:39 -0600
Message-ID: <20180227231739.GK20901@hector.attlocal.net>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-11-git-send-email-absahu@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1517644697-30806-11-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, David Brown <david.brown@linaro.org>, Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Feb 03, 2018 at 01:28:15PM +0530, Abhishek Sahu wrote:
> According to I2c specification, “If a master-receiver sends a
> repeated START condition, it sends a not-acknowledge (A) just
> before the repeated START condition”. QUP v2 supports sending
> of NACK without stop with QUP_TAG_V2_DATARD_NACK so added the
> same.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>

Reviewed-by: Andy Gross <andy.gross@linaro.org>
