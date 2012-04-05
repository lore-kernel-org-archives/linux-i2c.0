From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-tools: Discussion points about future library
Date: Thu, 5 Apr 2012 13:50:26 +0200
Message-ID: <20120405135026.48380acf@endymion.delvare>
References: <20120404160113.2295c636@endymion.delvare>
	<20120404174158.GA19773@sirena.org.uk>
	<20120404212323.59053a1f@endymion.delvare>
	<4F7CA3D4.8000104@fold.natur.cuni.cz>
	<20120405094910.1dcc4779@endymion.delvare>
	<4F7D68F2.4040106@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F7D68F2.4040106-08dBlVkRsZWoiTQjSSYKZesEoJ4y9sgM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Mokrejs <mmokrejs-08dBlVkRsZWoiTQjSSYKZesEoJ4y9sgM@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Aurelien Jarno <aurelien-rXXEIb44qovR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 05 Apr 2012 11:42:10 +0200, Martin Mokrejs wrote:
> Jean Delvare wrote:
> > (...)
> > I understand that having two libraries by the same name will cause some
> > confusion, but OTOH the parallel implementations and resulting
> > confusion already exist, I'm only making the confusion more formal.
> 
> Yes, that will be also a nightmare for distro maintainers, having same header
> and library files installed simultaneously on a system, users having problems
> which one to install ...

I don't see any nightmare for distro maintainers (and I would mind, as
I am maintaining i2c-tools and thus will be maintaining libi2c, in
openSUSE.) Today there is no libi2c in distributions, tomorrow there
will be one, that's all OK. Likewise, users won't have any problem,
unless they fetch random code and build it themselves. If they do that,
I would assume they know what they're doing, and they can then install
the alternative implementation files under /opt or similar.

Again, it would be a problem if there was already a libi2c in
distributions, but it turns out this isn't the case. Unless you can
find a distribution with a non-negligible market share which actually
ships a library by that name.

Also note that, assuming for a moment that Katalix's libi2c has some
visibility and people are actually using it at wide (which I doubt,
IMHO users are limited to a few embedded platform developers), then the
confusion will not come from the fact that both libraries have the same
name, it will start with the fact that two libraries exist that achieve
the same purpose. The fact is that we do not need two libraries, so any
time spent on making it easy to install them in parallel, is wasted
time IMHO.

> > (...)
> > No, sorry. I'm not going to invent a fancy name to make sure it isn't
> > clashing with something out there. If anyone wanted their code to
> > become the standard Linux i2c library, they should have pushed it to
> > major Linux distributions. Nobody did AFAICS.
> 
> No, sorry, don't take me wrong and not personally, at all with the following.
> Once I read somewhere on the internet a rant from some software developer who
> created program "foo". Later on, someone else decided to create a package
> "foo2" and the original author commented that it was "nasty", as it appears
> "foo2" is an improved version of "foo".

I don't quite see how it relates to the problem at hand...

> Back to our case, I find it "nasty" as well to say, now, X years later we have
> our own library and will use exactly this name, as we don't care about you all.
> We are the "official" ...

We will indeed be "official" at the time distributions package and ship
our library. If others wanted to be "official", they had to get their
code visible and included in several distributions.

> I hope I will not start a flame with this answer. Personally, I do not mind
> but I just saw too many times packages using same library and header names.
> Last time it was, that glibc since some newer version had a header file
> of some name which some app used since years. I convinced the app author
> to change his header name as it seemed more feasible than convincing glibc
> people to take their decision back.

This is the problem with having a single namespace. This is the reason
why I will put the header files under /usr/include/i2c rather
than /usr/include directly. While not bullet-proof, this should limit
the risk of collisions.

> But you just asked beforehand, so I wanted to tell you my opinion. I would
> contact Katalix to discuss, that would be fair thing to do.

I'll put exactly the same amount of effort in contacting them now than
they put in contacting us 6 years ago. That is, none.

And don't get me wrong, I don't mean to be harsh with them. They wrote
a library because there was none at the time, and I understand that.
They decided their time was not worth spending on trying to get it into
distributions, and I understand and respect that too, everyone have
their priorities. And I don't even think they will have any problem
with what I'm doing now, because a library maintained by somebody else
means less work for them, and converting existing applications to use
it should be fairly easy.

So I'm not going to start a discussion with Katalix, because it's
rather unlikely that they care about what I'm doing, and if they do,
it's rather likely that it won't bother them at all.

-- 
Jean Delvare
