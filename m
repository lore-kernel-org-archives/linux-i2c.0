From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v3] i2c: i801: blacklist Host Notify on HP EliteBook G3
 850
Date: Tue, 10 Apr 2018 09:38:36 +0200
Message-ID: <20180410093836.1e39d9d8@endymion>
References: <20180404225643.6b40782f@endymion>
        <20180405183824.13333-1-jandryuk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180405183824.13333-1-jandryuk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Andryuk <jandryuk@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, benjamin.tissoires@redhat.com, andyrtr@archlinux.org, aduggan@synaptics.com, stable@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu,  5 Apr 2018 14:38:24 -0400, Jason Andryuk wrote:
> The HP EliteBook G3 850 has a weird bug where a subsequent cold boot
> hangs while plugged in if Linux enables the Host Notify features of
> i2c-i801.  The cold boot hang depends on how the system boots.  It does
> not hang on UEFI Grub text boot or legacy Grub text boot.  But it does
> hang on legacy Grub graphical boot and Intel Boot Agent PXE text boot.
> Booting unplugged is not affected.
> 
> Disabling the Host Notify feature with disable_feature=0x20 works around
> the bug, so automatically do so based on DMI information.
> 
> More information can be found here:
> https://www.spinics.net/lists/linux-i2c/msg33938.html
> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> Cc: stable@vger.kernel.org
> ---
> v3: Switch to DMI_EXACT_MATCH and add empty element to array
> 
>  drivers/i2c/busses/i2c-i801.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> (...)

Wolfram and stable, please hold on with this patch, Jason and I may have
found a proper fix so blacklisting would no longer be needed.

-- 
Jean Delvare
SUSE L3 Support
