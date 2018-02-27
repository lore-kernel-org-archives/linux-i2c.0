From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 05/12] i2c: qup: fix the transfer length for BAM rx EOT
 FLUSH tags
Date: Tue, 27 Feb 2018 16:38:25 -0600
Message-ID: <20180227223825.GF20901@hector.attlocal.net>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-6-git-send-email-absahu@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1517644697-30806-6-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, David Brown <david.brown@linaro.org>, Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Feb 03, 2018 at 01:28:10PM +0530, Abhishek Sahu wrote:
> In case of FLUSH operation, BAM copies INPUT EOT FLUSH (0x94)
> instead of normal EOT (0x93) tag in input data stream when an
> input EOT tag is received during flush operation. So only one tag
> will be written instead of 2 separate tags.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>

Reviewed-by: Andy Gross <andy.gross@linaro.org>
