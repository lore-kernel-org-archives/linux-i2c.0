From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: skip address detection if provided in board_info
Date: Wed, 13 Oct 2010 10:01:12 -0700
Message-ID: <20101013100112.00002279@unknown>
References: <1286838635-16474-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<20101012092822.6f4e4aa5@endymion.delvare>
	<20101012162140.429b03b3@feng-i7>
	<20101012104707.3318511d@endymion.delvare>
	<20101012173028.638cd3ae@po-laptop>
	<20101012133425.490e3c4c@endymion.delvare>
	<20101012110140.00003391@unknown>
	<20101013092654.7e26fa00@endymion.delvare>
	<20101013085418.00003979@unknown>
	<20101013180751.2d37c513@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101013180751.2d37c513-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, i2c list <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

>> Can we make an explicit bit I2C_CLASS_NO_DETECT so that is is more
>> explicit? It also allows co-existance with other flags so that we can
>> handle mixed cases?
>
>And what exactly would this bit do?
>
You can scratch this idea. I thought the i2c adapter's class code has
some use other than matching with device class. but it seems it is the
only use. I was thinking about having HWMON|NO_DETECT so that adapter
can still maintain the class identity.
Anyway, i don't think it is needed. Sorry for the confusion :)

Thanks,

Jacob
