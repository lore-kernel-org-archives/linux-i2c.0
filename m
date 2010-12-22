From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [linux-pm] [PATCH 1/2] PM: Prototype the pm_generic_ operations
Date: Wed, 22 Dec 2010 13:15:06 +0100
Message-ID: <201012221315.06948.rjw@sisk.pl>
References: <1292855593-30608-1-git-send-email-broonie@opensource.wolfsonmicro.com> <201012202208.59102.rjw@sisk.pl> <20101222114316.GA4520@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101222114316.GA4520-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday, December 22, 2010, Mark Brown wrote:
> On Mon, Dec 20, 2010 at 10:08:58PM +0100, Rafael J. Wysocki wrote:
> 
> > I'd take this one, but the second one depends on it.
> 
> > I can take both if Jean agrees.
> 
> Given the nearness of the merge window another option is to apply this
> one now and punt the I2C one until 2.6.38, I guess?

Except that I don't have any more fixes for 2.6.37 pending
and this one isn't really a fix. :-)

If there's anything else I should push to Linus before 2.6.37, I'll
include this patch in the pull request.  Otherwise I think it shoul go in
during the merge window.

Thanks,
Rafael
