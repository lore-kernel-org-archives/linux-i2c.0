From: "Mohandass, Divagar" <divagar.mohandass@intel.com>
Subject: RE: [PATCH v5 3/3] eeprom: at24: enable runtime pm support
Date: Mon, 4 Sep 2017 10:27:26 +0000
Message-ID: <7B8CE47BD58441468D2BB13285B50E6031DE80FF@BGSMSX107.gar.corp.intel.com>
References: <1504507245-12902-1-git-send-email-divagar.mohandass@intel.com>
 <1504507245-12902-4-git-send-email-divagar.mohandass@intel.com>
 <20170904073850.i77nk36k5extin56@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170904073850.i77nk36k5extin56@valkosipuli.retiisi.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mani, Rajmohan" <rajmohan.mani@intel.com>
List-Id: linux-i2c@vger.kernel.org

Hi Sakari,

Thanks, I will fix this and send the patch v6.

---
^Divagar

>-----Original Message-----
>From: Sakari Ailus [mailto:sakari.ailus@iki.fi]
>Sent: Monday, September 04, 2017 1:09 PM
>To: Mohandass, Divagar <divagar.mohandass@intel.com>
>Cc: robh+dt@kernel.org; mark.rutland@arm.com; wsa@the-dreams.de;
>devicetree@vger.kernel.org; linux-i2c@vger.kernel.org; linux-
>kernel@vger.kernel.org; Mani, Rajmohan <rajmohan.mani@intel.com>
>Subject: Re: [PATCH v5 3/3] eeprom: at24: enable runtime pm support
>
>Hi Divagar,
>
>On Mon, Sep 04, 2017 at 12:10:45PM +0530, Divagar Mohandass wrote:
>> Currently the device is kept in D0, there is an opportunity to save
>> power by enabling runtime pm.
>>
>> Device can be daisy chained from PMIC and we can't rely on I2C core
>> for auto resume/suspend. Driver will decide when to resume/suspend.
>>
>> Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>
>> ---
>>  drivers/misc/eeprom/at24.c | 40
>> ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>
>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>> index 2199c42..03f5cb7 100644
>> --- a/drivers/misc/eeprom/at24.c
>> +++ b/drivers/misc/eeprom/at24.c
>> @@ -750,9 +782,12 @@ static int at24_probe(struct i2c_client *client,
>const struct i2c_device_id *id)
>>  	err = at24_read(at24, 0, &test_byte, 1);
>
>You do pm_runtime_put()s here and drop the ones below as it's needed
>unconditionally. Then I think we're done.
>
>>  	if (err) {
>>  		err = -ENODEV;
>> +		pm_runtime_put(&client->dev);
>>  		goto err_clients;
>>  	}
>>
>> +	pm_runtime_put(&client->dev);
>> +
>>  	at24->nvmem_config.name = dev_name(&client->dev);
>>  	at24->nvmem_config.dev = &client->dev;
>>  	at24->nvmem_config.read_only = !writable;
>
>--
>Kind regards,
>
>Sakari Ailus
>e-mail: sakari.ailus@iki.fi
