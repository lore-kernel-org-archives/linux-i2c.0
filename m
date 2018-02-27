From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 02/12] i2c: qup: minor code reorganization for use_dma
Date: Tue, 27 Feb 2018 16:26:07 -0600
Message-ID: <20180227222607.GC20901@hector.attlocal.net>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-3-git-send-email-absahu@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1517644697-30806-3-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, David Brown <david.brown@linaro.org>, Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Feb 03, 2018 at 01:28:07PM +0530, Abhishek Sahu wrote:
> 1. Assigns use_dma in qup_dev structure itself which will
>    help in subsequent patches to determine the mode in IRQ handler.
> 2. Does minor code reorganization for loops to reduce the
>    unnecessary comparison and assignment.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>

Reviewed-by: Andy Gross <andy.gross@linaro.org>
