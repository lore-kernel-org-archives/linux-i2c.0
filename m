From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c-mxs: fixed PIO NACK error instead of timeout (1000ms)
Date: Sat, 20 Sep 2014 15:22:00 +0200
Message-ID: <201409201522.00331.marex@denx.de>
References: <1410279571-4552-1-git-send-email-j.uzycki@elproma.com.pl> <1410279571-4552-2-git-send-email-j.uzycki@elproma.com.pl> <20140920124935.GF3850@katana>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140920124935.GF3850@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Saturday, September 20, 2014 at 02:49:36 PM, Wolfram Sang wrote:
> On Tue, Sep 09, 2014 at 06:19:31PM +0200, Janusz Uzycki wrote:
> > i2cdetect scanned i2c bus very slow if address was not occupied by any
> > device.
> > 
> > Signed-off-by: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
> 
> I would apply this patch and produce a fitting commit message out of the
> text you already sent, so you get an idea what is apropriate. However, I
> can't apply the patch. How did you create it?
> 

I'd say it's based on Linux 3.14 . Btw. you could have pasted the commit message 
here too ;-)

Best regards,
Marek Vasut
