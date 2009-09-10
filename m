From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] I2C: add new AMD SMBus device ID
Date: Thu, 10 Sep 2009 13:50:47 +0200
Message-ID: <20090910135047.2a55ccca@hyperion.delvare>
References: <20090910080427.GA10945@crane-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090910080427.GA10945@crane-desktop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Crane,

On Thu, 10 Sep 2009 16:04:27 +0800, Crane Cai wrote:
> Add new SMBus device ID for SB900
> 
> ---
> Hi Jean,
> 
> We follow your point, new patch submitted, please apply.

Applied, thanks. FYI, I also had to list the SB900 in
Documentation/i2c/busses/i2c-piix4 and drivers/i2c/busses/Kconfig. Next
time, please include these changes in your patch. The completed patch
can be seen at:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/i2c-piix4-add-amd-SB900-smbus-device-id.patch

Will a datasheet for the SB900 be released to the public at some point
in the future? That would be useful for us developers.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
