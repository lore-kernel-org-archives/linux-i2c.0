From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i801: Fix Failed to allocate irq -2147483648 error
Date: Tue, 28 Nov 2017 14:37:07 +0100
Message-ID: <20171128143707.257a2fa1@endymion>
References: <20171122112817.9554-1-hdegoede@redhat.com>
        <20171124144957.6a7323cc@endymion>
        <5ba5b26d-18d9-6f07-d9a9-52cde30ea5ee@redhat.com>
        <20171127110427.624a8b3c@endymion>
        <a733c418-9a88-fd40-96b7-40690c757db0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60673 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750871AbdK1NhK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 28 Nov 2017 08:37:10 -0500
In-Reply-To: <a733c418-9a88-fd40-96b7-40690c757db0@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, stable@vger.kernel.org

On Mon, 27 Nov 2017 16:38:50 +0100, Hans de Goede wrote:
> On 27-11-17 11:04, Jean Delvare wrote:
> > Turning a cryptic error message into a meaningful error message isn't
> > necessarily a bad thing.  
> 
> Given all the effort distros have done with splash-screens to give
> users a nice clean boot experience, we really want dmesg --level=err
> to not print anything unless there is a real problem with either the
> hardware or the kernel,

I completely agree with that, same goal here.

> printing an error message on all Apollo Lake
> systems is really not helpful IMHO.

It wouldn't have to be an error message, it could be a mere notice.

What I'm afraid of is that the missing IRQ is an overlook from the
standard BIOS provided by Intel to integrators, and the error will keep
spreading until BIOS developers are aware of the problem.

-- 
Jean Delvare
SUSE L3 Support
