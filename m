From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Jan 31 (drivers/i2c/busses/i2c-stm32f7.c)
Date: Thu, 30 Jan 2020 23:49:53 -0800
Message-ID: <7cd84961-d1f5-03eb-2e00-8f51b2f7121d@infradead.org>
References: <20200131150606.34caeb7c@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200131150606.34caeb7c@canb.auug.org.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, M'boumba Cedric Madianga <cedric.madianga@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 1/30/20 8:06 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Please do not add any v5.7 material to your linux-next included
> branches until after v5.6-rc1 has been released.
> 
> I am experimenting with a "make htmldocs" build at
> the end of the day, but it currently has an error:
> 
> docutils.utils.SystemMessage: Documentation/driver-api/thermal/cpu-idle-cooling.rst:95: (SEVERE/4) Unexpected section title.
> 
> Changes since 20200130:
> 
> The amdgpu tree lost its build failure.
> 
> The akpm-current tree gained a build failure due to an interaction with
> the nfsd tree for which I have revertd a commit.
> 
> Non-merge commits (relative to Linus' tree): 3654
>  3320 files changed, 145104 insertions(+), 53102 deletions(-)
> 
> ----------------------------------------------------------------------------
> 
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
> are tracking the linux-next tree using git, you should not use "git pull"
> to do so as that will try to merge the new linux-next release with the
> old one.  You should use "git fetch" and checkout or reset to the new
> master.
> 
> You can see which trees have been included by looking in the Next/Trees
> file in the source.  There are also quilt-import.log and merge.log
> files in the Next directory.  Between each merge, the tree was built
> with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
> multi_v7_defconfig for arm and a native build of tools/perf. After
> the final fixups (if any), I do an x86_64 modules_install followed by
> builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
> ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
> and sparc64 defconfig. And finally, a simple boot test of the powerpc
> pseries_le_defconfig kernel in qemu (with and without kvm enabled).
> 
> Below is a summary of the state of the merge.
> 
> I am currently merging 315 trees (counting Linus' and 78 trees of bug
> fix patches pending for the current merge release).
> 
> Stats about the size of the tree over time can be seen at
> http://neuling.org/linux-next-size.html .
> 
> Status of my local build tests will be at
> http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
> advice about cross compilers/configs that work, we are always open to add
> more builds.
> 
> Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
> Gortmaker for triage and bug fixes.
> 

on i386:

when CONFIG_I2C is not set/enabled:

../drivers/i2c/busses/i2c-stm32f7.c: In function ‘stm32f7_i2c_suspend’:
../drivers/i2c/busses/i2c-stm32f7.c:2199:44: error: ‘struct dev_pm_info’ has no member named ‘wakeup_path’
  if (!device_may_wakeup(dev) && !dev->power.wakeup_path) {
                                            ^
../drivers/i2c/busses/i2c-stm32f7.c: In function ‘stm32f7_i2c_resume’:
../drivers/i2c/busses/i2c-stm32f7.c:2218:44: error: ‘struct dev_pm_info’ has no member named ‘wakeup_path’
  if (!device_may_wakeup(dev) && !dev->power.wakeup_path) {
                                            ^


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
