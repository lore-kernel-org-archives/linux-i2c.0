From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: Re: [RESEND PATCH v6 3/6] i2c: designware: MASTER mode as separated
 driver
Date: Thu, 2 Mar 2017 15:34:18 +0000
Message-ID: <113b5d86-970b-ec86-0a38-735573f1eec2@synopsys.com>
References: <cover.1488383202.git.lolivei@synopsys.com>
 <d250a2bebe89ee99bf9d1a86503bebf2ee60c85c.1488383202.git.lolivei@synopsys.com>
 <da9fb29b-7920-eb74-9102-65b3f253eb4d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <da9fb29b-7920-eb74-9102-65b3f253eb4d@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

On 02-Mar-17 13:41, Jarkko Nikula wrote:
> On 03/01/17 17:59, Luis Oliveira wrote:
>> - The functions related to I2C master mode of operation were transformed
>>   in a single driver.
>> - Common definitions were moved to i2c-designware-core.h
>> - The i2c-designware-core is now only a library file, the functions
>>   associated are in a source file called i2c-designware-common and
>>   are used by both i2c-designware-master and i2c-designware-slave.
>> - To decrease noise in namespace common i2c_dw_*() functions are
>>   now using ops to keep them private.
>>
>> Almost all of the "core" source is now part of the "master" source. The
>> difference is the functions used by both modes and they are in the
>> "common" source file.
>>
>> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
>> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>> V5->V6
>> - Now using ops
>>
>>  drivers/i2c/busses/Makefile                        |   1 +
>>  drivers/i2c/busses/i2c-designware-common.c         | 274 +++++++++++++++
>>  drivers/i2c/busses/i2c-designware-core.h           | 140 +++++++-
>>  ...c-designware-core.c => i2c-designware-master.c} | 367 +--------------------
>>  drivers/i2c/busses/i2c-designware-platdrv.c        |   6 +-
>>  5 files changed, 423 insertions(+), 365 deletions(-)
>>  create mode 100644 drivers/i2c/busses/i2c-designware-common.c
>>  rename drivers/i2c/busses/{i2c-designware-core.c => i2c-designware-master.c}
>> (64%)
>>
> ...
>> diff --git a/drivers/i2c/busses/i2c-designware-core.h
>> b/drivers/i2c/busses/i2c-designware-core.h
>> index 1a010730be43..35d7264d9e3a 100644
>> --- a/drivers/i2c/busses/i2c-designware-core.h
>> +++ b/drivers/i2c/busses/i2c-designware-core.h
>> @@ -40,6 +40,124 @@
> ...
>>  /**
>>   * struct dw_i2c_dev - private i2c-designware data
>> @@ -125,15 +243,31 @@ struct dw_i2c_dev {
>>      int            (*acquire_lock)(struct dw_i2c_dev *dev);
>>      void            (*release_lock)(struct dw_i2c_dev *dev);
>>      bool            pm_runtime_disabled;
>> +    void            (*disable)(struct dw_i2c_dev *dev);
>> +    void            (*disable_int)(struct dw_i2c_dev *dev);
>> +    int            (*init)(struct dw_i2c_dev *dev);
> 
> Please move kernel doc comments for these members from patch 4/6 here. Adding
> new members and comments should go together.

I will. Thanks
> 
>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
>> b/drivers/i2c/busses/i2c-designware-platdrv.c
>> index 206dea03b0d0..671bdc0fdb24 100644
>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> ...
>> @@ -347,7 +347,7 @@ static int dw_i2c_plat_suspend(struct device *dev)
>>      struct platform_device *pdev = to_platform_device(dev);
>>      struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
>>
>> -    i2c_dw_disable(i_dev);
>> +    dev->disable(i_dev);
>>      i2c_dw_plat_prepare_clk(i_dev, false);
> 
> This doesn't compile. Looks like copy-paste from your dw_i2c_plat_remove()
> change but here you must access through the i_dev.

It's true! sorry, I forgot to change the "i_dev". And with the CONFIG_PM not
defined I didn't get the compile error.
> 
> You need to convert also the i2c-designware-pcidrv.c.

I will check that
> 
