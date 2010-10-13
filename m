From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: skip address detection if provided in board_info
Date: Wed, 13 Oct 2010 11:29:30 +0200
Message-ID: <20101013112930.7c25a8d7@endymion.delvare>
References: <1286838635-16474-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<20101012092822.6f4e4aa5@endymion.delvare>
	<20101012162140.429b03b3@feng-i7>
	<20101012104707.3318511d@endymion.delvare>
	<20101012173028.638cd3ae@po-laptop>
	<20101012133425.490e3c4c@endymion.delvare>
	<20101014010422.0247b96b@feng-vmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101014010422.0247b96b@feng-vmt>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, i2c list <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 14 Oct 2010 01:04:22 +0800, Feng Tang wrote:
> But I still have some concern (not specific to our platforms), I just checked,
> there are 42 i2c adapter drivers set their class to I2C_CLASS_HWMON and 50
> hwmon i2c device drivers set it as well. So if a kernel has an adapter driver
> and hwmon driver which both set I2C_CLASS_HWMON, the long init time problem
> will show up again, and it will be worse if there are multiple adapters HW
> there.

It has been that way for a couple years now and has never been reported
to be a problem in practice.

The overall number of drivers setting class flag I2C_CLASS_HWMON is
irrelevant, as on a given system, only a few I2C adapter and device
drivers will be loaded. As I said before, it would become a problem if
you loaded a huger number of I2C-based hwmon device drivers you don't
need, which would happen if you were to build a kernel with all hwmon
drivers build-in. But this doesn't sound like a sane thing to do.

Also please note that I still believe that your I2C adapter driver
could be improved to better deal with this case. Loading the adm1021
hwmon driver on my systems only takes 21 ms, even though it probes 9
addresses. If proving 4 * 5 addresses on your system took a noticeable
time, then I suspect that your adapter driver isn't dealing with that
case properly.

But anyway, if you're on an embedded system and care a lot about very
fast boot times, then you don't want to do any I2c device probing at
all. You want all your devices enumerated as platform data, that's the
fastest option.

-- 
Jean Delvare
