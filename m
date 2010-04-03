From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: remove_clientdata_to_null-branch
Date: Sat, 3 Apr 2010 20:13:17 +0200
Message-ID: <20100403201317.1321b414@hyperion.delvare>
References: <20100403173646.GB2190@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100403173646.GB2190-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Sat, 3 Apr 2010 19:36:46 +0200, Wolfram Sang wrote:
> just wanted to announce that I put up a branch for removing the
> i2c_set_clientdata(..., NULL)-calls, so you can see what the current status is.
> It will be rebased, so don't work on it (why would you? :)).
> 
> http://git.pengutronix.de/?p=wsa/linux-2.6.git;a=shortlog;h=refs/heads/remove_clientdata_to_null
> 
> The main cleaning patch is a single patch scheduled for 2.6.35 as discuessed.
> I'd like to add another round of review before sending out a patch to this
> list, probably around -rc4. (Altough I still wonder if we shouldn't wait for
> 2.6.35-rc1, then we could also catch the calls sitting now in linux-next).
> 
> Jean, have you noticed this one for 2.6.34?
> 
> http://article.gmane.org/gmane.linux.drivers.i2c/5784

I've seen it, but it is something for the power subsystem maintainer
(or akpm if there is none) to apply. I did kill drivers/i2c/chips for a
reason.

-- 
Jean Delvare
