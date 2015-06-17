From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c-tools: enable static use of libi2c
Date: Wed, 17 Jun 2015 15:10:25 +0200
Message-ID: <20150617151025.1353abe3@endymion.delvare>
References: <1434420079-3029-1-git-send-email-wsa@the-dreams.de>
	<20150617110615.7c7cb411@endymion.delvare>
	<20150617105309.GF1517@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150617105309.GF1517@katana>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 17 Jun 2015 12:53:09 +0200, Wolfram Sang wrote:
> Hi Jean,
> 
> > > When debugging embedded systems, it is often nice to simply TFTP the
> > > desired i2ctool to the target without the hazzle of dealing with shared
> > > libs. Using -static is overkill, too, so let's add a switch which will
> > > only link functions from libi2c statically.
> > 
> > Fine with me.
> 
> Hooray!
> 
> > >  BUILD_STATIC_LIB ?= 1
> > > +# Uncomment to use static libi2c
> > > +#USE_STATIC_LIB := 1
> > 
> > Any reason for not using ?= as above, with the default being unset?
> 
> Agreed.
> 
> > Unrelated to your patch, but shouldn't this -Llib rather been written
> > -L$(LIB_DIR)?
> 
> Yes, makes sense.

OK, I'll fix it after applying your updated patch.

> > Also it might make sense to check if USE_STATIC_LIB is set when
> > BUILD_STATIC_LIB isn't and complain about it?
> 
> For easier usage, I'd rather enforce BUILD_STATIC_LIB in that case.

You mean that USE_STATIC_LIB = 1 would silently imply
BUILD_STATIC_LIB = 1? Yes, that's much better than my proposal.

I'm wondering if we should make it even more flexible, but I'm not sure
if it's worth the effort... Are you calling "make install" after that?
I guess not.

-- 
Jean Delvare
SUSE L3 Support
