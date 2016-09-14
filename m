From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH] i2c: qup: skip qup_i2c_suspend if the device is already
 runtime suspended
Date: Wed, 14 Sep 2016 12:33:07 -0500
Message-ID: <20160914173307.GA5431@hector.attlocal.net>
References: <1472124219-1627-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:32850 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762069AbcINRdJ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Sep 2016 13:33:09 -0400
Received: by mail-oi0-f41.google.com with SMTP id r126so32772010oib.0
        for <linux-i2c@vger.kernel.org>; Wed, 14 Sep 2016 10:33:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1472124219-1627-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, David Brown <david.brown@linaro.org>, Wolfram Sang <wsa@the-dreams.de>

On Thu, Aug 25, 2016 at 12:23:39PM +0100, Sudeep Holla wrote:
> If the i2c device is already runtime suspended, if qup_i2c_suspend is
> executed during suspend-to-idle or suspend-to-ram it will result in the
> following splat:
> 
<snip>
> 
> This patch fixes the issue by executing qup_i2c_pm_suspend_runtime
> conditionally in qup_i2c_suspend.
> 
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Andy Gross <andy.gross@linro.org>
