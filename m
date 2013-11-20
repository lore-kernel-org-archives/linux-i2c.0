From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH 2/2] i2c-designware-pci: Index Haswell ULT bus names from 0
Date: Tue, 19 Nov 2013 18:14:18 -0800
Message-ID: <CANLzEksP1nRfBaQ3-sSouOYL4C+oLKiE75eHfFdEzLmrQKn3dQ@mail.gmail.com>
References: <1382326010-4554-1-git-send-email-bleung@chromium.org>
	<1382326010-4554-3-git-send-email-bleung@chromium.org>
	<20131021065804.GX3521@intel.com>
	<CANLzEksGqD30Cefh3r2urH-ToxWzkxAnTJZiY07yX2Py58FQPw@mail.gmail.com>
	<20131114180538.GK11022@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131114180538.GK11022@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, khali@linux-fr.org, andriy.shevchenko@linux.intel.com, jacmet@sunsite.dk, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Duncan Laurie <dlaurie@chromium.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, Nov 14, 2013 at 10:05 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> In the chromeos_laptop driver, I do by-name matching of i2c busses to
>> find busses and instantiate devices, so there is value to have each
>> named something predictable.
>
> Any why don't you use fixed bus numbers which you can attach the devices
> to?

On this particular set of systems, there are two other classes of i2c
adapters that use dynamically assigned bus numbers, specifically the
i915 gmbus adapters, and the i801_smbus adapter. This is why
chromeos_laptop uses the name matching, as some of the boards that it
supports have devices on those dynamic busses.

I can't guarantee that these other busses will always have the same
bus numbers, nor can I guarantee that this driver
(i2c_designware_pcidrv) is loaded before or after the others, so it
seemed the right thing to do to to make sure that the names of each of
the adapters correspond to how they are referred to on various
schematics and datasheets.


-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
