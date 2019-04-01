From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: isch: Remove unnecessary acpi.h include
Date: Mon, 01 Apr 2019 17:07:20 +0200
Message-ID: <1554131240.6965.5.camel@suse.de>
References: <20190325183652.252175-1-helgaas@kernel.org>
         <CAErSpo6_VMJ8nP9sA2xZffsMXdG3bKKv8WL0skyTTbuLe4WtJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAErSpo6_VMJ8nP9sA2xZffsMXdG3bKKv8WL0skyTTbuLe4WtJQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mukesh Ojha <mojha@codeaurora.org>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

Hi Bjorn,

On Mon, 2019-04-01 at 08:50 -0500, Bjorn Helgaas wrote:
> On Mon, Mar 25, 2019 at 1:37 PM <helgaas@kernel.org> wrote:
> > 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > 54fb4a05af0a ("i2c: Check for ACPI resource conflicts") included
> > <linux/acpi.h> so we could use acpi_check_region().  fd46a0064af1 ("i2c:
> > convert i2c-isch to platform_device") removed the use of
> > acpi_check_region() but not the include.
> > 
> > Remove the now-unnecessary include of <linux/acpi.h>.  No functional change
> > intended.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Added
> 
>     Fixes: fd46a0064af1 ("i2c: convert i2c-isch to platform_device")
>     Reviewed-by: Jean Delvare <jdelvare@suse.de>
>     Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> 
> on my local branch.
> 
> Jean, would you like me to repost this with the updates?  I assume you
> will merge this (just based on get_maintainer.pl)?

No, Wolfram prefers to pick all the i2c patches into his own branch,
I'm only giving my Reviewed-by. So your question is for him.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
