From: andrey <andrey@elphel.com>
Subject: Re: clock driver
Date: Wed, 27 May 2015 16:58:44 -0700
Message-ID: <14d97d05f05.c0c23a8c778110.9087956443203424916@elphel.com>
References: <5564C58B.9050400@freescale.com> <20150526223829.GA26454@roeck-us.net> <55650DBA.5000304@freescale.com> <5565108D.2020502@freescale.com> <20150527173055.22384.74368@quantum> <556602BC.6040203@freescale.com> <20150527181521.GA19448@roeck-us.net> <55660BF2.6000002@freescale.com> <20150527185442.GA6607@roeck-us.net> <556613CE.8020906@freescale.com> <14d96cd6d64.f62a1a09739217.9114963256886461171@elphel.com> <55664E5C.3000903@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55664E5C.3000903@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Michael Turquette <mturquette@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, sebastian.hesselbarth@gmail.com, rabeeh@solid-run.com, York Sun <yorksun@freescale.com>
List-Id: linux-i2c@vger.kernel.org



---- On Wed, 27 May 2015 16:08:12 -0700 Guenter Roeck<linux@roeck-us.net> wrote ---- 

 > On 05/27/2015 12:44 PM, andrey wrote: 
 > > Hello all, 
 > > Let me add a comment on using sysfs to simplify user space access to the clock
 > > features as opposed to controlling them from a driver that uses the clock chip driver. 
 > > 
 > > It is common to use such advanced clock chips with the FPGA devices (as me and
 > > York do), and a lot of development (HDL code) is done before a fancy higher-level
 > > driver is even started. And it is not just a temporary stage needed by a small minority
 > > of developers - as HDL coding gets more to the the core of many new devices running
 > > Linux kernel, it makes sense to create the chip drivers more developer-friendly, not
 > > just for the final use in a higher level device driver - modification of the HDL code
 > > (most modern FPGA are programmed at runtime) makes it a new device that may
 > > need a new driver. 
 > > I'm sure that it is not just for me, when it starts with the chip driver that supports
 > > low-level functionality exposing it to the user space, and then working on the HDL
 > > code using Python scripts at that stage. And only later in the development designing
 > > the higher level device drivers that may not need all of the chip functionality. And such
 > > higher level driver will work for our systems, but other developers who work on their
 > > embedded systems will again need access to low level chip functionality, and will have
 > > to redo the same work all over again. This I believe is a rationale of exposing such
 > > chip-specific hardware features (not all of them are probably easy to fit into a specific
 > > standard model) to the user space scripts. 
 > > 
 > > I wrote the initial driver code for our system
 > > ( https://github.com/Elphel/linux-elphel/blob/master/src/drivers/misc/si5338.c ) and
 > > being very far from being a kernel developer myself (I'm more of a hardware guy)
 > > I didn't even try to satisfy the required coding style and submit it, so I'm very thankful
 > > to York who re-wrote the code and is trying to make it usable to others. 
 > > 
 >  
 > Line wraps at ~75 columns would make this a bet easier to read.

Guenter, I'm sorry for using "rich text" email settings. 

 >  
 > A more generic solution to your problem might be to implement a driver 
 > similar to i2c-dev, which exports raw i2c device information to user space. 
 > In your case, you would export information about the clocks in the system, 
 > possibly through sysfs (i2c-dev uses ioctl which is a bit old-fashioned).

I was trying to make it safer to use low-level functionality of the particular
(and rather popular) clock chip and to avoid using SiLabs proprietary tools to
generate required settings offline. Using just raw i2c would require to have
large user space program to calculate valid settings for the device.

I would consider this chip as both a generic clock device that can fit into
a standard framework and simultaneously a unique device that offers specific
functionality outside of the framework. I thought that sysfs (instead of
"old-fashioned" ioctl I used in such cases before) can offer
hardware developer-friendly solution as a supplement to in-framework
basic functionality.

Device driver for this chip makes it possible to avoid proprietary configuration
software and calculate register settings at runtime, minimizing requirements to
the user space software and so the time developers of the new embedded
systems will need to (re-)implement these important chip-specific  features.

Andrey

 >  
 > This would be a driver independent solution, and work for all clock drivers. 
 > It might still not be accepted by Mike and Stephen, due to the risk, but it 
 > might be worth a try. After all, using i2c-dev to access i2c devices directly 
 > is just as risky. 
 >  
 > In my opinion, it is always better to have a driver in the upstream kernel, 
 > if possible one that uses a standard framework. That makes it much easier 
 > to support going forward. 
 >  
 > Guenter 
 >  
 > 
