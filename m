From: vitor <vitor.soares@synopsys.com>
Subject: Re: [PATCH] i3c: master: dw: split dw-i3c-master.c into master and
 bus specific parts
Date: Mon, 26 Nov 2018 20:11:39 +0000
Message-ID: <4c743a9a-d636-d34c-b7e3-913f18e6c754@synopsys.com>
References: <ade2c1a8d1eb48681b01ccdc9bed22caf5e96c4b.1542904564.git.soares@synopsys.com>
 <20181122210202.6af50fcc@bbrezillon>
 <6d513e04-3a57-1989-429c-64631101c5a2@synopsys.com>
 <20181123135004.7fd1cd58@bbrezillon>
 <83115f47-1326-cb33-a7dc-4bc8ff95befa@synopsys.com>
 <20181126133550.51469816@bbrezillon>
 <4e9c0461-02a3-80b2-c9b7-2e9ea9b38f8b@synopsys.com>
 <20181126195618.352eafb1@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181126195618.352eafb1@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, vitor <vitor.soares@synopsys.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, linus.walleij@linaro.org, Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se, mshettel@codeaurora.org, swboyd@chromium.org
List-Id: linux-i2c@vger.kernel.org


On 26/11/18 18:56, Boris Brezillon wrote:
> On Mon, 26 Nov 2018 18:33:37 +0000
> vitor <vitor.soares@synopsys.com> wrote:
>
>> On 26/11/18 12:35, Boris Brezillon wrote:
>>> On Mon, 26 Nov 2018 12:06:24 +0000
>>> vitor <vitor.soares@synopsys.com> wrote:
>>>   
>>>> Hi Boris,
>>>>
>>>>
>>>> On 23/11/18 12:50, Boris Brezillon wrote:
>>>>> On Fri, 23 Nov 2018 12:39:31 +0000
>>>>> vitor <vitor.soares@synopsys.com> wrote:
>>>>>      
>>>>>> Hi Boris,
>>>>>>
>>>>>>
>>>>>> On 22/11/18 20:02, Boris Brezillon wrote:
>>>>>>> On Thu, 22 Nov 2018 17:54:54 +0000
>>>>>>> Vitor Soares <vitor.soares@synopsys.com> wrote:
>>>>>>>         
>>>>>>>> From: Vitor Soares <soares@synopsys.com>
>>>>>>>>
>>>>>>>> This patch slipts dw-i3c-master.c into three pieces:
>>>>>>>> 	dw-i3c-master.c - contains the code that interacts directly with the
>>>>>>>> 	core in master mode.
>>>>>>>>
>>>>>>>> 	dw-i3c-platdrv.c - contains the code specific to the platform driver.
>>>>>>>>
>>>>>>>> 	dw-i3c-core.h - contains the definitions and declarations shared by
>>>>>>>> 	dw-i3c-master and dw-i3c-platdrv
>>>>>>>>
>>>>>>>> This patch will allow SOC integrators to add their code specific to
>>>>>>>> DesignWare I3C IP.
>>>>>>> Isn't it too early to do this change? Can't we wait until we have a SoC
>>>>>>> that actually embeds this IP?
>>>>>> I'm trying to turn it more flexible so the other can reuse the code.
>>>>> Looking at the separation you've done here, I don't see why you need
>>>>> it. All the resources you request are generic, so why not just adding a
>>>>> new compat in the of_match_table?
>>>> I understand your point.
>>>>
>>>>
>>>> I'm just following what it's done in others Synopsys drivers and what I
>>>> expect is that in the future we will have the same for the I3C.
>>>>
>>>> Some of the current generic functions might be override according with
>>>> SoC requirements (e.g i2c-designware, pcie-designware).
>>>>
>>>>
>>>> for now what do you prefer?
>>>>   
>>> I prefer that we keep the driver as is until we actually need to split
>>> things up.
>> This is already done and will benefit everyone:
>>
>>       - for me is better do it now than the secondary master and slave
>> development.
> Sorry, I don't get that one.


I already share my plan with you. See the structure above.

>
>>       - for the others it will easy the SoC integration avoiding
>> duplicated work and doing things from scratch.
> What would be duplicated? You want to support a new SoC, just add a new
> entry in the of_match_table and you're done. When you need to add
> SoC/integration specific stuff, create a struct and attach a different
> instance per-compatible so that each SoC can have its own configuration
> (or even init sequence if needed). That's how we do for pretty much all
> IPs out there, why should designware ones be different?
>
>>
>>>   
>>>>>>      
>>>>>>>         
>>>>>>>> Signed-off-by: Vitor Soares <soares@synopsys.com>
>>>>>>>> ---
>>>>>>>>      drivers/i3c/master/Kconfig          |   9 +-
>>>>>>>>      drivers/i3c/master/Makefile         |   5 +-
>>>>>>>>      drivers/i3c/master/dw-i3c-core.h    | 214 ++++++++++++++++++++++++++
>>>>>>>>      drivers/i3c/master/dw-i3c-master.c  | 299 ++----------------------------------
>>>>>>>>      drivers/i3c/master/dw-i3c-platdrv.c | 112 ++++++++++++++
>>>>> Just realized the driver is named dw-i3c-master, while the cadence
>>>>> driver is named i3c-master-cdns.c. I'll send a patch to make that
>>>>> consistent and follow the initial naming scheme: i3c-master-<ipname>.c.
>>>> As I shared with you in previous email, the structure that I have in
>>>> mind is this one:
>>>>
>>>> - core.h (or common.h, any though?)
>>>>
>>>> - common.c
>>>>
>>>> - master.c
>>>>
>>>> - slave.c
>>>>
>>>>
>>>> so for me doesn't make sense to have for instance: i3c-master-dw-slave.c
>>> If you have several files and they're all placed in a dw/ subdir, then
>>> I agree, prefixing everything with i3c-master- is useless, as you'll
>>> have to define a custom rule to create the i3c-master-dw.ko object.
>>>
>>> When there's a single source file, and this source file is directly
>>> used to create a .ko, we need this prefix, otherwise we would have
>>> dw.ko, and this would basically conflict with any other designware
>>> driver that does not have a proper prefix.
>>>   
>>>> But seeing what is already in the kernel I wasn't coherent and it should
>>>> be named to i3c-designware-master.c
>>> Actually it's i3c-master-designware.c (or i3c-master-dw.c) if we follow
>>> what's been done for the cadence driver.
>>>   
>> I was referring to what was made in other modules and should be applied
>> here too.
> This is a subsystem decision. I don't mind changing the naming scheme,
> though I don't see why yours is better than the one I initially
> proposed. In any case, what's important here is to keep driver names
> consistent.
>
>>
>>>> or
>>>>
>>>>
>>>> follow this https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2017_7_12_430&d=DwICAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=qVuU64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=9fGCPbkiqaG2-CJ5qrOU2Os6ZcstSNxi7UbQiF9YEBk&s=ADR3LotyBBy6e8Rv-UFW_-J8B5os_PY71QtUols3tb4&e=
>>> And I agree with Linus on this, except that does not apply to single
>>> source file drivers.
>>>   
>>>> This topic rise another one related with the master folder. I understand
>>>> that now the subsystem doesn't have slave support but the name is
>>>> limited. Isn't better to have something like controller or busses? What
>>>> do you have in mind for the slave?
>>> drivers/i3c/slave/... for slave drivers and drivers/i3c/slave.c for the
>>> framework, just like we have drivers/i3c/master/ for master controller
>>> drivers and drivers/i3c/master.c.
>> I have to disagree here. I don't see any place on the kernel with
>> .../master/ and ../slave/ folders and it is very likely that both rules
>> will have some common code.
> I see at least one that uses this model: the USB framework
> (drivers/usb/gadget/ for device controllers and drivers/usb/host/ for
> host controllers). Given that I3C is closer to USB than I2C I initially
> decided to keep this separation. Maybe I'm wrong, but I'd like to
> understand why you think it's not appropriate.


You can say there some features from USB in I3C but cannot compare USB 
vs I3C since they are in different championships.

The aim of I3C is to fill the gaps discovery on I2C over the years but 
still keeping its simplicity not to go to the complexity of USB.


I'm not sure but I think that a controller cannot change between gadget 
to host in USB in runtime. Even so, this kind of behavior is more likely 
to have in an I3C bus.


>
>> With this structure the user will have the code spread in /master and
>> /slave folders...
> Not sure who you call "user" here, but yes, master controller and slave
> controller drivers would be placed in different dirs.
>
>>
>> I would like you consider to change the folder name and the names rules
>> to something like in i2c.
> Why? And more importantly, why is this coming up now? You've been
> reviewing the framework since the beginning, and never complained about
> the subdirs/files organization so far.


Sorry for that and don't take me wrong... maybe I should rise this 
question early but this only came up now when I started splitting and 
thinking where to put what is for master for slave, what is common and 
the thing of putting everything of controller in a folder.


Taking the USB as exemple do you prefer a dwc folder on i3c root?


>
> I'm okay changing it, but I want to understand why the proposed
> separation is not good.


I already tell you my use case and as I said maybe someone can advise :)
