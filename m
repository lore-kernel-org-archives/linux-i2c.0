From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] I2C: Make i2cdev_detach_adapter static
Date: Fri, 18 Nov 2011 16:17:53 +0530
Message-ID: <4EC637D9.7000201@ti.com>
References: <1321605731-3098-1-git-send-email-shubhrajyoti@ti.com> <20111118104317.7d150bab@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111118104317.7d150bab@endymion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Friday 18 November 2011 03:13 PM, Jean Delvare wrote:
> On Fri, 18 Nov 2011 14:12:11 +0530, Shubhrajyoti D wrote:
>> The function i2cdev_detach_adapter is used only in i2c-dev file
>> making it static.
> This description doesn't match what the patch actually does. Please
> resubmit with proper subject and description.
Yes will correct it.
>> Also removes the following sparse warning
>>
>> drivers/i2c/i2c-dev.c:582:5: warning: symbol 'i2cdev_notifier_call'
>> was not declared. Should it be static?
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>>  drivers/i2c/i2c-dev.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
>> index c90ce50..57a45ce 100644
>> --- a/drivers/i2c/i2c-dev.c
>> +++ b/drivers/i2c/i2c-dev.c
>> @@ -579,7 +579,7 @@ static int i2cdev_detach_adapter(struct device *dev, void *dummy)
>>  	return 0;
>>  }
>>  
>> -int i2cdev_notifier_call(struct notifier_block *nb, unsigned long action,
>> +static int i2cdev_notifier_call(struct notifier_block *nb, unsigned long action,
>>  			 void *data)
>>  {
>>  	struct device *dev = data;
>
