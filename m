From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] i2c: cht-wc: drop check because i2c_unregister_device()
 is NULL safe
Date: Wed, 4 Sep 2019 10:26:30 +0200
Message-ID: <2e55f3cb-ba88-5404-3b38-585710976ed0@redhat.com>
References: <20190820153441.7693-1-wsa+renesas@sang-engineering.com>
 <20190903175218.GE2171@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903175218.GE2171@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 03-09-19 19:52, Wolfram Sang wrote:
> On Tue, Aug 20, 2019 at 05:34:40PM +0200, Wolfram Sang wrote:
>> No need to check the argument of i2c_unregister_device() because the
>> function itself does it.
>>
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> ---
> 
> Hans, are you OK with this change?

Yes this is fine by me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> 
>> Build tested only, buildbot is happy, too.
>>
>> Please apply to your tree.
>>
>>   drivers/i2c/busses/i2c-cht-wc.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
>> index 66af44bfa67d..3e2608a65c06 100644
>> --- a/drivers/i2c/busses/i2c-cht-wc.c
>> +++ b/drivers/i2c/busses/i2c-cht-wc.c
>> @@ -363,8 +363,7 @@ static int cht_wc_i2c_adap_i2c_remove(struct platform_device *pdev)
>>   {
>>   	struct cht_wc_i2c_adap *adap = platform_get_drvdata(pdev);
>>   
>> -	if (adap->client)
>> -		i2c_unregister_device(adap->client);
>> +	i2c_unregister_device(adap->client);
>>   	i2c_del_adapter(&adap->adapter);
>>   	irq_domain_remove(adap->irq_domain);
>>   
>> -- 
>> 2.20.1
>>
