From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-algo-pca: fix all coding style issues in
 i2c-algo-pca.c
Date: Thu, 22 Apr 2010 09:25:24 +0200
Message-ID: <20100422092524.77b7aa84@hyperion.delvare>
References: <1271877097-10939-1-git-send-email-farid.hammane@gmail.com>
	<20100421235738.GB24384@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100421235738.GB24384-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Farid Hammane <farid.hammane-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Enrik.Berkhan-JJi787mZWgc@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 22 Apr 2010 01:57:38 +0200, Wolfram Sang wrote:
> Hi Farid,
> 
> thanks for this approach. Have you checked that the binary is the same
> before/after your patch? If so, please mention in your patch description.
> 
> Also, always keep in mind that checkpatch helps to make code readable. Some of
> your changes should keep readability in mind not just fixing the warnings.
> 
> On Wed, Apr 21, 2010 at 09:11:37PM +0200, Farid Hammane wrote:
> > This patch fixes all coding style issues found by checkpatch.pl.
> 
> > 
> > Signed-off-by: Farid Hammane <farid.hammane-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/i2c/algos/i2c-algo-pca.c |   74 ++++++++++++++++++++++---------------
> >  1 files changed, 44 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
> > (...)
> > @@ -178,12 +178,12 @@ static int pca_rx_ack(struct i2c_algo_pca_data *adap,
> >  }
> >  
> >  static int pca_xfer(struct i2c_adapter *i2c_adap,
> > -                    struct i2c_msg *msgs,
> > -                    int num)
> > +		struct i2c_msg *msgs,
> > +		int num)
> 
> One more tab maybe?

Better use tab + spaces and align on the opening parenthesis. What
checkpatch.pl complains about here isn't the alignment, it's the use of
more than 8 consecutive spaces.

> > (...)
> > @@ -241,8 +244,10 @@ static int pca_xfer(struct i2c_adapter *i2c_adap,
> >  			completed = pca_address(adap, msg);
> >  			break;
> >  
> > -		case 0x18: /* SLA+W has been transmitted; ACK has been received */
> > -		case 0x28: /* Data byte in I2CDAT has been transmitted; ACK has been received */
> > +		case 0x18: /* SLA+W has been transmitted;
> > +			      ACK has been received */
> > +		case 0x28: /* Data byte in I2CDAT has been transmitted;
> > +			      ACK has been received */
> 
> First, check CodingStyle for how multiline comments should look like. For
> readability, I'd like to keep them single line, though. I think this could
> be done by rewording. Same for all following comments.

Please keep in mind that Farid doesn't know the code. He is "only"
helping with formatting cleanups. Asking him to reword the comments
doesn't seem wise. And there's nothing wrong with two-line comments as
above. The "preferred comment format" in CodingStyle is often
unrealistic IMHO, I'm not always following it in my own code.

I agree with all other comments.

-- 
Jean Delvare
