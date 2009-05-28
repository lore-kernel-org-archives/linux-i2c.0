From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/6] i2c: ignore active clients detaching during
 adapter removal.
Date: Thu, 28 May 2009 09:50:54 +0200
Message-ID: <20090528095054.03fc2df3@hyperion.delvare>
References: <1233840973-13268-1-git-send-email-giometti@linux.it>
	<1233840973-13268-3-git-send-email-giometti@linux.it>
	<1233840973-13268-4-git-send-email-giometti@linux.it>
	<200902051602.44036.david-b@pacbell.net>
	<20090206102220.GF28554@enneenne.com>
	<20090206131520.232b53c3@hyperion.delvare>
	<20090206125907.GA8581@enneenne.com>
	<20090206221519.5fc3d2b9@hyperion.delvare>
	<20090209130642.GV7975@enneenne.com>
	<20090210120839.23592e38@hyperion.delvare>
	<20090218164812.GA11217@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090218164812.GA11217-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Rodolfo,

Sorry for the late answer, I missed this post in the middle of the
thread.

On Wed, 18 Feb 2009 17:48:13 +0100, Rodolfo Giometti wrote:
> On Tue, Feb 10, 2009 at 12:08:39PM +0100, Jean Delvare wrote:
> > Well, you can always do that if you want, but please first clearly
> > define the practical problem you are trying to solve. We are not going
> > to change the i2c core without a good reason.
> 
> I created a new page here:
> 
>    http://i2c.wiki.kernel.org/index.php/I2C_bus_multiplexing

Thanks for doing this!

> Please, take a look and report everything should be fixed. :)

Random comments:

* I really would like to get rid of the "virtual" term that has been
  repeatedly abused. Bus segments behind multiplexers are very real.

* I am surprised that you use the term "trunk" for all segments, be
  they in front of or behind multiplexers. When I think of a
  multiplexer, I designate the segment between the controller and the
  multiplexer as the trunk, and the segments behind the multiplexer as
  branches.

Other than that I am rather happy with your page, which explains the
problem and the proposed solution clearly.

-- 
Jean Delvare
