From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 2/3] ACPI / PMIC: xpower: Block P-Unit I2C access
 during read-modify-write
Date: Sun, 14 Oct 2018 14:49:17 +0200
Message-ID: <69000721-79f7-aee7-6aff-0fca4bd0d533@redhat.com>
References: <20181011102627.7418-3-hdegoede@redhat.com>
 <201810140336.mWbfDBaj%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201810140336.mWbfDBaj%fengguang.wu@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi All,

On 13-10-18 21:05, kbuild test robot wrote:
> Hi Hans,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on wsa/i2c/for-next]
> [also build test ERROR on v4.19-rc7]
> [cannot apply to next-20181012]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/x86-baytrail-cherrytrail-Rework-and-move-P-Unit-PMIC-semaphore-handling/20181013-230503
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
> config: ia64-allyesconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 8.1.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          GCC_VERSION=8.1.0 make.cross ARCH=ia64
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/acpi/pmic/intel_pmic_xpower.c:21:10: fatal error: asm/iosf_mbi.h: No such file or directory
>      #include <asm/iosf_mbi.h>

I've a fix for this in my personal tree now. As mentioned in the
cover letter, patches 2 + 3 are really more of a RFC for now, the
goal for now is just to get patch 1 merged.

I will send out a new version of this patch after patch 1 is merged
(or when patch 1 needs a new revision).

Regards,

Hans
