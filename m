From: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 3/5] I2C: DaVinci: remove useless IVR read
Date: Fri, 28 Mar 2008 15:23:45 -0700
Message-ID: <47ED6FF1.8070007@boundarydevices.com>
References: <1206068770-15458-1-git-send-email-troy.kisky@boundarydevices.com>	<1206068770-15458-2-git-send-email-troy.kisky@boundarydevices.com>	<1206068770-15458-3-git-send-email-troy.kisky@boundarydevices.com>	<1206068770-15458-4-git-send-email-troy.kisky@boundarydevices.com>	<20080327165641.4380a7f1@hyperion.delvare>	<47ED48E7.4060803@boundarydevices.com>
	<20080328220153.3d197f0d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080328220153.3d197f0d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
> On Fri, 28 Mar 2008 12:37:11 -0700, Troy Kisky wrote:
>> Jean Delvare wrote:
>>> On Thu, 20 Mar 2008 20:06:08 -0700, Troy Kisky wrote:
>>>> Interrupts are enabled at the point where
>>>> the DAVINCI_I2C_IVR_REG is read, so unless
>>>> an interrupt happened just at that moment,
>>>> no interrupt would be pending. Even though
>>>> documentation implies you should do this,
>>>> I see no reason. If slave support is added,
>>>> this read would cause a hard to reproduce bug.
>>> This is only a problem if the device can operate in master mode and
>>> slave mode concurrently. Is it the case? But even then, as you can't
>>> have master and slave activity going on at the same time on a given I2C
>>> bus, it only matters if some DaVinci boards have more than one i2c
>>> buses. Is it the case?
>>>
>> There is only one i2c bus AFAIK, but how that is relevant escapes me.
>> And I realize that the host controller can not be master while it is
>> addressed as slave, but that does not prohibit a program from trying to
>> be master. Just because the interrupt that lets me know I am addressed
>> as slave is removed (and ignored,) the state of the bus is not suddenly
>> idle again. The documentation says to make sure no interrupts are pending
>> before starting a transfer. It should says "Service all pending interrupts, so
>> that the bus is idle before starting a transfer."
> 
> Even that is just best effort... You can be addressed as a slave
> between the time you serviced all pending interrupts and the time you
> start a transfer as a master. There's no way to solve this problem
> though as far as I can see.

I don't think it needs to be solved.
> 
>> The wait_bus_not_busy
>> will satisfy this in most cases. The exception being if the process is swapped
>> out, giving time for someone else on the bus to become master.
> 
> The process being swapped out only gives the race more time to happen,
> but it can happen even without it.

If interrupt were locked out, then the bus checked to still be idle before
starting the transfer, that should guarantee that no interrupts where pending
before the transfer start. But that seems like overkill to me and I can still
lose arbitration anyway.

> 
>>
>> My removing the IVR read will not magically make the bus idle again either. But
>> at least, the interrupt routine will have a chance to do something.
> 
> OK, fine with me. But then don't you want to read the IVR register at
> driver load time, to clear up everything that may have happened before
> the driver is loaded?
> 

The reset function clear this register.

Thanks
Troy

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
