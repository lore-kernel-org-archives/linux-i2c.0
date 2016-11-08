From: Jean Delvare <jdelvare@suse.de>
Subject: Re: amd756 driver error introduced with
 kernel-4.9.0-0.rc1.git0.2.fc26
Date: Tue, 8 Nov 2016 14:58:22 +0100
Message-ID: <20161108145822.7194beac@endymion>
References: <5821CA1A.5020608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45093 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751521AbcKHONq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 8 Nov 2016 09:13:46 -0500
In-Reply-To: <5821CA1A.5020608@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Johnny Bieren <jbieren@redhat.com>
Cc: linux-i2c@vger.kernel.org

Hi Johnny,

On Tue, 8 Nov 2016 07:50:34 -0500, Johnny Bieren wrote:
> Hello,
> It appears that a driver_probe_device failure was introduced with 
> kernel-4.9.0-0.rc1.git0.2.fc26.  When booting this kernel, or any newer 
> kernel, I see the following:
> 
> [   15.675485] ------------[ cut here ]------------
> [   15.680129] WARNING: CPU: 4 PID: 528 at drivers/base/dd.c:343 
> driver_probe_device+0x353/0x430
> [   15.688678] Modules linked in: i2c_amd756(+) pcc_cpufreq(-) k8temp 
> (...)
> 
> The problem does not appear in kernel-4.9.0-0.rc0.git9.1.fc26, but it 
> does appear in kernel-4.9.0-0.rc1.git0.2.fc26.  It reproduces 100% of 
> the time for me.  Can you please look into this issue?

Are the failing kernels built with option DEBUG_TEST_DRIVER_REMOVE
enabled?

-- 
Jean Delvare
SUSE L3 Support
