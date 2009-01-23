From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: Again on virtual i2c adapter support.
Date: Fri, 23 Jan 2009 16:04:35 +0100
Message-ID: <87r62ujc70.fsf@macbook.be.48ers.dk>
References: <20090122150230.GA10952@enneenne.com>
	<20090123095110.7b0c7b82@hyperion.delvare>
	<878wp2ml52.fsf@macbook.be.48ers.dk>
	<20090123103659.38a25c30@hyperion.delvare>
	<874ozqmjwq.fsf@macbook.be.48ers.dk>
	<20090123151613.7424fa4f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090123151613.7424fa4f-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org> (Jean Delvare's message of "Fri\, 23 Jan 2009 15\:16\:13 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "Jean" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:

 >> True. I unsually solve this by making sure the multiplexer starts in
 >> an unconnected state so the trunk probe doesn't find anything, or
 >> simply not use the old style probing.

 Jean> Please keep in mind that the difficulty here is with probing itself,
 Jean> not just with old-style. The new binding model also has a detection
 Jean> mode, which is also affected. Making sure that the multiplexer is in an
 Jean> unconnected state initially isn't sufficient, as you can load I2C chip
 Jean> drivers at any later point in time and this will trigger a new
 Jean> detection cycle. And not all multiplexers can be disabled that way,
 Jean> some have always one outer channel enabled.

Yes, but my code
(http://www.mail-archive.com/i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org/msg01539.html) does:

lock parent mutex
enable mux
do transfer on parent bus
disable mux
unlock parent

So that afaik shouldn't be a problem.

If your mux doesn't have an enable control and there's no unused
connection you can use instead, then that ofcourse doesn't work.

-- 
Bye, Peter Korsgaard
