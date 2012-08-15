From: Jiri Slaby <jslaby@suse.cz>
Subject: i2c-designware-core: KBUILD_MODNAME undeclared [was: Build regressions/improvements
 in v3.6-rc1]
Date: Wed, 15 Aug 2012 22:01:38 +0200
Message-ID: <502C0022.2020106@suse.cz>
References: <1344072256-13170-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344072256-13170-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, dirk.brandewie@gmail.com, khali@linux-fr.org, linux-i2c@vger.kernel.org, Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org, jbaron@redhat.com, ben-linux@fluff.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On 08/04/2012 11:24 AM, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v3.6-rc1[1] compared to v3.5[2].
...
>   + drivers/i2c/busses/i2c-designware-core.c: error: 'KBUILD_MODNAME' undeclared (first use in this function):

This is a real problem we are facing here. It happens on PPC when all
I2C_DESIGNWARE_PLATFORM, I2C_DESIGNWARE_PCI and DYNAMIC_DEBUG are set.

It's because i2c-designware-core.c is used in two modules
(i2c-designware-platform and i2c-designware-pci) and KBUILD_MODNAME is
not defined for those because (scripts/Makefile.lib):
# $(modname_flags) #defines KBUILD_MODNAME as the name of the module
# it will end up in (or would, if it gets compiled in)
# Note: Files that end up in two or more modules are compiled
#       without the KBUILD_MODNAME definition. The reason is
#       that any made-up name would differ in different configs.

But DYNAMIC_DEBUG needs KBUILD_MODNAME for dev_dbg used in that source.

Any ideas? Why is it not a separate module for example?

thanks,
-- 
js
suse labs
