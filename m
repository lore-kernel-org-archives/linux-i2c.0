From: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 2/5] I2C: DaVinci: move dev_debug line for more
 output
Date: Mon, 28 Apr 2008 09:20:33 -0700
Message-ID: <4815F951.5030700@boundarydevices.com>
References: <1209142694-30046-1-git-send-email-troy.kisky@boundarydevices.com>	<1209142694-30046-2-git-send-email-troy.kisky@boundarydevices.com>
	<20080428180437.272109dc@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080428180437.272109dc-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> Hi Troy,
> 
> On Fri, 25 Apr 2008 09:58:11 -0700, Troy Kisky wrote:
>> Previously the dev_dbg only printed if no error.
>> Printing also on an error is more useful
>>
>> Signed-off-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
>> Signed-off-by: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-davinci.c |    4 +---
>>  1 files changed, 1 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
>> index 0e5a39c..318579b 100644
>> --- a/drivers/i2c/busses/i2c-davinci.c
>> +++ b/drivers/i2c/busses/i2c-davinci.c
>> @@ -345,12 +345,10 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>>  
>>  	for (i = 0; i < num; i++) {
>>  		ret = i2c_davinci_xfer_msg(adap, &msgs[i], (i == (num - 1)));
>> +		dev_dbg(dev->dev, "%s ret: %d\n", __func__, ret);
>>  		if (ret < 0)
>>  			return ret;
>>  	}
> 
> I would like to suggest an improvement. Right now, if a transaction has
> several messages, you will print as many debug lines. If several
> transactions happen in a row, all the lines in the logs will look
> alike, and you won't be able to differentiate the various transactions.
> 
> I suggest the following:
> 
> 		dev_dbg(dev->dev, "%s [%d/%d] ret: %d\n", __func__, i + 1, num, ret);
> 
> So you know how many messages there are in every transaction. What do
> you think?
> 
>> -
>> -	dev_dbg(dev->dev, "%s:%d ret: %d\n", __func__, __LINE__, ret);
>> -
>>  	return num;
>>  }
>>  
> 
> 
Looks better to me.


Do you want to handle it, or me to send a patch?

Thanks

Troy

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
