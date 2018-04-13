From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] Documentation/i2c: sync docs with current state of
 i2c-tools.
Date: Fri, 13 Apr 2018 14:13:59 +0200
Message-ID: <20180413141359.793919fb@endymion>
References: <20180412213342.138010-1-hansens@google.com>
        <20180412222457.x4jdwt27ylgi74o3@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180412222457.x4jdwt27ylgi74o3@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Sam Hansen <hansens@google.com>, linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram, Sam,

On Fri, 13 Apr 2018 00:24:57 +0200, Wolfram Sang wrote:
> On Thu, Apr 12, 2018 at 02:33:42PM -0700, Sam Hansen wrote:
> > Currently, Documentation/i2c/dev-interface describes the use of i2c_smbus_*
> > helper routines as static inlined functions provided by linux/i2c-dev.h.  Work
> > has been done to refactor the linux/i2c-dev.h file in the i2c-tools project
> > out into its own library.  As a result, these docs have become stale.  
> 
> Thanks for fixing this!
> 
> > This patch corrects the discrepancy and directs the reader to the i2c-tools
> > project for more information.  Additionally, some trailing-whitespace cleanups
> > were made.  
> 
> Minor nit: Having the whitespace changes in a seperate patch is a tad
> easier to review.
> 
> > -  /* Using I2C Write, equivalent of 
> > +  /* Using I2C Write, equivalent of
> >       i2c_smbus_write_word_data(file, reg, 0x6543) */  
> 
> Maybe change to Kernel coding style comments while here?
> 
> > -  Not meant to be called  directly; instead, use the access functions
> > -  below.
> > +  If possible, use the provided i2c_smbus_* methods described below in favor
> > +  of issuing direct ioctls.  
> 
> Why this change?

I'm also not sure if "in favor of" is right. "instead of" would sound
better to me, but I'm no native English speaker, I could be wrong.

> > -The above functions are all inline functions, that resolve to calls to
> > -the i2c_smbus_access function, that on its turn calls a specific ioctl
> > -with the data in a specific format. Read the source code if you
> > -want to know what happens behind the screens.
> > +The above functions are made available by linking against the libi2c library,
> > +which is provided by the i2c-tools project.  See:
> > +https://git.kernel.org/pub/scm/utils/i2c-tools/i2c-tools.git/.  
> 
> This is fine with me. Maybe Jean has a comment on this?

Fixing the documentation is always welcome, thanks Sam for stepping in.
However we really want separate patches for whitespace fixes and actual
contents change, as Wolfram already mentioned above.

-- 
Jean Delvare
SUSE L3 Support
