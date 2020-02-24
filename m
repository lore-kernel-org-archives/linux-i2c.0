From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [regression] nct6775 does not load in 5.4 and 5.5, bisected to
 b84398d6d7f90080
Date: Mon, 24 Feb 2020 12:51:21 +0200
Message-ID: <20200224105121.GK2667@lahna.fi.intel.com>
References: <CAM1AHpQ4196tyD=HhBu-2donSsuogabkfP03v1YF26Q7_BgvgA@mail.gmail.com>
 <1bdbac08-86f8-2a57-2b0d-8cd2beb2a1c0@roeck-us.net>
 <CAM1AHpSKFk9ZosQf=k-Rm2=EFqco7y4Lpfb7m07r=j_uJd4T0A@mail.gmail.com>
 <85356d1a-f90d-e94d-16eb-1071d4e94753@roeck-us.net>
 <CAM1AHpSpEFshpUGxKdhLV3XuThQg_XVaPgOWzvrTv6YtzHyO+A@mail.gmail.com>
 <bec1f81c-09a8-ba48-c6c4-5d9b340f7c0b@roeck-us.net>
 <20200224101800.GJ2667@lahna.fi.intel.com>
 <20200224103731.GA10400@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:44085 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgBXKv0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 05:51:26 -0500
Content-Disposition: inline
In-Reply-To: <20200224103731.GA10400@smile.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Martin Volf <martin.volf.42@gmail.com>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Mon, Feb 24, 2020 at 12:37:31PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 24, 2020 at 12:18:00PM +0200, Mika Westerberg wrote:
> > On Sat, Feb 22, 2020 at 01:26:48PM -0800, Guenter Roeck wrote:
> > > On 2/22/20 12:49 PM, Martin Volf wrote:
> > > > On Sat, Feb 22, 2020 at 8:05 PM Guenter Roeck <linux@roeck-us.net> wrote:
> 
> ...
> 
> > > >          devfn = PCI_DEVFN(PCI_SLOT(pci_dev->devfn), 2);
> 
> I'm wondering if
> 
> 		pci_dev_is_present(...);
> 
> returns false here.

Well that might also be the case since lspci shows this:

00:1f.0 ISA bridge: Intel Corporation Z390 Chipset LPC/eSPI Controller (rev 10)
00:1f.3 Audio device: Intel Corporation Cannon Lake PCH cAVS (rev 10)
00:1f.4 SMBus: Intel Corporation Cannon Lake PCH SMBus Controller (rev 10)

PMC is 1f.2 and not present here. However, it may be that the PMC is
still there it just does not "enumerate" because its devid/vendorid are
set to 0xffff. Similar hiding was done for the P2SB bridge.
