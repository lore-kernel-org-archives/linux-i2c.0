From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH RFC] i2c algo, Add i2c-algo-i801 driver [v1]
Date: Wed, 09 Apr 2014 12:57:36 -0400
Message-ID: <53457C00.1030400@redhat.com>
References: <1397060563-30431-1-git-send-email-prarit@redhat.com> <20140409183732.5c8f6355@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20140409183732.5c8f6355@endymion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Seth Heasley <seth.heasley@intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Janet Morgan <janet.morgan@intel.com>, Myron Stowe <mstowe@redhat.com>
List-Id: linux-i2c@vger.kernel.org



On 04/09/2014 12:37 PM, Jean Delvare wrote:
> Hi Prarit,
> 
> On Wed,  9 Apr 2014 12:22:43 -0400, Prarit Bhargava wrote:
>> RFC and a work in progress ... I need to go through and do a bunch of error
>> condition checking, more testing, etc.  I'm just throwing this out there to see
>> if anyone has any major concerns about doing something like this.
>>
>> TODO:
>>
>> - decipher error returns from ACPI AML operations (and implement those too)
>> - additional error checking from i2c and acpi function calls (this code is
>> not robust enough)
>> - testing
>>
>> P.
>>
>> ----8<----
>>
>> Some ACPI tables on new systems implement an SBUS device in ACPI.  This results
>> in a conflict with the ACPI tables and the i2c-i801 driver over the address
>> space.  As a result the i2c-i801 driver will not load.  To workaround this, we
>> have users use the kernel parameter "acpi_enforce_resources=lax".  This,
>> isn't a good solution as I've seen other conflicts on some systems that are
>> also overriden.  I thought about implementing an i2c-core kernel parameter and
>> a wrapper function for acpi_check_resource_conflict() but that seems rather
>> clunky and doesn't resolve the issue of the shared resource between the ACPI
>> and the device.
>>
>> There isn't any documentaton on Intel's website about the SBUS device but from
>> reading the acpidump it looks like the operations are straightforward.
>>
>> SSXB
>>      transmit one byte
>> SRXB
>>      receive one byte
>> SWRB
>>      write one byte
>> SRDB
>>      read one byte
>> SWRW
>>      write one word
>> SRDW
>>      read one word
>> SBLW
>>      write block
>> SBRW
>>      read block
>>
>> I've implemented these as an i2c algorithm so that users who cannot load the
>> regular i801 i2c driver can at least get the functionality they are looking
>> for.
> 
> Writing a driver for the ACPI interface to the SMBus is IMHO a very
> good idea, thanks for doing that.
> 
> However I have two technical concerns with your approach:
> 
> 1* What you wrote is NOT an "i2c algo". i2c "algorithms" are abstracted
> I2C implementations, not correlated with any hardware or BIOS specific
> interfaces. If you check other drivers under i2c/algos you'll see they
> do NOT call i2c_add_adapter (although they may implement helper
> wrappers around that function.) Hardware-specific drivers which build
> on top of the algo driver are responsible for that.
> 
> What you wrote is much more like i2c/busses/i2c-scmi.c, so it is
> actually an i2c _bus_ driver.
> 
> 2* You are creating a link between i2c-i801 and your driver, where IMHO
> there should not be any. Both drivers are independent, and from the
> kernel's perspective, they are not even for the same hardware. In your
> case the ACPI interface is backed by an i801-like chip, but the same
> interface could totally be implemented on top of any other chip.
> 
> So I invite you to make your driver an independent i2c bus driver much
> like i2c-scmi.

Hey Jean -- thanks for the valuable feedback.  This is exactly why I RFC'd it :)
before I got in too deep :)

I'll rework the patch with your suggestions.  I may have (possibly dumb)
questions and I hope that's okay ..

P.
> 
> Thanks,
> 
