From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 2/7] i3c: Add core I3C infrastructure
Date: Mon, 18 Dec 2017 10:22:26 -0800
Message-ID: <0e0cc2f1-8459-fbcf-6c44-4e5648190e9d@infradead.org>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
 <20171214151610.19153-3-boris.brezillon@free-electrons.com>
 <63546906-2fab-300a-b952-a0a7e8eb8bb5@infradead.org>
 <20171218093740.52eed20d@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20171218093740.52eed20d@bbrezillon>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@co>
List-Id: linux-i2c@vger.kernel.org

On 12/18/2017 12:37 AM, Boris Brezillon wrote:
> On Sun, 17 Dec 2017 14:32:04 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 12/14/17 07:16, Boris Brezillon wrote:
>>> Add core infrastructure to support I3C in Linux and document it.
>>>
>>> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>>> ---
>>>  drivers/Kconfig                 |    2 +
>>>  drivers/Makefile                |    2 +-
>>>  drivers/i3c/Kconfig             |   24 +
>>>  drivers/i3c/Makefile            |    4 +
>>>  drivers/i3c/core.c              |  573 ++++++++++++++++
>>>  drivers/i3c/device.c            |  344 ++++++++++
>>>  drivers/i3c/internals.h         |   34 +
>>>  drivers/i3c/master.c            | 1433 +++++++++++++++++++++++++++++++++++++++
>>>  drivers/i3c/master/Kconfig      |    0
>>>  drivers/i3c/master/Makefile     |    0
>>>  include/linux/i3c/ccc.h         |  380 +++++++++++
>>>  include/linux/i3c/device.h      |  321 +++++++++
>>>  include/linux/i3c/master.h      |  564 +++++++++++++++
>>>  include/linux/mod_devicetable.h |   17 +
>>>  14 files changed, 3697 insertions(+), 1 deletion(-)
>>>  create mode 100644 drivers/i3c/Kconfig
>>>  create mode 100644 drivers/i3c/Makefile
>>>  create mode 100644 drivers/i3c/core.c
>>>  create mode 100644 drivers/i3c/device.c
>>>  create mode 100644 drivers/i3c/internals.h
>>>  create mode 100644 drivers/i3c/master.c
>>>  create mode 100644 drivers/i3c/master/Kconfig
>>>  create mode 100644 drivers/i3c/master/Makefile
>>>  create mode 100644 include/linux/i3c/ccc.h
>>>  create mode 100644 include/linux/i3c/device.h
>>>  create mode 100644 include/linux/i3c/master.h


>>> diff --git a/drivers/i3c/core.c b/drivers/i3c/core.c
>>> new file mode 100644
>>> index 000000000000..7eb8e84acd33
>>> --- /dev/null
>>> +++ b/drivers/i3c/core.c
>>> @@ -0,0 +1,573 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2017 Cadence Design Systems Inc.
>>> + *
>>> + * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
>>> + */
>>> +
>>> +#include <linux/idr.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/slab.h>  
>>
>> #include <linux/device.h>
>> #include <linux/init.h>
>> #include <linux/list.h>
>> #include <linux/mutex.h>
>> #include <linux/rwsem.h>
> 
> Do you have a tool to detect those missing inclusions?

Nope, I've often wanted one, but for now it's just slow reading.



>>> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
>>> new file mode 100644
>>> index 000000000000..7ec9a4821bac
>>> --- /dev/null
>>> +++ b/include/linux/i3c/master.h
>>> @@ -0,0 +1,564 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (C) 2017 Cadence Design Systems Inc.
>>> + *
>>> + * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
>>> + */
>>> +
>>> +#ifndef I3C_MASTER_H
>>> +#define I3C_MASTER_H
>>> +
>>> +#include <linux/i2c.h>
>>> +#include <linux/i3c/ccc.h>
>>> +#include <linux/i3c/device.h>
>>> +#include <linux/spinlock.h>
>>> +
>>> +#define I3C_HOT_JOIN_ADDR		0x2
>>> +#define I3C_BROADCAST_ADDR		0x7e
>>> +#define I3C_MAX_ADDR			GENMASK(6, 0)
>>> +  
>>
>> Needs bitops.h, workqueue.h, rwsem.h
>>
>>
>> Needs <asm-generic/bitsperlong.h>
> 
> Okay, that's really weird to directly include a header from the
> asm-generic directory, are you sure this is the right thing to do here?

Looks like it should be <asm/bitsperlong.h>, which will grab the correct one.


-- 
~Randy
