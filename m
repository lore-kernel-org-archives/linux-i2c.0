From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] i2c: designware: Round down ACPI provided clk to nearest
 supported clk
Date: Tue, 29 Aug 2017 22:27:14 +0200
Message-ID: <3cc3df29-b2b5-4a2a-fce4-a9d2302fee54@redhat.com>
References: <20170829120835.17276-1-hdegoede@redhat.com>
 <1504009379.25945.142.camel@linux.intel.com>
 <078c7214-230e-2a68-734b-2a01003ee378@redhat.com>
 <20170829201826.htdia6olxs3j5k66@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751249AbdH2U1R (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 29 Aug 2017 16:27:17 -0400
In-Reply-To: <20170829201826.htdia6olxs3j5k66@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org

Hi,

On 08/29/2017 10:18 PM, Wolfram Sang wrote:
> Hi,
> 
>>> I dunno what standard says if we may or may not use 100 kHz as a last
>>> resort even for speeds defined less than 100 kHz.
>>
>> The < 100000 case is for when i2c_acpi_find_bus_speed() returns 0, so
>> that we then keep it 0, in which case the code a bit lower will pick
>> a default.
> 
> This is fine by me.
> 
>> Since speeds < 100000 are clearly not valid treating them
> 
> Here I wonder: Not valid because of ACPI specs? Because I2C specs surely
> allow speeds < 100kHz.

The speed comes from an ACPI entry describing an i2c client,
any compliant i2c client must at least support 100KHz, right ?

Alternatively I could wrap the entire round-down for loop in
an if (acpi_speed) {} block.

Regards,

Hans
