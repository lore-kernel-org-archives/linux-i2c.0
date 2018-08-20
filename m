From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler warning
Date: Mon, 20 Aug 2018 13:36:55 -0700
Message-ID: <CA+55aFy+vVH4Mb-unrxm72JNORdxHaCFYEhD8iXbxo-OW0f8qg@mail.gmail.com>
References: <20180819135135.8801-1-sedat.dilek@credativ.de>
 <CA+55aFxv5_8C5ApV4cDjpvAmZbn1aiKebc7yrRWBskQQbz9=Hw@mail.gmail.com>
 <1d2a7c56cc44ff639ef2943366f4868e6e5ecdfe.camel@kernel.crashing.org> <20180820080629.i7y4cx4wewmcyqpk@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820080629.i7y4cx4wewmcyqpk@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, sedat.dilek@credativ.de, Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, pmac@au1.ibm.com
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 20, 2018 at 1:06 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> [1] http://patchwork.ozlabs.org/patch/461759/

Let's just apply this.

If it breaks something and somebody notices, we'll at least have found a tester.

And if it doesn't break anything, or if nobody ever notices the
breakage, then we will have gotten rid of that deprecated function.

Either way we win. There's no downside.

Wolfram, should I just take that patch as-is and get rid of the
deprecated atach_adapter thing, or will you send me a pull request?

                 Linus
