From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: Issues with touchpad / touchscreen on yoga 900
Date: Fri, 30 Oct 2015 09:58:14 +0200
Message-ID: <56332316.90506@linux.intel.com>
References: <20151029112913.1036f00b@voldemort.scrye.com> <20151029183032.GA8992@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60864 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758878AbbJ3H6R (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 30 Oct 2015 03:58:17 -0400
In-Reply-To: <20151029183032.GA8992@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Kevin Fenzi <kevin@scrye.com>
Cc: linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi

On 10/29/2015 08:30 PM, Wolfram Sang wrote:
> On Thu, Oct 29, 2015 at 11:29:13AM -0600, Kevin Fenzi wrote:
>> Greetings.
>>
>> I'm having problems with a lenovo yoga 900 not seeing it's touchscreen
>> or touchpad.
>>
>> Downstream bug:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1275718
>>
>> The problem parts of dmesg seem to be:
>>
>> Oct 26 15:20:08 localhost kernel: i2c_designware i2c_designware.1: i2c_dw_handle_tx_abort: lost arbitration
>> Oct 26 15:20:08 localhost kernel: i2c_hid i2c-SYNA2B29:00: hid_descr_cmd failed
>> Oct 26 15:20:08 localhost kernel: i2c_designware i2c_designware.2: i2c_dw_handle_tx_abort: lost arbitration
>> Oct 26 15:20:08 localhost kernel: i2c_hid i2c-ELAN21EF:00:
>> hid_descr_cmd failed
>>
>> This is with 4.3.0-0.rc7.git1.1.fc24.x86_64 (post rc7 4.3.0).
>>
>> Happy to gather further info or try patches. ;)
>
Could you try this test patch from Mika that prints the parameters it 
gets from ACPI and forces using calculated ones (your quirk was supposed 
to be doing the same):

http://www.spinics.net/lists/linux-i2c/msg21239.html

Another fix from Mika that comes to my mind is "HID: multitouch: Fetch 
feature reports on demand for Win8 devices" which is sitting in 
linux-next. Not sure is it related but probably worth to try.

https://lkml.org/lkml/2015/9/28/404

-- 
Jarkko
