From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: Again on virtual i2c adapter support.
Date: Fri, 23 Jan 2009 10:49:41 +0100
Message-ID: <874ozqmjwq.fsf@macbook.be.48ers.dk>
References: <20090122150230.GA10952@enneenne.com>
	<20090123095110.7b0c7b82@hyperion.delvare>
	<878wp2ml52.fsf@macbook.be.48ers.dk>
	<20090123103659.38a25c30@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090123103659.38a25c30-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org> (Jean Delvare's message of "Fri\, 23 Jan 2009 10\:36\:59 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "Jean" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:

Hi,

 Jean> There are still a few caveats when doing this. In particular,
 Jean> if you use drivers which probe the I2C bus for devices, you
 Jean> must make sure that the devices will be properly found on
 Jean> either the trunk or one of the multiplexer branches but not
 Jean> both. In fact this is with this specific case in mind that I
 Jean> decided to wait for the i2c device driver binding model to be
 Jean> cleaned up before going on with full multiplexing support.

True. I unsually solve this by making sure the multiplexer starts in
an unconnected state so the trunk probe doesn't find anything, or
simply not use the old style probing.

-- 
Bye, Peter Korsgaard
