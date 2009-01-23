From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: Again on virtual i2c adapter support.
Date: Fri, 23 Jan 2009 14:44:59 +0100
Message-ID: <20090123134459.GG12256@enneenne.com>
References: <20090122150230.GA10952@enneenne.com> <20090123095110.7b0c7b82@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090123095110.7b0c7b82-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 23, 2009 at 09:51:10AM +0100, Jean Delvare wrote:

> Thanks for keeping up with this despite my lack of support. I really
> hope that we can get this done this year.
> 
> Did you speak with Dave Miller already? Some months ago he proposed an
> horrible hack to implement support for I2C bus multiplexing, which I
> nacked and I pointed him to you.

No... I don't remember about it...

> Last year I have been working with David Brownell of cleaning up
> i2c-core so that adding things like multiplexing support is easier, in
> particular when it comes to the locking model. It's not completely done
> yet but I think we're on the right track. My hope was that we could
> finish the cleanups first and add multiplexing support only then, but
> maybe I was too optimistic, the cleanups take longer than I expected.

I see.

> Honestly, I am not sure either. The locking model isn't completely
> cleared yet, we still need to get rid of the 3 dozen remaining legacy
> i2c chip drivers before we can finish it. I _think_ the above it
> correct, after all we do not hold the lock when calling
> driver_register() so I can't see why we would need to hold it when
> calling driver_unregister()... unless either i2c_client_release() or
> i2c_client_dev_release() needs this.

That is exactly what I supposed to be. :)

> I would like to propose that you create yourself an account on
> i2c.wiki.kernel.org. I've just added a "Work in progress" section on
> the main page so that other interested developers can keep track of
> what is happening. You could create a page describing your progress and
> things that need to be done. And I should do the same for my part.

Ok. Thanks.

> Oh, and please stop calling the thing "virtual i2c adapter support".
> These adapters are very real. What you are working on is better
> described as "i2c bus multiplexing support".

I do.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
