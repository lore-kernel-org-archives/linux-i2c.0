From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v2] i2c: cadence: Move to sensible power management
Date: Mon, 23 Nov 2015 10:47:10 -0800
Message-ID: <20151123184710.GH32017@xsjsorenbubuntu>
References: <1446017200-30373-1-git-send-email-shubhraj@xilinx.com>
 <20151028161810.GB6436@xsjsorenbubuntu>
 <CAKfKVtHbKrYK-JkQRWO3hEyOkGEW8q9zc6r90PNP8uEm3VXc4Q@mail.gmail.com>
 <CAKfKVtHHKcs1UAM4pb4Qbtn5TEOboZf1SrL4qFuFZYSCUundHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKfKVtHHKcs1UAM4pb4Qbtn5TEOboZf1SrL4qFuFZYSCUundHw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, anirudh@xilinx.com, Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Shubhrajyoti Datta <shubhraj@xilinx.com>
List-Id: linux-i2c@vger.kernel.org

On Sat, 2015-11-21 at 07:00PM +0530, Shubhrajyoti Datta wrote:
> On Thu, Oct 29, 2015 at 8:27 PM, Shubhrajyoti Datta
> <shubhrajyoti.datta@gmail.com> wrote:
> > On Wed, Oct 28, 2015 at 9:48 PM, S=C3=B6ren Brinkmann
> > <soren.brinkmann@xilinx.com> wrote:
> >> Hi Shubhrajyoti,
> >>
> >>
> >> On Wed, 2015-10-28 at 12:56PM +0530, Shubhrajyoti Datta wrote:
> >>> Currently the clocks are enabled at probe and disabled at remove.
> >>> Which keeps the clocks enabled even if no transaction is going on=
=2E
> >>> This patch enables the clocks at the start of transfer and disabl=
es
> >>> after it.
> >>>
> >>> Also adapts to runtime pm.
> >>> Remove xi2c->suspended and use pm runtime status instead.
> >>>
> >>> converts dev pm to const to silence a checkpatch warning.
> >>>
> >>> Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
> >>
> >> To me, this looks all good. Just one small concern below.
> >
> > Thanks for the review.
> Soren ,
> Do are you ok with the change or do you want me to resend without the
> suspended flag change.

I'm always for removing code that is not needed. If things are tested
and well and work without throwing any warnings I'm OK with it.

	S=C3=B6ren
