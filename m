From: Jean Delvare <jdelvare@suse.de>
Subject: Re: amd756 driver error introduced with
 kernel-4.9.0-0.rc1.git0.2.fc26
Date: Wed, 9 Nov 2016 14:54:12 +0100
Message-ID: <20161109145412.151c9ffc@endymion>
References: <5821CA1A.5020608@redhat.com>
        <20161108145822.7194beac@endymion>
        <58221469.50005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932223AbcKINyR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 9 Nov 2016 08:54:17 -0500
In-Reply-To: <58221469.50005@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Johnny Bieren <jbieren@redhat.com>
Cc: linux-i2c@vger.kernel.org

On Tue, 8 Nov 2016 13:07:37 -0500, Johnny Bieren wrote:
> No, that option is not enabled.
> 
> cat /boot/config-4.9.0-0.rc1.git0.2.fc26.x86_64 | grep DEBUG_TEST
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set

Then I don't know. I can't see how the only recent change to the
i2c-amd756 driver (ea734404f3daf1f6b5103171d848c9d4641fd96b) could
cause this. The warning comes from:

	WARN_ON(!list_empty(&dev->devres_head));

which was added a decade ago so nothing new here.

I'm out of ideas. The only way to move forward is to bisect it to find
out the exact commit which triggered the warning.

-- 
Jean Delvare
SUSE L3 Support
