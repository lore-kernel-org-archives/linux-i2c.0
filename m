From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: Fix modalias for ACPI enumerated I2C devices
Date: Mon, 14 Oct 2013 09:45:53 +0300
Message-ID: <525B9321.5000906@linux.intel.com>
References: <1381414669-26115-1-git-send-email-jarkko.nikula@linux.intel.com> <2393462.4JRAMNeigd@vostro.rjw.lan> <20131012050413.GY3521@intel.com> <2878883.SYGmCkS5Bt@vostro.rjw.lan> <20131012161805.GB3521@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20131012161805.GB3521@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On 10/12/2013 07:18 PM, Mika Westerberg wrote:
> If we have two ACPI enumerated devices, they have following modalias:
>
>    i2c-device0:	i2c:INTABCD:00
> 		acpi:INTABCD
>
>    i2c-device1:	i2c:INTABCD:01
>    		acpi:INTABCD
>
> Likelihood that some random I2C driver has INTABCD:00 or INTABCD:01 ids in
> their list is minimal. However, when you turn it to this:
>
>
>    i2c-device0:	i2c:INTABCD
> 		acpi:INTABCD
>
>    i2c-device1:	i2c:INTABCD
>    		acpi:INTABCD
>
> It might be possible that we get a match that isn't supposed to happen.
> Well, OK it is pretty remote but anyway :-)
Well, name conflicts could occur of course but still I don't think we 
should generate illegal or wrong modaliases. I'm not an udev expert but 
I suppose trying to load nonexisting drivers (i2c_INTABCD:xy) could slow 
booting a little and perhaps pollute needlessly error log compared to if 
it can see that driver is already loaded or tries to load the same 
driver again.

I don't think name conflicts can pose too big risk as they are trivial 
to fix in sources and can be queued to stable too.

-- 
Jarkko
