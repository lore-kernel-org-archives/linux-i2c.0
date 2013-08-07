From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
Date: Wed, 7 Aug 2013 11:57:00 -0400
Message-ID: <20130807155700.GE19280@titan.lakedaemon.net>
References: <1373898278-4805-1-git-send-email-gregory.clement@free-electrons.com>
 <1373898278-4805-2-git-send-email-gregory.clement@free-electrons.com>
 <20130716080503.GA3125@lukather>
 <5200E684.5080003@free-electrons.com>
 <20130807143546.GD2978@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130807143546.GD2978@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebasti>
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 07, 2013 at 04:35:46PM +0200, Wolfram Sang wrote:
> 
> > But we shouldn't use it alone: we should always use:
> > compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
> > 
> > From my point of view using  "marvell,mv78230-i2c" alone is an error.
> > 
> > Wolfram what is your opinion on it?
> 
> It is not strictly an error, but risky. If you use an older Kernel
> version (or other OS) which only offers "mv64xxx" you will have no
> match. Although the driver theoretically could have basic support for
> all mv64xxx variants skipping all additional features of later IP
> revisions.

I agree here.  The driver is advertising what IP blocks it can handle,
so it makes sense to add both strings since it can handle both.

thx,

Jason.
