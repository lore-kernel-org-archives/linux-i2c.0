From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: Finding 'orphaned' i2c drivers
Date: Mon, 23 Feb 2009 15:04:24 +0000
Message-ID: <20090223150423.GD2078@sirena.org.uk>
References: <20090223110052.GE15722@buzzloop.caiaq.de> <20090223144343.GC2078@sirena.org.uk> <20090223145142.GB18378@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090223145142.GB18378-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 23, 2009 at 03:51:42PM +0100, Daniel Mack wrote:

> The question is: how do I access this instance at a later point? Without
> messing around with static pointers, of course.

You're going to need to do something which is specific to your
application - it's not a problem for the I2C layer, all it's doing is
providing the lower level bus access for the device.  The upper level
API offered by your driver is something that depends on what services
your driver is implementing.

As I said in my previous e-mail you should probably either register with
ASoC core and get at the device that way or do something like what the
neo1973 driver is doing in your machine driver.
