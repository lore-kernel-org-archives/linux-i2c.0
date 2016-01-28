From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V7 3/6] i2c: qup: Transfer each i2c_msg in i2c_msgs without a stop bit
Date: Thu, 28 Jan 2016 10:27:05 +0530
Message-ID: <001401d15988$59f6dcf0$0de496d0$@codeaurora.org>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org> <1453197766-18976-4-git-send-email-sricharan@codeaurora.org> <20160124112915.GA1775@katana>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34646 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967495AbcA1E5P (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 27 Jan 2016 23:57:15 -0500
In-Reply-To: <20160124112915.GA1775@katana>
Content-Language: en-us
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: 'Wolfram Sang' <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, galak@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, ntelkar@codeaurora.org, architt@codeaurora.org

Hi Wolfram,

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa@the-dreams.de]
> Sent: Sunday, January 24, 2016 4:59 PM
> To: Sricharan R
> Cc: devicetree@vger.kernel.org; linux-arm-msm@vger.kernel.org;
> agross@codeaurora.org; linux-kernel@vger.kernel.org; linux-
> i2c@vger.kernel.org; iivanov@mm-sol.com; galak@codeaurora.org;
> dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> andy.gross@linaro.org; ntelkar@codeaurora.org; architt@codeaurora.org
> Subject: Re: [PATCH V7 3/6] i2c: qup: Transfer each i2c_msg in i2c_msgs
> without a stop bit
> 
> Hi,
> 
> > "If this is the last message in a group, it is followed by a STOP.
> > Otherwise it is followed by the next @i2c_msg transaction segment,
> > beginning with a (repeated) START"
> 
> This is correct.
> 
> > So the expectation is that there is no 'STOP' bit inbetween individual
> > i2c_msg segments with repeated 'START'. The QUP i2c hardware has no
> > way to inform that there should not be a 'STOP' at the end of
transaction.
> > The only way to implement this is to coalesce all the i2c_msg in
> > i2c_msgs in to one transaction and transfer them. Adding the support for
> the same.
> 
> So, there will not be a REP_START condition on the bus? I am sorry to say
that
> I can't accept this. A REP_START is a REP_START and nothing else. There
are
> devices which will get confused if there is no real REP_START condition.
> 
> Without knowing the HW in detail, can't you implement I2C_M_NOSTART
> and let the touchscreen driver use it via regmap? That would be the proper
> way (from what I understand).


Ah, so what I meant above is there is no 'STOP' bit between each msg in
i2c_msgs, 
but 'REAPEATED_START' still holds true.  We are sending 'START' bit for each
msg.
So these is how each msg in i2c_msg is sent,

|------MSG1--------|-----MSG2---------|------MSG3------------|

  |START|DATA|------|START|DATA|---|START|DATA|STOP|      

If my commit text does not make this clear, I  can reword that ?

Regards,
  Sricharan
