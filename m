From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [patch 2/6] Extension of pca-algorithm
Date: Thu, 24 Jan 2008 14:00:47 +0100
Message-ID: <fna260$2f6$1@ger.gmane.org>
References: <20080121142010.988419876@pengutronix.de>	<20080121143657.455317984@pengutronix.de>
	<20080123205241.3e1235e7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080123205241.3e1235e7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Jean,

first of all thank you for your detailed constructive criticism; I 
appreciate your effort very much (and will try harder next time)!

Jean Delvare wrote:

> I would like a more detailed changelog entry. Please explain all the
> changes you did and why you had to do them. If might be obvious to you,
> but it may not be to others (including me.)
Will do!

> This patch break the i2c-pca-isa driver, which is not OK. Your patchset
> should be such that everything still builds and work after each
> incremental patch. In practice, this means that patches 2/6 and 5/6
> should be merged. Except for white-space cleanups which would rather
> belong to patch 1/6.
I understand, will restructure it this way...

> 
>> Index: linux-playground/include/linux/i2c-algo-pca.h
>> ===================================================================
[...]
>>  struct i2c_algo_pca_data {
>> -	int  (*get_own)			(struct i2c_algo_pca_data *adap); /* Obtain own address */
>> -	int  (*get_clock)		(struct i2c_algo_pca_data *adap);
>> -	void (*write_byte)		(struct i2c_algo_pca_data *adap, int reg, int val);
>> -	int  (*read_byte)		(struct i2c_algo_pca_data *adap, int reg);
>> -	int  (*wait_for_interrupt)	(struct i2c_algo_pca_data *adap);
>> +	void 				*data;	/* private low level data */
>> +	void (*write_byte)		(void *data, int reg, int val);
>> +	int  (*read_byte)		(void *data, int reg);
>> +	int  (*wait_for_completion)	(void *data);
>> +	void (*reset_chip)		(void *data);
>> +	unsigned int			my_slave_addr;
>> +	unsigned int			i2c_clock;
>> +	unsigned int			timeout;
>>  };
> I do not understand why you change struct i2c_algo_pca_data *adap to
> void *data in these prototypes?
I adopted this behaviour from the other algorithms, which do all use 
void *data here. I guess, i2c-pca-algo used to pass the struct as it did 
not have any private_data field before. The ISA-driver as the only user 
of i2c-pca-algo never touched this parameter, as it gained all 
neccessary data from its own static variables.

> struct i2c_adapter already has a timeout field, so why define your own?
Sorry, this the result of a mistake in my notes. Will fix.

>> -int i2c_pca_add_bus(struct i2c_adapter *);
>> +int i2c_pca_add_adapter(struct i2c_adapter *);
> Why change this? All other algorithm drivers have i2c_foo_add_bus().
I thought it makes it more "readable" what this function actually does. 
Besides doing initialization, it mainly calls i2c_add_adapter. So, 
giving them a similar name, it could perhaps be more obvious that this 
function is a wrapper. But if you prefer consistency, I will go back to 
i2c_pca_add_bus.

>> Index: linux-playground/drivers/i2c/algos/i2c-algo-pca.h
>> ===================================================================
>> --- linux-playground.orig/drivers/i2c/algos/i2c-algo-pca.h	2008-01-21 12:39:28.000000000 +0100
>> +++ linux-playground/drivers/i2c/algos/i2c-algo-pca.h	2008-01-21 12:42:14.000000000 +0100
>> @@ -14,13 +14,4 @@
>>  #define I2C_PCA_CON_SI		0x08 /* Serial Interrupt */
>>  #define I2C_PCA_CON_CR		0x07 /* Clock Rate (MASK) */
>>  
>> -#define I2C_PCA_CON_330kHz	0x00
>> -#define I2C_PCA_CON_288kHz	0x01
>> -#define I2C_PCA_CON_217kHz	0x02
>> -#define I2C_PCA_CON_146kHz	0x03
>> -#define I2C_PCA_CON_88kHz	0x04
>> -#define I2C_PCA_CON_59kHz	0x05
>> -#define I2C_PCA_CON_44kHz	0x06
>> -#define I2C_PCA_CON_36kHz	0x07
>> -
>>  #endif /* I2C_PCA9564_H */
> 
> Maybe you could get rid of this header file altogether? It never made
> much sense to me. Symbols internal to i2c-algo-pca do not need to be in
> a header file. Symbols needed by bus drivers or platform code should be
> in a header file under include/linux, not drivers/i2c/algos.
I'd like to do this, but it gave me a hard time already. The reason is, 
that, in general, I would say all register definitions of the chip 
should be inside the algorithm, as this is the abstraction which deals 
with the chip and works with its registers. Now the problem is, 
i2c-pca-algo defines a function wait_for_completion which has to be 
filled by the adapter. (BTW, this routine used to have the name 
"wait_for_interrupt". I renamed it, because it also does polling when no 
interrupt is assigned, so this is a bit misleading) This function needs 
to check a bit from the PCA9564 when calling wait_event_interruptible, 
so it needs two definitions to work, namely those:

#define I2C_PCA_CON		0x03 /* CONTROL Read/Write */
#define I2C_PCA_CON_SI		0x08 /* Serial Interrupt */

Furthermore it might be nice to have those definitions within the ISR, 
so we can check if the interrupt was really caused by the PCA9564.

I see the following options, which all have drawbacks.

1) Do it like now, have a seperate i2c-pca-algo.h in /drivers/i2c/algos 
and include it in algorithm and adapter. Drawback: There is an 
additional .h-file.

2) Put all register-definitions into /include/linux/i2c-pca-algo.h. 
Drawback: All registers become visible, although not needed in most 
cases when this file is being included.

3) Just put the two #defines from above into 
/include/linux/i2c-pca-algo.h, the rest into i2c-pca-algo.c. Drawback: 
Register definitions are scattered -> messy -> horrible.

4) Duplicate those two #defines in the adapter source code: Drawback: 
Spoils maintainability pretty much. Also horrible.

5) Move the wait_for_completion-function from the adapter to the 
algorithm. Drawback: This function is connected to the wait_queue and 
the ISR which better belong to the adapter and not the algorithm. I fear 
the outcome will be unneccessarily complicated. We also lose the 
possibility to check if the interrupt was caused by the PCA.

6) Make the algorithm have a function i2c_pca_get_si_status which 
reports the desired condition. Export it, so it can be called from 
adapters. Drawback: I wonder if adapters should call the algorithms 
except for foo_add_bus? Sounds like wrong direction to me.

I'd be happy to get opinions here (or option number 7 which is so simple 
that I don't see it :))

> History doesn't belong there, we have git for that.
Will fix.

>> +	if (pca_data->i2c_clock > 7) {
>> +		dev_warn(&adap->dev, "Invalid I2C clock speed selected. Trying default.\n");
>> +		pca_data->i2c_clock = I2C_PCA_CON_59kHz;
>> +	}
>> +	/* No need to check my_slave_addr. driver can't handle slave mode */
> Why define it at all then?
It was in the original PCA-driver; as it was never removed, I thought 
there is a reason for being there.


>> +	adap->retries = 1;
> Please don't set retries, the driver doesn't actually implement a retry
> mechanism, and this structure field will be dropped soon in favor of a
> different approach anyway.
It used to be set to 3 without being implemented :) Will drop it.


>> +	DEB1(KERN_INFO "%s: Own address is %#04x\n", adap->name, own);
>> +	DEB1(KERN_INFO "%s: Clock freqeuncy is %dkHz\n", adap->name, freqs[clock]);
> Typo: frequency.
Legacy bug: Will fix.


-- 
   Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
