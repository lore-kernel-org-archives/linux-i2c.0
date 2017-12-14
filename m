From: Jean Delvare <jdelvare@suse.de>
Subject: Re: i2c-tools: lib/Module.mk: fixing LIB_LINKS dependency
Date: Thu, 14 Dec 2017 13:42:48 +0100
Message-ID: <20171214134248.6e908946@endymion>
References: <1513011624-1555-1-git-send-email-angelo@amarulasolutions.com>
        <20171214093649.61e8f1df@endymion>
        <CA+_SqVZ4dJBcL9+D3x42b0bJB2POasiu4Tz6gtTZHkmX=h56xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751839AbdLNMmw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 14 Dec 2017 07:42:52 -0500
In-Reply-To: <CA+_SqVZ4dJBcL9+D3x42b0bJB2POasiu4Tz6gtTZHkmX=h56xg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Angelo Compagnucci <angelo@amarulasolutions.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>

On Thu, 14 Dec 2017 10:43:33 +0100, Angelo Compagnucci wrote:
> On Thu, Dec 14, 2017 at 9:36 AM, Jean Delvare <jdelvare@suse.de> wrote:
> > I suppose that BUILD_DYNAMIC_LIB=0 should imply USE_STATIC_LIB=1.
> > Something like:
> >
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -43,6 +43,8 @@ endif
> >  ifeq ($(BUILD_DYNAMIC_LIB),0)
> >  ifeq ($(BUILD_STATIC_LIB),0)
> >  $(error BUILD_DYNAMIC_LIB and BUILD_STATIC_LIB cannot be disabled at the same time)
> > +else
> > +USE_STATIC_LIB := 1
> >  endif
> >  endif
> >
> > What do you think?  
> 
> I think you are totally right. If BUILD_DYNAMIC_LIB is 0 the static
> variant should be built and used too.

Thanks. Both fixes committed.

> Could you realease a new version of i2c-tools with these patches? I'm
> in the phase of updating the package in buildroot and I do really
> prefer to have a new stable release than an old release with a bunch
> of patches on top.

I don't have such a plan, sorry. Version 4.0 is still relatively new, I
expect more problems to be found and fixed in the next weeks, I don't
think it makes sense to rush a new release. There are only 13 commits
since 4.0, it's not that many.

Backporting patches for distribution packages is the usual process, and
6 patches is not a bunch. If the patch count really bothers you, you can
always consolidate the fix-ups into the original patch and you'll be
down to 4, that seems easily manageable. Quilt is your friend ;-)

-- 
Jean Delvare
SUSE L3 Support
