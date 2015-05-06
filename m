From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v2 i2c/for-next] i1c: i801: recover from hardware PEC
 errors
Date: Wed, 6 May 2015 11:33:16 +0200
Message-ID: <20150506113316.7dae4066@endymion.delvare>
References: <1430772076-1151-1-git-send-email-ellen@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430772076-1151-1-git-send-email-ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ellen,

On Mon,  4 May 2015 13:41:16 -0700, Ellen Wang wrote:
> On a CRC error while using hardware-supported PEC, an additional
> error bit is set in the auxiliary status register.  If this bit
> isn't cleared, all subsequent operations will fail, essentially
> hanging the controller.
> 
> The fix is simple: check, report, and clear the bit in
> i802_check_post().  Also, in case the driver starts with the
> hardware in that state, clear it in i801_check_pre() as well.

You seem to be angry against 1s and 2s ;-) The subsystem is i2c and the
driver is i801, not the other way around.

> 
> Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
> ---
> This is essentially the patch from Jean Delvare, which handles
> the polling case while my original version didn't.  (Thank you!
> Please add appropriate attribution if you wish.)

Well, thanks for adding the comments, it's definitely helpful. This is
collaborative work :-)

> 
> I tested all the additional code paths by selectively commenting
> out code: with interrupts, without interrupts, relying on check_pre()
> to clear CRCE, no clearing of CRCE at all (baseline).

Thanks a lot for testing. I'll perform some tests on my ICH5 system as
well and if everything passes I'll resend the patch with fixed subject,
description and credits.

-- 
Jean Delvare
SUSE L3 Support
