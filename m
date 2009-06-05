From: =?ISO-8859-15?Q?Richard_R=F6jfors?=
	<richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Subject: Re: [PATCH] I2C: ocores can add I2C devices to the bus
Date: Fri, 05 Jun 2009 09:12:57 +0200
Message-ID: <4A28C579.7090507@mocean-labs.com>
References: <4A2566E8.7080404@mocean-labs.com>	<20090602224822.GE18453@fluff.org.uk>	<20090603101533.599d41db@hyperion.delvare>	<87oct53ewh.fsf@macbook.be.48ers.dk>	<4A2639F6.2010505@mocean-labs.com>	<20090604150752.6aa7668c@hyperion.delvare>	<4A27D91E.1000306@mocean-labs.com> <20090604210243.078aeb2f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090604210243.078aeb2f-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> 
> I am now convinced your proposed implementation makes sense for your
> specific need (which is relatively rare, which is why i2c-core doesn't
> handle it.) And contrary to what I first wrote, this doesn't need to be
> moved to i2c-core: this is specific enough that I'd rather let the code
> live in the bus driver (i2c-ocores) for now, and only if at least two
> other bus drivers need the same, consider moving it to i2c-core.
> 
> So if you fix the minor objection Ben had about your patch and resend
> it, I think we can merge that.

Will do.

> Oh, and I also believe your driver
> should call i2c_unregister_device() on removal, for symmetry.

Isn't better to leave that to i2c_del_adapter? Otherwise we need to store a list
of the I2C-clients returned by i2c_new_device.

--Richard
