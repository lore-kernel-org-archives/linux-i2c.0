From: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 4/5] I2C: DaVinci: fix signal handling bug
Date: Mon, 28 Apr 2008 16:40:59 -0700
Message-ID: <4816608B.2000001@boundarydevices.com>
References: <1209142694-30046-1-git-send-email-troy.kisky@boundarydevices.com>	<1209142694-30046-2-git-send-email-troy.kisky@boundarydevices.com>	<1209142694-30046-3-git-send-email-troy.kisky@boundarydevices.com>	<1209142694-30046-4-git-send-email-troy.kisky@boundarydevices.com>	<20080428191332.371e35e3@hyperion.delvare>	<48161578.3080000@boundarydevices.com>
	<20080428225011.4d97736c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080428225011.4d97736c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
> On Mon, 28 Apr 2008 11:20:40 -0700, Troy Kisky wrote:
>> Jean Delvare wrote:
>>> Hi Troy,
>>>
>>> On Fri, 25 Apr 2008 09:58:13 -0700, Troy Kisky wrote:
>>>> If wait_for_completion_interruptible_timeout exits due
>>>> to a signal, the i2c bus was locking up.
>>> What kind of signal (coming from where) are you talking about?
>> With the user space i2c interface, a ^c was
>> locking the bus.
> 
> Ah, OK. I admit I've never tested this on any i2c bus driver.
> 
>>> If you don't want to be interrupted, why don't you simply use
>>> wait_for_completion_timeout() instead of
>>> wait_for_completion_interruptible_timeout()?
>> I didn't make that choice. Perhaps wait_for_completion_timeout()
>> would be better. I just preferred fixing the lockup if a signal
>> happened. It seemed like a safer change to me. Can wait_for_completion_timeout()
>> return for any reason other the successful completion or timeout?
> 
> I think not, but...
> 
>> Will an explicit kill of the process return?
> 
> I just don't know. I guess you'd have to try.
> 
>> Do you want it changed to use wait_for_completion_timeout()?
> 
> I'm suggesting this because it seems to be a much more simple way to
> fix the problem. If that works for you, why do something more complex?
> 

IMHO, if an i2c interrupt happens that says data is available to
read, that data should be read, regardless of whether or not we expected
data to be available. So, the ^c bug just nudged me to change it.
But my stance is not firm, let me know your preference.



> As a side note, I'm curious what happens if the call timeouts. Doesn't
> the hardware lockup happen? From the hardware's perspective I can't see
> any difference between the timeout case and the signal case.

The code checks explicitly for a timeout and resets the controller if found.
If you did this with a signal as well, I think the bus would be non-idle
until another I2C transfer is started by a reset controller(this one or another).

> 
>>>> +static inline void terminate_read(struct davinci_i2c_dev *dev)
>>>> +{
>>>> +	if (dev->buf_len)
>>>> +		dev->buf_len--;
>>>> +	if (dev->buf_len) {
>>> Please explain (in a comment) what you are doing here. Can't you just
>>> test for (dev->buf_len > 1)?
>> Or maybe no test, just always set the nak bit and throw away the data??
> 
> You know the hardware, I don't, I just can't tell. My suggestion was
> only based on logic.
> 
OK, I'll test it .

>>>> +		u16 w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
>>>> +		w |= DAVINCI_I2C_MDR_NACK;
>>>> +		davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
>>>> +	}
> 

Thanks
Troy

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
