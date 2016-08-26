From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: Question related i2c fixed clk rate
Date: Fri, 26 Aug 2016 14:29:14 +0300
Message-ID: <64363513-96c8-9ace-131f-27fc176d146b@linux.intel.com>
References: <MWHPR12MB121624883C79696F1A248570A0ED0@MWHPR12MB1216.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5458 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752985AbcHZLeD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 26 Aug 2016 07:34:03 -0400
In-Reply-To: <MWHPR12MB121624883C79696F1A248570A0ED0@MWHPR12MB1216.namprd12.prod.outlook.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Cc: "linux-i2c-owner@vger.kernel.org" <linux-i2c-owner@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Ken Xue <Ken.Xue@amd.com>, Xiangliang Yu <Xiangliang.Yu@amd.com>, Wang Hongcheng <annie.wang@amd.com>

Hi

+ Cc AMD contacts from acpi_apd.c changelog

On 08/25/2016 08:00 PM, Shah, Nehal-bakulchandra wrote:
> Hi,
> I am new to this. Appreciate your help for my query.
> I am working on updating i2c-designware clock rate for AMD upcoming platform. Here new 150000000 clk rate will be supported. I want to validate this but currently in our platform I do not have any i2c lines out. Is there any tool or way to check if this is getting setup properly.
> Basically I want to change
>  .fixed_clk_rate = 133000000 to
> .fixed_clk_rate = 150000000 in acpi_apd.c file.
>
I guess what you want is to have a new static struct apd_device_desc 
descriptor in drivers/acpi/acpi_apd.c and a new entry to 
acpi_apd_device_ids[] for your new platform.

Something like what commits b790eb20b8e4 ("ACPI / APD: Add APM X-Gene 
ACPI I2C device support") does.

-- 
Jarkko
