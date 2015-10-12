From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [RFC] i2c: Revert back to old device naming for ACPI enumerated
 I2C slaves
Date: Mon, 12 Oct 2015 11:32:23 +0300
Message-ID: <561B7017.8090004@linux.intel.com>
References: <1440413522-7855-1-git-send-email-jarkko.nikula@linux.intel.com> <20151001203744.GA7514@katana> <560E4DF4.4000901@linux.intel.com> <20151009214712.GD1481@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15345 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbbJLIc1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 12 Oct 2015 04:32:27 -0400
In-Reply-To: <20151009214712.GD1481@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jean Delvare <jdelvare@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Dustin Byford <dustin@cumulusnetworks.com>, linux@roeck-us.net

Hi
On 10/10/2015 12:47 AM, Wolfram Sang wrote:
> On Fri, Oct 02, 2015 at 12:27:16PM +0300, Jarkko Nikula wrote:
>> On 10/01/2015 11:37 PM, Wolfram Sang wrote:
>>> Do you foresee troubles already? I am still in favour of a symlink.
>>>
>> I haven't looked at this for a while but one problem was that devices/
>> directory belongs to private structure of struct bus_type and in order to
>> create a symlink there it needs to done in drivers/base/bus.c:
>> bus_add_device() which felt quite hackish to me.
>
> This is just a quick prototype and untested; but I did something similar
> in the i2c-mux code:
>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 5f89f1e3c2f24f..715dca57ba68fd 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -970,13 +970,15 @@ static void i2c_dev_set_name(struct i2c_adapter *adap,
>   {
>   	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
>
> -	if (adev) {
> -		dev_set_name(&client->dev, "i2c-%s", acpi_dev_name(adev));
> -		return;
> -	}
> -
>   	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
>   		     i2c_encode_flags_to_addr(client));
> +
> +	if (adev) {
> +		char symlink_name[256];
> +
> +		snprintf(symlink_name, sizeof(symlink_name), "i2c-%s", acpi_dev_name(adev));
> +		sysfs_create_link(&client->dev.kobj, &adap->dev.kobj, symlink_name);
> +	}
>   }
>
>   /**
>
> Shouldn't something like this be enough?
>
Not really. It would create the symlink under the device not under 
/sys/bus/i2c/devices/. Please note the sysfs_create_link() must be 
called after device_register(). I moved the symlink creation into 
i2c_new_device() for the example below.

Now:

/sys/bus/i2c/devices/i2c-ATML3432:00 -> 
../../../devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-9/i2c-ATML3432:00

After modified patch:

/sys/bus/i2c/devices/9-004c -> 
../../../devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-9/9-004c

which has now the symlink pointing to adapter

/sys/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-9/9-004c/
i2c-ATML3432:00 -> ../../i2c-9

We would need a following symlink but I didn't figure out how to do it 
without touching drivers/base/bus.c.

/sys/bus/i2c/devices/i2c-ATML3432:00 -> 9-004c

Symlinks there are added/removed by using &bus->p->devices_kset->kobj 
where p is a private for driver core only.

-- 
Jarkko
