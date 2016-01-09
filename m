From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [V5, 3/6] i2c: qup: Transfer each i2c_msg in i2c_msgs without a
 stop bit
Date: Fri, 8 Jan 2016 22:36:11 -0600
Message-ID: <20160109043611.GB4616@hector.attlocal.net>
References: <1447760727-4897-4-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34947 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbcAIEgO (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 8 Jan 2016 23:36:14 -0500
Received: by mail-ob0-f182.google.com with SMTP id xn1so96115393obc.2
        for <linux-i2c@vger.kernel.org>; Fri, 08 Jan 2016 20:36:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1447760727-4897-4-git-send-email-sricharan@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: iivanov@mm-sol.com, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, agross@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Nov 17, 2015 at 05:15:24PM +0530, Sricharan R wrote:
> The definition of i2c_msg says that
> 
> "If this is the last message in a group, it is followed by a STOP.
> Otherwise it is followed by the next @i2c_msg transaction segment,
> beginning with a (repeated) START"
> 
> So the expectation is that there is no 'STOP' bit inbetween individual
> i2c_msg segments with repeated 'START'. The QUP i2c hardware has no way
> to inform that there should not be a 'STOP' at the end of transaction.
> The only way to implement this is to coalesce all the i2c_msg in i2c_msgs
> in to one transaction and transfer them. Adding the support for the same.
> 
> This is required for some clients like touchscreen which keeps
> incrementing counts across individual transfers and 'STOP' bit inbetween
> resets the counter, which is not required.
> 
> This patch adds the support in non-dma mode.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

Reviewed-by: Andy Gross <andy.gross@linaro.org>
