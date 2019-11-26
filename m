From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2] docs: i2c: Fix return value of i2c_smbus_xxx
 functions
Date: Tue, 26 Nov 2019 11:52:43 +0100
Message-ID: <20191126115243.673fc164@endymion>
References: <1574162632-65848-1-git-send-email-mine260309@gmail.com>
        <20191125144857.GA2412@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191125144857.GA2412@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Lei YU <mine260309@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 25 Nov 2019 15:48:57 +0100, Wolfram Sang wrote:
> On Tue, Nov 19, 2019 at 07:23:52PM +0800, Lei YU wrote:
> > In i2c/dev-interface.rst it said
> >   
> > > All these transactions return -1 on failure  
> > 
> > But actually the i2c_smbus_xxx functions return negative error numbers
> > on failure, instead of -1.
> > 
> > Fix the document and remove the following sentence.
> > 
> > Signed-off-by: Lei YU <mine260309@gmail.com>
> > ---
> >  Documentation/i2c/dev-interface.rst | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/i2c/dev-interface.rst b/Documentation/i2c/dev-interface.rst
> > index 69c23a3..f2f2b28 100644
> > --- a/Documentation/i2c/dev-interface.rst
> > +++ b/Documentation/i2c/dev-interface.rst
> > @@ -163,11 +163,10 @@ for details) through the following functions::
> >    __s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length,
> >                                     __u8 *values);
> >  
> > -All these transactions return -1 on failure; you can read errno to see
> > -what happened. The 'write' transactions return 0 on success; the
> > -'read' transactions return the read value, except for read_block, which
> > -returns the number of values read. The block buffers need not be longer
> > -than 32 bytes.
> > +All these transactions return a negative error number on failure.
> > +The 'write' transactions return 0 on success; the 'read' transactions
> > +return the read value, except for read_block, which returns the number
> > +of values read. The block buffers need not be longer than 32 bytes.  
> 
> I think the correct solution is to remove this paragraph entirely.
> Because the returned value does not depend on the kernel but on the
> libi2c version. Check this commit from 2012 in the i2c-tools repo:
> 
> 330bba2 ("libi2c: Properly propagate real error codes on read errors")
> 
> So, I think we should document it there. Jean, what do you think?

I would go further and move half of the document to i2c-tools. i2c-dev
itself only provides the ioctls. Everything on top of that is in libi2c
now, so the kernel documentation should point to libi2c and the
detailed documentation should come with libi2c.

So I guess I should review the whole document now to see what needs to
be updated, what should stay, and what should move.

-- 
Jean Delvare
SUSE L3 Support
