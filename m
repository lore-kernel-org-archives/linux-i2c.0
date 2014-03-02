From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] i2c: i801: enable Intel BayTrail SMBUS
Date: Sun, 2 Mar 2014 10:29:30 +0100
Message-ID: <20140302102930.0b46b639@endymion.delvare>
References: <1393603436-3494-1-git-send-email-chiau.ee.chew@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393603436-3494-1-git-send-email-chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Chew Kean Ho <kean.ho.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Chew,

On Sat,  1 Mar 2014 00:03:56 +0800, Chew Chiau Ee wrote:
> From: Chew, Kean ho <kean.ho.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> Add Device ID of Intel BayTrail SMBus Controller.
> 
> Signed-off-by: Chew, Kean ho <kean.ho.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/i2c/busses/i2c-i801 |    1 +
>  drivers/i2c/busses/Kconfig        |    1 +
>  drivers/i2c/busses/i2c-i801.c     |    3 +++
>  3 files changed, 5 insertions(+), 0 deletions(-)
> (...)

Looks alright.

Reviewed-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>

-- 
Jean Delvare
SUSE L3 Support
