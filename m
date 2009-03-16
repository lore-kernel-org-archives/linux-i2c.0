From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Let checkpatch shout on users of the legacy model
Date: Mon, 16 Mar 2009 17:39:54 +0100
Message-ID: <20090316173954.20de0fe4@hyperion.delvare>
References: <20090312161551.51ee067f@hyperion.delvare>
	<20090312123204.7d093fca@pedra.chehab.org>
	<20090312185110.41e25953@hyperion.delvare>
	<20090312234133.2c84c56a@pedra.chehab.org>
	<20090315092529.6f3a6c9f@hyperion.delvare>
	<20090316072559.0e61eab1@gaivota.chehab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090316072559.0e61eab1-mH16qt36X8hBi9Soz/MV8B2eb7JE58TQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Mauro,

On Mon, 16 Mar 2009 07:25:59 -0300, Mauro Carvalho Chehab wrote:
> On Sun, 15 Mar 2009 09:25:29 +0100
> Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > Hans made a poll some weeks ago with regards to the interest developers
> > and users have in supporting pre-2.6.22 kernels and the results were
> > pretty clear: this is something almost nobody is interested in. So I am
> > curious, what are we waiting for before we drop support these old
> > kernels?
> 
> From the comments posted at lwn.net, it seems that there are more people
> interested on keeping backport support.

Pointer?

The key question IMHO is: are these people willing to contribute their
time to make it work? If not then their opinion is only mildly
interesting.

> Also, from my side, not supporting
> 2.6.18 will break my production environment, and for sure this is something I
> don't want.

I can understand that you want a rock-solid environment for your daily
work. However I fail to see why that environment also needs to be the
target for your development. I have a separate system for this.

> Anyway, I've already provided an skeleton of a backport solution for pre-2.6.22, on an
> experimental tree, based on a driver that Hans provided me, with what he thinks
> it will be the way the new drivers will look alike and what's needed to keep it
> working with 2.6.22 or lower.
> 
> Since people are still busy with the i2c conversion I didn't have any feedback
> yet about the backport tree, nor I think people will have enough time to test
> this before 2.6.30 rc cycle, I suspect that the tree changes (and probably
> including moving it to a full git-based deployment model) will likely be
> postponed, since we'll need to adjust the entire development environment, and
> this takes time that I won't have during this merging cycle.

Agreed.

-- 
Jean Delvare
