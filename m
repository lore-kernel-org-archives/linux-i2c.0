From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 16/16] i2c: designware: Convert to use unified device
 property API
Date: Wed, 2 Dec 2015 11:33:41 +0200
Message-ID: <20151202093341.GM1593@lahna.fi.intel.com>
References: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20151130195858.GB16446@katana>
 <1448966031.15393.131.camel@linux.intel.com>
 <3465575.VLD33ozkzD@vostro.rjw.lan>
 <1449048220.15393.141.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449048220.15393.141.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 02, 2015 at 11:23:40AM +0200, Andy Shevchenko wrote:
> On Wed, 2015-12-02 at 02:28 +0100, Rafael J. Wysocki wrote:
> > On Tuesday, December 01, 2015 12:33:51 PM Andy Shevchenko wrote:
> > > On Mon, 2015-11-30 at 20:58 +0100, Wolfram Sang wrote:
> > > > On Mon, Nov 30, 2015 at 05:11:44PM +0200, Andy Shevchenko wrote:
> 
> 
> 
> > > > What is the bug fix here described in the cover letter?
> > > 
> > > The cover letter mentioned 'last part' which I refer to as patches
> > > 14,
> > > 15 (though this is for UART), and 16.
> > 
> > Hmm.
> > 
> > So may I assume that patches [1-13/16] are for me and the rest is to
> > be applied
> > by the other respective maintainers?
> > 
> > That should be easiest logistically IMHO.
> 
> Have no objections.

Unfortunately the patches (except this one) depend on each other so they
cannot be applied separately.
