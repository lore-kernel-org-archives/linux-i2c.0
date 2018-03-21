From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 2/3] i2c: mux: pca9541: namespace cleanup
Date: Wed, 21 Mar 2018 06:53:12 +0100
Message-ID: <d683d542-3def-9156-2628-2fa1c1830a12@axentia.se>
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
 <20180320093200.19179-3-peda@axentia.se>
 <b472b2e4-8360-6f5a-b753-fa8fc7083d04@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b472b2e4-8360-6f5a-b753-fa8fc7083d04@mleia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>, linux-kernel@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>, Ken Chen <chen.kenyy@inventec.com>, joel@jms.id.au, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-03-21 00:24, Vladimir Zapolskiy wrote:
> Hi Peter,
> 
> On 03/20/2018 11:31 AM, Peter Rosin wrote:
>> In preparation for PCA9641 support, convert the mybus and busoff macros
>> to functions, and in the process prefix them with pca9541_. Also prefix
>> remaining chip specific macros with PCA9541_.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/i2c/muxes/i2c-mux-pca9541.c | 26 +++++++++++++++++++-------
>>  1 file changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
>> index ad168125d23d..47685eb4e0e9 100644
>> --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
>> +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
>> @@ -59,10 +59,8 @@
>>  #define PCA9541_ISTAT_MYTEST	BIT(6)
>>  #define PCA9541_ISTAT_NMYTEST	BIT(7)
>>  
>> -#define BUSON		(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
>> -#define MYBUS		(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
>> -#define mybus(x)	(!((x) & MYBUS) || ((x) & MYBUS) == MYBUS)
>> -#define busoff(x)	(!((x) & BUSON) || ((x) & BUSON) == BUSON)
>> +#define PCA9541_BUSON	(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
>> +#define PCA9541_MYBUS	(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
>>  
>>  /* arbitration timeouts, in jiffies */
>>  #define ARB_TIMEOUT	(HZ / 8)	/* 125 ms until forcing bus ownership */
>> @@ -93,6 +91,20 @@ static const struct of_device_id pca9541_of_match[] = {
>>  MODULE_DEVICE_TABLE(of, pca9541_of_match);
>>  #endif
>>  
>> +static int pca9541_mybus(int ctl)
> 
> static inline?

No, "inline" is only used in header files in the kernel. The compiler
is free to inline whatever function it likes anyway, and in this case
we do not know better than the compiler. We don't care either. At least,
that is my understanding of the situation regarding the "inline"
keyword.

> 
>> +{
>> +	if (!(ctl & PCA9541_MYBUS))
>> +		return 1;
>> +	return (ctl & PCA9541_MYBUS) == PCA9541_MYBUS;
>> +}
>> +
>> +static int pca9541_busoff(int ctl)
> 
> static inline?
> 
>> +{
>> +	if (!(ctl & PCA9541_BUSON))
>> +		return 1;
>> +	return (ctl & PCA9541_BUSON) == PCA9541_BUSON;
>> +}
> 
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

Thanks!

Cheers,
Peter

> 
> --
> With best wishes,
> Vladimir
> 
