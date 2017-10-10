From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v6 3/3] eeprom: at24: enable runtime pm support
Date: Tue, 10 Oct 2017 12:54:52 +0900
Message-ID: <CAAFQd5CjjAfkcfLVDSk4mSakPA=ELM_XFwJhduNFL5rZxJdN5Q@mail.gmail.com>
References: <1504520928-5191-1-git-send-email-divagar.mohandass@intel.com>
 <1504520928-5191-4-git-send-email-divagar.mohandass@intel.com>
 <6F87890CF0F5204F892DEA1EF0D77A5972FC1278@FMSMSX114.amr.corp.intel.com>
 <CAAFQd5DUNHJ7fqWy5iD_fb=TBUqGy3AQ3uGXr-TdQ5v39f_hsw@mail.gmail.com>
 <20170920084519.asyfjxo6upt36woz@valkosipuli.retiisi.org.uk> <20171003142349.6uxwfime32dwzxwk@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:50651 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755048AbdJJDzP (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 9 Oct 2017 23:55:15 -0400
Received: by mail-qt0-f175.google.com with SMTP id f15so47634884qtf.7
        for <linux-i2c@vger.kernel.org>; Mon, 09 Oct 2017 20:55:15 -0700 (PDT)
Received: from mail-qt0-f181.google.com (mail-qt0-f181.google.com. [209.85.216.181])
        by smtp.gmail.com with ESMTPSA id 13sm5982555qtv.59.2017.10.09.20.55.13
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Oct 2017 20:55:13 -0700 (PDT)
Received: by mail-qt0-f181.google.com with SMTP id a43so41682600qta.0
        for <linux-i2c@vger.kernel.org>; Mon, 09 Oct 2017 20:55:13 -0700 (PDT)
In-Reply-To: <20171003142349.6uxwfime32dwzxwk@valkosipuli.retiisi.org.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "sakari.ailus@iki.fi" <sakari.ailus@iki.fi>
Cc: "Mani, Rajmohan" <rajmohan.mani@intel.com>, "Mohandass, Divagar" <divagar.mohandass@intel.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, mika.westerberg@linux.intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, Oct 3, 2017 at 11:23 PM, sakari.ailus@iki.fi
<sakari.ailus@iki.fi> wrote:
> On Wed, Sep 20, 2017 at 11:45:20AM +0300, sakari.ailus@iki.fi wrote:
>> > >> @@ -743,11 +770,17 @@ static int at24_probe(struct i2c_client *clie=
nt, const
>> > >> struct i2c_device_id *id)
>> > >>
>> > >>       i2c_set_clientdata(client, at24);
>> > >>
>> > >> +     /* enable runtime pm */
>> > >> +     pm_runtime_get_noresume(&client->dev);
>> > >> +     pm_runtime_set_active(&client->dev);
>> > >> +     pm_runtime_enable(&client->dev);
>> >
>> > Do we need this get_noresume/set_active dance? I remember it was for
>> > some reason needed for PCI devices, but I don't see why for I2C
>> > anything else than just pm_runtime_enable() would be necessary.
>>
>> You specifically do not need (all) this for PCI devices, but AFAIU for I=
=E6=B6=8E
>> devices you do. The runtime PM status of a device is disabled by default
>> and the use count is zero, but on ACPI based systems the device is still
>> powered on.
>>
>> >
>> > Also, we enable runtime PM, but we don't provide any callbacks. If
>> > there is no callback in any level of the hierarchy, NULL would be
>> > returned in [3], making [2] return -ENOSYS and [1] fail. The behavior
>> > depends on subsystem and whether the device is attached to a
>> > pm_domain. In our particular case I'd guess the device would be in an
>> > ACPI pm_domain and that would work, but the driver is generic and must
>> > work in any cases.
>>
>> Agreed.
>
> I looked at the code and what actually happens here is the runtime_suspen=
d
> and runtime_resume callbacks aren't set is that the first pm_runtime_put(=
)
> call itself succeeds because checking the the runtime_suspend callback wi=
ll
> be done in the work queue function. This leaves the device in RPM_ACTIVE
> state, which I don't think is a problem since the driver did not have
> explicit functions to control the device power state.
>
> Further pm_runtime_put() and pm_runtime_get() calls will succeed because
> the device is in RPM_ACTIVE state.
>
> So I see no reason to set the callbacks if they would not actually contro=
l
> regulators, clocks or GPIOs required by the device.
>
> Cc linux-pm.

Sounds reasonable. I remember seeing some problems in the past, but
looks like they may be already fixed in current upstream. Thanks for
checking this thoroughly.

Best regards,
Tomasz
