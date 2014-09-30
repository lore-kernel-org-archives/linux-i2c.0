From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] i2c: move acpi code back into the core
Date: Tue, 30 Sep 2014 22:34:07 +0200
Message-ID: <1773097.ooYUbTzKBv@vostro.rjw.lan>
References: <1411594591-5048-1-git-send-email-wsa@the-dreams.de> <20140930160352.GV1786@lahna.fi.intel.com> <20140930204607.2ab3baed@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20140930204607.2ab3baed@endymion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lan Tianyu <tianyu.lan@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Tuesday, September 30, 2014 08:46:07 PM Jean Delvare wrote:
> On Tue, 30 Sep 2014 19:03:52 +0300, Mika Westerberg wrote:
> > On Tue, Sep 30, 2014 at 12:55:20PM +0200, Jean Delvare wrote:
> > > The only thing which I find curious is that ACPI_I2C_OPREGION depends
> > > on I2C=y. Is this limitation a leftover from when the code was split to
> > > a separate file? It builds just fine with I2C=m, and I can't see why it
> > > wouldn't work. I have a patch to enable that, I can send it if it is
> > > the right thing to do. But maybe I'm missing something?
> > 
> > I think reason for the limitation is that if there happens to be some
> > AML code that is currently using the I2C operation region and the user
> > decides to unload the i2c-core.ko module or along those lines.
> 
> If that's the reason then shouldn't it be addressed by proper reference
> counting instead? We could simply increase the module reference count
> when entering the critical section, and decrease it when we're done.

That is not so simple in practice, because the code containing the
critical sections in question is AML and not part of the kernel.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
