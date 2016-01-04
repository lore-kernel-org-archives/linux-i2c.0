From: Loc Ho <lho@apm.com>
Subject: Re: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
Date: Sun, 3 Jan 2016 22:23:44 -0800
Message-ID: <CAPw-ZTkZ5Su9CfgGQCHGFFCw-RE=tFeCF1GyMP3EUaZ8WDisSg@mail.gmail.com>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
	<4133541.hlxbdmvYbG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35037 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbcADGXq (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 4 Jan 2016 01:23:46 -0500
Received: by mail-lf0-f44.google.com with SMTP id c192so93396424lfe.2
        for <linux-i2c@vger.kernel.org>; Sun, 03 Jan 2016 22:23:45 -0800 (PST)
In-Reply-To: <4133541.hlxbdmvYbG@vostro.rjw.lan>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: wsa@the-dreams.de, Ken Xue <Ken.Xue@amd.com>, Jeff.Wu@amd.com, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jon Masters <jcm@redhat.com>, "patches@apm.com" <patches@apm.com>

Hi,

On Sat, Jan 2, 2016 at 4:54 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, December 10, 2015 02:19:15 PM Loc Ho wrote:
>> Add APM X-Gene ACPI I2C device support. These patches follow
>> the same implementation as AMD I2C driver - changes in ACPI APD
>> and Designware I2C drivers.
>>
>> v2:
>> * Spilt the acpi_apd change with defines for AMD and X-Gene I2C's
>>
>> Signed-off-by: Loc Ho <lho@apm.com>
>> ---
>> Loc Ho (2):
>>   acpi:apd: Add APM X-Gene ACPI I2C device support
>>   i2c:dw: Add APM X-Gene ACPI I2C device support
>
> Both patches applied, thanks!
>

Thanks...

-Loc
