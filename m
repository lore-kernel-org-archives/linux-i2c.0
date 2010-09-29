From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] I2C: runtime: Fix checks which make legacy suspend to
 never get called
Date: Wed, 29 Sep 2010 14:23:21 +0200
Message-ID: <20100929142321.59356b5b@endymion.delvare>
References: <1285602360-21180-1-git-send-email-rnayak@ti.com>
	<201009282345.26363.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201009282345.26363.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 28 Sep 2010 23:45:26 +0200, Rafael J. Wysocki wrote:
> On Monday, September 27, 2010, Rajendra Nayak wrote:
> > For devices which are not adapted to runtime PM a call to
> > pm_runtime_suspended always returns true.
> > 
> > Hence the pm_runtime_suspended checks below prevent legacy
> > suspend from getting called.
> > 
> > So do a pm_runtime_suspended check only for devices with a
> > dev_pm_ops populated (which hence do not rely on the legacy
> > suspend)
> 
> Makes sense.
> 
> > Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
> > Cc: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
> 
> Acked-by: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
> 
> > Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> > Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> > Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> > ---
> >  drivers/i2c/i2c-core.c |   44 ++++++++++++++++++++++++--------------------
> >  1 files changed, 24 insertions(+), 20 deletions(-)

Applied, thanks.

-- 
Jean Delvare
