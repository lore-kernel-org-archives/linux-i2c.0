From: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 4/5] I2C: DaVinci: fix signal handling bug
Date: Mon, 28 Apr 2008 11:20:40 -0700
Message-ID: <48161578.3080000@boundarydevices.com>
References: <1209142694-30046-1-git-send-email-troy.kisky@boundarydevices.com>	<1209142694-30046-2-git-send-email-troy.kisky@boundarydevices.com>	<1209142694-30046-3-git-send-email-troy.kisky@boundarydevices.com>	<1209142694-30046-4-git-send-email-troy.kisky@boundarydevices.com>
	<20080428191332.371e35e3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080428191332.371e35e3-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
> On Fri, 25 Apr 2008 09:58:13 -0700, Troy Kisky wrote:
>> If wait_for_completion_interruptible_timeout exits due
>> to a signal, the i2c bus was locking up.
> 
> What kind of signal (coming from where) are you talking about?

With the user space i2c interface, a ^c was
locking the bus.

> 
> If you don't want to be interrupted, why don't you simply use
> wait_for_completion_timeout() instead of
> wait_for_completion_interruptible_timeout()?

I didn't make that choice. Perhaps wait_for_completion_timeout()
would be better. I just preferred fixing the lockup if a signal
happened. It seemed like a safer change to me. Can wait_for_completion_timeout()
return for any reason other the successful completion or timeout? Will
an explicit kill of the process return? Do you want it changed to
use wait_for_completion_timeout()?

>> +static inline void terminate_read(struct davinci_i2c_dev *dev)
>> +{
>> +	if (dev->buf_len)
>> +		dev->buf_len--;
>> +	if (dev->buf_len) {
> 
> Please explain (in a comment) what you are doing here. Can't you just
> test for (dev->buf_len > 1)?

Or maybe no test, just always set the nak bit and throw away the data??


> 
>> +		u16 w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
>> +		w |= DAVINCI_I2C_MDR_NACK;
>> +		davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
>> +	}
>> +	/* Throw away data */
>> +	davinci_i2c_read_reg(dev, DAVINCI_I2C_DRR_REG);
>> +	if (!dev->terminate)
>> +		dev_err(dev->dev, "RDR IRQ while no data requested\n");
>> +}
>> +static inline void terminate_write(struct davinci_i2c_dev *dev)
>> +{
>> +	u16 w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
>> +	w |= DAVINCI_I2C_MDR_RM|DAVINCI_I2C_MDR_STP;
> 
> Coding-style: spaces around |.

OK
> 
>> +	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
>> +
>> +	if (!dev->terminate)
>> +		dev_err(dev->dev, "TDR IRQ while no data to send\n");
>> +}
> 
> I don't see the point of inlining these functions explicitly... They
> are only called in an unlikely event so this is certainly not
> performance-critical.

OK
>> @@ -419,9 +460,10 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
>>  				davinci_i2c_write_reg(dev,
>>  						      DAVINCI_I2C_IMR_REG,
>>  						      w);
>> -			} else
>> -				dev_err(dev->dev, "TDR IRQ while no data to "
>> -					"send\n");
>> +			} else {
>> +				/* signal can terminate transfer */
>> +				terminate_write(dev);
>> +			}
>>  			break;
>>  
>>  		case DAVINCI_I2C_IVR_SCD:
> 
> Apparently you are using dev->buf_len = 0 and dev->buf = NULL to notify
> particular conditions accross the driver? This should be clearly
> documented, otherwise other developers are likely to break the driver
> while working on it.
> 

Agreed.



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
