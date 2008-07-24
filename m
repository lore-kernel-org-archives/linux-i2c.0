From: Wilken Haase <Hibbelharry-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Problem with unstable i2c communication with i810 bus
 driver
Date: Thu, 24 Jul 2008 19:23:12 +0200
Message-ID: <4888BA80.80109@gmx.de>
References: <48321FD9.2010007@gmx.de>	<20080520091807.071f1032@hyperion.delvare>	<4832C0C8.2090401@gmx.de>	<20080520203715.68c502f3@hyperion.delvare>	<483352EA.2090005@gmx.de>
	<20080521091440.2252167d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080521091440.2252167d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c list <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi People,
a while ago i asked for help on this list concerning unreliable i2c 
communication in a pc based settopbox i own.

Short explanation of the problem:
Basically there is a scan converter on the mainboard which converts 
video signals from the intel i815 graphics chip to tv compatible analog 
signaling at the video outputs of the box. This converter is configured 
via i2c. I2c communication works sort of, but is unreliable.
While reading i always get some bogus values back, writing has often to 
be done twice to work.

The scan konverter is the only device on the bus.

As there is quite a big community with these boxes a defect in my box 
can be ruled out. There is noone without these problems. Another fact: 
Intel IEGD Drivers for Windows and Linux work without any failure, but 
these are a dead end because they only support very old xfree and kernel 
versions.

After this description some new stuff. I've found someone to do some i2c 
oscilloscope dumps while accessing the chips. There seem to be problems 
while ACK'ing. You can see the pictures here:

Dump of bios initializing the chip:
http://beeker.campuspoint.de/pool/smt/bios_i2c_start.jpg

Dump of writing a 32bit value to the chip via console i2cset:
http://beeker.campuspoint.de/pool/smt/i2cset_0x6a_0xc4_0x9842.jpg

More details, same command, first 16bits:
http://beeker.campuspoint.de/pool/smt/i2cset_0x6a_0xc4_0x9842_16bits.jpg

Even more details:
http://beeker.campuspoint.de/pool/smt/i2cset_0x6a_0xc4_0x9842_ACK_error.jpg

Any idea what might go wrong here is appreciated. This should definately 
be some issue in software.
If any more infos are needed just ask, i will supply them.

Greets
Wilken Haase


Jean Delvare schrieb:
> On Wed, 21 May 2008 00:38:34 +0200, Wilken Haase wrote:
>   
>> I am able to probe the bus. The only discovered device on the bus is the
>> fs454 at 0x6a and the master at 0x00.
>>     
>
> 0x00 is actually the broadcast address. I've never seed used so far,
> but apparently the FS454 supports broadcast messages.
>
> BTW, you must be using an old version of i2cdetect. Newer versions
> don't probe address 0 by default.
>
> What about the DDC channel? If there is a screen connected with an EDID
> EEPROM you should see it on the DDC channel, and then you could test if
> it has transaction errors as well.
>
>   
>> "The FS453 registers are accessed through a serial input/output bus (SIO)
>> which is I2C*-compatible and SMBus-compatible. These registers can be
>> read or written at any time the part is receiving a reference clock at
>> XTAL_IN and not being held in reset via the RESET_L pin."
>>     
>
> OK, this doesn't sound like any delay is required between accesses then.
>
>   
>> Isn't this true i2c here ?
>>     
>
> As the FS454 is advertised as compatible with I2C, yes.
>
>   
>> A hardware defect is not the problem here. There is a growing community
>> on these settopboxes in Germany
>> and I do talk to many of the owners actively. All the Samsung SMT-7020S
>> share the same problem when used with Linux. This is no single defect. 
>>     
>
> OK.
>
>   
>> On a sidenote: I never saw the Original WindowsCE Operating System or
>> the Intel IEGD Driver fail on setting up the fs454 once, but those both
>> are dead end solutions. The IEGD Drivers for older chipsets don't work
>> with newer software like Linux Kernel >2.6.15, the original Operating
>> System is really plagued by obscure Bugs and missing functionality...
>>     
>
> Maybe the i810fb driver is missing an initialization which your system
> needs. You might want to discuss your problem with the i810fb driver
> maintainer (Antonino Daplas).
>
> You could try the old i2c-i810 driver temporarily and see if it does a
> better job, but I wouldn't hold my breath. Both drivers use the same
> helper driver (i2c-algo-bit) for the actual work. 
>
> I don't have any more ideas, sorry.
>
>   


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
