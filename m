From: Jean Delvare <jdelvare@suse.de>
Subject: Re: randconfig build error with next-20150812, in
 drivers/i2c/busses/i2c-i801.c
Date: Fri, 25 Sep 2015 09:36:10 +0200
Message-ID: <20150925093610.64ed7f59@endymion.delvare>
References: <CA+r1ZhjyBKcWbNB3hkPxoEKatojYk9=VPqSurZHPk9nfNp_gSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <CA+r1ZhjyBKcWbNB3hkPxoEKatojYk9=VPqSurZHPk9nfNp_gSQ@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Jim Davis <jim.epost@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, jdelvare@suse.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, Matt Fleming <matt.fleming@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, 12 Aug 2015 08:42:18 -0700, Jim Davis wrote:
> Building with the attached random configuration file,
> 
> drivers/built-in.o: In function `dmi_check_onboard_devices':
> i2c-i801.c:(.text+0x126b36): undefined reference to `i2c_new_device'
> drivers/built-in.o: In function `i801_remove':
> i2c-i801.c:(.text+0x126b86): undefined reference to `i2c_del_adapter'
> drivers/built-in.o: In function `i801_probe':
> i2c-i801.c:(.text+0x127d08): undefined reference to `i2c_add_adapter'
> i2c-i801.c:(.text+0x127d6e): undefined reference to `i2c_new_device'

Sorry for the late reply. The error is caused by the following
combination of options:

CONFIG_I2C=m
CONFIG_I2C_I801=y

I can reproduce it even with mainline now. This is caused by
CONFIG_ITCO_WDT=y, which selects CONFIG_I2C_I801=y without selecting
its dependencies (CONFIG_I2C.)

Thanks for reporting, I'll post a fix shortly.

-- 
Jean Delvare
SUSE L3 Support
