From: Jayachandran C <jchandra@broadcom.com>
Subject: Re: [PATCH v2] i2c: xlp9xx: add ACPI support for Broadcom Vulcan
Date: Fri, 17 Jun 2016 22:50:52 +0530
Message-ID: <CAKc_7PXUOJ0F527jz-P6xHRCmdmD8ZBMYVCAZnQWNy8p56rV2w@mail.gmail.com>
References: <1464077343-1665-1-git-send-email-tanmay.jagdale@broadcom.com> <1464952474-15714-1-git-send-email-tanmay.jagdale@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36136 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522AbcFQRVd (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 17 Jun 2016 13:21:33 -0400
Received: by mail-yw0-f175.google.com with SMTP id d137so1633205ywe.3
        for <linux-i2c@vger.kernel.org>; Fri, 17 Jun 2016 10:21:32 -0700 (PDT)
In-Reply-To: <1464952474-15714-1-git-send-email-tanmay.jagdale@broadcom.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: Tanmay Jagdale <tanmay.jagdale@broadcom.com>, linux-i2c@vger.kernel.org, Jayachandran C <jayachandran.chandrashekaran@broadcom.com>

On Fri, Jun 3, 2016 at 4:44 PM, Tanmay Jagdale
<tanmay.jagdale@broadcom.com> wrote:
> Added ACPI support for the I2C controller present on Broadcom's
> Vulcan ARM64 processor. ACPI ID used by the controller is BRCM9007.
>
> Changed the xlp9xx_i2c_get_frequency() function to use
> device_property_read_u32() API so that the "clock-frequency" value
> can be read from _DSD in ACPI mode.
>
> Signed-off-by: Tanmay Jagdale <tanmay.jagdale@broadcom.com>

Tested-by: Jayachandran C <jchandra@broadcom.com>

Tested with broadcom vulcan UEFI firmware. It would be useful
if this is merged, then we can use the I2C controller when booting
with ACPI

Thanks,
JC.
