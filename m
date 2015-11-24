From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH v2] i2c: cadence: Move to sensible power management
Date: Tue, 24 Nov 2015 09:58:32 +0530
Message-ID: <CAKfKVtHbzEAWL8OedkxY2bfC+oR_DHejS3Lx5F_t0mKCs21i2g@mail.gmail.com>
References: <1446017200-30373-1-git-send-email-shubhraj@xilinx.com>
	<20151028161810.GB6436@xsjsorenbubuntu>
	<CAKfKVtHbKrYK-JkQRWO3hEyOkGEW8q9zc6r90PNP8uEm3VXc4Q@mail.gmail.com>
	<CAKfKVtHHKcs1UAM4pb4Qbtn5TEOboZf1SrL4qFuFZYSCUundHw@mail.gmail.com>
	<20151123184710.GH32017@xsjsorenbubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qg0-f67.google.com ([209.85.192.67]:36209 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbbKXE2d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 23 Nov 2015 23:28:33 -0500
In-Reply-To: <20151123184710.GH32017@xsjsorenbubuntu>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, anirudh@xilinx.com, Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Shubhrajyoti Datta <shubhraj@xilinx.com>

On Tue, Nov 24, 2015 at 12:17 AM, S=C3=B6ren Brinkmann
<soren.brinkmann@xilinx.com> wrote:
> On Sat, 2015-11-21 at 07:00PM +0530, Shubhrajyoti Datta wrote:
>> On Thu, Oct 29, 2015 at 8:27 PM, Shubhrajyoti Datta
>> <shubhrajyoti.datta@gmail.com> wrote:
>> > On Wed, Oct 28, 2015 at 9:48 PM, S=C3=B6ren Brinkmann
>> > <soren.brinkmann@xilinx.com> wrote:
>> >> Hi Shubhrajyoti,
>> >>
>> >>
>> >> On Wed, 2015-10-28 at 12:56PM +0530, Shubhrajyoti Datta wrote:
>> >>> Currently the clocks are enabled at probe and disabled at remove=
=2E
>> >>> Which keeps the clocks enabled even if no transaction is going o=
n.
>> >>> This patch enables the clocks at the start of transfer and disab=
les
>> >>> after it.
>> >>>
>> >>> Also adapts to runtime pm.
>> >>> Remove xi2c->suspended and use pm runtime status instead.
>> >>>
>> >>> converts dev pm to const to silence a checkpatch warning.
>> >>>
>> >>> Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
>> >>
>> >> To me, this looks all good. Just one small concern below.
>> >
>> > Thanks for the review.
>> Soren ,
>> Do are you ok with the change or do you want me to resend without th=
e
>> suspended flag change.
>
> I'm always for removing code that is not needed. If things are tested
> and well and work without throwing any warnings I'm OK with it.

It should be also having a suspended book-keeping in the driver is not
needed the pm does that for us.

I will spilt the patch and resend.

Thanks,

>
>         S=C3=B6ren
