From: sathyanarayanan kuppuswamy
	<sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 1/1] i2c: designware: Fix hold and setup time issue
Date: Tue, 02 Jun 2015 17:40:34 -0700
Message-ID: <556E4D02.90908@linux.intel.com>
References: <cover.1428374207.git.sathyanarayanan.kuppuswamy@linux.intel.com> <b3d42396c046e4ab4a14edec84f3484b0f27d192.1428374207.git.sathyanarayanan.kuppuswamy@linux.intel.com> <20150602174600.GB1494@katana>
Reply-To: sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150602174600.GB1494@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 06/02/2015 10:46 AM, Wolfram Sang wrote:
> On Mon, Apr 06, 2015 at 07:40:28PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> If the device configuration is updated by firmware and
>> the information is not passed to driver via firmware
>> interfaces like ACPI or DT parameters, then that information
>> will be lost once the device either resets or suspends. This
>> patch checks the boot value of hold and setup time during
>> device probe and updates the driver hold and setup time params.
>> This fix will ensure that the updates to hold and setup time
>> values are not lost after device suspend or resets.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Adding Mika to CC.
>
>> ---
>>   drivers/i2c/busses/i2c-designware-core.c    | 37 +++++++++++++++++++++++++++++
>>   drivers/i2c/busses/i2c-designware-core.h    |  2 ++
>>   drivers/i2c/busses/i2c-designware-platdrv.c |  4 ++++
>>   3 files changed, 43 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
>> index 6e25c01..2598207 100644
>> --- a/drivers/i2c/busses/i2c-designware-core.c
>> +++ b/drivers/i2c/busses/i2c-designware-core.c
>> @@ -64,6 +64,7 @@
>>   #define DW_IC_RXFLR		0x78
>>   #define DW_IC_SDA_HOLD		0x7c
>>   #define DW_IC_TX_ABRT_SOURCE	0x80
>> +#define DW_IC_SDA_SETUP		0x94
>>   #define DW_IC_ENABLE_STATUS	0x9c
>>   #define DW_IC_COMP_PARAM_1	0xf4
>>   #define DW_IC_COMP_VERSION	0xf8
>> @@ -89,6 +90,9 @@
>>   					 DW_IC_INTR_TX_ABRT | \
>>   					 DW_IC_INTR_STOP_DET)
>>   
>> +#define DW_IC_DEFAULT_SDA_SETUP	0x64
>> +#define DW_IC_DEFAULT_SDA_HOLD	0x1
>> +
>>   #define DW_IC_STATUS_ACTIVITY	0x1
>>   
>>   #define DW_IC_ERR_TX_ABRT	0x1
>> @@ -271,6 +275,35 @@ static void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable)
>>   		 enable ? "en" : "dis");
>>   }
>>   
>> +/*
>> + * Update device default param values if its changed by
>> + * firmware
>> + */
>> +void dw_i2c_update_defaults(struct dw_i2c_dev *dev)
>> +{
>> +	int ret;
>> +
>> +	/*
>> +	 * make sure default is not updated by firmware
>> +	 * interfaces like OF or ACPI
>> +	 */
>> +
>> +	/* SDA hold time update */
>> +	if (!dev->sda_hold_time) {
>> +		ret = dw_readl(dev, DW_IC_SDA_HOLD);
>> +		if ((ret > 0) && (ret != DW_IC_DEFAULT_SDA_HOLD))
>> +			dev->sda_hold_time = ret;
>> +	}
>> +
>> +	/* SDA setup time update */
>> +	if (!dev->sda_setup_time) {
>> +		ret = dw_readl(dev, DW_IC_SDA_SETUP);
>> +		if ((ret > 0) && (ret != DW_IC_DEFAULT_SDA_SETUP))
>> +			dev->sda_setup_time = ret;
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(dw_i2c_update_defaults);
>> +
>>   /**
>>    * i2c_dw_init() - initialize the designware i2c master hardware
>>    * @dev: device private data
>> @@ -368,6 +401,10 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>>   				"Hardware too old to adjust SDA hold time.");
>>   	}
>>   
>> +	/* Configure SDA setup time if required */
>> +	if (dev->sda_setup_time)
>> +		dw_writel(dev, dev->sda_setup_time, DW_IC_SDA_SETUP);
>> +
>>   	/* Configure Tx/Rx FIFO threshold levels */
>>   	dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
>>   	dw_writel(dev, 0, DW_IC_RX_TL);
>> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
>> index 9630222..23ae2e8 100644
>> --- a/drivers/i2c/busses/i2c-designware-core.h
>> +++ b/drivers/i2c/busses/i2c-designware-core.h
>> @@ -98,6 +98,7 @@ struct dw_i2c_dev {
>>   	unsigned int		rx_fifo_depth;
>>   	int			rx_outstanding;
>>   	u32			sda_hold_time;
>> +	u32			sda_setup_time;
>>   	u32			sda_falling_time;
>>   	u32			scl_falling_time;
>>   	u16			ss_hcnt;
>> @@ -131,3 +132,4 @@ extern int i2c_dw_eval_lock_support(struct dw_i2c_dev *dev);
>>   #else
>>   static inline int i2c_dw_eval_lock_support(struct dw_i2c_dev *dev) { return 0; }
>>   #endif
>> +extern void dw_i2c_update_defaults(struct dw_i2c_dev *dev);
>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
>> index c270f5f..d8995d8 100644
>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>> @@ -233,6 +233,10 @@ static int dw_i2c_probe(struct platform_device *pdev)
>>   		dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
>>   		dev->adapter.nr = pdev->id;
>>   	}
>> +
>> +	/* call after firmware param update */
>> +	dw_i2c_update_defaults(dev);
> What about calling this from the pci driver?
Agreed. I will fix it in next version.
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer
