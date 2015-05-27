From: York Sun <yorksun@freescale.com>
Subject: Re: clock driver
Date: Wed, 27 May 2015 08:07:54 -0700
Message-ID: <5565DDCA.2000308@freescale.com>
References: <5564C58B.9050400@freescale.com> <20150526223829.GA26454@roeck-us.net> <55650DBA.5000304@freescale.com> <5565108D.2020502@freescale.com> <55656D96.9030603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55656D96.9030603@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Guenter Roeck <linux@roeck-us.net>, mturquette@linaro.org
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, andrey@elphel.com, rabeeh@solid-run.com
List-Id: linux-i2c@vger.kernel.org



On 05/27/2015 12:09 AM, Sebastian Hesselbarth wrote:
> On 27.05.2015 02:32, York Sun wrote:
>> On 05/26/2015 05:20 PM, York Sun wrote:
>>> On 05/26/2015 03:38 PM, Guenter Roeck wrote:
>>>> On Tue, May 26, 2015 at 12:12:11PM -0700, York Sun wrote:
>>>>> I have rewritten a driver for Silicon Labs SI5338 programmable clock chip. The
>>>>> original driver was written by Andrey (CC'ed), but was floatingn outside of the
>>>>> kernel. The driver was written to use sysfs as the interface, not the common
>>>>> clock framework. I wonder if I have to rewrite the driver following common clock
>>>>> framework. One concern is to support a feature to accept ClockBuilder (TM)
>>>>> output on sysfs. I don't see sysfs support on common clock framework. Please
>>>>> correct me if I am wrong.
>>>>>
>>>>> If not using common clock framework is acceptable, I would like to send a RFC
>>>>> patch for review.
>>>>>
>>>> My original driver for si570 was rejected because it didn't support the clock
>>>> framework, so you might face an uphill battle.
>>>>
>>>> SI provides a document for SI5338 describing how to configure it without
>>>> using clockbuilder [1]. Can that be used to implement generic code which
>>>> doesn't need clockbuilder ?
>>>>
>>>
>>> The driver is capable to handle the user's input and enable the clocks. Removing
>>> the support of importing is a step back. At least it is a feature I am using. I
>>> believe Andrey also used this feature when the driver was first drafted.
> 
> York,
> 
> IMHO what kind of driver you need for the clock generator clearly
> depends on the use case you have in mind.
> 
> Also, why should a user ever be able to mess with the clocks? If you
> allow a user to change the clock rate of any output, you have to
> consider that he will likely be able to crash your system easily.
> 
> As long as you cannot give a clear requirement for user-configurable
> clocks - especially in the detail of the driver you mentioned -
> mainline kernel is not the place for such a driver.

Sebastian,

This driver I am proposing supports SI5338 in a generic way. It can take device
tree as its default configuration. However I am using it differently, explained
in detail below.

> 
>>> That being said, my application relies on setting multiple clock chips on a PCIe
>>> device. That means I cannot put the configuration into device tree. There may be
>>> a way to fill device tree, but I am not ready to explore yet. Without a sysfs
>>> interface, can I change the configuration for each clock?
> 
> If the clock chip is part of a PCI device, the PCI driver should include
> functions to set the clock rate. If you expose each clock with common
> clock framework or not depends on how dynamically you want your clocks
> to be. IMHO you have these options:
> 
> (a) Clocks are limited to the PCI card and only need a limited set of
> configurable clocks. You should add functions to load the registers
> with either the full register map or parts of it in a table based
> approach. You don't expose the clocks with CCF but deal with rate
> change requests internally in the PCI driver. You could also consider
> to have the initial clock configuration as part of some firmware blob
> you request with the PCI driver.

That's right. I only need to change a small portion of the configuration, such
as frequency, but keeping the reset the same, including output driver voltage,
input clock, etc.

> 
> (b) Clocks are driving the PCI card as a parent clock but are not
> dynamic. You should use the boot loader to load the register map or you
> could simply use i2c-dev to load the registers from userspace. You'll
> need no driver at all.
> 
> (c) Clocks are driving clock inputs of your SoC and should be fully
> dynamic, i.e. you cannot tell the rate that will be requested. Expose
> each clock with CCF and find some good code to derive si5338 register
> values from the requested rate. si5351 driver is an example but I know
> silabs documentation isn't that good when it comes to dynamically
> changing the clocks. With CCF you'll have no user interface at all
> because users just shouldn't be able to mess with the clocks.
> 
> [...]
>> If converting my driver to common clock framework, I need to find a way to
>> configure the clocks without recompiling the kernel. I will have about 30 clock
>> chips (with different frequency) on multiple PCIe cards.
> 
> This is your specific use case of the clock driver, something that
> clearly doesn't match a generic use case. If you describe your use
> case in detail, we may be able to give you more hints on what kind
> of driver you'll need and if that driver will ever be able to get
> into mainline.
> 

My application has a host SoC booting up Linux. Then the clocks on PCIe (FPGA)
cards get initialized with their clocks. The clocks are not used by host SoC, so
setting the wrong clocks doesn't crash the system. Each PCIe card has up to four
clock chips (with four clocks on each chip). It is required for users to be able
to change the clocks after system boots up.

I wrote my driver for the PCIe cards so the clocks can be initialized using the
data provided. But changing the clocks, or initializing with another set of
configuration requires an interface. There are many ways to solve this. I would
like to keep the clock driver generic so it can be reused. It looks like CCF may
not be the best fit for such driver. What is an acceptable way to write this
driver so it can be in the mainline kernel, or other maintained projects (I am
not aware of any though)?

York
