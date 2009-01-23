From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Again on virtual i2c adapter support.
Date: Fri, 23 Jan 2009 10:36:59 +0100
Message-ID: <20090123103659.38a25c30@hyperion.delvare>
References: <20090122150230.GA10952@enneenne.com>
	<20090123095110.7b0c7b82@hyperion.delvare>
	<878wp2ml52.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <878wp2ml52.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

On Fri, 23 Jan 2009 10:23:05 +0100, Peter Korsgaard wrote:
> >>>>> "Jean" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:
> 
> Hi,
> 
>  Jean> Oh, and please stop calling the thing "virtual i2c adapter support".
>  Jean> These adapters are very real. What you are working on is better
>  Jean> described as "i2c bus multiplexing support".
> 
> Not only that, it's afaik about doing i2c bus multiplexing where the
> multiplexers are themselves i2c devices - E.G. stuff where you might
> need to recursively call into the i2c core.
> 
> I have been doing i2c multiplexers where the multiplexers themselves
> are not controlled through i2c for years without problems.
> 
> I afaik even posted an example driver back when Dave posted his
> multiplex hack.

There are still a few caveats when doing this. In particular, if you
use drivers which probe the I2C bus for devices, you must make sure
that the devices will be properly found on either the trunk or one of
the multiplexer branches but not both. In fact this is with this
specific case in mind that I decided to wait for the i2c device driver
binding model to be cleaned up before going on with full multiplexing
support.

That being said, yes, you're correct, multiplexing where the
multiplexer chip isn't on the bus itself is a lot easier and can
already be done today in some cases.

-- 
Jean Delvare
