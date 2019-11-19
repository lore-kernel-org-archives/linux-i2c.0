From: Lei YU <mine260309@gmail.com>
Subject: Re: [PATCH] docs: i2c: Fix return value of i2c_smbus_xxx functions
Date: Tue, 19 Nov 2019 17:43:43 +0800
Message-ID: <CAARXrtmHh-7smvGi1_0J81zRfR9iiEG2+DJK2nDi_fThOKggmA@mail.gmail.com>
References: <1574153778-59977-1-git-send-email-mine260309@gmail.com> <a1444cbf-3a1d-6f17-97a9-77664a95d304@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a1444cbf-3a1d-6f17-97a9-77664a95d304@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 19, 2019 at 5:33 PM Peter Rosin <peda@axentia.se> wrote:
>
> On 2019-11-19 09:56, Lei YU wrote:
> > In i2c/dev-interface.rst it said
> >
> >> All these transactions return -1 on failure
> >
> > But actually the i2c_smbus_xxx functions return negative error numbers
> > on failure, instead of -1.
> >
> > Fix the document.
> >
> > Signed-off-by: Lei YU <mine260309@gmail.com>
> > ---
> >  Documentation/i2c/dev-interface.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/i2c/dev-interface.rst b/Documentation/i2c/dev-interface.rst
> > index 69c23a3..73b77c3 100644
> > --- a/Documentation/i2c/dev-interface.rst
> > +++ b/Documentation/i2c/dev-interface.rst
> > @@ -163,8 +163,8 @@ for details) through the following functions::
> >    __s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length,
> >                                     __u8 *values);
> >
> > -All these transactions return -1 on failure; you can read errno to see
> > -what happened. The 'write' transactions return 0 on success; the
> > +All these transactions return negative value on failure; you can read errno to
> > +see what happened. The 'write' transactions return 0 on success; the
>
> s/return negative/return a negative/

Ack, will send v2 patch.

>
> And the line is now too long compared to the rest of the text, so you
> need to rewrap the paragraph.

In this patch it's at column 78, that should be OK.
But after adding the "a" it will exceed and will rewrap in v2 patch.

>
> And why do you need to dig around in errno if the negative errno has
> already been returned?

Yeah, good question, probably we could remove the following sentence?

>
> >  'read' transactions return the read value, except for read_block, which
> >  returns the number of values read. The block buffers need not be longer
> >  than 32 bytes.
> >
>
> Hmm, unrelated, but should that perhaps be "must not" instead of "need not"?
>
> Cheers,
> Peter
