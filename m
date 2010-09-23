From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-mv64xxx: use subsys_initcall for early initialization
Date: Thu, 23 Sep 2010 09:11:00 +0200
Message-ID: <AANLkTi=gtXJ8zQt2kTSCCy7=Zc4R-8BDp=Z8w7u8_ua+@mail.gmail.com>
References: <1284284129-28105-1-git-send-email-mike@compulab.co.il>
	<20100914232547.GD7494@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100914232547.GD7494-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

2010/9/15 Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>:
> On Sun, Sep 12, 2010 at 11:35:29AM +0200, Mike Rapoport wrote:
>> Signed-off-by: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
>> ---
>> =A0drivers/i2c/busses/i2c-mv64xxx.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> We really should have an i2c_initcall, but it may be difficult to mov=
e
> everyone over to it. What would be lovely is some form of dependency
> based initialisation, but that's probably a way off...

SPI, SDIO and other external busses (Dallas 1-wire? w1) may all have
the same "needs to be up early because we need that before that"
type of problem.

Makes me think of crazy things like putting a lightweight version of
Lennars P=F6tterings "systemd" scheme into the kernel for resolving
these initcalls.

Yours,
Linus Walleij
