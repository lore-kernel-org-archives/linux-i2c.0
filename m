From: Wilken Haase <Hibbelharry-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Problem with unstable i2c communication with i810 bus
 driver
Date: Wed, 21 May 2008 00:38:34 +0200
Message-ID: <483352EA.2090005@gmx.de>
References: <48321FD9.2010007@gmx.de>	<20080520091807.071f1032@hyperion.delvare>	<4832C0C8.2090401@gmx.de>
	<20080520203715.68c502f3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080520203715.68c502f3-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, i2c list <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> Hi Wilken,
>
> On Tue, 20 May 2008 14:15:04 +0200, Wilken Haase wrote:
>   
>> Badly I don't know of anymore devices connected to this bus.
>>     
>
> You could probe the bus using i2cdetect. Just testing if i2cdetect works
> will be a good test already.
>
>   
I am able to probe the bus. The only discovered device on the bus is the
fs454 at 0x6a and the master at 0x00.
>> I do have the datasheets and read them multiple times just to be sure.
>> The data sheet talks of needed delays.
>>     
>
> What does it say exactly?
>   
"The FS453 registers are accessed through a serial input/output bus (SIO) which is I2C*-compatible and SMBus-compatible. These registers can be read or written at any time the part is receiving a reference clock at XTAL_IN and not being held in reset via the RESET_L pin."

see Hardware Datasheet, Page 8 at:
http://ingeninge.homelinux.net/ingmar/zenega/Datenbl%E4tter/FS453-4___FS455-6_HW_v31.pdf
,page 8

you can find the Software Reference there too if you need more
information, but id not find anything related there:
http://ingeninge.homelinux.net/ingmar/zenega/Datenbl%E4tter/FS453-4___FS455-6_SW_v31.pdf

>> I tried experimenting with udelay values at the right file and did slow
>> the bus down, both values up to 150.
>>     
>
> Note: values above 50 are not compatible with SMBus.
>
>   
Isn't this true i2c here ?
>> But while dumping the chip slowed noticeably
>> down i still got some bogus values back. Think that's maybe not the
>> right idea.
>> On another sidenote: I own another settopbox which is partly similar and
>> also uses a fs454 scan konverter, but controlled by an intel i830 chipset.
>> The fs454 is accessible without any problems there with the stock kernel
>> driver. I really don't think the bus is multi mastered. Maybe this is a
>> termination problem.
>>     
>
> If the other system works OK with basically the same type of hardware,
> then I indeed suspect a hardware defect on the failing box. Maybe try
> to find out someone else with exactly the same box which is failing for
> you, and see if it also fails for him/her?
>
>   

A hardware defect is not the problem here. There is a growing community
on these settopboxes in Germany
and I do talk to many of the owners actively. All the Samsung SMT-7020S
share the same problem when used with Linux. This is no single defect. 
On a sidenote: I never saw the Original WindowsCE Operating System or
the Intel IEGD Driver fail on setting up the fs454 once, but those both
are dead end solutions. The IEGD Drivers for older chipsets don't work
with newer software like Linux Kernel >2.6.15, the original Operating
System is really plagued by obscure Bugs and missing functionality...

Greetings
Wilken Haase


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
