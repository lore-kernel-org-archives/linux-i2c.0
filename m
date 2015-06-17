From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Py-smbus and python3 support: it's time for a new release?
Date: Wed, 17 Jun 2015 11:18:55 +0200
Message-ID: <20150617111855.787ddc6e@endymion.delvare>
References: <CA+TH9V=OwuaezZ7UKT-9Vg4cs8h4+mmhSZiGBDNq_Pp7V+G7Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+TH9V=OwuaezZ7UKT-9Vg4cs8h4+mmhSZiGBDNq_Pp7V+G7Og-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Angelo Compagnucci <angelo.compagnucci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Angelo,

On Tue, 26 May 2015 09:56:47 +0200, Angelo Compagnucci wrote:
> Dear Jean Delvare,
> 
> Now that python3 support was added to python-smbus, could you release
> a new stable version with it?
> 
> This way, py-smbus with python3 support could be included in
> distributions that usually don't pick unstable packages.

I understand that distributions don't want to ship unstable packages,
however they can (and do) cherry-pick individual commits to fix bugs or
add features they want. If you have a specific need, you can always ask
your distribution to consider backporting a few commits. In this
specific case, there's a dedicated stable branch for i2c-tools 3.1 so
it's even easier.

> Is there any planned roadmap or showstopper that makes this thing difficult?

The main blocker is that I'm always so busy and can never find the time
for the release.

Another problem is that it's the first release which will include
libi2c, and with that the first API will be set. After that, it's
harder to change it I got it wrong for any reason. I had plans to
extend the API a bit too (basically merging i2cbusses into the
library.) I guess that's the reason why I'm always delaying the
release. But to be honest, I suppose that no problem will be reported
until the library is widely used, and that just can't happen until it's
part of a stable release. So it's a kind of chicken-and-egg problem.

For the legacy branch (3.1), there's no libi2c excuse, and I did
consider a release after adding support for python3, but canceled the
idea after seeing only 2 lines in the CHANGES file. That being said,
there's so little happening on that branch that maybe it's expected
that only a couple fixes will make it into every release.

I'm adding "release i2c-tools" to my formal to-do list [1], but I can't
promise anything regarding the schedule.

[1] A sheet of paper on my desk, nothing fancy, really.

-- 
Jean Delvare
SUSE L3 Support
