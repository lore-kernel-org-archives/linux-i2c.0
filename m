From: Adam Williamson <awilliam@redhat.com>
Subject: Re: [PATCH 0/9] I2C ACPI operation region handler support
Date: Wed, 16 Apr 2014 09:35:22 -0700
Message-ID: <1397666122.2719.6.camel@adam.happyassassin.net>
References: <1397654682-7094-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397654682-7094-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: wsa@the-dreams.de, rjw@rjwysocki.net, lenb@kernel.org, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2014-04-16 at 21:24 +0800, Lan Tianyu wrote:
> ACPI 5.0 spec(5.5.2.4.5) defines GenericSerialBus(i2c, spi, uart) operation
> region. It allows ACPI aml code able to access such kind of devices to
> implement some ACPI standard method.
> 
> On the Asus T100TA, Bios use GenericSerialBus operation region to access
> i2c device to get battery info. So battery function depends on the I2C
> operation region support. Here is the bug link.
> https://bugzilla.kernel.org/show_bug.cgi?id=69011
> 
> This patchset is to add I2C ACPI operation region handler support.
> 
> [PATCH 1/9] ACPICA: Executer: Fix buffer allocation issue for
> [PATCH 2/9] ACPICA: Export acpi_buffer_to_resource symbol
> [PATCH 3/9] ACPI: Add acpi_bus_attach_private_data() to facilitate to
> [PATCH 4/9] ACPI/Thermal: Use acpi_bus_attach_private_data() to
> [PATCH 5/9] I2C: Add smbus quick read/write helper function
> [PATCH 6/9] I2C: Add smbus word/block process call helper function
> [PATCH 7/9] I2C/ACPI: Add i2c ACPI operation region support
> [PATCH 8/9] I2C/ACPI: Move ACPI related code to i2c-acpi.c
> [PATCH 9/9] I2C/ACPI: Add CONFIG_I2C_ACPI config

I've tested the version of these changes that's available as
https://bugzilla.kernel.org/attachment.cgi?id=131321 on my Venue 8 Pro
and found it gives apparently accurate battery stats (and doesn't seem
to make anything else explode). I'll try this form of the change out
today if I can.
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | XMPP: adamw AT happyassassin . net
http://www.happyassassin.net
