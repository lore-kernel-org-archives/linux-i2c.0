From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: Again on virtual i2c adapter support.
Date: Fri, 23 Jan 2009 14:48:33 +0100
Message-ID: <20090123134833.GH12256@enneenne.com>
References: <20090122150230.GA10952@enneenne.com> <20090123095110.7b0c7b82@hyperion.delvare> <878wp2ml52.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <878wp2ml52.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 23, 2009 at 10:23:05AM +0100, Peter Korsgaard wrote:
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

I did exactly as you say. I have a custom board with a PCA9540 which
is a i2c multiplexer controlled by i2c bus.

> I have been doing i2c multiplexers where the multiplexers themselves
> are not controlled through i2c for years without problems.
> 
> I afaik even posted an example driver back when Dave posted his
> multiplex hack.

Did you post the code on this list?

However I'm going to publish my job on i2c multiplexers ASAP, maybe
you can take a look at it and verify if it fixes your needs.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
