From: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Request for Clarification: old - legacy - new driver model
Date: Thu, 26 Feb 2009 12:09:52 +0100
Message-ID: <go5ta2$rtu$1@ger.gmane.org>
References: <gngvea$eqj$1@ger.gmane.org>	<20090218173645.GD3049@pengutronix.de>	<gnjplc$hqd$1@ger.gmane.org>	<20090220135300.353cd53a@hyperion.delvare>	<go12jd$ec4$1@ger.gmane.org> <20090225090002.2c31dbf1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090225090002.2c31dbf1-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare said the following:
> Hi Michael,
> 
> On Tue, 24 Feb 2009 16:09:33 +0100, Michael Lawnick wrote:
>> Jean Delvare said the following:
>> > On Thu, 19 Feb 2009 15:17:13 +0100, Michael Lawnick wrote:
>> <snip>
>> >> Our situation: main board is up and running, all drivers loaded.
>> >> Now an extension board will be plugged in. It is detected by
>> >> periodically polling via I2C for MUX. After detection the drivers e.g.
>> > 
>> > This is totally unsupported. I2C isn't an hot-pluggable bus.
>> > 
>> <snip>
>> > 
>> > What you are missing, as far as I can see, is proper mux support.
>> > Rodolfo Giometti (Cc'd) is working on this, if you want to test his
>> > patches (which I still didn't have the time to look at, sadly.)
>> > 
>> I have seen the patches, I am planning based on them.
>> 
>> Well, thinking about it, I hope to have a solution.
>> Here is what a H/W might look like:
>>                           +-------+   +--------+
>>                           |  LM75 |   | EEPROM |
>>                           +-------+   +--------+
>>  Mainboard                    |           |
>> +------------+                |           |
>> | controller |----------------+-----+-----+---....
>> +------------+                      |
>>                                     |
>>                                     |
>>                                  +------+
>>                                  |      |
>>    ...>--------------------------| MUX1 |----------------------<...
>>                +-----------------|      |---------------+
>>                |                 +------+               |
>>                |                                        |
>>                |                                        |
>>                ^                                        ^
>> Plugin1        |                          Plugin2       |
>>             +------+                                +------+
>>             |      |   +-------+                    |      |   +-------+
>>         +---| MUX2 |---|  LM75 |                +---| MUX3 |---|  LM75 |
>>         |   |      |   +-------+                |   |      |   +-------+
>>         |   +------+                            |   +------+
>>         |                                       |
>>         |   +-------+                           |   +-------+
>>         +---|  LM75 |                           +---|  LM75 |
>>         |   +-------+                           |   +-------+
>>         |                                       |
>>         |   +--------+                          |   +--------+
>>         +---| EEPROM |                          +---| EEPROM |
>>         |   +--------+                          |   +--------+
>>         |                                       |
>> 
> 
> I don't quite get the point of MUX2 and MUX3.

Only 2 LM75 per MUX are shown above, but there will be 10+ in real ...
Don't ask - H/W engineers ...

> 
>> 
>> The idea: when deferring the instantiation of the adapters of MUX1,
>> there should be something like a hot-plug event.
>> AFAIK, after adding an adapter via i2c_add_numbered_adapter(), the I2C
>> subsystem will probe for all currently known clients on this new bus.
>> Correct?
>> If so, this should cascade through the newly plugged in board.
> 
> For I2C chip drivers which do device autodetection (lm75 and eeprom are
> amongst them but for example at24 is not) yes. For other drivers (say
> at24) there should be a board definition for the new i2c bus segment.

I don't get the point here. The problem of correct identification will
have to be solved in any case.

> This might be a little difficult to implement with the traditional
> i2c_register_board_info() due to the hotplug nature is not all plugins
> have the same set of I2C chips. But some custom code using
> i2c_new_device() should do.

This would have to be done in kernel, doesn't it? I dislike such an
idea. Furthermore I raise the question of my previous posting again:
>>> For kernel space init I assume its a call to i2c_new_device(). Here I'm
>>> wondering where I should get the adapter info from.

> 
>> This defer could be implemented by removing auto instantiation (module
>> parameter)
> 
> Auto instantiation only happens if the bus driver asks for it (through
> an I2C_CLASS_* flag). If you don't want it, no need for a module
> parameter, simply don't set any class flag.
> 
What was meant is the auto instantiation of sub controllers.
I'm talking based on i2c-pca954x.c posted by Rodolfo Giometti on
01/28/09. I can't see an class attribute there. So how gets it
instantiated? Until now I assumed an automatic call of probe() for every
host controller.

>> but adding a sysFs entry on MUX that does it on demand:
>> #start controller 5
>> echo 5 > /sys/bus/i2c/devices/1-0020/startAdapter
>> #stop controller 5
>> echo 5 > /sys/bus/i2c/devices/1-0020/stopAdapter
>> 
>> Any contradictions?
> 
> What are you trying to achieve? 

Dynamically add of new instances of already running devices to the I2C
system.

> What is wrong with auto instantiation
> as it is implemented today?
> 
The point of time when it is done (AFAICS);-)
As I previously said:
>>>> Our situation: main board is up and running, all drivers loaded.
>>>> Now an extension board will be plugged in. It is detected by
>>>> periodically polling via I2C for MUX. After detection the drivers e.g.
>>>> for temperature an MUX on the secondary board need to be attached to I2C
>>>> subsystem. Instances of both drivers are already running for local
>>>> devices, re-loading is only a bad option.
Until now I can see no way to initiate an additional instantiation of an
I2C driver without reloading the module.

So far I have seen, the new model assumes a static network of devices
that can be initialized on boot strap. Information for this is taken
from device tree or kernel configuration data.
What I need is a user space initiated additional registration of a device.

I have the typical S/W engineers problem: no H/W, no documentation, but
should design and implement a system that has to run out of the box when
first version of H/W arrives ;-)
Therefore I asked for links in the OP so I can understand the idea of
the so called 'new I2C model'. The kernel documentation seems not to be
sufficient to achieve my goals.
Currently I'm waiting for 2 MUXes and an LM75, so I can connect them to
our current MUX-less board and start to play.

-- 

Michael Lawnick
Software Design Engineer

Lise-Meitner-Str. 7/1
89081 Ulm
Tel: +49 731 9533 2066

Michael.Lawnick.ext-OYasijW0DpE@public.gmane.org
http://www.nokiasiemensnetworks.com/global/

Think before you print
