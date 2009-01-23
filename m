From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Again on virtual i2c adapter support.
Date: Fri, 23 Jan 2009 15:16:13 +0100
Message-ID: <20090123151613.7424fa4f@hyperion.delvare>
References: <20090122150230.GA10952@enneenne.com>
	<20090123095110.7b0c7b82@hyperion.delvare>
	<878wp2ml52.fsf@macbook.be.48ers.dk>
	<20090123103659.38a25c30@hyperion.delvare>
	<874ozqmjwq.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <874ozqmjwq.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 23 Jan 2009 10:49:41 +0100, Peter Korsgaard wrote:
> >>>>> "Jean" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:
> 
> Hi,
> 
>  Jean> There are still a few caveats when doing this. In particular,
>  Jean> if you use drivers which probe the I2C bus for devices, you
>  Jean> must make sure that the devices will be properly found on
>  Jean> either the trunk or one of the multiplexer branches but not
>  Jean> both. In fact this is with this specific case in mind that I
>  Jean> decided to wait for the i2c device driver binding model to be
>  Jean> cleaned up before going on with full multiplexing support.
> 
> True. I unsually solve this by making sure the multiplexer starts in
> an unconnected state so the trunk probe doesn't find anything, or
> simply not use the old style probing.

Please keep in mind that the difficulty here is with probing itself,
not just with old-style. The new binding model also has a detection
mode, which is also affected. Making sure that the multiplexer is in an
unconnected state initially isn't sufficient, as you can load I2C chip
drivers at any later point in time and this will trigger a new
detection cycle. And not all multiplexers can be disabled that way,
some have always one outer channel enabled.

I've been thinking about it a bit and my conclusion is that detection
is simply not compatible with multiplexed I2C buses in general. In
specific cases (for example if there is no chip on the trunk) you can
get it to work but I couldn't come up with a logic that always works.
If anyone has ideas, these are welcome.

-- 
Jean Delvare
