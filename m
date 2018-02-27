From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 03/12] i2c: qup: remove redundant variables for BAM SG
 count
Date: Tue, 27 Feb 2018 16:28:55 -0600
Message-ID: <20180227222855.GD20901@hector.attlocal.net>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-4-git-send-email-absahu@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1517644697-30806-4-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, David Brown <david.brown@linaro.org>, Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Feb 03, 2018 at 01:28:08PM +0530, Abhishek Sahu wrote:
> The rx_nents and tx_nents are redundant. rx_buf and tx_buf can
> be used for total number of SG entries.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---

Naming conventions aside,

Reviewed-by: Andy Gross <andy.gross@linaro.org>
