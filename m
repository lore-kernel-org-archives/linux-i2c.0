From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] i2c: acpi: Do not create i2c-clients for LNXVIDEO ACPI
 devices
Date: Tue, 4 Jul 2017 14:50:41 +0200
Message-ID: <a28123d2-91cf-6dba-16e2-acfad25a37d8@redhat.com>
References: <20170704124613.14591-1-hdegoede@redhat.com>
 <20170704124927.GB5057@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752159AbdGDMuo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 4 Jul 2017 08:50:44 -0400
In-Reply-To: <20170704124927.GB5057@katana>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org

Hi,

On 04-07-17 14:49, Wolfram Sang wrote:
> 
>> +	static const struct acpi_device_id video_device_ids[] = {
> 
> What about naming the array 'ignored_device_ids' to be more generic?

Sure I can do that, any other remarks before I send a v3 ?

Regards,

Hans
