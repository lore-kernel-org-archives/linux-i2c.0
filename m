From: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/8] misc: remove boundary checks from bin attr users
Date: Fri, 07 Aug 2015 19:15:46 +0300
Message-ID: <55C4D9B2.3000708@mleia.com>
References: <1437945502-27944-1-git-send-email-vz@mleia.com> <20150807161055.GD25357@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150807161055.GD25357@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Ian Munsie <imunsie-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org>, Michael Neuling <mikey-/owAOxkjmzZAfugRpC6u6w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 07.08.2015 19:10, Wolfram Sang wrote:
> Vladimir,
> 
> On Mon, Jul 27, 2015 at 12:18:22AM +0300, Vladimir Zapolskiy wrote:
>> This change removes a number of redundant checks on bin attribute
>> client's side, the same checks are done by sysfs_kf_bin_read() or
>> sysfs_kf_bin_write() caller from fs/sysfs/file.c.
>>
>> Note, drivers/misc/pch_phub.c and drivers/misc/c2port/core.c may be
>> updated in a similar way, however this task is not done due to more
>> complicated read()/write() callbacks.
> 
> Can you resend the patches which touch i2c drivers with me on cc? I'd
> like to take care of them.

if we're talking about this particular series, you should have them in
your mailbox, since you have them applied in wsa/i2c/for-next:

commit d12c0aaf3780c5b26b4ea9e795252381f586c063
Author: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Date:   Mon Jul 27 00:18:51 2015 +0300

    misc: eeprom: at24: clean up at24_bin_write()

    The change removes redundant sysfs binary file boundary check, since
    this task is already done on caller side in fs/sysfs/file.c

    Signed-off-by: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

commit 1f023297f7f77d434ecc221018d2e181eac0ae36
Author: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Date:   Mon Jul 27 00:16:31 2015 +0300

    i2c: slave eeprom: clean up sysfs bin attribute read()/write()

    The change removes redundant sysfs binary file boundary checks,
    since this task is already done on caller side in fs/sysfs/file.c

    Note, on file size overflow read() now returns 0, and this is a
    correct and expected EOF notification according to POSIX.

    Signed-off-by: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>


Do you want me to send them to you again anyway?

--
With best wishes,
Vladimir
