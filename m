From: Sedat Dilek <sedat.dilek@credativ.de>
Subject: Re: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler
 warning
Date: Fri, 24 Aug 2018 16:19:53 +0200 (CEST)
Message-ID: <1600966696.540.1535120394100@ox.credativ.com>
References: <20180819135135.8801-1-sedat.dilek@credativ.de>
 <20180824130130.bialyhjarwkwodzw@ninjato>
 <1335058904.531.1535118581478@ox.credativ.com>
 <20180824140705.t3pkiqfpnqzaaksz@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824140705.t3pkiqfpnqzaaksz@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-i2c@vger.kernel.org

> Wolfram Sang <wsa@the-dreams.de> hat am 24. August 2018 um 16:07 geschrieben:
> 
> 
> 
> > will my patch go to [1]?
> 
> It won't be needed anymore, the __deprecated function will go away until
> next week.
>

The relict in drivers/i2/Makefile should go away, too.

- sed@ -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git/tree/drivers/i2c/Makefile?h=i2c/for-next#n21
