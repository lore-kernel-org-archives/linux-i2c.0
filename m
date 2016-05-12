From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 1/2] i2c: qup: Cleared the error bits in ISR
Date: Thu, 12 May 2016 00:13:47 -0500
Message-ID: <20160512051347.GE8453@hector.attlocal.net>
References: <1462797871-8595-1-git-send-email-absahu@codeaurora.org>
 <1462797871-8595-2-git-send-email-absahu@codeaurora.org>
 <000701d1ab9d$df9b3100$9ed19300$@codeaurora.org>
 <934365f2bd30f242d8548e2a27483679@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34491 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbcELFNt (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 12 May 2016 01:13:49 -0400
Received: by mail-oi0-f42.google.com with SMTP id k142so102778583oib.1
        for <linux-i2c@vger.kernel.org>; Wed, 11 May 2016 22:13:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <934365f2bd30f242d8548e2a27483679@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Sricharan <sricharan@codeaurora.org>, agross@codeaurora.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, wsa@the-dreams.de

On Wed, May 11, 2016 at 11:04:17PM +0530, Abhishek Sahu wrote:

<snip>

> >       In qup_i2c_xfer and qup_i2c_xfer_v2 state is set to RESET at the
> >end, when
> >       there is no error. So would it be fine if we do it there
> >unconditionally ?
> >
> >Regards,
> > Sricharan
> 
> RESET the QUP state wouldn't create any issue in the case of multiple calls.
> The existing code also RESET the QUP state for bus_err but it is not
> clearing
> status bits.

It'd be better to not reset the QUP inside the ISR at all.  I think the better
solution is making the reset occur in the xfer function.  So just clear the bits
like you should in the isr, and defer reset till later.
