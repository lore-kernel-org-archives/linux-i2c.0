From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [PATCH] i2c: support for hmc6343 3-Axis digital compass module.
Date: Thu, 9 Apr 2009 19:01:51 +0100
Message-ID: <20090409180151.GE18152@sirena.org.uk>
References: <1239290169-20393-1-git-send-email-giometti@enneenne.com> <20090409181435.7b55a861@hyperion.delvare> <20090409175908.GD7924@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090409175908.GD7924-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Apr 09, 2009 at 07:59:08PM +0200, Rodolfo Giometti wrote:

> I see that note but this chip (IMHO) doesn't fit any already existing
> categories... it's a compass module where should I add it? Maybe in
> hwmon? But a compass or accelerometer doesn't monitor the
> hardware at all... =:-o

We have drivers/misc...
