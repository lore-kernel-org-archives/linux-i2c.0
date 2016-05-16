From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V2 2/2] drivers: i2c: qup: Fix error handling
Date: Mon, 16 May 2016 11:29:25 +0530
Message-ID: <002201d1af38$1eb3e330$5c1ba990$@codeaurora.org>
References: <1462534274-28925-1-git-send-email-sricharan@codeaurora.org> <1462534274-28925-3-git-send-email-sricharan@codeaurora.org> <20160513114823.GJ1778@katana> <20160513115021.GK1778@katana>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54473 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbcEPF7g (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 16 May 2016 01:59:36 -0400
In-Reply-To: <20160513115021.GK1778@katana>
Content-Language: en-us
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: 'Wolfram Sang' <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, agross@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nkaje@codeaurora.org

Hi,
> > > Among the bus errors reported from the QUP_MASTER_STATUS register
> > > only NACK is considered and transfer gets suspended, while other
> > > errors are ignored. Correct this and suspend the transfer for other
> > > errors as well. This avoids unnessecary 'timeouts' which happens
> > > when waiting for events that would never happen when there is
> > > already an error condition on the bus.
> > >
> > > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > > Reviewed-by: Andy Gross <andy.gross@linaro.org>
> >
> > Please check Documentation/i2c/fault-codes for proper fault codes.
> 
    Ok, Thanks for pointing this out. So, for NACK I think it is more
appropriate to
    return -ENXIO and -EIO for other errors. Will correct this.

> And while we are here: NACK is not an error but a valid response. Can you
> remove the dev_err related to that? Otherwise tools like i2cdetect will
> probably flood your log.
  Ok, will correct this.

Regards,
 Sricharan         
