From: Sedat Dilek <sedat.dilek@credativ.de>
Subject: Re: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler
 warning
Date: Fri, 24 Aug 2018 15:49:41 +0200 (CEST)
Message-ID: <1335058904.531.1535118581478@ox.credativ.com>
References: <20180819135135.8801-1-sedat.dilek@credativ.de>
 <20180824130130.bialyhjarwkwodzw@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824130130.bialyhjarwkwodzw@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

will my patch go to [1]?

Thank you, too.

Regards,
- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git/log/?h=i2c/for-next

> Wolfram Sang <wsa@the-dreams.de> hat am 24. August 2018 um 15:01 geschrieben:
> 
> 
> Sedat,
> 
> > This can be dropped with commit 771c035372a036f83353eef46dbb829780330234
> > ("deprecate the '__deprecated' attribute warnings entirely and for good")
> > now in upstream.
> 
> The pull request removing attach_adapter() is on the way now. Thanks for
> triggering all this!
> 
> Happy hacking,
> 
>    Wolfram
