From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PULL REQUEST] i2c for 4.20
Date: Sat, 10 Nov 2018 07:06:52 -0600
Message-ID: <CAHk-=wgAJXs32MZNWNO9HjMmgtV9kWmDvjQS7zcFg0PVgJyHog@mail.gmail.com>
References: <20181110112036.GA5905@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181110112036.GA5905@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, peda@axentia.se, brgl@bgdev.pl
List-Id: linux-i2c@vger.kernel.org

On Sat, Nov 10, 2018 at 5:20 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> I hope the rc1 rule still applies for this new driver. It consists of the I2C
> master part and UCSI client part which has the needed ack from Heikki.

I've pulled it, but please don't do this again.

The "New driver" rule has become pretty much historical, simply
because releases have been regular enough that it doesn't much make
much sense, and we just have't had the kinds of "basic support"
drivers that make sense pushing out as early as possible just to get
people able to use a machine at all. So in practice, the "new driver"
rule has become a "new ID or quirk" rule.

The nVidia i2c support doesn't sound so special that it couldn't have
waited until the merge window.

                    Linus
