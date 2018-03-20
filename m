From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 2/3] i2c: mux: pca9541: namespace cleanup
Date: Tue, 20 Mar 2018 22:48:40 +0100
Message-ID: <23103b1d-8f33-7885-379b-384382953a42@axentia.se>
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
 <20180320093200.19179-3-peda@axentia.se>
 <e92c5457-20fd-1e6e-ab59-5ff53e647e89@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e92c5457-20fd-1e6e-ab59-5ff53e647e89@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Ken Chen <chen.kenyy@inventec.com>, joel@jms.id.au, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-03-20 14:20, Guenter Roeck wrote:
> On 03/20/2018 02:31 AM, Peter Rosin wrote:
>> +static int pca9541_mybus(int ctl)
> 
> bool ?
> 
>> +{
>> +	if (!(ctl & PCA9541_MYBUS))
>> +		return 1;
> 
> true ?
> 
>> +	return (ctl & PCA9541_MYBUS) == PCA9541_MYBUS;
>> +}
>> +
>> +static int pca9541_busoff(int ctl)
> 
> bool ?
> 
>> +{
>> +	if (!(ctl & PCA9541_BUSON))
>> +		return 1;
> 
> true ?

bool? true? Isn't that C++? Sigh, but you're right, and old habits
die hard...

Would it be ok to add your reviewed-by tag as I fix that?

Cheers,
Peter
