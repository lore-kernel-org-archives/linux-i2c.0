From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] lib: Fix compilation when USE_STATIC_LIB
Date: Wed, 29 Nov 2017 13:05:55 +0100
Message-ID: <20171129130555.0367567f@endymion>
References: <1511909897-18600-1-git-send-email-angelo@amarulasolutions.com>
        <20171129110808.4168f82f@endymion>
        <CA+_SqVakUBi3H3=GySprvYpZhZFhMXCzabY-ESwVb=vOaFP3zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53945 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751783AbdK2MF6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 29 Nov 2017 07:05:58 -0500
In-Reply-To: <CA+_SqVakUBi3H3=GySprvYpZhZFhMXCzabY-ESwVb=vOaFP3zQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Angelo Compagnucci <angelo@amarulasolutions.com>
Cc: linux-i2c@vger.kernel.org

On Wed, 29 Nov 2017 12:04:06 +0100, Angelo Compagnucci wrote:
> On Wed, Nov 29, 2017 at 11:08 AM, Jean Delvare <jdelvare@suse.de> wrote:
> > On Tue, 28 Nov 2017 23:58:17 +0100, Angelo Compagnucci wrote:  
> > > This patch removes the mandatory compiling of the shared library
> > > when USE_STATIC_LIB is used.  
> >
> > No, thanks. The current behavior is as desired: always build the
> > dynamic library, and optionally build the static library. It was never
> > the intent to allow only building the static library. Static libraries
> > are evil.  
> 
> In Buildroot we have the need to support also static only libraries
> cause we have targets that doesn't support dynamic libraries (like
> cortex M4 for which I'm fixing this bug).

That's a frightening platform :(

> The option for static only is also present for various other
> architectures as a build option.
> 
> So, if this cannot be fixed upstream, I'll push a patch only on the
> Buildroot side.

Maybe it can be fixed upstream, but not the way you proposed because it
causes a regression (by default the dynamic lib would no longer be
built.)

I suppose that introducing BUILD_DYNAMIC_LIB, which would default to 1
and would only control whether the dynamic library is built or not,
would be acceptable. But you'll have to make sure that at least one
flavor of the library is being built, and that the tools themselves are
linked to the right library (dynamic if available, else fallback to
static, see USE_STATIC_LIB.)

By default we want all library flavors built, and the tools linked
dynamically.

-- 
Jean Delvare
SUSE L3 Support
