From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i801: Fix Failed to allocate irq -2147483648 error
Date: Mon, 27 Nov 2017 11:04:27 +0100
Message-ID: <20171127110427.624a8b3c@endymion>
References: <20171122112817.9554-1-hdegoede@redhat.com>
        <20171124144957.6a7323cc@endymion>
        <5ba5b26d-18d9-6f07-d9a9-52cde30ea5ee@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751225AbdK0KEa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Nov 2017 05:04:30 -0500
In-Reply-To: <5ba5b26d-18d9-6f07-d9a9-52cde30ea5ee@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, stable@vger.kernel.org

On Sat, 25 Nov 2017 14:43:08 +0100, Hans de Goede wrote:
> On 11/24/2017 02:49 PM, Jean Delvare wrote:
> > Isn't it a BIOS bug?  
> 
> No, as mentioned in:
> 
> >> BugLink: https://communities.intel.com/thread/114759  
> 
> The BIOS deliberately does not contain IRQ routing issues because some
> variants of the Windows driver for this falling over if their is
> any IRQ routing set, so this is a "feature" not a bug :|

What I do not understand is how Apollo Lake systems are different from
any other Intel system, which already had a compatible SMBus controller
and apparently having an IRQ configured was never an issue?

> > (...)
> > However if this is considered a BIOS bug then a pr_err(FW_BUG...) would
> > be good to add IMHO.  
> 
> See above, that would just replace one error message with another on all
> Apollo Lake systems.

Turning a cryptic error message into a meaningful error message isn't
necessarily a bad thing.

-- 
Jean Delvare
SUSE L3 Support
