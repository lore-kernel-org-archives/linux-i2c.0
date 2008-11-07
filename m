From: Krzysztof Halasa <khc-9GfyWEdoJtJmR6Xm/wNWPw@public.gmane.org>
Subject: Re: I2C from interrupt context?
Date: Fri, 07 Nov 2008 17:05:35 +0100
Message-ID: <m3bpwrbjxs.fsf@maximus.localdomain>
References: <m3bpws8ln3.fsf@maximus.localdomain>
	<20081106.154754.02648408.davem@davemloft.net>
	<20081107101118.286f3713@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081107101118.286f3713-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org> (Jean Delvare's message of "Fri\, 7 Nov 2008 10\:11\:18 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:

> The situation is far from perfect though. For one thing, I seem to
> recall that Andrew Morton didn't like the approach taken in
> i2c_transfer(). For another, i2c_smbus_xfer() was not yet modified so
> at this point only I2C-level transactions can be non-sleeping,
> SMBus-level transactions can't. But all this could be fixed by anyone
> who cares about these specific issues.

Thanks, I'll look at it.
-- 
Krzysztof Halasa
