From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 1/5] i2c: Add SMBus alert support
Date: Tue, 16 Feb 2010 13:39:35 +0000
Message-ID: <20100216133934.GA10586@sirena.org.uk>
References: <20100213230438.31fd0fd7@hyperion.delvare> <20100213230656.341ec091@hyperion.delvare> <4B7991CC.3020904@cam.ac.uk> <20100216105606.003b01dd@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100216105606.003b01dd-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 16, 2010 at 10:56:06AM +0100, Jean Delvare wrote:
> On Mon, 15 Feb 2010 18:26:20 +0000, Jonathan Cameron wrote:

> > Can we change the name of data here.  From readability point of view it
> > would be better not to have this reliance on scope (as data used for 
> > struct i2c_smbus_alert *data above. (obviously changing it above would 
> > work as well!) 

> Oh, yeah, of course. Thanks for pointing this out. I wish we built the
> kernel with -Wshadow so that gcc could tell us automatically...

If you build with sparse (install it then add C=1 to the command line)
it'll pick up shadowing along with all the other stuff.
