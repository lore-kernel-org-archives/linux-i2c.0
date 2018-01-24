From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] i2c: Allow ACPI_I2C_OPREGION if I2C is built as a
 module
Date: Wed, 24 Jan 2018 16:23:50 +0100
Message-ID: <26d6761c-17c9-73d8-42d6-25815b58bc87@redhat.com>
References: <1514988151-12248-1-git-send-email-eric.auger@redhat.com>
 <20180124055615.c3qwhwnj7spmcr3w@ninjato>
 <20180124062725.GK27654@lahna.fi.intel.com>
 <f498c1ef-0e15-3956-8e70-bca53ec2cac4@codeaurora.org>
 <CAHp75VexHQS20azPFO5uv+sBQ4QYVXL+yhT56EhT+QmNZfzMFg@mail.gmail.com>
 <54ef10bd-6209-6983-1d3a-ddf7d7fea252@redhat.com>
 <f918bbf3-1f9a-df63-9906-7147620ee6cf@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <f918bbf3-1f9a-df63-9906-7147620ee6cf@codeaurora.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On 24-01-18 16:12, Sinan Kaya wrote:
> On 1/24/2018 9:59 AM, Hans de Goede wrote:
>> TL;DR: I have to NAK this, I'm sorry but with the current state of ACPI we
>> must simply have some stuff builtin to help with probe-ordering issues. Now
>> if the ACPI code where ever to honor the _DEP method everywhere instead of
>> only for battery devices this might change, but even then things will still
>> be tricky.
> 
> Well, the alternative is even worse.

No it is not, if I2C gets builtin things work fine, you proposal does not
fix anything, it merely gives the illusion of being builtin

> Redhat and most other distros configure I2C as a module.

Fedora has stopped building I2C as a module a long time ago already and where
Fedora goes RHEL typically follows.

> With this setup,
> I2C OpRegion support does not get compiled. It doesn't even work let alone to have
> race conditions.

So at least it is consistent then, which makes for a lot easier debugging.

> I2C OpRegion feature is practically dead for most general users unless you recompile
> your own kernel.

Then talk to various distro kernel maintainers and ask them to
set CONFIG_I2C=y.

> There must be a middle ground somewhere.

One thing which comes to mind is to simply not allow building i2c as a module
when ACPI is selected, something like this should work I think:

  config I2C
          tristate "I2C support"
          select RT_MUTEXES
          select IRQ_DOMAIN
+        # force building I2C in on ACPI systems, for opregion availability
+        depends on y || !ACPI

> I had some conversation with Rafael about _DEP support. He is not a big fan :)

Ok.

Regards,

Hans
