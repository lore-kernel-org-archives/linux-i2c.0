From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Feb 17 (i2c-designware-baytrail.c)
Date: Tue, 17 Feb 2015 10:28:16 -0800
Message-ID: <54E38840.5060306@infradead.org>
References: <20150217160221.1a15340e@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150217160221.1a15340e@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 02/16/15 21:02, Stephen Rothwell wrote:
> Hi all,
> 
> Please do not add any material destined for v3.21 to your linux-next
> included trees until after v3.20-rc1 has been released.
> 
> Changes since 20150216:
> 

on i386, when CONFIG_IOSF_MBI=m and
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y:

drivers/built-in.o: In function `i2c_dw_eval_lock_support':
(.text+0x37dd74): undefined reference to `iosf_mbi_available'
drivers/built-in.o: In function `reset_semaphore.isra.1':
i2c-designware-baytrail.c:(.text+0x37ddd1): undefined reference to `iosf_mbi_read'
i2c-designware-baytrail.c:(.text+0x37de13): undefined reference to `iosf_mbi_write'
drivers/built-in.o: In function `baytrail_i2c_acquire':
(.text+0x37df26): undefined reference to `iosf_mbi_write'
drivers/built-in.o: In function `baytrail_i2c_acquire':
(.text+0x37dfab): undefined reference to `iosf_mbi_read'
drivers/built-in.o: In function `baytrail_i2c_acquire':
(.text+0x37e080): undefined reference to `iosf_mbi_read'


because IOSF_MBI is tristate and I2C_DESIGNWARE_BAYTRAIL is bool:

config I2C_DESIGNWARE_BAYTRAIL
	bool "Intel Baytrail I2C semaphore support"
	depends on I2C_DESIGNWARE_PLATFORM && IOSF_MBI && ACPI


I suppose someone could make that:

	depends on I2C_DESIGNWARE_PLATFORM && IOSF_MBI=y && ACPI

or even make I2C_DESIGNWARE_BAYTRAIL be a tristate symbol.


-- 
~Randy
