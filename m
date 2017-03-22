From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: Re: [PATCH v7 3/6] i2c: designware: MASTER mode as separated driver
Date: Wed, 22 Mar 2017 14:56:28 +0000
Message-ID: <fe009c91-4ce6-c444-7282-4a8112c0cad8@synopsys.com>
References: <cover.1490007620.git.lolivei@synopsys.com>
 <c224fa537fc1daf9f3256ce7c8da12f73f7035a7.1490007620.git.lolivei@synopsys.com>
 <390a6b71-92d4-bafe-224a-f2b2a864cabc@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <390a6b71-92d4-bafe-224a-f2b2a864cabc@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

On 22-Mar-17 14:47, Jarkko Nikula wrote:
> On 03/20/17 13:10, Luis Oliveira wrote:
>> - The functions related to I2C master mode of operation were transformed
>>   in a single driver.
>> - Common definitions were moved to i2c-designware-core.h
>> - The i2c-designware-core is now only a library file, the functions
>>   associated are in a source file called i2c-designware-common and
>>   are used by both i2c-designware-master and i2c-designware-slave.
>> - To decrease noise in namespace common i2c_dw_*() functions are
>>   now using ops to keep them private.
>> - Designware PCI driver had to be changed to match the previous ops
>>   functions implementation.
>>
>> Almost all of the "core" source is now part of the "master" source. The
>> difference is the functions used by both modes and they are in the
>> "common" source file.
>>
>> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
>> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>> v6-v7
>> - Moved kernel doc comments from patch 4/6 to this patch. @Jarkko
>> - Fix Designware I2C PCI driver error when looking for previous extern
>>   functions.
>>
> ...
>>   * struct dw_i2c_dev - private i2c-designware data
>> @@ -78,7 +196,11 @@
>>   * @acquire_lock: function to acquire a hardware lock on the bus
>>   * @release_lock: function to release a hardware lock on the bus
>>   * @pm_runtime_disabled: true if pm runtime is disabled
>> - *
>> + * @dynamic_tar_update_enabled: true if dynamic TAR update is enabled
>> + * @disable: function to disable the controller
>> + * @disable_int: function to disable all interrupts
>> + * @init: function to initialize the I2C hardware
>> + *
>>   * HCNT and LCNT parameters can be used if the platform knows more accurate
>>   * values than the one computed based only on the input clock frequency.
>>   * Leave them to be %0 if not used.
>> @@ -126,15 +248,31 @@ struct dw_i2c_dev {
>>      int            (*acquire_lock)(struct dw_i2c_dev *dev);
>>      void            (*release_lock)(struct dw_i2c_dev *dev);
>>      bool            pm_runtime_disabled;
>> +    void            (*disable)(struct dw_i2c_dev *dev);
>> +    void            (*disable_int)(struct dw_i2c_dev *dev);
>> +    int            (*init)(struct dw_i2c_dev *dev);
>>  };
>>
> I take my ack back. You are adding comment for dynamic_tar_update_enabled which
> was removed by the 12688dc21f71 ("Revert "i2c: designware: detect when dynamic
> tar update is possible"")
> 
Oh yes. Don't know how I miss to remove this. The revert didn't removed it
because it was not there. I add it before because it was missing. Sorry.
