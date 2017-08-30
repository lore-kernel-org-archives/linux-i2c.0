From: "Mohandass, Divagar" <divagar.mohandass@intel.com>
Subject: RE: [PATCH v3 3/3] eeprom: at24: enable runtime pm support
Date: Wed, 30 Aug 2017 17:04:21 +0000
Message-ID: <7B8CE47BD58441468D2BB13285B50E6031DE62E9@BGSMSX107.gar.corp.intel.com>
References: <1504066266-30051-1-git-send-email-divagar.mohandass@intel.com>
 <1504066266-30051-4-git-send-email-divagar.mohandass@intel.com>
 <20170830075329.cyhzitpfwojq3aox@valkosipuli.retiisi.org.uk>
 <7B8CE47BD58441468D2BB13285B50E6031DE621E@BGSMSX107.gar.corp.intel.com>
 <20170830124122.3oipo4ykpzmkzdy2@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:60428 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751920AbdH3RH3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 30 Aug 2017 13:07:29 -0400
In-Reply-To: <20170830124122.3oipo4ykpzmkzdy2@valkosipuli.retiisi.org.uk>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mani, Rajmohan" <rajmohan.mani@intel.com>

Hi Sakari,

Thanks for the review.
My comments below.

---
^Divagar

>-----Original Message-----
>From: Sakari Ailus [mailto:sakari.ailus@iki.fi]
>Sent: Wednesday, August 30, 2017 6:11 PM
>To: Mohandass, Divagar <divagar.mohandass@intel.com>
>Cc: robh+dt@kernel.org; mark.rutland@arm.com; wsa@the-dreams.de;
>devicetree@vger.kernel.org; linux-i2c@vger.kernel.org; linux-
>kernel@vger.kernel.org; Mani, Rajmohan <rajmohan.mani@intel.com>
>Subject: Re: [PATCH v3 3/3] eeprom: at24: enable runtime pm support
>
>On Wed, Aug 30, 2017 at 12:32:07PM +0000, Mohandass, Divagar wrote:
>> >> @@ -743,6 +770,15 @@ static int at24_probe(struct i2c_client
>> >> *client, const struct i2c_device_id *id)
>> >>
>> >>  	i2c_set_clientdata(client, at24);
>> >>
>> >> +	/* enable runtime pm */
>> >> +	pm_runtime_get_noresume(&client->dev);
>> >> +	err = pm_runtime_set_active(&client->dev);
>> >> +	if (err < 0)
>> >> +		goto err_clients;
>> >> +
>> >> +	pm_runtime_enable(&client->dev);
>> >> +	pm_runtime_put(&client->dev);
>> >> +
>> >
>> >You're just about to perform a read here. I believe you should move
>> >the last put after that.
>>
>> At the end of at24_read we are performing a pm_runtime_put, still we need
>this change ?
>
>True, so this isn't an actual problem.
>
>It'll still power the chip down when you're about to need it, so it'd make sense
>to perform the check before pm_runtime_put().
>
>I might move the runtime PM setup after the check altogether.

Ok, I will move the pm_runtime_put() after the check and publish the v4.
Moving the PM setup altogether below, will introduce more error handling in read call.

>
>--
>Sakari Ailus
>e-mail: sakari.ailus@iki.fi
