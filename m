From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 4/5] i2c: designware-baytrail: Force the CPU to C1
 state while holding the punit semaphore
Date: Mon, 02 Jan 2017 10:26:34 +0200
Message-ID: <1483345594.9552.179.camel@linux.intel.com>
References: <20161210141908.16470-1-hdegoede@redhat.com>
         <20161210141908.16470-4-hdegoede@redhat.com>
         <1481381595.7188.6.camel@linux.intel.com>
         <a1e46965-9cef-1ec0-ddb4-3a527cd71045@redhat.com>
         <5425712f-550e-cc30-3b52-5bd25eabc5d9@redhat.com>
         <CAJvTdKnqdhYo1hTp33z-dUCO3H5sROZQtDdSaGiL_EwW3DbbqQ@mail.gmail.com>
         <e415e26c-8781-6ce1-c0f9-a68249e542d3@redhat.com>
         <c6933f49-6f1b-d24a-1878-8893bfe88090@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13487 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750944AbdABI0j (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 2 Jan 2017 03:26:39 -0500
In-Reply-To: <c6933f49-6f1b-d24a-1878-8893bfe88090@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, jani.nikula@linux.intel.com
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Vincent Gerris <vgerris@gmail.com>, linux-i2c@vger.kernel.org, tagore.chandan@gmail.com, intel-gfx@lists.freedesktop.org

On Sat, 2016-12-31 at 22:29 +0100, Hans de Goede wrote:

> This makes sense, the iosf_mbi code which is used by the
> i2c bus semaphore code has this:
> 
> arch/x86/platform/intel/iosf_mbi.c:
> 
> int iosf_mbi_read(u8 port, u8 opcode, u32 offset, u32 *mdr)
> {
>          u32 mcr, mcrx;
>          unsigned long flags;
>          int ret;
> 
>          /* Access to the GFX unit is handled by GPU code */
>          if (port == BT_MBI_UNIT_GFX) {
>                  WARN_ON(1);
>                  return -EPERM;
>          }
> 
> 	...
> }
> 
> So the i915 driver definitely is interacting with the punit
> through the mailbox interface too...

Yes, they have private mailbox support. Once I talked to Ville to make
at least definitions common between two: iosf_mbi.h and whatever i915 is
using, but have no time to implement that.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
