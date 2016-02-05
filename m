From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V7 3/6] i2c: qup: Transfer each i2c_msg in i2c_msgs without a stop bit
Date: Fri, 5 Feb 2016 13:30:25 +0530
Message-ID: <006e01d15feb$4a08d0a0$de1a71e0$@codeaurora.org>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org> <1453197766-18976-4-git-send-email-sricharan@codeaurora.org> <20160124112915.GA1775@katana> <001401d15988$59f6dcf0$0de496d0$@codeaurora.org> <20160204200903.GE1958@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48725 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbcBEIAf (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 5 Feb 2016 03:00:35 -0500
In-Reply-To: <20160204200903.GE1958@tetsubishi>
Content-Language: en-us
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: 'Wolfram Sang' <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, agross@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Wolfram,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces@lists.infradead.org] On Behalf Of Wolfram Sang
> Sent: Friday, February 05, 2016 1:39 AM
> To: Sricharan
> Cc: devicetree@vger.kernel.org; architt@codeaurora.org; linux-arm-
> msm@vger.kernel.org; ntelkar@codeaurora.org; galak@codeaurora.org;
> linux-kernel@vger.kernel.org; andy.gross@linaro.org; linux-
> i2c@vger.kernel.org; iivanov@mm-sol.com; agross@codeaurora.org;
> dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH V7 3/6] i2c: qup: Transfer each i2c_msg in i2c_msgs
> without a stop bit
> 
> Hi,
> 
> > Ah, so what I meant above is there is no 'STOP' bit between each msg
> > in i2c_msgs, but 'REAPEATED_START' still holds true.  We are sending
> > 'START' bit for each msg.
> > So these is how each msg in i2c_msg is sent,
> >
> > |------MSG1--------|-----MSG2---------|------MSG3------------|
> >
> >   |START|DATA|------|START|DATA|---|START|DATA|STOP|
> >
> > If my commit text does not make this clear, I  can reword that ?
> 
> OK, now this looks to me perfectly fine: A number of *messages*
> concatenated into one *transfer* by repeated start. That's the way it
should
> be.
> 
> So, I'd simply remove these words:
> 
> "The QUP i2c hardware has no way to inform that there should not be a
> 'STOP' at the end of transaction. The only way to implement this is to
> coalesce all the i2c_msg in i2c_msgs in to one transaction and transfer
them."
> 
> This sounded like the HW needed a special handling, so I was under the
> impression REP_START was broken. However, unless I misunderstood
> something again, this now sounds like the standard case and we can keep
> the commit message simple. If you are okay with that, I can update it
here,
> no need to resend.
> 
      Yes the above modified commit text looks perfect to be updated and
thanks
      for the update as well.

Regards,
 Sricharan
