From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH V5] i2c: mux: pca954x: Add ACPI support for pca954x
Date: Tue, 29 Nov 2016 16:50:51 +0100
Message-ID: <8351922e-f006-da76-1b76-e850113d4e7a@axentia.se>
References: <1480414363-16318-1-git-send-email-tnhuynh@apm.com>
 <d1576b0e-75e7-a8e7-b752-301d125ea765@axentia.se>
 <CANQ9TuC64k8Ub_Pn01aJkQqL6kKrcXaJp35bPJR6c5WScUHj9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CANQ9TuC64k8Ub_Pn01aJkQqL6kKrcXaJp35bPJR6c5WScUHj9A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tin Huynh <tnhuynh@apm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches <patches@apm.com>
List-Id: linux-i2c@vger.kernel.org

On 2016-11-29 16:12, Tin Huynh wrote:
> On Tue, Nov 29, 2016 at 5:15 PM, Peter Rosin <peda@axentia.se> wrote:
>> On 2016-11-29 11:12, Tin Huynh wrote:
>>> This patch enables ACPI support for mux-pca954x driver.
>>
>> Looks good, thanks!
>>
>>> Signed-off-by: Tin Huynh <tnhuynh@apm.com>
>>
>> Acked-by: Peter Rosin <peda@axentia.se>
>>
>> Cheers,
>> Peter
>>
> Added Mika
> However , in http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/gpio/gpio-pca953x.c?id=f32517bf1ae0a2de72b3f27200233bd3ad65bfeb
>  log , i didn't see the CONFIG_ACPI and CONFIG_PTR.
> I have been acked with the same patch to support for i2c-leds (
> without CONFIG_ACPI)
> About logic , if we don't enable CONFIG_ACPI , acpi_match_table will
> be NULL . So , the probe functions will be not called
> and nothing happens.
> I though we should use V3 (https://lkml.org/lkml/2016/11/28/893)
> 

V3 will work, but you waste resources (not much, but still) for the
ACPI table even though it is never going to be used, so it's best
to #ifdef it out. (At least I think so, but maybe GCC sees that the
variable isn't really used for anything useful and manages to kill
it off? Anyway, I'm assuming that there really are resources wasted
if you don't do the #ifdef...)

But the thing is that you do not want a bunch of #ifdefs *in* the
code. It's ok to #ifdef out a variable, but not *in* the code. That
way lies madness.

So the code is going to have a call to acpi_match_device(). If
CONFIG_ACPI isn't set, that function compiles to an inline function
simply returning NULL, but the compiler still evaluates its args
and complains if the above variable is not found, which it isn't
since it's #ifdef out. So, we need to "hide" the variable if it
doesn't exist, using the ACPI_PTR macro.

For gpio-pca953x, the same reasoning can be used, but the resource
waste is even less in that case.

Cheers,
Peter

