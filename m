From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH v1 04/15] ipmi_ssif: Remove
 duplicate NULL check
Date: Thu, 18 Jan 2018 09:41:53 -0600
Message-ID: <9a4c8dda-2a5c-14f3-559f-f4d5260fbdb0@acm.org>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
 <20171031142149.32512-4-andriy.shevchenko@linux.intel.com>
 <1516289388.7000.1092.camel@linux.intel.com>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-Reply-To: <1516289388.7000.1092.camel@linux.intel.com>
Content-Language: en-GB
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openipmi-developer>,
 <mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
 <mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: openipmi-developer@lists.sourceforge.net
List-Id: linux-i2c@vger.kernel.org

On 01/18/2018 09:29 AM, Andy Shevchenko wrote:
> On Tue, 2017-10-31 at 16:21 +0200, Andy Shevchenko wrote:
>> Since i2c_unregister_device() became NULL-aware we may remove
>> duplicate
>> NULL check.
> Anyone?
>
> Wolfram, I think if no one picks this soon it's quite safe to push it
> through i2c tree.
>

I'll pick this up for the next release.

-corey

>> Cc: Corey Minyard <minyard@acm.org>
>> Cc: openipmi-developer@lists.sourceforge.net
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>   drivers/char/ipmi/ipmi_ssif.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/ipmi/ipmi_ssif.c
>> b/drivers/char/ipmi/ipmi_ssif.c
>> index 466b3a1c0adf..8d183e182eab 100644
>> --- a/drivers/char/ipmi/ipmi_ssif.c
>> +++ b/drivers/char/ipmi/ipmi_ssif.c
>> @@ -2072,8 +2072,7 @@ static int ssif_platform_remove(struct
>> platform_device *dev)
>>   		return 0;
>>   
>>   	mutex_lock(&ssif_infos_mutex);
>> -	if (addr_info->client)
>> -		i2c_unregister_device(addr_info->client);
>> +	i2c_unregister_device(addr_info->client);
>>   
>>   	list_del(&addr_info->link);
>>   	kfree(addr_info);



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
