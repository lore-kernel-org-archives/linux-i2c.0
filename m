From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH RFC] i2c algo, Add i2c-algo-i801 driver [v1]
Date: Fri, 11 Apr 2014 13:47:46 -0400
Message-ID: <53482AC2.2060605@redhat.com>
References: <1397060563-30431-1-git-send-email-prarit@redhat.com>  <1397061392.5276.11.camel@x230> <53457D0D.7020805@redhat.com>  <1397063381.5276.17.camel@x230> <5346EDEA.3070704@redhat.com> <1397161609.5276.32.camel@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1397161609.5276.32.camel@x230>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "seth.heasley@intel.com" <seth.heasley@intel.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "janet.morgan@intel.com" <janet.morgan@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "mstowe@redhat.com" <mstowe@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org



On 04/10/2014 04:26 PM, Matthew Garrett wrote:
> On Thu, 2014-04-10 at 15:15 -0400, Prarit Bhargava wrote:
>>
>> On 04/09/2014 01:09 PM, Matthew Garrett wrote:
>>> Not really. These are an internal implementation detail, not an exported
>>> interface. We try to write drivers for exported interfaces, even if
>>> they're not documented.
>>
>> Aren't the methods the exported interface?  I'm obviously missing something :)
> 
> No. The device doesn't have a _HID(), so they're internal methods.
> 
>>> Imagine an i2c chip with indexed register access. What stops:
>>>

I think I missed something in this example (and if I have this wrong, please say
so).

Are you saying *both* the old (pci-style) driver and my new driver (ACPI) are
loaded?  Or something else?

>
>>> CPU0 (i2c):		CPU1 (ACPI):
>>> SBWB register address
>>> 			SBWB register address
>>> SBRB register value
>>> 			SBRB register value
>>>
>>> and CPU0 getting back the wrong value?

P.
