From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: i2c-core: One function call less in acpi_i2c_space_handler()
 after error detection
Date: Sat, 26 Dec 2015 09:52:11 +0100
Message-ID: <567E553B.5080005@users.sourceforge.net>
References: <201512261449.pmBxYtq3%fengguang.wu@intel.com>
 <567E3CF3.10606@users.sourceforge.net> <20151226074859.GA905@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151226074859.GA905@tetsubishi>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-i2c@vger.kernel.org

>> The kfree() function was called in one case by the
>> acpi_i2c_space_handler() function during error handling
>> even if the passed variable "client" contained a null pointer.
> 
> This is OK. kfree() is known to be NULL-tolerant and we rely on it in
> various places to keep the code simpler.

I would appreciate if an unnecessary function call can be avoided here
so that the affected exception handling can become also a bit more efficient.

Regards,
Markus
