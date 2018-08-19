From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler warning
Date: Sun, 19 Aug 2018 09:46:55 -0700
Message-ID: <CA+55aFxv5_8C5ApV4cDjpvAmZbn1aiKebc7yrRWBskQQbz9=Hw@mail.gmail.com>
References: <20180819135135.8801-1-sedat.dilek@credativ.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180819135135.8801-1-sedat.dilek@credativ.de>
Sender: linux-kernel-owner@vger.kernel.org
To: sedat.dilek@credativ.de, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-i2c@vger.kernel.org

On Sun, Aug 19, 2018 at 6:51 AM Sedat Dilek <sedat.dilek@credativ.de> wrote:
>
> This can be dropped with commit 771c035372a036f83353eef46dbb829780330234
> ("deprecate the '__deprecated' attribute warnings entirely and for good")
> now in upstream.

Could we please just remove the __deprecated use in i2c entirely?

As fat as I can tell, it's used for one thing, which is the
"attach_adapter" function pointer member in 'struct i2c_driver'.

And I think there is _one_ remaining driver using it, namely the
powermac "therm_windtunnel" driver.

Could somebody who knows the i2c probing just a bit convert that *one*
remaining driver, then remove the "attach_adapter" entirely, and also
remove this thing?

Alternatively, perhaps the driver should be removed? The last actual
powermac change to that driver seems to be from August 2009.
Everything since has been just cleanup unrelated to that driver code
itself (ie spelling fixes, automated coccinelle scripts etc).

Added a few people either because they're still officially maintainers
of that file, or because they touched the code ten years ago.

               Linus
