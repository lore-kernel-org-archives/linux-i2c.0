From: John Sperbeck <jsperbeck@google.com>
Subject: Re: [PATCH] i2c: core-smbus: don't trace smbus_reply data on errors
Date: Tue, 5 Feb 2019 09:19:01 -0800
Message-ID: <CAFNjLiU_KOmcBHykHt5JTr439DJVf=j=aGKpnObZfMx6nLreRQ@mail.gmail.com>
References: <20190104004203.116155-1-jsperbeck@google.com> <20190103214927.2bf947ca@vmware.local.home>
 <20190205121353.GC1045@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205121353.GC1045@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 5, 2019 at 4:14 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Thu, Jan 03, 2019 at 09:49:27PM -0500, Steven Rostedt wrote:
> > On Thu,  3 Jan 2019 16:42:03 -0800
> > John Sperbeck <jsperbeck@google.com> wrote:
> >
> > > If an smbus transfer fails, there's no guarantee that the output
> > > buffer was written.  So, avoid copying from the output buffer when
> > > tracing after an error.  This was 'mostly harmless', but would trip
> > > up kasan checking if left-over cruft in byte 0 is a large length,
> > > causing us to read from unwritten memory.
> > >
> > > Signed-off-by: John Sperbeck <jsperbeck@google.com>
> > > ---
> > >  drivers/i2c/i2c-core-smbus.c |  2 +-
> > >  include/trace/events/smbus.h | 10 +++++-----
> > >  2 files changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> > > index 9cd66cabb84f..132119112596 100644
> > > --- a/drivers/i2c/i2c-core-smbus.c
> > > +++ b/drivers/i2c/i2c-core-smbus.c
> > > @@ -585,7 +585,7 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
> > >  trace:
> > >     /* If enabled, the reply tracepoint is conditional on read_write. */
> > >     trace_smbus_reply(adapter, addr, flags, read_write,
> > > -                     command, protocol, data);
> > > +                     command, protocol, data, res);
> > >     trace_smbus_result(adapter, addr, flags, read_write,
> > >                        command, protocol, res);
> > >
> > > diff --git a/include/trace/events/smbus.h b/include/trace/events/smbus.h
> > > index d2fb6e1d3e10..b6376a7c7e74 100644
> > > --- a/include/trace/events/smbus.h
> > > +++ b/include/trace/events/smbus.h
> > > @@ -138,8 +138,8 @@ TRACE_EVENT_CONDITION(smbus_reply,
> > >     TP_PROTO(const struct i2c_adapter *adap,
> > >              u16 addr, unsigned short flags,
> > >              char read_write, u8 command, int protocol,
> > > -            const union i2c_smbus_data *data),
> > > -   TP_ARGS(adap, addr, flags, read_write, command, protocol, data),
> > > +            const union i2c_smbus_data *data, int res),
> > > +   TP_ARGS(adap, addr, flags, read_write, command, protocol, data, res),
> > >     TP_CONDITION(read_write == I2C_SMBUS_READ),
> >
> > Hmm, instead of tracing nothing, as this is already a "conditional
> > trace event", why not add to that condition:
> >
> >       TP_CONDITION(res >= 0 && read_write == I2C_SMBUS_READ),
> >
> > Unless you want to still trace some data on failure.
>
> John, any comment to this?
>

The issue we were dealing with was access to uninitialized memory on the stack.
The change '30f939feaeee i2c: fix kernel memory disclosure in dev interface'
does the initialization, so the tracing code is no longer affected.
We just didn't
have that change in the particular kernel we were testing.

Still, Steven's suggestion seems fine to me.  Would you like me to create a new
patch based on that?
