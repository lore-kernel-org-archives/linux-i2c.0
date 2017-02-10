From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v6 0/3] i2c: mux: pca954x: Add interrupt controller
 support
Date: Fri, 10 Feb 2017 09:02:00 +0100
Message-ID: <8a11d374-a9f9-0e58-d01f-1cc72827c5e9@axentia.se>
References: <1485307868-5408-1-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0096.outbound.protection.outlook.com ([104.47.2.96]:12256
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751767AbdBJICn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 10 Feb 2017 03:02:43 -0500
In-Reply-To: <1485307868-5408-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Phil Reid <preid@electromag.com.au>, linux-i2c@vger.kernel.org

Hi Wolfram!

I had prepared a branch for you to pull but then the kbuild
bot finally found this series and complained about the missing
initializer for the 'handled' variable. I amended the previously
posted fixup and was just about to send you the pull request when
you started to add patches to i2c/for-next. What is now left of what
I originally had in i2c-mux/for-next is this series. However, since
I told Phil that I amended the fixup I do not think he will resend
and I think you might therefore be waiting for a resend which will
probably not happen (anytime soon). I'm going to short out the wait
and just send a reworked pull request. See below.

A few thing to take away from this. Phil didn't post the series to
LKML, and the kbuild bots didn't find the series until I added it to
my i2c-mux tree. Fengguang indicated that the kbuild bot will now
(or soon) start to track the i2c list, which might be good to know.

I also think we need to come up with something that prevents us from
doing work twice. I think the main problem is at my end, for not
being clear enough about my intentions with an i2c-mux related
submission. So, from now on I think I'm just going to change my
acks to some message saying that the patch(es) have been added
to i2c-mux/for-next (in case the submission is clear-cut i2c-mux
and not at all about i2c-the-rest). If I just ack a submission I'll
expect you to pick it up. Ok?

The question then becomes at approximately which point you'll need
a pull request? Or should you perhaps be pulling in my tree
on a more continuous level so that everything i2c-related is
available in one tree (i.e. your tree)?

One thing that happened last time you pulled from the i2c-mux tree
was that you added your sign-offs, and that makes the i2c-mux tree
into a kind of 2nd rate tree that is not useful for much more than
feeding patches upstream. I have to force-push after each of your
pulls. I think (at least some) other 2nd level maintainers do not
"suffer" from this fate? Anyway, do you really need to add that
sign-off when you pull? It's not a big thing, but all things being
equal, I'd prefer the commits to stay as-is...

Cheers,
peda

The following changes since commit 7a308bb3016f57e5be11a677d15b821536419d36:

  Linux 4.10-rc5 (2017-01-22 12:54:15 -0800)

are available in the git repository at:

  https://github.com/peda-r/i2c-mux.git i2c-mux/for-next

for you to fetch changes up to f2114795f721bd5028284ddf84b150798a9b7a73:

  i2c: mux: pca954x: Add interrupt controller support (2017-02-10 08:23:51 +0100)

----------------------------------------------------------------
Phil Reid (3):
      i2c: mux: pca954x: Add missing pca9542 definition to chip_desc
      dt: bindings: i2c-mux-pca954x: Add documentation for interrupt controller
      i2c: mux: pca954x: Add interrupt controller support

 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt |  14 +++++-
 drivers/i2c/muxes/i2c-mux-pca954x.c                       | 150 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 159 insertions(+), 5 deletions(-)


On 2017-01-25 02:31, Phil Reid wrote:
> Various muxes can aggregate multiple interrupts from each i2c bus.
> All of the muxes with interrupt support combine the active low irq lines
> using an internal 'and' function and generate a combined active low
> output. The muxes do provide the ability to read a control register to
> determine which irq is active. By making the mux an irq controller isr
> latenct can potentially be reduced by reading the status register and 
> then only calling the registered isr on that bus segment.
> 
> Changes from v5:
> - p3 Added Peter's Ack.
> - Drop p4/5
> 
> Changes from v4:
> - p4: Change definition of irq_mask_enable to an array.
> - p4: Removed acks due to change requested by Peter
> - p5: Parse array of enables. Currently only supports 1 chip
>       But dt specification will allow expansion to handle
>       multple irq consume chips to be registered on a bus segment
> - p5: Fix up logic related to enabling and disable irq's.
>       Use a flag to indicate when irq has been enabled.
> 
> Changes from v3:
> - p3: Add spin lock to irq mask / unmask.
> - p4: Add Rob's ack.
> 
> Changes from v2:
> - p1: Added Acked-by
> - p5: fixup 2 typos
> 
> Changes from v1:
> - Update for new ACPI table
> - Fix typo in documentation
> - Fix typo in function names
> - Fix typo in irq name
> - Added spaces around '+' / '='
> - Change goto label names
> - Change property name from i2c-mux-irq-mask-en to nxp,irq-mask-enable
> - Change variable name irq_mask_en to irq_mask_enable
> - Add commentt about irq_mask_enable
> - Added Acked-By's
> Phil Reid (3):
>   i2c: mux: pca954x: Add missing pca9542 definition to chip_desc
>   dt: bindings: i2c-mux-pca954x: Add documentation for interrupt
>     controller
>   i2c: mux: pca954x: Add interrupt controller support
> 
>  .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |  14 +-
>  drivers/i2c/muxes/i2c-mux-pca954x.c                | 150 ++++++++++++++++++++-
>  2 files changed, 159 insertions(+), 5 deletions(-)
> 
