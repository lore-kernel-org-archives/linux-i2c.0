From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-mux-gpio platform device ID issue
Date: Thu, 26 Jul 2012 13:49:04 +0200
Message-ID: <20120726134904.3ac6774c@endymion.delvare>
References: <20120725144409.1e47bd95@endymion.delvare>
	<20120726092814.2689a30f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120726092814.2689a30f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Yeah, replying to myself once again...

On Thu, 26 Jul 2012 09:28:14 +0200, Jean Delvare wrote:
> I slept on it and came up with what I think is an easier and more
> elegant solution. We could simply agree on using GPIO pin numbers as
> platform device IDs, as two i2c-gpio-mux instances can't control the
> same GPIO pin.

Unfortunately this simple and elegant solution is not compatible with a
feature I want to add to the i2c-mux-gpio driver (deferred probing.)
I'll post that other patch later today. Unless someone sees a solution
I missed, I'm afraid we'll have to choose which one of these two
patches we want to take in, and discard the other one.

-- 
Jean Delvare
