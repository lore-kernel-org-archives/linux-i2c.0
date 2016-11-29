From: Tin Huynh <tnhuynh@apm.com>
Subject: Re: [PATCH V5] i2c: mux: pca954x: Add ACPI support for pca954x
Date: Tue, 29 Nov 2016 22:12:41 +0700
Message-ID: <CANQ9TuC64k8Ub_Pn01aJkQqL6kKrcXaJp35bPJR6c5WScUHj9A@mail.gmail.com>
References: <1480414363-16318-1-git-send-email-tnhuynh@apm.com> <d1576b0e-75e7-a8e7-b752-301d125ea765@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <d1576b0e-75e7-a8e7-b752-301d125ea765@axentia.se>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches <patches@apm.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 29, 2016 at 5:15 PM, Peter Rosin <peda@axentia.se> wrote:
> On 2016-11-29 11:12, Tin Huynh wrote:
>> This patch enables ACPI support for mux-pca954x driver.
>
> Looks good, thanks!
>
>> Signed-off-by: Tin Huynh <tnhuynh@apm.com>
>
> Acked-by: Peter Rosin <peda@axentia.se>
>
> Cheers,
> Peter
>
Added Mika
However , in http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/gpio/gpio-pca953x.c?id=f32517bf1ae0a2de72b3f27200233bd3ad65bfeb
 log , i didn't see the CONFIG_ACPI and CONFIG_PTR.
I have been acked with the same patch to support for i2c-leds (
without CONFIG_ACPI)
About logic , if we don't enable CONFIG_ACPI , acpi_match_table will
be NULL . So , the probe functions will be not called
and nothing happens.
I though we should use V3 (https://lkml.org/lkml/2016/11/28/893)
