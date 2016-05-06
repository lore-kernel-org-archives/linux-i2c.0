From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH 2/2] drivers: i2c: qup: Fix error handling
Date: Fri, 6 May 2016 09:39:18 +0530
Message-ID: <001e01d1a74d$13c716b0$3b554410$@codeaurora.org>
References: <1462166637-16778-1-git-send-email-sricharan@codeaurora.org> <1462166637-16778-3-git-send-email-sricharan@codeaurora.org> <20160505172219.GB6533@hector.attlocal.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160505172219.GB6533@hector.attlocal.net>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Andy Gross' <andy.gross@linaro.org>
Cc: devicetree@vger.kernel.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, agross@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Andy,

> -----Original Message-----
> From: Andy Gross [mailto:andy.gross@linaro.org]
> Sent: Thursday, May 05, 2016 10:52 PM
> To: Sricharan R <sricharan@codeaurora.org>
> Cc: devicetree@vger.kernel.org; architt@codeaurora.org; linux-arm-
> msm@vger.kernel.org; ntelkar@codeaurora.org; galak@codeaurora.org;
> linux-kernel@vger.kernel.org; linux-i2c@vger.kernel.org; iivanov@mm-
> sol.com; agross@codeaurora.org; dmaengine@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH 2/2] drivers: i2c: qup: Fix error handling
> 
> On Mon, May 02, 2016 at 10:53:57AM +0530, Sricharan R wrote:
> > Among the bus errors reported from the QUP_MASTER_STATUS register
> only
> > NACK is considered and transfer gets suspended, while other errors are
> > ignored. Correct this and suspend the transfer for other errors as
> > well. This avoids unnessecary 'timeouts' which happens when waiting
> > for events that would never happen when there is already an error
> > condition on the bus.
> >
> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > ---
> >  drivers/i2c/busses/i2c-qup.c | 34 +++++++++++++++++++++++++---------
> >  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> Reviewed-by: Andy Gross <andy.gross@linaro.org>
> 
 Thanks.
> <snip>
> 
> > @@ -1227,6 +1240,9 @@ static int qup_i2c_xfer_v2(struct i2c_adapter
> *adap,
> >  	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
> >  	int ret, len, idx = 0, use_dma = 0;
> >
> > +	qup->bus_err = 0;
> > +	qup->qup_err = 0;
> > +
> 
> What about the initial setting of these?  Does this need to be removed
from
> the main xfer function?
  Thanks for the catch. Will remove in bam_xfer , redundant.
  Now that there are i2x_xfer_v2 and i2c_xfer, 
   its not set in the old i2c_xfer call, where as it should be set there
   as well. I will change this and resend.

Regards,
 Sricharan
