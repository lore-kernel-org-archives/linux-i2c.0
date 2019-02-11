From: John Sperbeck <jsperbeck@google.com>
Subject: Re: [PATCH v2] i2c: core-smbus: don't trace smbus_reply data on errors
Date: Mon, 11 Feb 2019 13:43:54 -0800
Message-ID: <CAFNjLiVMOii_mzs4Px38GHxFq6WnrDNhQ9YHMb+4yGZZ6SFpkQ@mail.gmail.com>
References: <20190205190849.GA2686@kunai> <20190211034021.242932-1-jsperbeck@google.com>
 <20190211092417.7f211ee0@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211092417.7f211ee0@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 11, 2019 at 6:24 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sun, 10 Feb 2019 19:40:21 -0800
> John Sperbeck <jsperbeck@google.com> wrote:
>
> > If an smbus transfer fails, there's no guarantee that the output
> > buffer was written.  So, avoid trying to show the output buffer when
> > tracing after an error.  This was 'mostly harmless', but would trip
> > up kasan checking if left-over cruft in byte 0 is a large length,
> > causing us to read from unwritten memory.
>
> This looks fine to me, but I'm not sure how the i2c maintainers feel,
> but I always require that a new patch version starts a new thread, and
> not be part of a older thread release (causes these patches to be
> hidden from those that read patches in threading mode).

That sounds reasonable to me.  Unless I hear otherwise, I'll create a
v3 as a new thread.  Thanks.
