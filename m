From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] i2c: Add generic support passing secondary devices addresses
Date: Thu, 24 Mar 2016 09:02:13 -0500
Message-ID: <CAL_JsqLBVLoUOTPMHy+ABoXkZD0U36NCgSNPLLtBPoK6FJBfnQ@mail.gmail.com>
References: <1454254380-9246-1-git-send-email-jean-michel.hautbois@veo-labs.com>
 <20160201144608.GA26606@rob-hp-laptop> <CAH-u=80AH6njdkc_2JOnHM21eFFDDdwsE1y=k31=J-6kTPXwPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41650 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753112AbcCXOCn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 24 Mar 2016 10:02:43 -0400
In-Reply-To: <CAH-u=80AH6njdkc_2JOnHM21eFFDDdwsE1y=k31=J-6kTPXwPA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: Jean-Michel Hautbois <jhautbois@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lars-Peter Clausen <lars@metafoo.de>

On Thu, Mar 24, 2016 at 5:11 AM, Jean-Michel Hautbois
<jean-michel.hautbois@veo-labs.com> wrote:
> Hi !
>
> 2016-02-01 15:46 GMT+01:00 Rob Herring <robh@kernel.org>:
>> On Sun, Jan 31, 2016 at 04:33:00PM +0100, Jean-Michel Hautbois wrote:
>>> Some I2C devices have multiple addresses assigned, for example each address
>>> corresponding to a different internal register map page of the device.
>>> So far drivers which need support for this have handled this with a driver
>>> specific and non-generic implementation, e.g. passing the additional address
>>> via platform data.
>>>
>>> This patch provides a new helper function called i2c_new_secondary_device()
>>> which is intended to provide a generic way to get the secondary address
>>> as well as instantiate a struct i2c_client for the secondary address.
>>>
>>> The function expects a pointer to the primary i2c_client, a name
>>> for the secondary address and an optional default address. The name is used
>>> as a handle to specify which secondary address to get.
>>>
>>> The default address is used as a fallback in case no secondary address
>>> was explicitly specified. In case no secondary address and no default
>>> address were specified the function returns NULL.
>>>
>>> For now the function only supports look-up of the secondary address
>>> from devicetree, but it can be extended in the future
>>> to for example support board files and/or ACPI.
>>>
>>> Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>
>>> ---
>>> v2: adding some DT bindings documentation (more than one year later...)
>>>
>>>  Documentation/devicetree/bindings/i2c/i2c.txt |  7 +++++
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>>
>>>  drivers/i2c/i2c-core.c                        | 42 +++++++++++++++++++++++++++
>>>  include/linux/i2c.h                           |  5 ++++
>>>  3 files changed, 54 insertions(+)
>
> Thanks Rob for your ack. What is the future of this patch ?

I'm expecting Wolfram to pick it up.

> I know the merge window is opened, so it will not be integrated now,
> but could be in the next version ?

I would say it is not too late for 4.6 if it was missed by accident.

Rob
