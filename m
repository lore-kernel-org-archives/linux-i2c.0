From: Johnny Bieren <jbieren@redhat.com>
Subject: Re: amd756 driver error introduced with
 kernel-4.9.0-0.rc1.git0.2.fc26
Date: Tue, 8 Nov 2016 13:07:37 -0500
Message-ID: <58221469.50005@redhat.com>
References: <5821CA1A.5020608@redhat.com> <20161108145822.7194beac@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750869AbcKHSHi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 8 Nov 2016 13:07:38 -0500
In-Reply-To: <20161108145822.7194beac@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org

Hey Jean,

No, that option is not enabled.

cat /boot/config-4.9.0-0.rc1.git0.2.fc26.x86_64 | grep DEBUG_TEST
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set

Thanks,
Johnny

On 11/08/2016 08:58 AM, Jean Delvare wrote:
> Hi Johnny,
>
> On Tue, 8 Nov 2016 07:50:34 -0500, Johnny Bieren wrote:
>> Hello,
>> It appears that a driver_probe_device failure was introduced with
>> kernel-4.9.0-0.rc1.git0.2.fc26.  When booting this kernel, or any newer
>> kernel, I see the following:
>>
>> [   15.675485] ------------[ cut here ]------------
>> [   15.680129] WARNING: CPU: 4 PID: 528 at drivers/base/dd.c:343
>> driver_probe_device+0x353/0x430
>> [   15.688678] Modules linked in: i2c_amd756(+) pcc_cpufreq(-) k8temp
>> (...)
>>
>> The problem does not appear in kernel-4.9.0-0.rc0.git9.1.fc26, but it
>> does appear in kernel-4.9.0-0.rc1.git0.2.fc26.  It reproduces 100% of
>> the time for me.  Can you please look into this issue?
> Are the failing kernels built with option DEBUG_TEST_DRIVER_REMOVE
> enabled?
>
