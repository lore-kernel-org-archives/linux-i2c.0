From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c/nomadik: runtime PM support
Date: Mon, 24 Oct 2011 19:17:25 +0200
Message-ID: <CACRpkdaeYW9e2CkDvsLPKRsfGsQKS_ahbvrQqo1Sxibvru8WcQ@mail.gmail.com>
References: <1319127798-13395-1-git-send-email-linus.walleij@stericsson.com>
	<CANqRtoSxHHKxLaKd-qPjCDomp5o-iiij8hqLCs7GNhs4xCV-jg@mail.gmail.com>
	<CACRpkdZmifrV3o59JrWx2Z6DAqHO80W4d=7NJ6OipAOrbazgXg@mail.gmail.com>
	<CANqRtoRw5+1yrEuphdYT+wq2ooHTojj00i5yGLPMWomUBPSP1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANqRtoRw5+1yrEuphdYT+wq2ooHTojj00i5yGLPMWomUBPSP1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 24, 2011 at 4:32 PM, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
> On Fri, Oct 21, 2011 at 8:19 PM, Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
>> Currently we have something similar for the AMBA
>> bus here, since it actually has code in place to grab
>> the block clock on probe() and its own runtime PM
>> callbacks. Since the bus driver holds the actual reference
>> to the clock, we have to call down into the bus callbacks
>> from the platform runtime PM implementation since our
>> implementation takes precedence. I guess this is expected
>> way of doing it?
>
> I'm not sure actually. We should sit down together and discuss this
> over an afternoon - hopefully together with Rafael. I could probably
> find time during next week in Orlando if you're around.

OK sounds like a plan, I'll bring our code and we'll atleast try
to understand each others' thinking!

Med v=E4nlig h=E4lsning
Linus Walleij
