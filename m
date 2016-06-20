From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH] i2c: remove __init from i2c_register_board_info()
Date: Mon, 20 Jun 2016 17:12:12 +0200
Message-ID: <20160620151212.GA25646@wotan.suse.de>
References: <1465343547-19974-1-git-send-email-mcgrof@kernel.org>
 <20160619121538.GB3072@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160619121538.GB3072@tetsubishi>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, feng.tang@intel.com, linux-next@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Jun 19, 2016 at 02:15:38PM +0200, Wolfram Sang wrote:
> On Tue, Jun 07, 2016 at 04:52:27PM -0700, Luis R. Rodriguez wrote:
> > As of next-20160607 with allyesconfig we get this linker failure:
> > 
> >   MODPOST vmlinux.o
> > WARNING: vmlinux.o(.text+0x21bc0d): Section mismatch in reference from
> > the function intel_scu_devices_create() to the function
> > .init.text:i2c_register_board_info()
> > 
> > This is caused by the fact that intel_scu_devices_create() calls
> > i2c_register_board_info() and intel_scu_devices_create() is not
> > annotated with __init. This typically involves manual code
> > inspection and if one is certain this is correct we would
> > just peg intel_scu_devices_create() with a __ref annotation.
> > 
> > In this case this would be wrong though as the
> > intel_scu_devices_create() call is exported, and used in
> > the ipc_probe() on drivers/platform/x86/intel_scu_ipc.c.
> > The issue is that even though builtin_pci_driver(ipc_driver)
> > is used this just exposes the probe routine, which can occur
> > at any point in time if this bus supports hotplug. A race
> > can happen between kernel_init_freeable() that calls the init
> > calls (in this case registeres the intel_scu_ipc.c driver, and
> > later free_initmem(), which would free the i2c_register_board_info().
> > If a probe happens later in boot i2c_register_board_info() would
> > not be present and we should get a page fault.
> > 
> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> 
> Applied to for-current, thanks! Do you think this should go to stable?

Its a theoretical race, but a real one, but does fix allyesconfig builds.
Up to you.

  Luis
