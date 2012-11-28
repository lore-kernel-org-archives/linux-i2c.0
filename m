From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: SMBus: remove __dev* attributes
Date: Wed, 28 Nov 2012 21:58:03 +0100
Message-ID: <20121128215803.76aa3d1d@endymion.delvare>
References: <1354119353-7804-1-git-send-email-wfp5p@virginia.edu>
	<1354119353-7804-3-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354119353-7804-3-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 28 Nov 2012 11:15:53 -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option.  As result the __dev*
> markings will be going away.
> 
> Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
> and __devexit.
> 
> This also adds const to structs that were declared with __devinitdata
> as requested by Jean Delvare.
> 
> Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-ali1535.c |  8 ++++----
>  drivers/i2c/busses/i2c-ali15x3.c |  8 ++++----
>  drivers/i2c/busses/i2c-amd756.c  |  7 +++----
>  drivers/i2c/busses/i2c-amd8111.c |  7 +++----
>  drivers/i2c/busses/i2c-i801.c    | 28 +++++++++++++---------------
>  drivers/i2c/busses/i2c-isch.c    |  6 +++---
>  drivers/i2c/busses/i2c-nforce2.c | 12 ++++++------
>  drivers/i2c/busses/i2c-piix4.c   | 32 +++++++++++++++-----------------
>  drivers/i2c/busses/i2c-sis5595.c |  4 ++--
>  drivers/i2c/busses/i2c-sis630.c  |  8 ++++----
>  drivers/i2c/busses/i2c-via.c     |  6 +++---
>  drivers/i2c/busses/i2c-viapro.c  |  4 ++--
>  12 files changed, 62 insertions(+), 68 deletions(-)
> (...)

Very nice, thank you.

Reviewed-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

-- 
Jean Delvare
