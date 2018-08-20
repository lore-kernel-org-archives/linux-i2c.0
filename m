From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler
 warning
Date: Mon, 20 Aug 2018 21:25:24 +1000
Message-ID: <fed6012f3438f996cd2e7cb62e8eee58964fa36c.camel@kernel.crashing.org>
References: <20180819135135.8801-1-sedat.dilek@credativ.de>
         <CA+55aFxv5_8C5ApV4cDjpvAmZbn1aiKebc7yrRWBskQQbz9=Hw@mail.gmail.com>
         <1d2a7c56cc44ff639ef2943366f4868e6e5ecdfe.camel@kernel.crashing.org>
         <20180820080629.i7y4cx4wewmcyqpk@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820080629.i7y4cx4wewmcyqpk@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, sedat.dilek@credativ.de, Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Paul Mackerras <pmac@au1.ibm.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, 2018-08-20 at 10:06 +0200, Wolfram Sang wrote:
> 
> > Some people still use those old machines, I'll give a try at fixing the
> > driver.
> 
> I did this here a while ago [1] ("macintosh: therm_windtunnel: drop
> using attach adapter")...
> 
> > Paul: Do you still have one of these machines ?
> 
> ... but this was the main problem. I couldn't find anyone to test this.
> Even asked on PPC lists of various distributions.

Yeah this one is annoying because it's only used by one specific
machine model..

> Note that we did apply the same approach of patch [1] already in commit
> ac397c80de89 ("ALSA: ppc: keywest: drop using attach adapter"). This has
> been tested on HW. I also have a hack to make this driver probe on one
> of my ARM boards. Of course, no real HW present there, but shows that
> the new probing works at least there.
> 
> This is very interesting timing, too. Because I wanted to use the
> tentative version jump to 5.0 to finally get rid of this deprecated
> feature independently of the discussion here. Which would have meant
> resending the patch and arguing we have enough indications that the
> patch [1] is sane. And then I could finally remove this callback.
> 
> Thanks,
> 
>    Wolfram
> 
> [1] http://patchwork.ozlabs.org/patch/461759/

Ok, worst case we can remove the driver and re-instate it back later if
somebody complains, but I'll try to chase a machine first.

Cheers,
Ben.
