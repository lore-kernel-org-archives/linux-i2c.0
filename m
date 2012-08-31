From: Jean Delvare <khali@linux-fr.org>
Subject: Re: i2c-designware-core: KBUILD_MODNAME undeclared [was: Build
 regressions/improvements  in v3.6-rc1]
Date: Fri, 31 Aug 2012 14:44:29 +0200
Message-ID: <20120831144429.554345d0@endymion.delvare>
References: <1344072256-13170-1-git-send-email-geert@linux-m68k.org>
	<502C0022.2020106@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <502C0022.2020106@suse.cz>
Sender: linux-kbuild-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, dirk.brandewie@gmail.com, linux-i2c@vger.kernel.org, Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org, jbaron@redhat.com, ben-linux@fluff.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Hi Jiri, Geert,

On Wed, 15 Aug 2012 22:01:38 +0200, Jiri Slaby wrote:
> On 08/04/2012 11:24 AM, Geert Uytterhoeven wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v3.6-rc1[1] compared to v3.5[2].
> ...
> >   + drivers/i2c/busses/i2c-designware-core.c: error: 'KBUILD_MODNAME' undeclared (first use in this function):
> 
> This is a real problem we are facing here. It happens on PPC when all
> I2C_DESIGNWARE_PLATFORM, I2C_DESIGNWARE_PCI and DYNAMIC_DEBUG are set.
> 
> It's because i2c-designware-core.c is used in two modules
> (i2c-designware-platform and i2c-designware-pci) and KBUILD_MODNAME is
> not defined for those because (scripts/Makefile.lib):
> # $(modname_flags) #defines KBUILD_MODNAME as the name of the module
> # it will end up in (or would, if it gets compiled in)
> # Note: Files that end up in two or more modules are compiled
> #       without the KBUILD_MODNAME definition. The reason is
> #       that any made-up name would differ in different configs.
> 
> But DYNAMIC_DEBUG needs KBUILD_MODNAME for dev_dbg used in that source.
> 
> Any ideas? Why is it not a separate module for example?

It should be. Axel Lin has posted a patch which does that and it should
fix your problem:
https://lkml.org/lkml/2012/6/13/233

Please test and confirm it does the right thing. I'll push the patch
upstream if it does.

-- 
Jean Delvare
