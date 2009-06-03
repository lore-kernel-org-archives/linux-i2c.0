From: =?ISO-8859-1?Q?Richard_R=3F=F6jfors?=
	<richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Subject: Re: [PATCH] I2C: ocores can add I2C devices to the bus
Date: Wed, 03 Jun 2009 10:53:10 +0200
Message-ID: <4A2639F6.2010505@mocean-labs.com>
References: <4A2566E8.7080404@mocean-labs.com>	<20090602224822.GE18453@fluff.org.uk>	<20090603101533.599d41db@hyperion.delvare> <87oct53ewh.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87oct53ewh.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Peter Korsgaard wrote:
>>>>>> "Jean" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:
> 
> Hi,
> 
>  Jean> I don't like the idea much either, nor the implementation.
> 
>  Jean> Firstly, I don't understand why this would be needed. I can understand
>  Jean> that in some cases you don't know the I2C bus number in advance, but
>  Jean> then some code must still instantiate the I2C bus, and the same code
>  Jean> should be able to call i2c_new_device() directly to instantiate the
>  Jean> devices on that bus. Richard, did you try to just do this? If it
>  Jean> doesn't work, please explain why.
> 
> Indeed. Isn't it just a matter of using i2c_add_numbered_adapter -
> E.G.:

Let say there are several PCI boards which have I2C busses, connected in let say
a standard PC. The PCI drivers could be MFD:s which exposes some platform
devices for the I2C busses.
How should those drivers know which bus numbers that are free?
Let say there are 2 boards of one type and two of an other.

The MFD:s might register there platform devices before there are I2C bus drivers available.
So a call to i2c_get_adapter, won't return any adapter, so AFAIK there is no
way to check if a bus number is "free" for use(?) Should those drivers talk to each other
and try to coordinate the bus number usage?


But even if it was possible to figure out bus numbers to use, the bus drivers might
not be available when the MFD registers the platform device, so when should it call
i2c_new_device? Start a timer and call i2c_get_adapter until it returns something?


--Richard
