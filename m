From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Q: I2C multiplexer support
Date: Mon, 7 Dec 2009 10:51:32 +0100
Message-ID: <20091207105132.6926bf19@hyperion.delvare>
References: <4B1CC5EA.7040902@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B1CC5EA.7040902-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, giometti-k2GhghHVRtY@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

On Mon, 07 Dec 2009 10:07:54 +0100, Michael Lawnick wrote:
> on my current project I'm now at the point to have to implement
> multiplexer support. The last patch set from Rodolfo was for 2.6.29,

Correct.

> most parts seem to have been integrated already in 2.6.31

I don't think so, no. What went in (or more exactly, out of) i2c-core
in 2.6.31 was the removal of the legacy i2c binding model, along with
the cleanups that allowed. It should make multiplexing support easier
to add, but that's about it.

> If I got it correctly the patch based on creating a mux folder with
> i2c-mux.c as a core file and then additional mux layer files.
> So my questions:
> Rodolfo, do you have a more resent patch set?

I've been asking the same some weeks ago.

> Jean, what are your plans about multiplexer support, where do you see
> open issues?

In all honesty, I did not look at Rodolfo's code at all. When he sent
it originally, I didn't have the time, being in the middle of major
i2c-core changes and cleanups. After 2.6.31 was released, I finally had
the time to look into it. But as I knew the recent i2c-core changes
would require Rodolfo's patches to be rebased, I asked him to do that
first. But now it's apparently Rodolfo's time to be busy :( If you want
to help, you're welcome.

> Do you agree with current centralized layout or would you
> prefer independent single files integrating all necessary parts and
> residing in bus folder?

Not having looked at the current proposal, I can't really comment on
the design. But having a separate folder for mux drivers sounds sane at
first sight.

-- 
Jean Delvare
