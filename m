From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [RFC] i2c: Revert back to old device naming for ACPI enumerated
 I2C slaves
Date: Fri, 02 Oct 2015 12:27:16 +0300
Message-ID: <560E4DF4.4000901@linux.intel.com>
References: <1440413522-7855-1-git-send-email-jarkko.nikula@linux.intel.com> <20151001203744.GA7514@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57246 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbbJBJ1U (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 2 Oct 2015 05:27:20 -0400
In-Reply-To: <20151001203744.GA7514@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jean Delvare <jdelvare@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Dustin Byford <dustin@cumulusnetworks.com>, linux@roeck-us.net

On 10/01/2015 11:37 PM, Wolfram Sang wrote:
>
>> This is for discussion so I didn't cc stable@vger.kernel.org yet. I was
>> thinking would it work if we'd keep the stable name but have an another
>> symlink in /sys/bus/i2c/devices/ that uses "x-00yz" name. However this
>> feels ill-use of devices directory and probably causes more troubles
>> elsewhere.
>
> Do you foresee troubles already? I am still in favour of a symlink.
>
I haven't looked at this for a while but one problem was that devices/ 
directory belongs to private structure of struct bus_type and in order 
to create a symlink there it needs to done in drivers/base/bus.c: 
bus_add_device() which felt quite hackish to me.

-- 
Jarkko
