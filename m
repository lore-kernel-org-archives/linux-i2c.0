From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c-mxs: fixed error message in pio transfer
Date: Sat, 20 Sep 2014 15:21:23 +0200
Message-ID: <201409201521.23553.marex@denx.de>
References: <1410279571-4552-1-git-send-email-j.uzycki@elproma.com.pl> <20140920123953.GE3850@katana>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140920123953.GE3850@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Saturday, September 20, 2014 at 02:39:53 PM, Wolfram Sang wrote:
> On Tue, Sep 09, 2014 at 06:19:30PM +0200, Janusz Uzycki wrote:
> > If I2C_M_RD flag is set SELECT command is sent
> > and afterward READ command.
> > The patch fixes READ command to return READ failure error message
> > instead of SELECT failure error message.
> > 
> > Signed-off-by: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
> 
> Applied to for-next with minor updates to the commit message, thanks!
> 
> Marek, I added your ack since you said you are fine with the change
> itself.

Ah yes, sure.

> Thanks for reviewing the Freescale drivers BTW, much
> appreciated!

Well you're welcome, though I don't do much, really.

Best regards,
Marek Vasut
