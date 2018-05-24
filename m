From: John Sperbeck <jsperbeck@google.com>
Subject: Re: [PATCH v3 0/2] Re: Problem: lockdep warning with nested instances
 of i2c-mux
Date: Thu, 24 May 2018 11:21:31 -0700
Message-ID: <CAFNjLiVZ+g6eeHjpwMm+KiAA69Kpm_nVjWxkm2wCuV58RZwj4A@mail.gmail.com>
References: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
 <20180524135240.10881-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180524135240.10881-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: peda@axentia.se
Cc: linux-kernel@vger.kernel.org, wsa@the-dreams.de, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, dave@stgolabs.net, pombredanne@nexb.com, tglx@linutronix.de, gregkh@linuxfoundation.org, linux-i2c@vger.kernel.org, Peter Chang <dpf@google.com>, Deepa Dinamani <deepadinamani@google.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 24, 2018 at 6:52 AM Peter Rosin <peda@axentia.se> wrote:

> Hi!

> Sorry for spamming. At least I'm finding these embarrassing f$&%ups
> myself, not that it helps all that much, but...

> Changes since v2    https://lkml.org/lkml/2018/5/24/176
> - EXPORT_SYMBOL_GPL(rt_mutex_lock_nested) is more appropriate (the
>    rt_ prefix was missing).


Yes, after fixing the "rt_" typo, this addresses our use case.  Thanks for
the quick response.
