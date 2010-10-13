From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: skip address detection if provided in board_info
Date: Wed, 13 Oct 2010 18:07:51 +0200
Message-ID: <20101013180751.2d37c513@endymion.delvare>
References: <1286838635-16474-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<20101012092822.6f4e4aa5@endymion.delvare>
	<20101012162140.429b03b3@feng-i7>
	<20101012104707.3318511d@endymion.delvare>
	<20101012173028.638cd3ae@po-laptop>
	<20101012133425.490e3c4c@endymion.delvare>
	<20101012110140.00003391@unknown>
	<20101013092654.7e26fa00@endymion.delvare>
	<20101013085418.00003979@unknown>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101013085418.00003979@unknown>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, i2c list <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 13 Oct 2010 08:54:18 -0700, Jacob Pan wrote:
> Jean Delvare Wed, 13 Oct 2010 09:26:54 +0200
> >Mixed cases aren't supported, because it is expected that all devices
> >are declared as platform data, or none is. This seems to work OK so far
> >for everybody. If it doesn't work for you, please explain why, in
> >details.
>
> it works for us in practice, at least for today. perhaps I am just playing
> devil's advocate, but also for the completeness of the logic for future
> use.

OK, thanks for clarifying. I do not expect this case to ever happen.
But if it ever does, then feel free to come back to me with all the
details and we'll discuss it again. I don't think it makes sense to add
support for a case which doesn't exist, because it's impossible to
figure out the best way to fix it until we actually see it.

> >Note though that there is some level of granularity because the adapter
> >class is a bitfield. So it is possible to declare all I2C devices as
> >platform data except the hardware monitoring devices, for example, and
> >set adapter class = I2C_CLASS_HWMON.
> >
> >There aren't many bits really used, BTW, mostly I2C_CLASS_HWMON and
> >I2C_CLASS_SPD, and the trend is to remove the unused class flags rather
> >than to add new ones. However, if you need a new I2C_CLASS flag, this
> >can certainly be done.
> 
> Can we make an explicit bit I2C_CLASS_NO_DETECT so that is is more
> explicit? It also allows co-existance with other flags so that we can
> handle mixed cases?

And what exactly would this bit do?

Confused.

-- 
Jean Delvare
